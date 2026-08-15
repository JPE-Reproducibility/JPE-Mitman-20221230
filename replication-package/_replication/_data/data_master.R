# =========================================================================
#
# DATA MASTER FILE
#
# Reproduces every figure and table in Section 2, Online Appendix A,
# the data panel of Table B.2, and the data column of Table III.
#
# Run with the working directory set to this folder (_data), e.g.
#   cd _data && Rscript data_master.R
# or from the package root via ../run_all.sh
#
# =========================================================================
rm(list = ls())

WD <- getwd()

if (!file.exists("data_master.R")) {
  stop("data_master.R must be run with the working directory set to the _data folder. Current wd: ", WD)
}

## Locate MATLAB and Stata ------------------------------------------------
#  Override either with an environment variable if they live elsewhere:
#    MATLAB_BIN=/Applications/MATLAB_R2024b.app/bin/matlab Rscript data_master.R

find_exe <- function(env_var, candidates, label) {
  from_env <- Sys.getenv(env_var, unset = "")
  if (nzchar(from_env)) {
    if (!file.exists(from_env)) stop(label, " not found at ", env_var, "=", from_env)
    return(from_env)
  }
  hits <- Sys.glob(candidates)
  hits <- hits[file.exists(hits)]
  if (length(hits) == 0) {
    stop(label, " not found. Set ", env_var, " to its full path. Looked in: ",
         paste(candidates, collapse = ", "))
  }
  sort(hits, decreasing = TRUE)[1]
}

matlab <- find_exe(
  "MATLAB_BIN",
  c("/Applications/MATLAB_R*.app/bin/matlab",
    "/usr/local/MATLAB/R*/bin/matlab",
    "/opt/MATLAB/R*/bin/matlab"),
  "MATLAB"
)

stata <- find_exe(
  "STATA_BIN",
  c("/Applications/Stata*/StataMP.app/Contents/MacOS/stata-mp",
    "/Applications/Stata*/StataSE.app/Contents/MacOS/stata-se",
    "/Applications/Stata*/Stata.app/Contents/MacOS/stata",
    "/usr/local/stata*/stata-mp",
    "/usr/local/stata*/stata-se",
    "/usr/local/stata*/stata"),
  "Stata"
)

message("Using MATLAB: ", matlab)
message("Using Stata:  ", stata)

run_matlab <- function(cmd, wd) {
  out <- system2(matlab,
                 args = c("-batch", shQuote(sprintf('cd("%s"); %s', wd, cmd))),
                 stdout = TRUE, stderr = TRUE)
  cat(out, sep = "\n")
  status <- attr(out, "status")
  if (!is.null(status) && status != 0) {
    stop("MATLAB command failed: ", cmd)
  }
  invisible(out)
}

## [1] Generate data files ------------------------------------------------
#  Order matters: bvar_data -> bvar_est -> spf_data -> sce_data.
#  sce_data.R writes _aux/data_sce.rda, the input to every script in [2].

source("_aux/bvar_data.R", chdir = TRUE)

run_matlab("bvar_est", file.path(WD, "_aux"))
run_matlab("spf_data", file.path(WD, "_aux"))

source("_aux/sce_data.R", chdir = TRUE)

## [2] Run results files --------------------------------------------------

setwd(WD)

source("figure_1_ab_table_a7a9.R")   # Figure 1a, 1b; Tables A.7, A.9
setwd(WD)
source("figure_1_cd.R")              # Figure 1c, 1d
setwd(WD)
source("figure_2_a.R")               # Figure 2a
setwd(WD)
source("figure_2_b.R")               # Figure 2b
setwd(WD)
source("figure_6_data.R")            # data component of Figure 6
setwd(WD)
source("table_a8.R")                 # Table A.8
setwd(WD)
source("table_a10.R")                # Table A.10
setwd(WD)

run_matlab("table_b2_a", WD)         # Table B.2, panel (a)

stata_output <- system2(stata,
                        args = c("-b", "do", shQuote(file.path(WD, "make_table3_data.do"))),
                        stdout = TRUE, stderr = TRUE)   # Table III, data column
cat(stata_output, sep = "\n")

message("data_master.R finished. Figures in _figures/, tables in _tables/.")
