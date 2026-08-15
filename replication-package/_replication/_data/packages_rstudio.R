# Install the R packages required by the data branch of the replication kit.
# Run this once, before data_master.R, on a machine that does not already
# have these packages.

pkgs <- c(
  "AER",          # ivreg / summary methods used by the regression scripts
  "dplyr",        # data manipulation
  "foreign",      # legacy data import
  "ggplot2",      # plotting
  "haven",        # Stata .dta import
  "jtools",       # regression summaries
  "lmtest",       # coeftest
  "matrixStats",  # weighted quantiles / row-column statistics
  "mgcv",         # smoothing in figure_6_data.R
  "plm",          # panel estimators
  "plyr",         # split-apply-combine
  "pracma",       # numerical helpers
  "R.matlab",     # writeMat, for handing data to the MATLAB branch
  "readxl",       # .xls / .xlsx import
  "restriktor",   # constrained-inference test in table_a8.R
  "sandwich",     # HC1 robust covariance
  "stargazer",    # regression tables
  "tidyverse"     # loaded by the _aux data-build scripts
)

missing <- pkgs[!(pkgs %in% rownames(installed.packages()))]

if (length(missing) > 0) {
  install.packages(missing, repos = "https://cloud.r-project.org")
} else {
  message("All required packages are already installed.")
}
