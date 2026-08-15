# Figure 2:a 
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

lagpad <- function(x, k) {
  res <- c(rep(NA, k), x)[1:length(x)]
  return(res)
}

n              = 6


load("_aux/data_sce.rda")

data_sce$qdate  = data_sce$qdate.x
data_tmp        = data_sce[data_sce$qdate<=2014.6,]
qq              = quantile(data_tmp$wealth_real, probs = seq(.1,.9,by=.1), na.rm=TRUE)

data_sce$wealth_1 = 0
data_sce$wealth_1[is.na(data_sce$wealth_quantile)==1] = NA
data_sce$wealth_1[data_sce$wealth_real<= qq[[1]]] = 1

data_sce$wealth_2 = ifelse(data_sce$wealth_real<= qq[[2]] & data_sce$wealth_real> qq[[1]],1,0)
data_sce$wealth_2[is.na(data_sce$wealth_quantile)==1] = NA

data_sce$wealth_3 = ifelse(data_sce$wealth_real<= qq[[4]] & data_sce$wealth_real> qq[[2]],1,0)
data_sce$wealth_3[is.na(data_sce$wealth_quantile)==1] = NA

data_sce$wealth_4 = ifelse(data_sce$wealth_real<= qq[[6]] & data_sce$wealth_real> qq[[4]],1,0)
data_sce$wealth_4[is.na(data_sce$wealth_quantile)==1] = NA

data_sce$wealth_5 = ifelse(data_sce$wealth_real<= qq[[8]] & data_sce$wealth_real> qq[[6]],1,0)
data_sce$wealth_5[is.na(data_sce$wealth_quantile)==1] = NA

data_sce$wealth_6 = ifelse(data_sce$wealth_real> qq[[8]],1,0)
data_sce$wealth_6[is.na(data_sce$wealth_quantile)==1] = NA

lm_all           = lm(as.numeric(abs(infl_errors_med)) ~  wealth_1 + wealth_2 + wealth_3 + wealth_4 + wealth_5  + male + college + participate + age  + agesq  + factor(qdate), data=data_sce)
robust_all       = sqrt(diag(vcovHC(lm_all, type = "HC1")))

betas = rep(NA,6)
betas[1] = lm_all$coefficients[2]
betas[2] = lm_all$coefficients[3]
betas[3] = lm_all$coefficients[4]
betas[4] = lm_all$coefficients[5]
betas[5] = lm_all$coefficients[5]
betas[6] = 0

stderrors = rep(NA,6)
stderrors[1] = robust_all[2]
stderrors[2] = robust_all[3]
stderrors[3] = robust_all[4]
stderrors[4] = robust_all[5]
stderrors[5] = robust_all[6]
stderrors[6] = 0

pdf(file="_figures/figure_2a_lhs.pdf")
barCenters = barplot(betas,   main="",xlab="Wealth Percentile", ylab="Absolute Error", border="darkorange", col="darkorange",  density=56, names.arg=c("0-10", "10-20", "20-40", "40-60", "60-80","80-100"), ylim = c(0,0.80))
abline(h=0)
text(x = barCenters, y = par("usr")[3] - 1, srt = 45,
     adj = 1, xpd = TRUE)
segments(barCenters, betas - 1*stderrors, barCenters,
         betas + 1*stderrors, lwd = 1.5)
arrows(barCenters, betas - 1*stderrors, barCenters,
       betas + 1*stderrors, lwd = 1.5, angle = 90,
       code = 3, length = 0.05)
dev.off()



lm_all           = lm(as.numeric(abs(infl_iqr_unc)) ~  wealth_1 + wealth_2 + wealth_3 + wealth_4 + wealth_5  + male + college + participate + age  + agesq  + factor(qdate), data=data_sce)
robust_all       = sqrt(diag(vcovHC(lm_all, type = "HC1")))


betas = rep(NA,6)
betas[1] = lm_all$coefficients[2]
betas[2] = lm_all$coefficients[3]
betas[3] = lm_all$coefficients[4]
betas[4] = lm_all$coefficients[5]
betas[5] = lm_all$coefficients[5]
betas[6] = 0

stderrors = rep(NA,6)
stderrors[1] = robust_all[2]
stderrors[2] = robust_all[3]
stderrors[3] = robust_all[4]
stderrors[4] = robust_all[5]
stderrors[5] = robust_all[6]
stderrors[6] = 0

pdf(file="_figures/figure_2a_rhs.pdf")
barCenters = barplot(betas,   main="",xlab="Wealth Percentile", ylab="Absolute Error", border="darkorange", col="darkorange",  density=56, names.arg=c("0-10", "10-20", "20-40", "40-60", "60-80","80-100"), ylim = c(0, 1.6))
abline(h=0)
text(x = barCenters, y = par("usr")[3] - 1, srt = 45,
     adj = 1, xpd = TRUE)
segments(barCenters, betas - 1*stderrors, barCenters,
         betas + 1*stderrors, lwd = 1.5)
arrows(barCenters, betas - 1*stderrors, barCenters,
       betas + 1*stderrors, lwd = 1.5, angle = 90,
       code = 3, length = 0.05)
dev.off()
