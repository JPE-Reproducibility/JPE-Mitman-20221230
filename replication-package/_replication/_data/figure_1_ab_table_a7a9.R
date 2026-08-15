# Figure 1:ab and Table A.7 and Table A.9
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
library(R.matlab)

lagpad <- function(x, k) {
  res <- c(rep(NA, k), x)[1:length(x)]
  return(res)
}

n = 6

load("_aux/data_sce.rda")
data_sce$u_errors = 2*abs(data_sce$u_forecast_spf - data_sce$u_forecast)/mean(data_sce$u_forecast_spf,na.rm=TRUE)
data_sce$qdate    = data_sce$qdate.x

data_sce$wealth_1 = 0
data_sce$wealth_1[is.na(data_sce$wealth_quantile)==1] = NA
data_sce$wealth_1[data_sce$wealth_real<= -171.0] = 1

data_sce$wealth_2 = ifelse(data_sce$wealth_real<= -42.8 & data_sce$wealth_real> -171,1,0)
data_sce$wealth_2[is.na(data_sce$wealth_quantile)==1] = NA

data_sce$wealth_3 = ifelse(data_sce$wealth_real<= 51.4 & data_sce$wealth_real> -42.8,1,0)
data_sce$wealth_3[is.na(data_sce$wealth_quantile)==1] = NA

data_sce$wealth_4 = ifelse(data_sce$wealth_real<= 398 & data_sce$wealth_real> 51.4,1,0)
data_sce$wealth_4[is.na(data_sce$wealth_quantile)==1] = NA

data_sce$wealth_5 = ifelse(data_sce$wealth_real<= 985 & data_sce$wealth_real> 398,1,0)
data_sce$wealth_5[is.na(data_sce$wealth_quantile)==1] = NA

data_sce$wealth_6 = ifelse(data_sce$wealth_real> 985,1,0)
data_sce$wealth_6[is.na(data_sce$wealth_quantile)==1] = NA

data_out = subset(data_sce, select = c(u_errors, wealth_real))
writeMat("data_sce.mat", your_object = data_out) 

cond_mean      = rep(NA,n)
tmp            = data_sce[data_sce$wealth_1 == 1,]
cond_mean[1]   = mean(abs(tmp$u_errors),na.rm=TRUE)
tmp            = data_sce[data_sce$wealth_2 == 1,]
cond_mean[2]   = mean(abs(tmp$u_errors),na.rm=TRUE)
tmp            = data_sce[data_sce$wealth_3 == 1,]
cond_mean[3]   = mean(abs(tmp$u_errors),na.rm=TRUE)
tmp            = data_sce[data_sce$wealth_4 == 1,]
cond_mean[4]   = mean(abs(tmp$u_errors),na.rm=TRUE)
tmp            = data_sce[data_sce$wealth_5 == 1,]
cond_mean[5]   = mean(abs(tmp$u_errors),na.rm=TRUE)
tmp            = data_sce[data_sce$wealth_6 == 1,]
cond_mean[6]   = mean(abs(tmp$u_errors),na.rm=TRUE)

mean_all  = mean(cond_mean, na.rm=TRUE)
cond_mean = cond_mean - mean_all

pdf(file="_figures/figure_1a_lhs.pdf")
barplot(cond_mean,  main="",xlab="Wealth Percentile", ylab="Absolute Error Relative to Sample Mean", border="darkorange", col="darkorange",  density=56, names.arg=c("0-10", "10-20", "20-40", "40-60", "60-80","80-100"), ylim = c(-0.05,0.06))
abline(h=0)
dev.off()

Fhat                    = ecdf(data_sce$wealth_real)
data_sce$wealth_pctile  = Fhat(data_sce$wealth_real)
data_sce$wealth_pctile2 = data_sce$wealth_pctile^2

lm_simple        = lm(as.numeric(abs(u_errors)) ~  wealth_1 + wealth_2 + wealth_3 + wealth_4 + wealth_5 , data=data_sce)
robust_simple    = sqrt(diag(vcovHC(lm_simple, type = "HC1")))

lm_all           = lm(as.numeric(abs(u_errors)) ~  wealth_1 + wealth_2 + wealth_3 + wealth_4 + wealth_5  + male + college + participate + age  + agesq  + factor(qdate), data=data_sce)
robust_all       = sqrt(diag(vcovHC(lm_all, type = "HC1")))

lm_pre20         = lm(as.numeric(abs(u_errors)) ~  wealth_1 + wealth_2 + wealth_3 + wealth_4 + wealth_5  + male + college + participate + age  + agesq  + factor(qdate), data=data_sce, subset = qdate<=2019.25)
robust_pre20     = sqrt(diag(vcovHC(lm_pre20, type = "HC1")))

stderror = list(robust_simple, robust_all, robust_pre20)

stargazer(lm_simple, lm_all, lm_pre20, type = "text", se = stderror,out="_tables/table_a7.txt")

betas = rep(NA,6)
betas[1] = lm_all$coefficients[2]
betas[2] = lm_all$coefficients[3]
betas[3] = lm_all$coefficients[4]
betas[4] = lm_all$coefficients[5]
betas[5] = lm_all$coefficients[6]
betas[6] = 0

stderrors = rep(NA,6)
stderrors[1] = robust_all[2]
stderrors[2] = robust_all[3]
stderrors[3] = robust_all[4]
stderrors[4] = robust_all[5]
stderrors[5] = robust_all[6]
stderrors[6] = 0

pdf(file="_figures/figure_1b_rhs.pdf")
barCenters = barplot(betas,   main="",xlab="Wealth Percentile", ylab="Absolute Error", border="darkorange", col="darkorange",  density=56, names.arg=c("0-10", "10-20", "20-40", "40-60", "60-80","80-100"), ylim = c(0,0.12))
abline(h=0)
text(x = barCenters, y = par("usr")[3] - 1, srt = 45,
     adj = 1, xpd = TRUE)
segments(barCenters, betas - 1*stderrors, barCenters,
         betas + 1*stderrors, lwd = 1.75)
arrows(barCenters, betas - 1*stderrors, barCenters,
       betas + 1*stderrors, lwd = 1.75, angle = 90,
       code = 3, length = 0.05)
dev.off()


lm_pctile_1      = lm(as.numeric(abs(u_errors)) ~  wealth_pctile + wealth_pctile2, data=data_sce)
robust_1         = sqrt(diag(vcovHC(lm_pctile_1, type = "HC1")))

stderror = list(robust_1)
stargazer(lm_pctile_1,  type = "text", se = stderror, out="_tables/table_a9.txt")

