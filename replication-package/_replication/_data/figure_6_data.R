# FIGURE 6: data component
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
library(mgcv)

lagpad <- function(x, k) {
  res <- c(rep(NA, k), x)[1:length(x)]
  return(res)
}

trim_u = 0.01
trim_l = 0.001

lower_m = 1
upper_m = 3.5

load("_aux/data_sce.rda")
data_sce$u_errors = 2*abs(data_sce$u_forecast_spf - data_sce$u_forecast)/mean(data_sce$u_forecast_spf,na.rm=TRUE)
data_sce$qdate    = data_sce$qdate.x

data_sce$x  = data_sce$wealth_real
upper_quantile_wealth = quantile(data_sce$x, 1-trim_u, na.rm = TRUE)
lower_quantile_wealth = quantile(data_sce$x, trim_l, na.rm = TRUE)
data_sce$x_trim = data_sce$x
data_sce$x_trim[data_sce$x > upper_quantile_wealth] = NA
data_sce$x_trim[data_sce$x < lower_quantile_wealth] = NA

mean_wealth      = mean(data_sce$wealth_real, na.rm=TRUE)
mean_wealth_trim = mean(data_sce$x_trim, na.rm=TRUE)

data_sce$y  = data_sce$u_errors

x_pred_1    = seq(from = -lower_m*mean(data_sce$x_trim,na.rm=TRUE), to = upper_m*mean(data_sce$x_trim,na.rm=TRUE), by = 100)

smooth      = loess(y~x_trim, data=data_sce, span=0.90)
y_pred_1    = predict(smooth,x_pred_1)      

smooth      = loess(y~x_trim, data=data_sce, span=0.65)
y_pred_tmp = predict(smooth,x_pred_1,se=TRUE)

plot(x_pred_1,y_pred_1, type = "l", col="blue")

df_data = data.frame(x_pred_1,y_pred_1,y_pred_tmp$se)
write.csv(df_data, "../_model/_aux/_models_tmp/figure_6.csv", row.names = FALSE)
#write.csv(df_data,"_data/figure_6.csv", row.names = FALSE)



