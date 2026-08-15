# Table A.11
rm(list=ls())

(WD <- getwd())
if (!is.null(WD)) setwd(WD)

library(haven)
library(AER)
library(sandwich)
library(lmtest)
library(pracma)
library(dplyr)
library(stargazer)
library(plm)
library(pracma)
#library(DataCombine)
library(jtools)
library(plyr)
library(ggplot2)
library(matrixStats)
library(foreign)
library(readxl)

lagpad <- function(x, k) {
  res <- c(rep(NA, k), x)[1:length(x)]
  return(res)
}

data_spf_cpi   = paste0(WD,"/_aux/spf_infl_moments.csv","", collapse = NULL)
#data_realz_cpi = paste0(WD,"/_data/CPILFESL.xls","", collapse = NULL)
data_realz_cpi = paste0(WD,"/_data/_data_var/CPIAUCSL_tmp.xls","", collapse = NULL)

qstart = 2013
qend   = 2020

load("_aux/data_sce.rda")
data_sce$qdate      = data_sce$qdate.x
data_sce            = data_sce[data_sce$qdate>=qstart,]
data_sce            = data_sce[data_sce$qdate<=qend,]

median_u_spf        = median(data_sce$u_forecast_spf,na.rm=TRUE)
median_u_sce        = median(data_sce$u_forecast,na.rm=TRUE)
std_u_spf           = sqrt(var(data_sce$u_forecast_spf,na.rm=TRUE))
std_u_sce           = sqrt(var(data_sce$u_forecast,na.rm=TRUE))

median_inf_err_sce  = median(abs(data_sce$infl_errors_med),na.rm=TRUE) 
std_inf_err_sce     = sqrt(var(data_sce$infl_errors_med,na.rm=TRUE))

median_inf_iqr_sce  = median(data_sce$infl_iqr_unc,na.rm=TRUE)
std_inf_iqr_sce     = sqrt(var(data_sce$infl_iqr_unc,na.rm=TRUE))

df_u   = data.frame(median_err = c(median_u_sce,median_u_spf), std_err = c(std_u_sce, std_u_spf))

data_spf          = read.csv(data_spf_cpi)
data_spf$qdate    = data_spf$year+(data_spf$quarter-1)/4
data_spf          = data_spf[data_spf$qdate>=qstart,]
data_spf          = data_spf[data_spf$qdate<=qend,]
data_spf          = data_spf[data_spf$quarter==4,]
data_realz        = read_excel(data_realz_cpi)

data_realz$P     = data_realz$CPIAUCSL
data_realz$infl  = 100 * (data_realz$P / dplyr::lag(data_realz$P, 4) - 1)

data_realz       = data_realz[data_realz$qdate>=qstart,]
data_realz       = data_realz[data_realz$qdate<=qend,]

data_spf_infl     = merge(data_spf,data_realz,by='qdate')

data_spf_infl$err      = data_spf_infl$infl-data_spf_infl$median

median_inf_err_spf  = median(abs(data_spf_infl$err),na.rm=TRUE) 
std_inf_err_spf     = sqrt(var(data_spf_infl$err,na.rm=TRUE)) 
median_inf_iqr_spf  = median(data_spf_infl$iqr,na.rm=TRUE) 
std_inf_iqr_spf     = sqrt(var(data_spf_infl$iqr,na.rm=TRUE)) 

df_infl   = data.frame(median_err = c(median_inf_err_sce,median_inf_err_spf), std_err = c(std_inf_err_sce, std_inf_err_spf), median_iqr = c(median_inf_iqr_sce, median_inf_iqr_spf), std_iqr = c(std_inf_iqr_sce,std_inf_iqr_spf))


fmt <- function(x) sprintf("%.2f", x)

pa_med <- fmt(df_u$median_err)   
pa_std <- fmt(df_u$std_err)      


pb_mae  <- fmt(df_infl$median_err)  
pb_sde  <- fmt(df_infl$std_err)     
pb_miqr <- fmt(df_infl$median_iqr)  
pb_siqr <- fmt(df_infl$std_iqr)     

con <- file("_tables/table_a10.txt", "w")

# ---- Panel a: two value columns ----
wa1 <- 10   # row label
wa2 <- 22   # col 1
wa3 <- 22   # col 2
totA <- wa1 + wa2 + wa3

ruleA  <- function() writeLines(strrep("=", totA), con)
hlineA <- function() writeLines(strrep("-", totA), con)
rowA   <- function(a, b, c)
  writeLines(sprintf("%-*s%*s%*s", wa1, a, wa2, b, wa3, c), con)
sectionA <- function(title)
  writeLines(sprintf("%-*s%s", wa1, "",
                     formatC(title, width = (wa2 + wa3 + nchar(title)) %/% 2,
                             flag = " ")), con)

writeLines("Table A.10: Macroeconomic Expectations in the SCE and SPF", con)
ruleA()
sectionA("Panel a: Unemployment Rate")
rowA("", "Median Forecast", "Std. Dev. of Forecast")
hlineA()
rowA("SCE", pa_med[1], pa_std[1])
rowA("SPF", pa_med[2], pa_std[2])
ruleA()

# ---- Panel b: four value columns ----
wb1 <- 10   # row label
wb2 <- 18   # col 1
wb3 <- 20   # col 2
wb4 <- 16   # col 3
wb5 <- 18   # col 4
totB <- wb1 + wb2 + wb3 + wb4 + wb5

hlineB <- function() writeLines(strrep("-", totB), con)
rowB   <- function(a, b, c, d, e)
  writeLines(sprintf("%-*s%*s%*s%*s%*s",
                     wb1, a, wb2, b, wb3, c, wb4, d, wb5, e), con)
sectionB <- function(title)
  writeLines(sprintf("%-*s%s", wb1, "",
                     formatC(title, width = (wb2 + wb3 + wb4 + wb5 + nchar(title)) %/% 2,
                             flag = " ")), con)

sectionB("Panel b: Inflation")
rowB("", "Median Abs. Error", "Std. Dev. of Error", "Median IQR", "Std. Dev. of IQR")
hlineB()
rowB("SCE", pb_mae[1], pb_sde[1], pb_miqr[1], pb_siqr[1])
rowB("SPF", pb_mae[2], pb_sde[2], pb_miqr[2], pb_siqr[2])
writeLines(strrep("=", totB), con)

# ---- Note ----
writeLines("Note: The table shows moments of the individual probability distributions", con)
writeLines("from the Survey of Consumer Expectations (SCE) and the Survey of", con)
writeLines("Professional Forecasters (SPF). Panel a shows the median and standard", con)
writeLines("deviation of individual unemployment forecasts. Panel b shows the median", con)
writeLines("error of individual inflation forecasts (column 2), the standard deviation", con)
writeLines("of these errors (column 3), the median interquartile ranges derived from", con)
writeLines("individual distributions (column 4), and their standard deviation (column 5).", con)

close(con)


load("_aux/data_sce.rda")
data_sce$qdate      = data_sce$qdate.x
data_sce            = data_sce[data_sce$qdate>=2013.00,]
data_sce            = data_sce[data_sce$qdate<=2020.00,]

data_sce$u_errors   = abs(data_sce$u_forecast_spf - data_sce$u_forecast)/mean(data_sce$u_forecast_spf,na.rm=TRUE)

mean_abs_error = 2*mean(abs(data_sce$u_errors), na.rm=TRUE)
std_abs_error  = var(abs(data_sce$u_errors), na.rm=TRUE)^(0.5)

df <- data.frame(
  variable = c("mean_abs_error", "std_abs_error"),
  value    = c(mean_abs_error, std_abs_error)
)
write.csv(df, file.path("..", "_model/_aux/_models_tmp/", "calibration.csv"), row.names = FALSE)
