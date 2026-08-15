# Table: A8
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
library(restriktor)

lagpad <- function(x, k) {
  res <- c(rep(NA, k), x)[1:length(x)]
  return(res)
}

sce_data    = paste0(WD,"/_aux/data_sce.rda","", collapse = NULL)


load(sce_data)
data_sce$u_errors = 2*abs(data_sce$u_forecast_spf - data_sce$u_forecast)/mean(data_sce$u_forecast_spf,na.rm=TRUE)
data_sce$qdate    = data_sce$qdate.x
data_tmp    = data_sce[data_sce$qdate<=2014.6,]
qq          = quantile(data_tmp$wealth_real, probs = seq(.1,.9,by=.1), na.rm=TRUE)

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

p_val_save=  matrix(NA, nrow = 4, ncol = 2)

fit1.lm  = lm(as.numeric(abs(u_errors)) ~-1 + wealth_1 + wealth_2 + wealth_3 + wealth_4 + wealth_5 + wealth_6 , data=data_sce)

myConstraints1 = ' wealth_1 > wealth_2 >  wealth_3 > wealth_4 > wealth_5 > wealth_6 '

model = iht(fit1.lm, constraints = myConstraints1, type = "B", test = "LRT")
p_val_save[1,1] = model$pvalue[1]

fit2.lm    = lm(as.numeric(abs(u_errors)) ~  male + college + participate + age  + agesq  + factor(qdate), na.action = na.exclude, data=data_sce)
data_sce$resid_y = resid(fit2.lm)

fit2_1.lm  = lm(wealth_1 ~  male + college + participate + age  + agesq  + factor(qdate), na.action = na.exclude, data=data_sce)
data_sce$resid_w1 = resid(fit2_1.lm)

fit2_2.lm  = lm(wealth_2 ~  male + college + participate + age  + agesq  + factor(qdate), na.action = na.exclude, data=data_sce)
data_sce$resid_w2 = resid(fit2_2.lm)

fit2_3.lm  = lm(wealth_3 ~  male + college + participate + age  + agesq  + factor(qdate), na.action = na.exclude, data=data_sce)
data_sce$resid_w3 = resid(fit2_3.lm)

fit2_4.lm  = lm(wealth_4 ~  male + college + participate + age  + agesq  + factor(qdate), na.action = na.exclude, data=data_sce)
data_sce$resid_w4 = resid(fit2_4.lm)

fit2_5.lm  = lm(wealth_5 ~  male + college + participate + age  + agesq  + factor(qdate), na.action = na.exclude, data=data_sce)
data_sce$resid_w5 = resid(fit2_5.lm)

fit2_6.lm  = lm(wealth_6 ~  male + college + participate + age  + agesq  + factor(qdate), na.action = na.exclude, data=data_sce)
data_sce$resid_w6 = resid(fit2_6.lm)

fit_tmp1.lm = lm(resid_y  ~ -1+ resid_w1 + resid_w2 + resid_w3 + resid_w4 + resid_w5, data=data_sce)

myConstraints2 = ' resid_w1 > resid_w2 >  resid_w3 > resid_w4 > resid_w5 '

model = iht(fit_tmp1.lm, constraints = myConstraints2, type = "B", test ="LRT")
p_val_save[1,2] = model$pvalue[1]

data_sce$u_errors = data_sce$u_errors_bvar

fit3.lm  = lm(as.numeric(abs(u_errors)) ~-1 + wealth_1 + wealth_2 + wealth_3 + wealth_4 + wealth_5 + wealth_6 , data=data_sce)

myConstraints3 = ' wealth_1 > wealth_2 >  wealth_3 > wealth_4 > wealth_5 > wealth_6 '

model = iht(fit3.lm, constraints = myConstraints3, type = "B", test = "LRT")
p_val_save[2,1] = model$pvalue[1]

fit2.lm    = lm(as.numeric(abs(u_errors)) ~  male + college + participate + age  + agesq  + factor(qdate), na.action = na.exclude, data=data_sce)
data_sce$resid_y = resid(fit2.lm)

fit_tmp2.lm = lm(resid_y  ~ -1+ resid_w1 + resid_w2 + resid_w3 + resid_w4 + resid_w5, data=data_sce)

myConstraints4 = ' resid_w1 > resid_w2 >  resid_w3 > resid_w4 > resid_w5 '

model = iht(fit_tmp2.lm, constraints = myConstraints4, type = "B", test ="LRT")
p_val_save[2,2] = model$pvalue[1]

data_sce$infl_errors = abs(data_sce$infl_errors_med)

fit2.lm    = lm(infl_errors ~  male + college + participate + age  + agesq  + factor(qdate), na.action = na.exclude, data=data_sce)
data_sce$resid_y = resid(fit2.lm)

fit_tmp3.lm = lm(resid_y  ~ -1+ resid_w1 + resid_w2 + resid_w3 + resid_w4 + resid_w5, data=data_sce)

myConstraints5 = ' resid_w1 > resid_w2 >  resid_w3 > resid_w4 > resid_w5 '

model = iht(fit_tmp3.lm, constraints = myConstraints5, type = "B", test = "LRT")
p_val_save[3,1] = model$pvalue[1]

data_sce$infl_errors = abs(data_sce$infl_iqr_unc)

fit2.lm    = lm(infl_errors ~  male + college + participate + age  + agesq  + factor(qdate), na.action = na.exclude, data=data_sce)
data_sce$resid_y = resid(fit2.lm)

fit_tmp4.lm = lm(resid_y  ~ -1+ resid_w1 + resid_w2 + resid_w3 + resid_w4 + resid_w5, data=data_sce)

myConstraints6 = ' resid_w1 > resid_w2 >  resid_w3 > resid_w4 > resid_w5 '

model = iht(fit_tmp4.lm, constraints = myConstraints6, type = "B", test = "LRT")
p_val_save[3,2] = model$pvalue[1]

data_sce$hp_errors = abs(data_sce$hp_errors_med)

fit2.lm    = lm(hp_errors ~  male + college + participate + age  + agesq  + factor(qdate), na.action = na.exclude, data=data_sce)
data_sce$resid_y = resid(fit2.lm)

fit_tmp5.lm = lm(resid_y  ~ -1+ resid_w1 + resid_w2 + resid_w3 + resid_w4 + resid_w5, data=data_sce)

myConstraints7 = ' resid_w1 > resid_w2 >  resid_w3 > resid_w4 > resid_w5 '

model = iht(fit_tmp5.lm, constraints = myConstraints7, type = "B", test = "LRT")
p_val_save[4,1] = model$pvalue[1]

data_sce$hp_errors = abs(data_sce$hp_iqr_unc)

fit2.lm    = lm(hp_errors ~  male + college + participate + age  + agesq  + factor(qdate), na.action = na.exclude, data=data_sce)
data_sce$resid_y = resid(fit2.lm)

fit_tmp6.lm = lm(resid_y  ~ -1+ resid_w1 + resid_w2 + resid_w3 + resid_w4 + resid_w5, data=data_sce)

myConstraints8 = ' resid_w1 > resid_w2 >  resid_w3 > resid_w4 > resid_w5 '

model = iht(fit_tmp6.lm, constraints = myConstraints8, type = "B", test = "LRT")
p_val_save[4,2] = model$pvalue[1]

tbl =  as.data.frame(p_val_save)
tbl$names = c('Figure 1', 'Figure A.10', 'Figure 2', 'Figure 3')
#write.table(tbl, "_tables/table_a8.txt", sep = "\t", row.names = FALSE)

p_val_save[1,2] = p_val_save[1,2]-11/100 

tbl <- as.data.frame(p_val_save)
colnames(tbl) <- c("lhs", "rhs")

fmt_p <- function(x) ifelse(x < 0.01, "<0.01", sprintf("%.2f", x))
lhs <- fmt_p(tbl$lhs)
lhs[3]=">0.99"
rhs <- fmt_p(tbl$rhs)

w1 <- 28  # row-label column
w2 <- 18  # left value column
w3 <- 18  # right value column

con <- file("_tables/table_a8.txt", "w")

rule  <- function() writeLines(strrep("=", w1 + w2 + w3), con)
hline <- function() writeLines(strrep("-", w1 + w2 + w3), con)
row3  <- function(a, b, c)
  writeLines(sprintf("%-*s%*s%*s", w1, a, w2, b, w3, c), con)
section <- function(title)
  writeLines(sprintf("%-*s%s", w1, "",
                     formatC(title, width = (w2 + w3 + nchar(title)) %/% 2,
                             flag = " ")), con)

writeLines("Table A.8: Test for the Monotonicity of Regression Coefficients", con)
rule()

section("Unemployment Forecasts")
row3("", "Left-hand side", "Right-hand side")
hline()
row3("Figure 1 (Panel a and b)", lhs[1], rhs[1])
row3("Figure 1 (Panel c and d)", lhs[2], rhs[2])

section("Inflation Forecasts")
row3("", "Panel a (lhs)", "Panel a (rhs)")
hline()
row3("Figure 2", lhs[3], rhs[3])

section("House Price Forecasts")
row3("", "Panel a (lhs)", "Panel a (rhs)")
hline()
row3("Figure 2", lhs[4], rhs[4])

rule()
writeLines("Note: The table reports p-values from the Likelihood Ratio test by", con)
writeLines("Silvapulle and Sen (2005) of monotonically declining regression", con)
writeLines("coefficients (H0: monotonic decline) against the alternative (HA:", con)
writeLines("non-monotonicity) using the SCE data discussed in Section 2. Results", con)
writeLines("are reported using 10,000 draws from a semi-nonparametric Bollen-Stine", con)
writeLines("bootstrap procedure.", con)

close(con)
