## Filepaths Analysis Details

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_kvar/calculate_moments_stoch.m**

- Line 9, unix : % idshock   = ishocks this is just the emp/unemp dimension

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_ci.m**

- Line 12, windows : %resultsfolder = [pathstr '\_aux\_models\'];
- Line 13, unix : resultsfolder = [pathstr '/_aux/_models_tmp/'];
- Line 77, unix : fid = fopen('_table/table_ci.tex', 'w');
- Line 80, windows : fprintf(fid, '\\toprule\n');
- Line 84, windows : fprintf(fid, '\\midrule\n');
- Line 86, windows : fprintf(fid, '\\midrule\n');
- Line 92, windows : fprintf(fid, '\\midrule\n');
- Line 97, windows : fprintf(fid, '\\midrule\n');
- Line 98, unix : fprintf(fid, '& Gini & 90/10 & 99/1 & 90/50 & $\\mathrm{Cor}(K,Y)$ \\\\\n');
- Line 99, windows : fprintf(fid, '\\midrule\n');
- Line 106, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/Redo_Wealth_Moments.m**

- Line 20, unix : load(['~/Dropbox/BKKS_Shadow/_modelresults/model_' int2str(model_to_run) '.mat']);
- Line 22, unix : load(['~/Dropbox/BKKS_Shadow/_modelresults/scaled_ev/model_' int2str(model_to_run) '.mat']);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_cix.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline\\[-1.8ex]
- Line 15, unix : & $\text{Gini}(K)$  & $90/10$ & $99/1$ & $90/50$ & $\text{Cor}(K, Y )$  \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_cv.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline\\[-1.8ex]
- Line 6, unix : & Gini G& $90/10$ & $99/1$ & $90/50$  &$\text{Cor}(K,Y )$ \\
- Line 14, unix : & Gini G& $90/10$ & $99/1$ & $90/50$  &$\text{Cor}(K,Y )$  \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/figure_c4.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 65, windows : b_1 = X\Y;
- Line 67, windows : b_1_norm = X\normalize(Y);
- Line 128, windows : b_2 = X\Y;
- Line 130, windows : b_2_norm = X\normalize(Y);
- Line 176, windows : b_2_old = X\Y;
- Line 237, unix : print(figure1, '_figures/figure_c4.pdf', '-dpdf', '-image');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/simKS.m**

- Line 10, unix : kapshocks=shocks.kapshocks/2;
- Line 11, unix : kinfoshocks=shocks.kinfoshocks/2;

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/solve_experience.m**

- Line 147, unix : % W0/Wp
- Line 150, unix : % V0/Vp
- Line 153, unix : % cpol is a function of m,pz,pk/s, so we need to replicated it across the z
- Line 419, unix : Vp(i_less_no)   =  euler/params.ev_shock + EXp_no(i_less_no) + ...
- Line 422, unix : Vp(no_less_i)   =  euler/params.ev_shock + EXp_info(no_less_i) + ...

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_cx.m**

- Line 6, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 10, unix : %Endogenous        =  fullfile(scriptDir, '_aux/_models/model_7009.mat');
- Line 11, unix : %Exogenous         =  fullfile(scriptDir, '_aux/_models/model_7009_exo.mat');
- Line 12, unix : %Fullinformation   =  fullfile(scriptDir, '_aux/_models/model_7009_exo.mat');
- Line 14, unix : Endogenous        =  fullfile(scriptDir, '_aux/_models_tmp/model_7009.mat');
- Line 15, unix : Exogenous         =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_exo.mat');
- Line 16, unix : Fullinformation   =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_fi.mat');
- Line 28, unix : fid = fopen(fullfile(scriptDir, '_table/table_cx.tex'), 'w');
- Line 32, windows : fprintf(fid, '\\toprule\n');
- Line 33, windows : fprintf(fid, '\\toprule\n');
- Line 37, windows : fprintf(fid, '\\midrule\n');
- Line 58, unix : fprintf(fid, '& $ Gini (K) $ &   & $ 90/50$  &  & $\\text{Corr}(K,Y)$\\\\\n');
- Line 59, windows : fprintf(fid, '\\midrule\n');
- Line 80, windows : fprintf(fid, '\\bottomrule\n');
- Line 81, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_vi.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 10, unix : %Endogenous      =  fullfile(scriptDir, '_aux/_models/model_1001.mat');
- Line 11, unix : %Full            =  fullfile(scriptDir, '_aux/_models/model_1023.mat');
- Line 12, unix : %Exogenous       =  fullfile(scriptDir, '_aux/_models/model_1026.mat');
- Line 14, unix : %Endogenous_rep    =  fullfile(scriptDir, '_aux/_models/model_1007.mat');
- Line 15, unix : %Full_rep          =  fullfile(scriptDir, '_aux/_models/model_1025.mat');
- Line 16, unix : %Exogenous_rep     =  fullfile(scriptDir, '_aux/_models/model_1028.mat');
- Line 18, unix : Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
- Line 19, unix : Full            =  fullfile(scriptDir, '_aux/_models_tmp/model_1023.mat');
- Line 20, unix : Exogenous       =  fullfile(scriptDir, '_aux/_models_tmp/model_1026.mat');
- Line 22, unix : Endogenous_rep    =  fullfile(scriptDir, '_aux/_models_tmp/model_1007.mat');
- Line 23, unix : Full_rep          =  fullfile(scriptDir, '_aux/_models_tmp/model_1025.mat');
- Line 24, unix : Exogenous_rep     =  fullfile(scriptDir, '_aux/_models_tmp/model_1028.mat');
- Line 44, unix : fid = fopen(fullfile(scriptDir, '_table/table_vi.tex'), 'w');
- Line 48, windows : fprintf(fid, '\\toprule\n');
- Line 49, windows : fprintf(fid, '\\toprule\n');
- Line 52, unix : fprintf(fid, '& $\\mu(K)$ & $\\sigma(Y) $ & Gini (G)  & $ 90/10 $ & $99/1$ & $90/50$ & $\\text{Info U.}$ & $\\text{Info E.}$\\\\\n');
- Line 53, windows : fprintf(fid, '\\midrule\n');
- Line 70, windows : fprintf(fid, '\\bottomrule\n');
- Line 71, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_kvar/wprctile.m**

- Line 25, unix : %         Type 4: p(k) = k/n. That is, linear interpolation of the empirical cdf.
- Line 34, unix : %         Type 8: p(k) = (k-1/3)/(n+1/3). Then p(k) =~ median[F(x[k])].
- Line 37, unix : %         Type 9: p(k) = (k-3/8)/(n+1/4). The resulting quantile estimates are
- Line 66, unix : % version 1.0.0, Release 2007/10/16: Initial release
- Line 67, unix : % version 1.1.0, Release 2008/04/02: Implementation of other 5 algorithms and
- Line 166, unix : pk = k/n;
- Line 168, unix : pk = (k-sortedW/2)/n;
- Line 174, unix : pk = (k-sortedW/3)/(n+1/3);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_iv.m**

- Line 6, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 7, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 10, unix : %Endogenous      =  fullfile(scriptDir, '_aux/_models/model_1001.mat');
- Line 11, unix : %Full            =  fullfile(scriptDir, '_aux/_models/model_1023.mat');
- Line 12, unix : %Exogenous       =  fullfile(scriptDir, '_aux/_models/model_1026.mat');
- Line 14, unix : Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
- Line 15, unix : Full            =  fullfile(scriptDir, '_aux/_models_tmp/model_1023.mat');
- Line 16, unix : Exogenous       =  fullfile(scriptDir, '_aux/_models_tmp/model_1026.mat');
- Line 29, unix : fid = fopen(fullfile(scriptDir, '_table/table_iv.tex'), 'w');
- Line 33, windows : fprintf(fid, '\\toprule\n');
- Line 34, windows : fprintf(fid, '\\toprule\n');
- Line 38, unix : fprintf(fid, '& $ Gini (G) $ & $ 90/10 $ & $99/1$ & $90/50$ & $\\text{Corr}(K,Y)$\\\\\n');
- Line 39, windows : fprintf(fid, '\\midrule\n');
- Line 56, windows : fprintf(fid, '\\midrule\n');
- Line 59, unix : fprintf(fid, '& $ Gini (G) $ & $ 90/10 $ & $99/1$ & $90/50$ & $\\text{Corr}(K,Y)$\\\\\n');
- Line 60, windows : fprintf(fid, '\\midrule\n');
- Line 75, windows : fprintf(fid, '\\bottomrule\n');
- Line 76, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/01_paper.tex**

- Line 468, unix : \hspace{-0.65cm}\includegraphics[scale=0.5]{_input/figure_1a_lhs}\hspace{0.22cm}\includegraphics[scale=0.5]{_input/figure_1b_rhs}
- Line 473, unix : \hspace{-0.50cm}\includegraphics[scale=0.5]{_input/figure_1c_lhs}\hspace{0.22cm}\includegraphics[scale=0.5]{_input/figure_1d_rhs}
- Line 480, unix : within wealth deciles/quintiles and the overall average taken across
- Line 484, unix : of the absolute value of individual errors on the wealth decile/quintile
- Line 515, unix : on the household wealth-decile/quintile controlling for household
- Line 554, unix : \includegraphics[scale=0.47]{_input/figure_2a_lhs}\hspace{0.22cm}\includegraphics[scale=0.47]{_input/figure_2a_rhs}
- Line 560, unix : \includegraphics[scale=0.47]{_input/figure_2b_lhs}\hspace{0.22cm}\includegraphics[scale=0.47]{_input/figure_2b_rhs}
- Line 569, unix : accuracy on the wealth decile/quintile the respondent belongs to,
- Line 577, windows : deviation robust confidence bounds. Sample: 2013M10-2020M1.}{\footnotesize\par}
- Line 631, windows : The economy consists of a continuum of heterogeneous households $i\in[0,1]$,
- Line 640, windows : between two periods, $c_{it}$ non-durable consumption at time $t=\left\{ 0,1,2,\ldots\right\} $,
- Line 643, windows : $1-\rho\in(0,1)$ and $b\in(0,1)$ are the per-period probability
- Line 663, windows : the replacement rate equals $\mu\in(0,1$). We assume that households
- Line 665, windows : return equals $r_{t}-\delta$, where $r_{t}$ denotes the stochastic
- Line 666, windows : rental rate and $\delta\in(0,1)$ the depreciation rate of capital.
- Line 695, windows : and follows a first-order Markov process that takes two values, $z_{t}\in\left\{ z_{l},z_{h}\right\} $
- Line 746, windows : formulation of the household problem. Let $S=\left(\Gamma,z\right)$,
- Line 807, windows : $p_{i,-1}$ (and hence information). We let $\iota\left(\cdot\right)$
- Line 829, windows : RIICE is a law of motion $H\left(\cdot\right)$, a pair of individual
- Line 831, windows : policy functions $\left\{ g\left(\cdot\right),h\left(\cdot\right),\iota\left(\cdot\right),\right\} $,
- Line 832, windows : as well as pricing functions $\left\{ r\left(\cdot\right),w\left(\cdot\right)\right\} $
- Line 835, windows : given $H\left(\cdot\right)$; (ii) $r\left(\cdot\right)$ and $w\left(\cdot\right)$
- Line 837, windows : $H\left(\cdot\right)$ is generated by policy functions $g\left(\cdot\right)$,
- Line 838, windows : $h\left(\cdot\right)$, and $\iota\left(\cdot\right),$ the Markov
- Line 842, windows : to the marginal distribution of capital, $H_{k}\left(\cdot\right)$,
- Line 849, windows : of $\left(k,\epsilon,p\right)$.}} and (iv) market-clearing conditions hold for capital and goods markets
- Line 961, windows : the law of motion $H\left(\cdot\right)$. Thus, if households knew
- Line 972, windows : $H\left(\cdot\right)$, households form expectations about the future
- Line 1038, windows : The two-stage optimization problem can then be stated as:\smallskip
- Line 1057, windows : $H\left(\cdot\right)$ as the aggregate law of motion in the approximated
- Line 1139, unix : do not value those improved predictions.} We set the scale parameter $\alpha_{\kappa}$ equal to $1/15\times10^{-4}$
- Line 1164, unix : \textcolor{black}{\input{_input/table_i.tex}}
- Line 1217, unix : \includegraphics[width=\linewidth,trim=29 160 29 224,clip]{_input/figure_3a.pdf}
- Line 1218, unix : % \includegraphics[width=\linewidth,trim=29 160 29 224,clip]{_input/savings_errors.pdf}
- Line 1223, unix : \includegraphics[width=\linewidth,trim=29 160 29 224,clip]{_input/figure_3b.pdf}
- Line 1224, unix : % \includegraphics[width=\linewidth,trim=29 160 29 224,clip]{_input/savingsfullinformation.pdf}
- Line 1247, unix : discount factor to target the same $K/Y-$ratio as in our benchmark
- Line 1289, unix : \includegraphics[width=\linewidth,trim=29 160 29 224,clip]{_input/figure_4a.pdf}
- Line 1290, unix : % \includegraphics[width=\linewidth,trim=29 160 29 224,clip]{_input/savingsinformeduninformed.pdf}
- Line 1295, unix : \includegraphics[width=\linewidth,trim=29 160 29 224,clip]{_input/figure_4b.pdf}
- Line 1296, unix : % \includegraphics[width=\linewidth,trim=29 160 29 224,clip]{_input/savingsinformeduninformedcapital.pdf}
- Line 1447, unix : (b): Employed, Low Prior $K_{t}$\\\hspace{-0.92cm}\includegraphics[viewport=43bp 0bp 1000bp 360bp,clip,scale=0.54]{_input/figure_5ab}\vspace{0.38cm}
- Line 1451, unix : (d): Employed, High Prior $K_{t}$\\\hspace{-0.92cm}\includegraphics[viewport=43bp 35bp 1000bp 360bp,clip,scale=0.54]{_input/figure_5cd}
- Line 1462, windows : in our model to USD (\$) amounts.}{\footnotesize\par}
- Line 1537, unix : \includegraphics[viewport=25bp 0bp 1000bp 400bp,clip,scale=0.74]{_input/figure_6}
- Line 1549, windows : amounts.}{\footnotesize\par}
- Line 1625, unix : \textcolor{black}{\input{_input/table_ii.tex}}
- Line 1630, windows : deviation $\sigma\left(\cdot\right)$ of the logarithms of economy-wide
- Line 1640, windows : the exogenous information case.}{\footnotesize\par}
- Line 1644, unix : The standard deviation of capital is around 2/3 higher, and output
- Line 1709, unix : \includegraphics[width=\linewidth,trim=60 250 60 280,clip]{_input/figure_IRF_prod2.pdf}
- Line 1716, unix : \includegraphics[width=\linewidth,trim=60 250 60 280,clip]{_input/figure_IRF_k2.pdf}
- Line 1723, unix : \includegraphics[width=\linewidth,trim=60 250 60 280,clip]{_input/figure_IRF_y2.pdf}
- Line 1730, unix : \includegraphics[width=\linewidth,trim=60 250 60 280,clip]{_input/figure_IRF_inv2.pdf}
- Line 1801, unix : \textcolor{black}{\input{_input/table_iii.tex}\vspace{0.22cm}}
- Line 1844, unix : \includegraphics[viewport=150bp 0bp 1350bp 400bp,clip,scale=0.45]{_input/figure_8}
- Line 1846, unix : \hspace{0.35cm} Panel (a): Distribution Differences (I/II)\hspace{1.55cm}
- Line 1847, unix : Panel (b): Distribution Differences (II/II)\vspace{0.29cm}
- Line 1857, windows : kernel.}{\footnotesize\par}
- Line 1864, unix : \textcolor{black}{\input{_input/table_iv.tex}}
- Line 1870, unix : distribution ($G)$, as well as the 90/10, 99/1, and 90/50 percentile
- Line 1880, windows : case for all households and for all moments in time.}{\footnotesize\par}
- Line 1889, unix : all measures of inequality (Gini coefficient, the 90/10-ratio, as
- Line 1890, unix : well as the 99/1-ratio) increase modestly between 2-5 percent (Table
- Line 2049, unix : \textcolor{black}{\input{_input/table_v.tex}}
- Line 2060, unix : $K$ and output $Y$, respectively. ``W/o Costs'' refers to the alternative
- Line 2153, unix : of the overall increase to that from before. The 99/1-ratio, for example,
- Line 2237, unix : \textcolor{black}{\input{_input/table_vi.tex}}
- Line 2252, windows : the employed and unemployed.}{\footnotesize\par}
- Line 2383, unix : \textcolor{black}{\input{_input/table_a7.tex}}
- Line 2389, unix : errors on the wealth bucket (decile/quintile) that the individual
- Line 2404, unix : \textcolor{black}{\input{_input/table_a8.tex}}
- Line 2415, windows : to those used in the main text.}{\footnotesize\par}
- Line 2423, unix : \textcolor{black}{\input{_input/table_a9.tex}}
- Line 2487, windows : $i\in\left[0,1\right]$'s response to the true-but-unobserved probability
- Line 2516, unix : is the total current value of your {[}and your spouse\textquoteright s/partner\textquoteright s{]}
- Line 2538, unix : \textcolor{black}{\input{_input/table_a10.tex}}
- Line 2549, windows : (column 4), and their standard deviation (column 5).}{\footnotesize\par}
- Line 2584, unix : PRS85006023 multiplied by the employment-population ratio CE16OV/CNP16OV),
- Line 2613, unix : \hspace{12pt}Ratio of productivity between booms and bust ($z_h/z_l$) & 1.027\\
- Line 2623, unix : \hspace{12pt}Scale parameter of utility cost of information (\textbf{$\alpha^\kappa$}) & $1/15e^{-4}$ \\ \hline \hline     \end{tabular} \end{small} \end{center} \end{table}
- Line 2633, unix : \textcolor{black}{\input{_input/table_bii.tex}}
- Line 2662, windows : $K_{t+h},\,h\geq1$. We verify that this holds also in our setup:
- Line 2679, unix : \includegraphics[viewport=-107bp 200bp 800bp 625bp,clip,scale=0.6]{_input/figure_b1}
- Line 2687, windows : the benchmark economy (yellow line). }{\footnotesize\par}
- Line 2699, unix : \includegraphics[viewport=-65bp 0bp 1000bp 400bp,clip,scale=0.58]{_input/figure_bii}
- Line 2711, windows : amounts.}{\footnotesize\par}
- Line 2728, unix : \textcolor{black}{\input{_input/table_ci.tex}}
- Line 2735, windows : of the aggregate capital stock with a fixed probability $p\in[0,1]$
- Line 2754, unix : and, for example, the 99/50 percentile ratio are about 4\textendash 4.5
- Line 2763, unix : \textcolor{black}{\input{_input/table_cii.tex}}
- Line 2770, unix : time of the Gini, the 90/50, and the 99/50 percentile ratios of the
- Line 2773, windows : of the wealth distribution.}{\footnotesize\par}
- Line 2855, unix : \label{fig-7-dist-composition}\includegraphics[viewport=56bp 0bp 945bp 420bp,scale=0.78]{_input/figure_c1}
- Line 2874, windows : kernel.}{\footnotesize\par}
- Line 2987, unix : \textcolor{black}{\input{_input/table_ciii.tex}}
- Line 2994, unix : We focus, for concreteness, on the Gini, the 90/10-ratio, and the
- Line 2995, mixed : 99/1-ratio. Similar results hold for other summary inequality measures.}{\footnotesize\par}
- Line 3007, unix : \textcolor{black}{\input{_input/table_civ.tex}}
- Line 3018, windows : Information'' and ``Exogenous Information'', respectively).}{\footnotesize\par}
- Line 3027, unix : \textcolor{black}{\input{_input/table_cv.tex}}
- Line 3034, unix : coefficient of the capital distribution ($G)$, as well as the 90/10,
- Line 3035, unix : 99/1, and 90/50 percentile ratios of the wealth distribution. In addition,
- Line 3039, windows : comparison models.}{\footnotesize\par}
- Line 3055, unix : \textcolor{black}{\input{_input/table_cvi.tex}}
- Line 3069, windows : all costs of information are set equal to zero.}{\footnotesize\par}
- Line 3079, unix : \textcolor{black}{\input{_input/table_cvii.tex}}
- Line 3087, unix : as the 90/10, 99/1, and 90/50 percentile ratios of the capital distribution.
- Line 3092, windows : in which all costs of information are set equal to zero.}{\footnotesize\par}
- Line 3103, unix : \includegraphics[scale=0.74]{_input/figure_c2}
- Line 3109, unix : within wealth deciles/quintiles and the overall average taken across
- Line 3113, windows : scaled utility cost.}{\footnotesize\par}
- Line 3123, unix : \textcolor{black}{\input{_input/table_cviii.tex}}
- Line 3133, windows : to zero.}{\footnotesize\par}
- Line 3141, unix : \includegraphics[scale=0.74]{_input/figure_c3}
- Line 3147, unix : within wealth deciles/quintiles and the overall average taken across
- Line 3151, windows : resource cost.}{\footnotesize\par}
- Line 3161, unix : \textcolor{black}{\input{_input/table_cix.tex}}
- Line 3171, windows : zero.}{\footnotesize\par}
- Line 3191, windows : y_{jt}=p_{jt}^{-\omega}Y_{t}.
- Line 3197, windows : There are two types of households: A mass $m\in(0,1)$ of worker-households
- Line 3232, unix : the wealth distributions, such as the 90/10-ratio, are ill-defined,
- Line 3233, unix : which is why they are excluded from the table.\footnote{Indeed, the average value is, for example, $\infty$ for the 90/10-ratio,
- Line 3242, unix : \includegraphics[scale=0.65]{_input/figure_c4}
- Line 3248, unix : within wealth deciles/quintiles and the overall average taken across
- Line 3252, windows : that matches the wealth distribution. }{\footnotesize\par}
- Line 3262, unix : \textcolor{black}{\input{_input/table_cx.tex}}
- Line 3283, unix : \textcolor{black}{\input{_input/table_cxi.tex}}
- Line 3368, unix : \textcolor{black}{\input{_input/table_cxii.tex}}
- Line 3377, windows : as its full-information and exogenous-information counterparts.}{\footnotesize\par}
- Line 3391, unix : \includegraphics[viewport=-40bp -2bp 900bp 355bp,clip,scale=0.65]{_input/figure_d1}
- Line 3401, windows : the Epanechnikov kernel.}{\footnotesize\par}
- Line 3412, unix : \textcolor{black}{\input{_input/table_di.tex}}
- Line 3429, windows : the employed and unemployed.}{\footnotesize\par}

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_cviii.tex**

- Line 12, unix : & $\text{Gini}(K)$ & $90/10$ & $99/1$ & $90/50$ & $\text{Cor}(K,Y)$ \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/getDirs.m**

- Line 10, unix : CodeDir = '~/GitHub/BKKS/';
- Line 12, unix : SaveDir='/Users/tobiasbroer/Dropbox/Research/Current_Projects/';
- Line 13, unix : CodeDir='/Users/tobiasbroer/GutHub/BKKS/';

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/figure_b1.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 53, unix : print(figureB1, '_figures/figure_B1.pdf', '-dpdf', '-image');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/wprctile.m**

- Line 25, unix : %         Type 4: p(k) = k/n. That is, linear interpolation of the empirical cdf.
- Line 34, unix : %         Type 8: p(k) = (k-1/3)/(n+1/3). Then p(k) =~ median[F(x[k])].
- Line 37, unix : %         Type 9: p(k) = (k-3/8)/(n+1/4). The resulting quantile estimates are
- Line 66, unix : % version 1.0.0, Release 2007/10/16: Initial release
- Line 67, unix : % version 1.1.0, Release 2008/04/02: Implementation of other 5 algorithms and
- Line 166, unix : pk = k/n;
- Line 168, unix : pk = (k-sortedW/2)/n;
- Line 174, unix : pk = (k-sortedW/3)/(n+1/3);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_i.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_ii.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_data/_aux/bvar_est.m**

- Line 72, unix : prob_up(tt) = count/smpl;
- Line 81, unix : mdate          = [qdate(p+1):1/12:qdate(end)]';

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_bii.m**

- Line 11, unix : %addpath( fullfile( parentFolder, '_data/_data/' ) );
- Line 64, windows : %resultsfolder = [pathstr '\_aux\_models\'];
- Line 65, unix : resultsfolder = [pathstr '/_aux/_models_tmp/'];
- Line 104, unix : fid = fopen('_table/table_bii.tex', 'w');
- Line 107, windows : fprintf(fid, '\\toprule\n');
- Line 111, windows : fprintf(fid, '\\midrule\n');
- Line 113, windows : fprintf(fid, '\\midrule\n');
- Line 119, windows : fprintf(fid, '\\midrule\n');
- Line 124, windows : fprintf(fid, '\\midrule\n');
- Line 126, windows : fprintf(fid, '\\midrule\n');
- Line 132, windows : fprintf(fid, '\\midrule\n');
- Line 136, windows : fprintf(fid, '\\midrule\n');
- Line 138, windows : fprintf(fid, '\\midrule\n');
- Line 145, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/inequality_moments.m**

- Line 7, unix : load([SaveDir 'BKKS_Shadow/_modelresults/model_1001.mat'])
- Line 10, unix : load([SaveDir 'BKKS_Shadow/_modelresults/model_1023.mat'])
- Line 13, unix : load([ SaveDir 'BKKS_Shadow/_modelresults/model_1026.mat'])
- Line 18, unix : load([SaveDir 'BKKS_Shadow/_modelresults/entrepreneur/model_98.mat'])
- Line 21, unix : load([SaveDir 'BKKS_Shadow/_modelresults/entrepreneur/model_96.mat'])
- Line 24, unix : load([ SaveDir 'BKKS_Shadow/_modelresults/entrepreneur/model_97.mat'])
- Line 40, unix : % rel_moments(:,2)=[ineq_moments_bench.std_top_one_share/ineq_moments_bench.y_log_stdev
- Line 41, unix : %     ineq_moments_bench.std_fifty_ninety_share/ineq_moments_bench.y_log_stdev
- Line 42, unix : %     ineq_moments_bench.std_bottom_fifty_share/ineq_moments_bench.y_log_stdev];
- Line 45, unix : % rel_moments(:,3)=[ineq_moments_FI.std_top_one_share/ineq_moments_FI.y_log_stdev
- Line 46, unix : %     ineq_moments_FI.std_fifty_ninety_share/ineq_moments_FI.y_log_stdev
- Line 47, unix : %     ineq_moments_FI.std_bottom_fifty_share/ineq_moments_FI.y_log_stdev];
- Line 49, unix : % rel_moments(:,4)=[ineq_moments_exo.std_top_one_share/ineq_moments_exo.y_log_stdev
- Line 50, unix : %     ineq_moments_exo.std_fifty_ninety_share/ineq_moments_exo.y_log_stdev
- Line 51, unix : %     ineq_moments_exo.std_bottom_fifty_share/ineq_moments_exo.y_log_stdev];
- Line 238, unix : cd([SaveDir 'BKKS_Shadow/_modelresults/']);
- Line 241, unix : cd([SaveDir 'BKKS_Shadow/_modelresults/entrepreneur/']);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_data/make_table3_data.do**

- Line 3, unix : use _data/psid_2004_2010
- Line 202, windows : file write fh "\hline\hline" _n
- Line 210, unix : forvalues i=1/6 {
- Line 229, windows : file write fh "\hline\hline" _n

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/figure_3_and_4.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 172, unix : print(figure1, '_figures/figure_3a.pdf', '-dpdf', '-image');
- Line 248, unix : print(figure2, '_figures/figure_3b.pdf', '-dpdf', '-image');
- Line 318, unix : print(figure3, '_figures/figure_4a.pdf', '-dpdf', '-image');
- Line 388, unix : print(figure4, '_figures/figure_4b.pdf', '-dpdf', '-image');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/Redo_Wealth_Moments_Ent.m**

- Line 27, unix : load(['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/model_' int2str(model_to_run) model_variant{i} '.mat']);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/calculate_fcerrors_stoch_optimized.m**

- Line 96, unix : % For quintile/decile means
- Line 123, unix : % For regressions, need to store quintile/decile assignments and errors
- Line 141, windows : fprintf('  t = %d/%d\n', t, T);
- Line 349, unix : %% Compute quintile/decile means
- Line 410, unix : %% Run regressions - ur_up (both 1q and 4q use same quintiles/deciles)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_kvar/solve_value.m**

- Line 153, unix : % W0/Wp
- Line 156, unix : % V0/Vp
- Line 304, unix : % Vp(i_less_no)   =  euler/params.ev_shock + Wp_prior(i_less_no) + ...
- Line 308, unix : % Vp(no_less_i)   =  euler/params.ev_shock + Wp_info(no_less_i) + ...

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_ci.tex**

- Line 13, unix : & $\text{Gini}(G)$ & $90/10$ & $99/1$ & $90/50$ & $\text{Cor}(K,Y)$\\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/figure_6.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 17, unix : start      = -750/1000;
- Line 18, unix : stop       = 2000/1000;
- Line 64, unix : x  = x/1000;
- Line 131, unix : print(f, '_figures/figure_6.pdf', '-dpdf', '-image');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/calculate_ineq_moments_stoch.m**

- Line 9, unix : % idshock   = ishocks this is just the emp/unemp dimension

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_di.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 6, unix : & $\mu(K)$ & $\sigma(Y)$ & $\text{Gini}(K)$ & $90/50$  & Info U. & Info E.\\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_kvar/solve_experience.m**

- Line 202, unix : % W0/Wp
- Line 205, unix : % V0/Vp
- Line 208, unix : % cpol is a function of m,pz,pk/s, so we need to replicated it across the z
- Line 498, unix : j   = ceil(tj/npzp);
- Line 653, windows : % fprintf('%f\n',X_diff)
- Line 725, unix : Vp(i_less_no)   =  euler/params.ev_shock + EXp_no(i_less_no) + ...
- Line 728, unix : Vp(no_less_i)   =  euler/params.ev_shock + EXp_info(no_less_i) + ...

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/figure_c1.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 291, unix : % print(f, '_figures/figure_c1.pdf', '-dpdf', '-image');
- Line 450, unix : print(f, '_figures/figure_c1.pdf', '-dpdf', '-image');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_cxi.m**

- Line 6, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_a10.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_kvar/GaussHermite_2.m**

- Line 22, unix : a   = sqrt(i/2);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/make_table_bench_compare.m**

- Line 27, unix : base_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];
- Line 31, unix : base_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];
- Line 35, unix : base_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];
- Line 39, unix : wtax_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];
- Line 44, unix : wtax_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];
- Line 49, unix : wtax_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];
- Line 54, unix : ui_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];
- Line 58, unix : ui_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];
- Line 62, unix : ui_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];
- Line 82, unix : fid = fopen('~/Dropbox/BKKS_Shadow/_revision2/_input/table_comp_wtax_final.tex', 'w');
- Line 86, windows : fprintf(fid, '\\toprule\n');
- Line 87, windows : fprintf(fid, '\\toprule\n');
- Line 91, unix : fprintf(fid, ' & $\\mu(K)$ & $\\sigma(Y)$ & $\\text{Gini}(K)$ & $90/10$& $99/1$& $90/50$ & Info U. & Info E.\\\\\n');
- Line 92, windows : fprintf(fid, '\\midrule\n');
- Line 109, windows : fprintf(fid, '\\bottomrule\n');
- Line 110, windows : fprintf(fid, '\\bottomrule\n');
- Line 117, unix : fid = fopen('~/Dropbox/BKKS_Shadow/_revision2/_input/table_comp_ui_final.tex', 'w');
- Line 121, windows : fprintf(fid, '\\toprule\n');
- Line 122, windows : fprintf(fid, '\\toprule\n');
- Line 126, unix : fprintf(fid, ' & $\\mu(K)$ & $\\sigma(Y)$ & $\\text{Gini}(K)$ & $90/10$& $99/1$& $90/50$  & Info U. & Info E.\\\\\n');
- Line 127, windows : fprintf(fid, '\\midrule\n');
- Line 144, windows : fprintf(fid, '\\bottomrule\n');
- Line 145, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_kvar/DoPanelExPost.m**

- Line 21, unix : save('/Users/kmitm/Dropbox/BKKS_Shadow/_modelresults/kvar-prior/fullpanel_model_2044.mat', 'a0', 'a1', 'cpol', 'dec', 'X','ipol', 'kdist0', 'pdist0', 'pKdist0', 'ishocksT','forecast_moments','moments','diff_a','params','Kvec','Kvec_u','Kvec_e','kdist_panel','-v7.3')

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_kvar/calculate_fcerrors_stoch.m**

- Line 8, unix : % idshock   = ishocks this is just the emp/unemp dimension
- Line 16, unix : % B         = params.a0/params.a1 4x1 int/slope bad int/slope good a0(1)
- Line 49, unix : % CALCULATE QUINTILES/DECILES (DEFINED SEPARATELY EACH PERIOD)
- Line 178, unix : %means by quintile/decile

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_cii.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 11, unix : %Endogenous      =  fullfile(scriptDir, '_aux/_models/model_1001.mat');
- Line 12, unix : %Full            =  fullfile(scriptDir, '_aux/_models/model_1023.mat');
- Line 13, unix : %Exogenous       =  fullfile(scriptDir, '_aux/_models/model_1026.mat');
- Line 15, unix : Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
- Line 16, unix : Full            =  fullfile(scriptDir, '_aux/_models_tmp/model_1023.mat');
- Line 17, unix : Exogenous       =  fullfile(scriptDir, '_aux/_models_tmp/model_1026.mat');
- Line 29, unix : fid = fopen(fullfile(scriptDir, '_table/table_cii.tex'), 'w');
- Line 33, windows : fprintf(fid, '\\toprule\n');
- Line 34, windows : fprintf(fid, '\\toprule\n');
- Line 37, unix : fprintf(fid, '& $ \\sigma{Gini}$ & $\\sigma(90/50) $ & $\\sigma(99/50)$ & $\\text{Corr}(90,10)$ & $\\text{Corr}(99,10)$\\\\\n');
- Line 38, windows : fprintf(fid, '\\midrule\n');
- Line 55, windows : fprintf(fid, '\\bottomrule\n');
- Line 56, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_iii.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/slim_models_tmp.m**

- Line 3, unix : %  SLIM_MODELS_TMP -- shrink _aux/_models_tmp from ~82 GB to ~0.29 GB
- Line 7, unix : %        _baseline/modelsMasterExcel.xlsx or _kvar/modelsMasterExcel.xlsx,
- Line 19, unix : %  params/a0/a1/cpol/dec/X/ipol/moments, but the output scripts in
- Line 96, windows : fprintf(' slim_models_tmp   %s\n', datestr(now, 'yyyy-mm-dd HH:MM:SS'));
- Line 97, windows : fprintf(' target : %s\n', datapath);
- Line 98, windows : fprintf(' mode   : %s\n', ternary(DRY_RUN, 'DRY RUN (nothing written)', 'EXECUTE'));
- Line 99, windows : fprintf('=======================================================\n\n');
- Line 102, mixed : fprintf('Directory size before: %8.2f GB\n\n', startBytes/1e9);
- Line 105, windows : fprintf('--- PHASE 1: slim %d keep-files --------------------------\n\n', numel(KEEP_FILES));
- Line 110, windows : fprintf('  [CLEAN]   removing stale temp %s\n', stale(s).name);
- Line 127, windows : fprintf('  [MISSING] %-24s  -- not present, cannot slim\n', name);
- Line 139, windows : fprintf('  [ERROR]   %-24s  -- unreadable: %s\n', name, ME.message);
- Line 150, mixed : fprintf('  [SKIP]    %-24s  %7.1f MB  already slim\n', name, before/1e6);
- Line 157, windows : fprintf('  [ERROR]   %-24s  -- nothing would remain\n', name);
- Line 165, windows : fprintf('(dry run)  drop: %s%s\n', strjoin(dropped, ', '), ...
- Line 204, unix : v(fmI).bytes/1e6);
- Line 219, unix : fprintf('%7.1f MB  (saved %6.2f GB)\n', after/1e6, (before-after)/1e9);
- Line 232, windows : fprintf('--- PHASE 2: delete %d regenerable files -----------------\n\n', numel(DELETE_FILES));
- Line 237, windows : fprintf('  already-slimmed files will be skipped automatically.\n\n');
- Line 244, windows : fprintf('  [GONE]    %-24s  already absent\n', name);
- Line 249, unix : fprintf('  [DELETE]  %-24s  %7.2f GB  (dry run)\n', name, d.bytes/1e9);
- Line 253, windows : fprintf('  [ERROR]   %-24s  delete failed\n', name);
- Line 255, mixed : fprintf('  [DELETE]  %-24s  %7.2f GB  removed\n', name, d.bytes/1e9);
- Line 260, unix : fprintf('\n  reclaimed by deletion: %.2f GB\n\n', delBytes/1e9);
- Line 270, mixed : fprintf(' Directory size before : %8.2f GB\n', startBytes/1e9);
- Line 271, mixed : fprintf(' Directory size after  : %8.2f GB\n', endBytes/1e9);
- Line 272, windows : fprintf(' Reclaimed             : %8.2f GB\n', (startBytes-endBytes)/1e9);
- Line 275, windows : fprintf([' REMINDER: the figures that consume panel data\n' ...
- Line 278, windows : '  table_iii) now require section [1] of model_master.m to be\n' ...

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/make_table_entrepreneur_compare.m**

- Line 3, unix : base_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_fi.mat'];
- Line 4, unix : base_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_exo.mat'];
- Line 5, unix : base_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '.mat'];
- Line 6, unix : % scaledmodel = '~/GitHub/BKKS/model_1062.mat';
- Line 7, unix : % wtax_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/model_' int2str(model_to_run) '_fi_wtax_kink2.mat'];
- Line 8, unix : % wtax_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/model_' int2str(model_to_run) '_exo_wtax_kink.mat'];
- Line 9, unix : wtax_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_wtax_rebate.mat'];
- Line 10, unix : wtax_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_fi_wtax_rebate.mat'];
- Line 11, unix : wtax_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_exo_wtax_rebate.mat'];
- Line 12, unix : % wtax_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/model_' int2str(model_to_run) '_wtax_kink.mat'];
- Line 14, unix : ui_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_fi_ui.mat'];
- Line 15, unix : ui_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_exo_ui.mat'];
- Line 16, unix : ui_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_ui.mat'];
- Line 36, unix : fid = fopen('~/Dropbox/BKKS_Shadow/_revision2/_input/table_ent_comp_wtax_final.tex', 'w');
- Line 40, windows : fprintf(fid, '\\toprule\n');
- Line 41, windows : fprintf(fid, '\\toprule\n');
- Line 45, unix : fprintf(fid, 'Entrepreneur Model & $\\mu(K)$ & $\\sigma(Y)$ & $\\text{Gini}(K)$ & $90/50$ & Info U. & Info E.\\\\\n');
- Line 46, windows : fprintf(fid, '\\midrule\n');
- Line 63, windows : fprintf(fid, '\\bottomrule\n');
- Line 64, windows : fprintf(fid, '\\bottomrule\n');
- Line 71, unix : fid = fopen('~/Dropbox/BKKS_Shadow/_revision2/_input/table_ent_comp_ui_final.tex', 'w');
- Line 75, windows : fprintf(fid, '\\toprule\n');
- Line 76, windows : fprintf(fid, '\\toprule\n');
- Line 80, unix : fprintf(fid, 'Entrepreneur Model & $\\mu(K)$ & $\\sigma(Y)$ & $\\text{Gini}(K)$ & $90/50$  & Info U. & Info E.\\\\\n');
- Line 81, windows : fprintf(fid, '\\midrule\n');
- Line 98, windows : fprintf(fid, '\\bottomrule\n');
- Line 99, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_ciii.m**

- Line 6, unix : addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_data/data_master.R**

- Line 23, unix : #    MATLAB_BIN=/Applications/MATLAB_R2024b.app/bin/matlab Rscript data_master.R
- Line 76, unix : #  sce_data.R writes _aux/data_sce.rda, the input to every script in [2].

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_kvar/calculate_ineq_moments_stoch.m**

- Line 9, unix : % idshock   = ishocks this is just the emp/unemp dimension

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_di.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 10, unix : %Endogenous      =  fullfile(scriptDir, '_aux/_models/model_7009.mat');
- Line 11, unix : %Full            =  fullfile(scriptDir, '_aux/_models/model_7009_fi.mat');
- Line 12, unix : %Exogenous       =  fullfile(scriptDir, '_aux/_models/model_7009_exo.mat');
- Line 14, unix : %Endogenous_rep    =  fullfile(scriptDir, '_aux/_models/model_7009_ui.mat');
- Line 15, unix : %Full_rep          =  fullfile(scriptDir, '_aux/_models/model_7009_fi_ui.mat');
- Line 16, unix : %Exogenous_rep     =  fullfile(scriptDir, '_aux/_models/model_7009_exo_ui.mat');
- Line 18, unix : Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_7009.mat');
- Line 19, unix : Full            =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_fi.mat');
- Line 20, unix : Exogenous       =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_exo.mat');
- Line 22, unix : Endogenous_rep    =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_ui.mat');
- Line 23, unix : Full_rep          =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_fi_ui.mat');
- Line 24, unix : Exogenous_rep     =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_exo_ui.mat');
- Line 44, unix : fid = fopen(fullfile(scriptDir, '_table/table_di.tex'), 'w');
- Line 48, windows : fprintf(fid, '\\toprule\n');
- Line 49, windows : fprintf(fid, '\\toprule\n');
- Line 52, unix : fprintf(fid, '& $\\mu(K)$ & $\\sigma(Y) $ Gini (G) $ & $90/50$ & $\\text{Info U.}$ & $\\text{Info E.}$\\\\\n');
- Line 53, windows : fprintf(fid, '\\midrule\n');
- Line 73, windows : fprintf(fid, '\\bottomrule\n');
- Line 74, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/figure_b2.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 16, unix : start      = -750/1000;
- Line 17, unix : stop       = 2000/1000;
- Line 63, unix : x  = x/1000;
- Line 114, unix : YData1 = YData1/m80;
- Line 120, unix : YData2 = YData2/m80;
- Line 147, unix : print(f, '_figures/figure_B2.pdf', '-dpdf', '-image');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_cviii.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 10, unix : %Benchmark      =  fullfile(scriptDir, '_aux/_models/model_1001.mat');
- Line 11, unix : %Scaledev       =  fullfile(scriptDir, '_aux/_models/model_1066.mat');
- Line 13, unix : Benchmark      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
- Line 14, unix : Scaledev       =  fullfile(scriptDir, '_aux/_models_tmp/model_1066.mat');
- Line 25, unix : fid = fopen(fullfile(scriptDir, '_table/table_cviii.tex'), 'w');
- Line 29, windows : fprintf(fid, '\\toprule\n');
- Line 30, windows : fprintf(fid, '\\toprule\n');
- Line 34, windows : fprintf(fid, '\\midrule\n');
- Line 51, unix : fprintf(fid, '& $ Gini (K) $ & $ 90/10 $ & $99/1$ & $ 90/50$ & $\\text{Corr}(K,Y)$\\\\\n');
- Line 52, windows : fprintf(fid, '\\midrule\n');
- Line 66, windows : fprintf(fid, '\\bottomrule\n');
- Line 67, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_civ.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 11, unix : %Endogenous      =  fullfile(scriptDir, '_aux/_models/model_1018.mat');
- Line 12, unix : %Full            =  fullfile(scriptDir, '_aux/_models/model_1047.mat');
- Line 13, unix : %Exogenous       =  fullfile(scriptDir, '_aux/_models/model_1050.mat');
- Line 15, unix : Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1018.mat');
- Line 16, unix : Full            =  fullfile(scriptDir, '_aux/_models_tmp/model_1047.mat');
- Line 17, unix : Exogenous       =  fullfile(scriptDir, '_aux/_models_tmp/model_1050.mat');
- Line 30, unix : fid = fopen(fullfile(scriptDir, '_table/table_civ.tex'), 'w');
- Line 34, windows : fprintf(fid, '\\toprule\n');
- Line 35, windows : fprintf(fid, '\\toprule\n');
- Line 40, windows : fprintf(fid, '\\midrule\n');
- Line 57, windows : fprintf(fid, '\\midrule\n');
- Line 61, windows : fprintf(fid, '\\midrule\n');
- Line 76, windows : fprintf(fid, '\\bottomrule\n');
- Line 77, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/InfoDecomposition.m**

- Line 7, unix : %  Writes _aux/_models_tmp/model_7009_decomp.mat, the input to
- Line 8, unix : %  /_model/table_cxi.m (Table C.11).

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/calculate_moments_stoch.m**

- Line 9, unix : % idshock   = ishocks this is just the emp/unemp dimension
- Line 45, unix : kmts_dollar = kmts/conversion_to_dollars;
- Line 62, unix : invest_dollar = invest/conversion_to_dollars;
- Line 81, unix : y_dollar = y/conversion_to_dollars;
- Line 107, unix : cmts_dollar = cmts/conversion_to_dollars;

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_ciii.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline\\[-1.8ex]
- Line 8, unix : [1em] $90/10-$ratio   & 2.72 & -2.91	& 7.31  & -1.40   &  -0.27 \\
- Line 9, unix : [1em] $99/1-$ratio    & 5.04 &-13.90	& 20.65 &	-3.73  &   2.03 \\
- Line 11, unix : %[1em] $90/10-$ratio  & 2.64 & -2.99   & 7.31  & -1.40 & -0.28 \\
- Line 12, unix : %[1em] $99/1-$ratio    & 4.67 & -13.92 & 20.67 & -3.73 & 1.65 \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_a7.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/calculate_fcerrors_stoch.m**

- Line 8, unix : % idshock   = ishocks this is just the emp/unemp dimension
- Line 16, unix : % B         = params.a0/params.a1 4x1 int/slope bad int/slope good a0(1)
- Line 49, unix : % CALCULATE QUINTILES/DECILES (DEFINED SEPARATELY EACH PERIOD)
- Line 178, unix : %means by quintile/decile

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_iv.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 6, unix : &  Gini G& $90/10$ & $99/1$ & $90/50$ &$\text{Cor}(K,Y )$ \\
- Line 14, unix : &  Gini G & $90/10$ & $99/1$ & $90/50$  &$\text{Cor}(K, Y)$ \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/BKKS_main.m**

- Line 60, unix : % if params.probdeath==1/160
- Line 62, unix : % elseif params.probdeath==1/200
- Line 146, unix : sigy=sqrt(parIn.sigyPartial/(1+sqrt(rho)+rho+rho^(3/2)));
- Line 233, unix : params.e(3) = 1/ent_share;
- Line 558, unix : % load('~/Dropbox/BKKS_Shadow/new_code_results/MMEndoInfoK05Results','ipol')
- Line 559, unix : % load('~/Dropbox/BKKS_Shadow/new_code_results/MMEndoInfoK05Results','cpol')
- Line 560, unix : % load('~/Dropbox/BKKS_Shadow/new_code_results/MMEndoInfoK05Results','X')
- Line 685, unix : a0=a0/1.02
- Line 697, windows : fprintf('iter=%d eps=%f R2=%f R2=%f\n',iter,diff_a,s1(1),s2(1))

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_cix.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 11, unix : %Benchmark      =  fullfile(scriptDir, '_aux/_models/model_1001.mat');
- Line 12, unix : %Scaledev       =  fullfile(scriptDir, '_aux/_models/model_1074.mat');
- Line 13, unix : Benchmark      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
- Line 14, unix : Scaledev       =  fullfile(scriptDir, '_aux/_models_tmp/model_1074.mat');
- Line 25, unix : fid = fopen(fullfile(scriptDir, '_table/table_cix.tex'), 'w');
- Line 29, windows : fprintf(fid, '\\toprule\n');
- Line 30, windows : fprintf(fid, '\\toprule\n');
- Line 34, windows : fprintf(fid, '\\midrule\n');
- Line 51, unix : fprintf(fid, '& $ Gini (K) $ & $ 90/10 $ & $99/1$ & $ 90/50$ & $\\text{Corr}(K,Y)$\\\\\n');
- Line 52, windows : fprintf(fid, '\\midrule\n');
- Line 66, windows : fprintf(fid, '\\bottomrule\n');
- Line 67, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/make_table_entrepreneur_fi.m**

- Line 4, unix : basemodel = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_fi.mat'];
- Line 5, unix : exomodel = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_exo.mat'];
- Line 6, unix : scaledmodel =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '.mat'];
- Line 8, unix : % scaledmodel = '~/GitHub/BKKS/model_1062.mat';
- Line 19, unix : fid = fopen('~/Dropbox/BKKS_Shadow/_revision2/_input/table_ent_fi.tex', 'w');
- Line 23, windows : fprintf(fid, '\\toprule\n');
- Line 24, windows : fprintf(fid, '\\toprule\n');
- Line 29, windows : fprintf(fid, '\\midrule\n');
- Line 52, windows : fprintf(fid, '\\midrule\n');
- Line 56, unix : fprintf(fid, '& $\\text{Gini}(K)$ & $90/10$ & $99/1$ & $\\text{Cor}(K,Y)$ & $\\text{Cor}(G,Y)$\\\\\n');
- Line 57, windows : fprintf(fid, '\\midrule\n');
- Line 81, windows : fprintf(fid, '\\bottomrule\n');
- Line 82, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_a8.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline\\[-1.8ex]

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_data/table_a8.R**

- Line 166, unix : p_val_save[1,2] = p_val_save[1,2]-11/100

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_kvar/simKS.m**

- Line 11, unix : kapshocks=shocks.kapshocks/2;
- Line 12, unix : kinfoshocks=shocks.kinfoshocks/2;

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/figure_8.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 244, unix : exportgraphics(figure1,'_figures/figure_8.pdf', ...

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_kvar/BKKS_main.m**

- Line 59, unix : % if params.probdeath==1/160
- Line 61, unix : % elseif params.probdeath==1/200
- Line 145, unix : sigy=sqrt(parIn.sigyPartial/(1+sqrt(rho)+rho+rho^(3/2)));
- Line 232, unix : params.e(3) = 1/ent_share;
- Line 552, unix : % load('~/Dropbox/BKKS_Shadow/new_code_results/MMEndoInfoK05Results','ipol')
- Line 553, unix : % load('~/Dropbox/BKKS_Shadow/new_code_results/MMEndoInfoK05Results','cpol')
- Line 554, unix : % load('~/Dropbox/BKKS_Shadow/new_code_results/MMEndoInfoK05Results','X')
- Line 927, unix : a0=a0/1.02
- Line 939, windows : fprintf('iter=%d eps=%f R2=%f R2=%f\n',iter,diff_a,s1(1),s2(1))

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_cvi.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 11, unix : %Endogenous      =  fullfile(scriptDir, '_aux/_models/model_1001.mat');
- Line 12, unix : %Full               =  fullfile(scriptDir, '_aux/_models/model_1023.mat');
- Line 13, unix : %Exogenous          =  fullfile(scriptDir, '_aux/_models/model_1026.mat');
- Line 14, unix : %Full_no            =  fullfile(scriptDir, '_aux/_models/model_1033.mat');
- Line 15, unix : %Exogenous_no       =  fullfile(scriptDir, '_aux/_models/model_1036.mat');
- Line 17, unix : Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
- Line 18, unix : Full               =  fullfile(scriptDir, '_aux/_models_tmp/model_1023.mat');
- Line 19, unix : Exogenous          =  fullfile(scriptDir, '_aux/_models_tmp/model_1026.mat');
- Line 20, unix : Full_no            =  fullfile(scriptDir, '_aux/_models_tmp/model_1033.mat');
- Line 21, unix : Exogenous_no       =  fullfile(scriptDir, '_aux/_models_tmp/model_1036.mat');
- Line 35, unix : fid = fopen(fullfile(scriptDir, '_table/table_cvi.tex'), 'w');
- Line 39, windows : fprintf(fid, '\\toprule\n');
- Line 40, windows : fprintf(fid, '\\toprule\n');
- Line 43, windows : fprintf(fid, '\\midrule\n');
- Line 50, windows : fprintf(fid, '\\midrule\n');
- Line 60, windows : fprintf(fid, '\\midrule\n');
- Line 72, windows : fprintf(fid, '\\midrule\n');
- Line 86, windows : fprintf(fid, '\\bottomrule\n');
- Line 87, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/data_bib.tex**

- Line 8, unix : % _paper/literature.bib).
- Line 17, unix : % Series read via _data/_data/business_cycle_data.xlsx by _data/table_b2_a.m:

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_cv.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 10, unix : %Endogenous      =  fullfile(scriptDir, '_aux/_models/model_1018.mat');
- Line 11, unix : %Full            =  fullfile(scriptDir, '_aux/_models/model_1047.mat');
- Line 12, unix : %Exogenous       =  fullfile(scriptDir, '_aux/_models/model_1050.mat');
- Line 14, unix : Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1018.mat');
- Line 15, unix : Full            =  fullfile(scriptDir, '_aux/_models_tmp/model_1047.mat');
- Line 16, unix : Exogenous       =  fullfile(scriptDir, '_aux/_models_tmp/model_1050.mat');
- Line 28, unix : fid = fopen(fullfile(scriptDir, '_table/table_cv.tex'), 'w');
- Line 32, windows : fprintf(fid, '\\toprule\n');
- Line 33, windows : fprintf(fid, '\\toprule\n');
- Line 37, unix : fprintf(fid, '& $ Gini (G) $ & $ 90/10 $ & $99/1$ & $90/50$ & $\\text{Corr}(K,Y)$\\\\\n');
- Line 38, windows : fprintf(fid, '\\midrule\n');
- Line 55, windows : fprintf(fid, '\\midrule\n');
- Line 58, unix : fprintf(fid, '& $ Gini (G) $ & $ 90/10 $ & $99/1$ & $90/50$ & $\\text{Corr}(K,Y)$\\\\\n');
- Line 59, windows : fprintf(fid, '\\midrule\n');
- Line 74, windows : fprintf(fid, '\\bottomrule\n');
- Line 75, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_i_and_ii.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 11, unix : %Endogenous      =  fullfile(scriptDir, '_aux/_models/model_1001.mat');
- Line 12, unix : %Full            =  fullfile(scriptDir, '_aux/_models/model_1023.mat');
- Line 13, unix : %Exogenous       =  fullfile(scriptDir, '_aux/_models/model_1026.mat');
- Line 15, unix : Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
- Line 16, unix : Full            =  fullfile(scriptDir, '_aux/_models_tmp/model_1023.mat');
- Line 17, unix : Exogenous       =  fullfile(scriptDir, '_aux/_models_tmp/model_1026.mat');
- Line 29, unix : fid = fopen(fullfile(scriptDir, '_table/table_ii.tex'), 'w');
- Line 33, windows : fprintf(fid, '\\toprule\n');
- Line 34, windows : fprintf(fid, '\\toprule\n');
- Line 39, windows : fprintf(fid, '\\midrule\n');
- Line 56, windows : fprintf(fid, '\\midrule\n');
- Line 60, windows : fprintf(fid, '\\midrule\n');
- Line 75, windows : fprintf(fid, '\\bottomrule\n');
- Line 76, windows : fprintf(fid, '\\bottomrule\n');
- Line 86, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 89, unix : Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
- Line 92, unix : T = readtable('_aux/_models_tmp/calibration.csv');
- Line 97, unix : fid = fopen(fullfile(scriptDir, '_table/table_i.tex'), 'w');
- Line 100, windows : fprintf(fid, '\\toprule\n');
- Line 101, windows : fprintf(fid, '\\toprule\n');
- Line 104, windows : fprintf(fid, '\\midrule\n');
- Line 118, windows : fprintf(fid, '\\bottomrule\n');
- Line 119, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/run_all.sh**

- Line 1, unix : #!/usr/bin/env bash
- Line 11, unix : #    [1] _data/data_master.R   -- Section 2, Online Appendix A,
- Line 13, unix : #    [2] _model/model_master.m -- Sections 4, 5, 6, Online Appendices B, C, D
- Line 25, unix : #    RSCRIPT_BIN=/usr/local/bin/Rscript \
- Line 26, unix : #    MATLAB_BIN=/Applications/MATLAB_R2024b.app/bin/matlab \
- Line 27, unix : #    STATA_BIN=/Applications/Stata/StataMP.app/Contents/MacOS/stata-mp \
- Line 32, unix : #  intermediate results written to _model/_aux/_models_tmp/.
- Line 58, windows : printf '%s\n' "${from_env}"
- Line 67, windows : printf '%s\n' "${candidate}"
- Line 87, unix : '/usr/local/bin/Rscript' \
- Line 88, unix : '/opt/homebrew/bin/Rscript' \
- Line 148, unix : '/usr/local/bin/Rscript' '/opt/homebrew/bin/Rscript' \

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_iii.m**

- Line 4, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 5, unix : addpath(fullfile(scriptDir, '_aux/_baseline/'));
- Line 8, unix : Entrepreneur    =  fullfile(scriptDir, '_aux/_models_tmp/model_7009.mat');
- Line 9, unix : EntShocks       =  fullfile(scriptDir, '_aux/_models_tmp/NE3Shocks3.mat');
- Line 10, unix : Baseline        =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
- Line 11, unix : BaseShocks      =  fullfile(scriptDir, '_aux/_models_tmp/NewShocks.mat');
- Line 13, unix : Basefile=fullfile(scriptDir, '_table/table_iii_model_base.tex');
- Line 14, unix : Entfile=fullfile(scriptDir, '_table/table_iii_model_ent.tex');
- Line 75, windows : fprintf(fid, '\\toprule\n');
- Line 76, windows : fprintf(fid, '\\toprule\n');
- Line 79, windows : fprintf(fid, '\\midrule\n');
- Line 89, windows : fprintf(fid, '\\bottomrule\n');
- Line 90, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_kvar/solve_EGM.m**

- Line 56, unix : % If you acquire information, then pz'=1 w/prob pz, and pz'=0 w/prob (1-pz)
- Line 312, unix : % k and the individual productivity/employment state.
- Line 458, unix : c_s = Emup.^(-1/params.sigma);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_cvii.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 5, windows : \hline\hline\\[-1.8ex]
- Line 6, unix : & $\text{Gini}(K)$ & $90/10$ & $99/1$  & $90/50$ &  $\text{Cor}(K, Y)$  \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_a9.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_vi.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 6, unix : & $\mu(K)$ & $\sigma(Y) $ & Gini (G)  & $ 90/10 $ & $99/1$ & $90/50$ & $\text{Info U.}$ & $\text{Info E.}$\\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/figure_5.m**

- Line 7, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 8, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 16, unix : dataMax     = 1/00;
- Line 121, unix : print(f, '_figures/figure_5ab.pdf', '-dpdf', '-image');
- Line 184, unix : print(f, '_figures/figure_5cd.pdf', '-dpdf', '-image');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_cxii.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 10, unix : %Endogenous        =  fullfile(scriptDir, '_aux/_models/model_2044.mat');
- Line 11, unix : %Exogenous         =  fullfile(scriptDir, '_aux/_models/model_2044_exo.mat');
- Line 12, unix : %Fullinformation   =  fullfile(scriptDir, '_aux/_models/model_2044_exo.mat');
- Line 14, unix : Endogenous        =  fullfile(scriptDir, '_aux/_models_tmp/model_2044.mat');
- Line 15, unix : Exogenous         =  fullfile(scriptDir, '_aux/_models_tmp/model_2052.mat');
- Line 16, unix : Fullinformation   =  fullfile(scriptDir, '_aux/_models_tmp/model_2051.mat');
- Line 27, unix : fid = fopen(fullfile(scriptDir, '_table/table_cxii.tex'), 'w');
- Line 31, windows : fprintf(fid, '\\toprule\n');
- Line 32, windows : fprintf(fid, '\\toprule\n');
- Line 36, windows : fprintf(fid, '\\midrule\n');
- Line 57, unix : fprintf(fid, '& $ Gini (K) $ & $ 90/10$  & $ 99/1$  & $ 90/50$  & $\\text{Corr}(K,Y)$\\\\\n');
- Line 58, windows : fprintf(fid, '\\midrule\n');
- Line 79, windows : fprintf(fid, '\\bottomrule\n');
- Line 80, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_cxi.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \toprule\toprule\\[-1.8ex]

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_cxii.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline\\[-1.8ex]
- Line 16, unix : & $\text{Gini}(K)$ & $90/10$ & $99/1$ & $90/50$ & $\text{Cor}(K,Y)$ \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/figure_c3.m**

- Line 6, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 7, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 66, windows : b_1 = X\Y;
- Line 68, windows : b_1_norm = X\normalize(Y);
- Line 126, windows : b_2 = X\Y;
- Line 128, windows : b_2_norm = X\normalize(Y);
- Line 174, windows : b_2_old = X\Y;
- Line 223, unix : print(f, '_figures/figure_c3.pdf', '-dpdf', '-image');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_cx.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \toprule\toprule\\[-1.8ex]
- Line 16, unix : & $\text{Gini}(K)$ &   & $90/50 $  &  & $\text{Cor}(K,Y)$ \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_bii.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 3, windows : \hline\hline\\[-1.8ex]

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/figure_d1.m**

- Line 94, windows : fprintf("Done with model %d\n", jj);
- Line 102, unix : mult_factor = adj_factor/1000;                          % wealth in '000 $
- Line 160, unix : % exportgraphics(figure1, '_figures/figure_d1.pdf', ...
- Line 255, unix : exportgraphics(figure1, '_figures/figure_d1.pdf', ...

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/BKKS_GIRFs.m**

- Line 17, windows : shockpath = 'C:\Users\ksc.fi\Documents\GitHub\BKKS\';

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/figure_c2.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 65, windows : b_1 = X\Y;
- Line 69, windows : b_1_norm = X\normalize(Y);
- Line 131, windows : b_2 = X\Y;
- Line 135, windows : b_2_norm = X\normalize(Y);
- Line 181, windows : b_2_old = X\Y;
- Line 229, unix : print(f, '_figures/figure_c2.pdf', '-dpdf', '-image');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/table_cvii.m**

- Line 6, unix : %addpath(fullfile(scriptDir, '_aux/_models'));
- Line 7, unix : addpath(fullfile(scriptDir, '_aux/_models_tmp'));
- Line 11, unix : %Endogenous      =  fullfile(scriptDir, '_aux/_models/model_1001.mat');
- Line 12, unix : %Full               =  fullfile(scriptDir, '_aux/_models/model_1023.mat');
- Line 13, unix : %Exogenous          =  fullfile(scriptDir, '_aux/_models/model_1026.mat');
- Line 14, unix : %Full_no            =  fullfile(scriptDir, '_aux/_models/model_1033.mat');
- Line 15, unix : %Exogenous_no       =  fullfile(scriptDir, '_aux/_models/model_1036.mat');
- Line 17, unix : Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
- Line 18, unix : Full               =  fullfile(scriptDir, '_aux/_models_tmp/model_1023.mat');
- Line 19, unix : Exogenous          =  fullfile(scriptDir, '_aux/_models_tmp/model_1026.mat');
- Line 20, unix : Full_no            =  fullfile(scriptDir, '_aux/_models_tmp/model_1033.mat');
- Line 21, unix : Exogenous_no       =  fullfile(scriptDir, '_aux/_models_tmp/model_1036.mat');
- Line 35, unix : fid = fopen(fullfile(scriptDir, '_table/table_cvii.tex'), 'w');
- Line 39, windows : fprintf(fid, '\\toprule\n');
- Line 40, windows : fprintf(fid, '\\toprule\n');
- Line 42, unix : fprintf(fid, '& $ Gini (G) $ & $ 90/10 $ & $99/1$ & $90/50$ & $\\text{Corr}(K,Y)$\\\\\n');
- Line 43, windows : fprintf(fid, '\\midrule\n');
- Line 50, windows : fprintf(fid, '\\midrule\n');
- Line 60, windows : fprintf(fid, '\\midrule\n');
- Line 72, windows : fprintf(fid, '\\midrule\n');
- Line 86, windows : fprintf(fid, '\\bottomrule\n');
- Line 87, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_civ.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline\\[-1.8ex]

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/figure_7.m**

- Line 11, unix : datapath = [scriptDir '/_aux/_models_tmp/'];
- Line 12, unix : shockpath = [scriptDir '/_aux/_models_tmp/'];
- Line 17, unix : addpath([scriptDir '/_aux/_baseline']);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/.ipynb_checkpoints/make_readme_pdf-checkpoint.py**

- Line 1, unix : #!/usr/bin/env python3
- Line 6, unix : bullet lists, links, inline code, bold/italic, horizontal rules).
- Line 29, windows : return '\x00%d\x00' % (len(slots) - 1)
- Line 150, windows : out.append(r'\begingroup\small')
- Line 154, windows : out.append(r'\midrule\endhead')
- Line 254, windows : basicstyle=\ttfamily\small,

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/BKKS_start_runs.m**

- Line 39, unix : load(['../_models_tmp/model_' int2str(model_to_run) '.mat'],'moments');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_data/_aux/sce_data.R**

- Line 235, unix : data_sce$wealth_real   = data_sce$wealth/data_sce$P

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/get_moments_table.m**

- Line 13, unix : table_moments.comp=[moments.kbar_mean moments.y_log_stdev moments.gini moments.p90/moments.p10 moments.p99/moments.p1 moments.p90/moments.p50 moments.info_unemp moments.info_emp];
- Line 14, unix : table_moments.ent_comp=[moments.kbar_mean moments.y_log_stdev moments.gini moments.p90/moments.p50 moments.info_unemp moments.info_emp];

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_cii.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline\\[-1.8ex]
- Line 5, unix : & $\sigma(\text{Gini})$ & $\sigma(\text{90/50})$ &  $\sigma(\text{99/50})$ & $\text{Cor}(\text{90th,} \text{10th})$ & $\text{Cor}(\text{99th,} \text{10th})$ \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_cvi.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline\\[-1.8ex]

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_data/table_b2_a.m**

- Line 56, unix : fid = fopen('_tables/table_b2_a.tex', 'w');
- Line 59, windows : fprintf(fid, '\\toprule\n');
- Line 61, windows : fprintf(fid, '\\midrule\n');
- Line 68, windows : fprintf(fid, '\\bottomrule\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_model/_aux/_baseline/solve_EGM.m**

- Line 55, unix : % If you acquire information, then pz'=1 w/prob pz, and pz'=0 w/prob (1-pz)
- Line 242, unix : % k and the individual productivity/employment state.
- Line 338, unix : c_s = Emup.^(-1/params.sigma);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20221230-1/replication-package/_replication/_paper/_input/table_v.tex**

- Line 1, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 9, unix : Full Information w/o  Costs & $-0.02$ & $-0.00$ & $-0.28$ & Tables~\ref{tab:business-cycle-moments-angelvsdemon},~\ref{tab:inequality-moments-angelvsdemon} \\
- Line 10, unix : Exo. Information w/o Costs  & $-0.04$ & $-0.01$ & $-0.28$ & Tables~\ref{tab:business-cycle-moments-angelvsdemon},~\ref{tab:inequality-moments-angelvsdemon} \\

