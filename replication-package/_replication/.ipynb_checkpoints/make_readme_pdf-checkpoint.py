#!/usr/bin/env python3
"""Render the replication-package README.md to LaTeX, then PDF.

Deliberately narrow: it handles exactly the Markdown constructs used in
README.md (ATX headings, pipe tables, fenced code, task-list checkboxes,
bullet lists, links, inline code, bold/italic, horizontal rules).
"""
import re
import sys

SPECIALS = {
    '\\': r'\textbackslash{}',
    '&': r'\&', '%': r'\%', '$': r'\$', '#': r'\#',
    '_': r'\_', '{': r'\{', '}': r'\}',
    '~': r'\textasciitilde{}', '^': r'\textasciicircum{}',
}


def esc(s):
    return ''.join(SPECIALS.get(c, c) for c in s)


def inline(s):
    """Convert inline markdown to LaTeX, protecting code spans first."""
    slots = []

    def stash(tex):
        slots.append(tex)
        return '\x00%d\x00' % (len(slots) - 1)

    # `code`
    s = re.sub(r'`([^`]+)`', lambda m: stash(r'\texttt{%s}' % esc(m.group(1))), s)
    # [text](url)
    s = re.sub(r'\[([^\]]+)\]\((https?://[^)]+|#[^)]+)\)',
               lambda m: stash(r'\href{%s}{%s}' % (m.group(2).replace('%', r'\%').replace('#', r'\#'),
                                                   esc(m.group(1)))
                               if m.group(2).startswith('http')
                               else esc(m.group(1))), s)
    # bare <url>
    s = re.sub(r'<(https?://[^>]+)>',
               lambda m: stash(r'\url{%s}' % m.group(1).replace('%', r'\%').replace('#', r'\#')), s)
    # **bold**
    s = re.sub(r'\*\*([^*]+)\*\*', lambda m: stash(r'\textbf{%s}' % esc(m.group(1))), s)
    # *italic*
    s = re.sub(r'(?<![*\w])\*([^*\n]+)\*(?!\*)', lambda m: stash(r'\emph{%s}' % esc(m.group(1))), s)

    s = esc(s)
    # placeholders can nest (a bold span may contain a code span), so keep
    # expanding until none are left
    while '\x00' in s:
        s, n = re.subn('\x00(\\d+)\x00', lambda m: slots[int(m.group(1))], s)
        if n == 0:
            break
    return s


def colspec(header, rows, total_width=1.0):
    """Proportional p{} columns, weighted by observed content length."""
    import math
    n = len(header)
    weights = []
    for i in range(n):
        cells = [header[i]] + [r[i] for r in rows if len(r) > i]
        # total length drives the damped weight, but an unbreakable token
        # (a long path or code span) sets a hard floor so it cannot overlap
        longest = max((len(c) for c in cells), default=1)
        # split on whitespace only: a comma inside `rng(140324,'twister')` is
        # not a line-break opportunity once it is set in \texttt
        longest_token = max((max((len(t) for t in re.split(r'\s+', c)), default=1)
                             for c in cells), default=1)
        weights.append((math.sqrt(longest), longest_token))

    tok_total = sum(w[1] for w in weights) or 1
    floors = [max(0.10, 1.15 * t / tok_total) for _, t in weights]

    damped = [w for w, _ in weights]
    scale = sum(damped) or 1
    frac = [max(d / scale, f) for d, f in zip(damped, floors)]
    tot = sum(frac)
    frac = [f / tot * 0.95 for f in frac]
    return ('@{}' + ' '.join(r'>{\raggedright\arraybackslash}p{%.3f\linewidth}' % f
                             for f in frac) + '@{}')


def convert(md):
    out = []
    lines = md.split('\n')
    i = 0
    in_code = False
    list_open = False

    def close_list():
        nonlocal list_open
        if list_open:
            out.append(r'\end{itemize}')
            list_open = False

    while i < len(lines):
        ln = lines[i]

        # fenced code
        if ln.startswith('```'):
            if not in_code:
                close_list()
                out.append(r'\begin{lstlisting}')
                in_code = True
            else:
                out.append(r'\end{lstlisting}')
                in_code = False
            i += 1
            continue
        if in_code:
            out.append(ln)
            i += 1
            continue

        # horizontal rule
        if re.fullmatch(r'-{3,}', ln.strip()):
            close_list()
            out.append(r'\vspace{0.6em}\hrule\vspace{1.0em}')
            i += 1
            continue

        # headings
        m = re.match(r'^(#{1,4})\s+(.*)$', ln)
        if m:
            close_list()
            lvl = len(m.group(1))
            cmd = {1: 'section', 2: 'section', 3: 'subsection', 4: 'subsubsection'}[lvl]
            if lvl == 1:
                out.append(r'\begin{center}{\LARGE\bfseries %s}\end{center}' % inline(m.group(2)))
            else:
                out.append(r'\%s*{%s}' % (cmd, inline(m.group(2))))
                out.append(r'\addcontentsline{toc}{%s}{%s}' % (cmd, inline(m.group(2))))
            i += 1
            continue

        # pipe table
        if ln.strip().startswith('|') and i + 1 < len(lines) and re.match(r'^\s*\|[\s:|-]+\|\s*$', lines[i + 1]):
            close_list()
            def cells(row):
                return [c.strip() for c in row.strip().strip('|').split('|')]
            header = cells(ln)
            i += 2
            rows = []
            while i < len(lines) and lines[i].strip().startswith('|'):
                rows.append(cells(lines[i]))
                i += 1
            spec = colspec(header, rows)
            out.append(r'\begingroup\small')
            out.append(r'\begin{longtable}{%s}' % spec)
            out.append(r'\toprule')
            out.append(' & '.join(r'\textbf{%s}' % inline(h) for h in header) + r' \\')
            out.append(r'\midrule\endhead')
            for r in rows:
                r = (r + [''] * len(header))[:len(header)]
                out.append(' & '.join(inline(c) for c in r) + r' \\')
            out.append(r'\bottomrule')
            out.append(r'\end{longtable}\endgroup')
            continue

        # ordered list
        m = re.match(r'^(\s*)(\d+)\.\s+(.*)$', ln)
        if m:
            close_list()
            items = []
            while i < len(lines):
                mm = re.match(r'^(\s*)(\d+)\.\s+(.*)$', lines[i])
                if not mm:
                    break
                body = [mm.group(3)]
                j = i + 1
                while (j < len(lines) and lines[j].strip()
                       and not re.match(r'^\s*\d+\.\s', lines[j])
                       and not re.match(r'^\s*-\s', lines[j])
                       and not lines[j].startswith('#')
                       and not lines[j].startswith('```')):
                    body.append(lines[j].strip())
                    j += 1
                items.append(' '.join(body))
                i = j
            out.append(r'\begin{enumerate}[leftmargin=1.6em,itemsep=2pt,topsep=3pt]')
            for it in items:
                out.append(r'\item %s' % inline(it))
            out.append(r'\end{enumerate}')
            continue

        # checkbox / bullet list
        m = re.match(r'^(\s*)-\s+(\[[ xX]\]\s+)?(.*)$', ln)
        if m:
            if not list_open:
                out.append(r'\begin{itemize}[leftmargin=1.4em,itemsep=1pt,topsep=3pt]')
                list_open = True
            box = m.group(2) or ''
            body = [m.group(3)]
            # absorb wrapped continuation lines so they stay inside the \item
            j = i + 1
            while (j < len(lines) and lines[j].strip()
                   and not re.match(r'^\s*-\s', lines[j])
                   and not lines[j].startswith('#')
                   and not lines[j].startswith('```')
                   and not lines[j].strip().startswith('|')):
                body.append(lines[j].strip())
                j += 1
            text = inline(' '.join(body))
            if box:
                mark = r'$\boxtimes$' if box.strip()[1] in 'xX' else r'$\square$'
                out.append(r'\item[%s] %s' % (mark, text))
            else:
                out.append(r'\item %s' % text)
            i = j
            continue

        if not ln.strip():
            close_list()
            out.append('')
            i += 1
            continue

        close_list()
        # join a wrapped paragraph into one LaTeX paragraph
        para = [ln.strip()]
        j = i + 1
        while (j < len(lines) and lines[j].strip()
               and not re.match(r'^\s*-\s', lines[j])
               and not lines[j].startswith('#')
               and not lines[j].startswith('```')
               and not lines[j].strip().startswith('|')
               and not re.fullmatch(r'-{3,}', lines[j].strip())):
            para.append(lines[j].strip())
            j += 1
        out.append(inline(' '.join(para)))
        i = j

    close_list()
    return '\n'.join(out)


PREAMBLE = r"""\documentclass[11pt,a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[T1]{fontenc}
\usepackage{lmodern}
\usepackage{booktabs}
\usepackage{longtable}
\usepackage{array}
\usepackage{enumitem}
\usepackage{amssymb}
\usepackage{listings}
\usepackage{xcolor}
\usepackage[hidelinks]{hyperref}
\usepackage{parskip}
\urlstyle{same}
\lstset{
  basicstyle=\ttfamily\small,
  breaklines=true,
  frame=single,
  rulecolor=\color{gray!50},
  backgroundcolor=\color{gray!8},
  columns=fullflexible,
  keepspaces=true,
  showstringspaces=false,
  xleftmargin=0pt,
  framexleftmargin=3pt
}
\setcounter{secnumdepth}{0}
\sloppy
\begin{document}
"""


def main():
    src, dst = sys.argv[1], sys.argv[2]
    md = open(src, encoding='utf-8').read()
    body = convert(md)
    open(dst, 'w', encoding='utf-8').write(PREAMBLE + body + '\n\\end{document}\n')


if __name__ == '__main__':
    main()
