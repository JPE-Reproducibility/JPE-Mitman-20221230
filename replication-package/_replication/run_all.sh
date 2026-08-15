#!/usr/bin/env bash
#
# =========================================================================
#
#  Master script for the replication package of
#  "Expectation and Wealth Heterogeneity in the Macroeconomy"
#  Tobias Broer, Alexandre Kohlhas, Kurt Mitman, Kathrin Schlafmann
#
#  Runs both branches of the package end to end:
#
#    [1] _data/data_master.R   -- Section 2, Online Appendix A,
#                                 Table B.2 panel (a), Table III data column
#    [2] _model/model_master.m -- Sections 4, 5, 6, Online Appendices B, C, D
#
#  Usage
#  -----
#    ./run_all.sh              run both branches
#    ./run_all.sh data         run the data branch only
#    ./run_all.sh model        run the model branch only
#    ./run_all.sh check        locate R, MATLAB and Stata and exit
#
#  Requires R, MATLAB and Stata on the machine. Each is located
#  automatically; override with environment variables if needed:
#
#    RSCRIPT_BIN=/usr/local/bin/Rscript \
#    MATLAB_BIN=/Applications/MATLAB_R2024b.app/bin/matlab \
#    STATA_BIN=/Applications/Stata/StataMP.app/Contents/MacOS/stata-mp \
#    ./run_all.sh
#
#  WARNING: the model branch re-solves 29 models. Expect roughly 60-70 hours
#  of compute, up to ~50 GB of RAM per solve, and ~30 GB of free disk for the
#  intermediate results written to _model/_aux/_models_tmp/.
#  See README.md, "Computational requirements".
#
# =========================================================================

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOGDIR="${ROOT}/_logs"
mkdir -p "${LOGDIR}"

TARGET="${1:-all}"

# ---- locate interpreters -------------------------------------------------

find_exe () {
  # find_exe <ENV_VAR_NAME> <label> <glob> [<glob> ...]
  local var="$1"; shift
  local label="$1"; shift
  local from_env="${!var:-}"

  if [ -n "${from_env}" ]; then
    if [ ! -x "${from_env}" ]; then
      echo "ERROR: ${label} not executable at ${var}=${from_env}" >&2
      return 1
    fi
    printf '%s\n' "${from_env}"
    return 0
  fi

  local candidate
  for pattern in "$@"; do
    # shellcheck disable=SC2086
    for candidate in $(ls -d ${pattern} 2>/dev/null | sort -r); do
      if [ -x "${candidate}" ]; then
        printf '%s\n' "${candidate}"
        return 0
      fi
    done
  done

  if command -v "${label}" >/dev/null 2>&1; then
    command -v "${label}"
    return 0
  fi

  echo "ERROR: could not find ${label}. Set ${var} to its full path." >&2
  return 1
}

# ---- data branch ---------------------------------------------------------

run_data () {
  local rscript
  rscript="$(find_exe RSCRIPT_BIN Rscript \
      '/usr/local/bin/Rscript' \
      '/opt/homebrew/bin/Rscript' \
      '/Library/Frameworks/R.framework/Resources/bin/Rscript')"

  echo "==> [1/2] Data branch"
  echo "    Rscript: ${rscript}"
  echo "    Log:     ${LOGDIR}/data_master.log"
  echo "    Expected runtime: about 20-40 minutes."
  echo

  # data_master.R shells out to MATLAB and Stata; let it inherit our choices
  # if the caller set them, otherwise it discovers them the same way we do.
  local stata
  stata="$(find_exe STATA_BIN stata-mp \
      '/Applications/Stata*/StataMP.app/Contents/MacOS/stata-mp' \
      '/Applications/Stata*/StataSE.app/Contents/MacOS/stata-se' \
      '/Applications/Stata*/Stata.app/Contents/MacOS/stata' \
      '/usr/local/stata*/stata-mp' \
      '/usr/local/stata*/stata-se')" || return 1
  echo "    Stata:   ${stata}"

  ( cd "${ROOT}/_data" && STATA_BIN="${stata}" "${rscript}" data_master.R ) 2>&1 \
      | tee "${LOGDIR}/data_master.log"

  echo
  echo "==> Data branch complete."
  echo "    Figures: _data/_figures/    Tables: _data/_tables/"
  echo
}

# ---- model branch --------------------------------------------------------

run_model () {
  local matlab
  matlab="$(find_exe MATLAB_BIN matlab \
      '/Applications/MATLAB_R*.app/bin/matlab' \
      '/usr/local/MATLAB/R*/bin/matlab' \
      '/opt/MATLAB/R*/bin/matlab')"

  echo "==> [2/2] Model branch"
  echo "    MATLAB: ${matlab}"
  echo "    Log:    ${LOGDIR}/model_master.log"
  echo "    Expected runtime: 60-70 hours. Consider running under nohup or screen."
  echo

  ( cd "${ROOT}/_model" && "${matlab}" -batch "model_master" ) 2>&1 \
      | tee "${LOGDIR}/model_master.log"

  echo
  echo "==> Model branch complete."
  echo "    Figures: _model/_figures/    Tables: _model/_table/"
  echo
}

# ---- dispatch ------------------------------------------------------------

run_check () {
  local rc=0 p
  echo "==> Checking for required software"

  if p="$(find_exe RSCRIPT_BIN Rscript \
        '/usr/local/bin/Rscript' '/opt/homebrew/bin/Rscript' \
        '/Library/Frameworks/R.framework/Resources/bin/Rscript' 2>/dev/null)"; then
    echo "    OK   Rscript  ${p}"
  else
    echo "    MISS Rscript  -- needed for the data branch; set RSCRIPT_BIN"; rc=1
  fi

  if p="$(find_exe MATLAB_BIN matlab \
        '/Applications/MATLAB_R*.app/bin/matlab' '/usr/local/MATLAB/R*/bin/matlab' \
        '/opt/MATLAB/R*/bin/matlab' 2>/dev/null)"; then
    echo "    OK   MATLAB   ${p}"
  else
    echo "    MISS MATLAB   -- needed for both branches; set MATLAB_BIN"; rc=1
  fi

  if p="$(find_exe STATA_BIN stata-mp \
        '/Applications/Stata*/StataMP.app/Contents/MacOS/stata-mp' \
        '/Applications/Stata*/StataSE.app/Contents/MacOS/stata-se' \
        '/Applications/Stata*/Stata.app/Contents/MacOS/stata' \
        '/usr/local/stata*/stata-mp' '/usr/local/stata*/stata-se' 2>/dev/null)"; then
    echo "    OK   Stata    ${p}"
  else
    echo "    MISS Stata    -- needed for Table III, data column; set STATA_BIN"; rc=1
  fi

  echo
  if [ "${rc}" -eq 0 ]; then
    echo "    All three found. Free disk on this volume:"
    df -h "${ROOT}" | tail -1 | awk '{print "      " $4 " available (the model branch needs ~100 GB)"}'
  else
    echo "    One or more interpreters were not found; see README.md."
  fi
  return "${rc}"
}

case "${TARGET}" in
  all)
    run_data
    run_model
    ;;
  data)
    run_data
    ;;
  model)
    run_model
    ;;
  check)
    run_check
    exit $?
    ;;
  *)
    echo "Usage: $0 [all|data|model|check]" >&2
    exit 2
    ;;
esac

echo "==> run_all.sh finished. Logs in ${LOGDIR}/"
