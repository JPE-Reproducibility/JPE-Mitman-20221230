# Process RAW SCE DATA and RAW SCE FIN DATA 
rm(list=ls())

(WD <- getwd())
if (!is.null(WD)) setwd(WD)

library(haven)
library(AER)
library(sandwich)
library(lmtest)
library(pracma)
library(stargazer)
library(plm)
library(pracma)
#library(DataCombine)
library(jtools)
library(plyr)
library(readxl)
library(foreign)
library(tidyverse)

lagpad <- function(x, k) {
  res <- c(rep(NA, k), x)[1:length(x)]
  return(res)
}

# Data files
sce_1      = paste0(dirname(WD),"/_data/FRBNY-SCE-Public-Microdata-Complete-13-16.csv","", collapse = NULL)
sce_2      = paste0(dirname(WD),"/_data/FRBNY-SCE-Public-Microdata-Complete-17-19.csv","", collapse = NULL)
sce_3      = paste0(dirname(WD),"/_data/FRBNY-SCE-Public-Microdata-latest.csv","", collapse = NULL)
sce_wealth = paste0(dirname(WD),"/_data/SCE_public_HH-finance_quarterly_microdata.xlsx","", collapse = NULL)
fred_cpi   = paste0(dirname(WD),"/_data/CPIAUCSL.xls","", collapse = NULL)
fred_hpi   = paste0(dirname(WD),"/_data/CSUSHPINSA.xls","", collapse = NULL)
#spf_prob_u = paste0(dirname(WD),"/_aux/spf_prob_u.dta","", collapse = NULL)
spf_prob_u = paste0(dirname(WD),"/_aux/spf_prob_u.csv","", collapse = NULL)

bvar_prob_u = paste0(dirname(WD),"/_aux/prob_up_bvar.csv","", collapse = NULL)

##### SCE EXP DATA #############
data = read.csv(sce_1)

data$id      = as.numeric(data$userid) 
data$qdate   = as.numeric(substr(data$date, 1, 4)) +(as.numeric(substr(data$date, 5,6))-1)/12
data$sex     = as.numeric(data$Q33)
data$educ    = as.numeric(data$Q36)
data$age     = as.numeric(data$Q32)
data$labor_1 = as.numeric(data$Q10_1)
data$labor_2 = as.numeric(data$Q10_2)
data$labor_3 = as.numeric(data$Q10_3)
data$infl_forecast     = as.numeric(data$Q8v2part2)
data$infl_forecast[data$Q8v2part2<=-12] = NA #sample restrictions
data$infl_forecast[data$Q8v2part2>=+12] = NA #sample restrictions
data$infl_forecast_med = as.numeric(data$Q9_cent50) 
data$infl_forecast_med[data$Q9_cent50<=-12] = NA #sample restrictions
data$infl_forecast_med[data$Q9_cent50>=+12] = NA #sample restrictions
data$infl_iqr_unc      = as.numeric(data$Q9_iqr)
data$u_forecast        = as.numeric(data$Q4new)
data$hp_forecast     = as.numeric(data$Q31v2part2)
data$hp_forecast[data$Q31v2part2<=-40] = NA #sample restrictions
data$hp_forecast[data$Q31v2part2>=+40] = NA #sample restrictions
data$hp_forecast_med = as.numeric(data$C1_cent50)
data$hp_forecast[data$C1_cent50<=-40] = NA #sample restrictions
data$hp_forecast[data$C1_cent50>=+40] = NA #sample restriction
data$hp_iqr_unc                       = as.numeric(data$C1_iqr)

data_sce_1    = subset(data, select = c(qdate,date,id,sex,educ,age,labor_1,labor_2,labor_3,infl_forecast,infl_forecast_med, u_forecast,infl_iqr_unc, hp_forecast, hp_forecast_med, hp_iqr_unc))

ii_tmp        = unique(data_sce_1[c("id")])
counter_tmp   = nrow(ii_tmp)
data_sce_1_new = data_sce_1
for (ii in 1:counter_tmp) {
  id_tmp   = as.numeric(ii_tmp[ii,])
  data_tmp = data_sce_1_new[data_sce_1_new$id == id_tmp,]
  data_sce_1_new$age[data_sce_1_new$id == id_tmp] = min(data_tmp$age, na.rm= TRUE)
  data_sce_1_new$sex[data_sce_1_new$id == id_tmp] = min(data_tmp$sex, na.rm= TRUE)
  data_sce_1_new$educ[data_sce_1_new$id == id_tmp] = min(data_tmp$educ, na.rm= TRUE)
}

data_sce_1_new$age[data_sce_1_new$age == Inf]   = NA
data_sce_1_new$sex[data_sce_1_new$sex == Inf]   = NA
data_sce_1_new$educ[data_sce_1_new$educ == Inf] = NA

data = read.csv(sce_2)

data$id      = as.numeric(data$userid) 
data$qdate   = as.numeric(substr(data$date, 1, 4)) +(as.numeric(substr(data$date, 5,6))-1)/12
data$sex     = as.numeric(data$Q33)
data$educ    = as.numeric(data$Q36)
data$age     = as.numeric(data$Q32)
data$labor_1 = as.numeric(data$Q10_1)
data$labor_2 = as.numeric(data$Q10_2)
data$labor_3 = as.numeric(data$Q10_3)
data$infl_forecast     = as.numeric(data$Q8v2part2)
data$infl_forecast[data$Q8v2part2<=-12] = NA #sample restrictions
data$infl_forecast[data$Q8v2part2>=+12] = NA #sample restrictions
data$infl_forecast_med = as.numeric(data$Q9_cent50) 
data$infl_forecast_med[data$Q9_cent50<=-12] = NA #sample restrictions
data$infl_forecast_med[data$Q9_cent50>=+12] = NA #sample restrictions
data$infl_iqr_unc      = as.numeric(data$Q9_iqr)
data$u_forecast        = as.numeric(data$Q4new)
data$hp_forecast     = as.numeric(data$Q31v2part2)
data$hp_forecast[data$Q31v2part2<=-40] = NA #sample restrictions
data$hp_forecast[data$Q31v2part2>=+40] = NA #sample restrictions
data$hp_forecast_med = as.numeric(data$C1_cent50)
data$hp_forecast[data$C1_cent50<=-40] = NA #sample restrictions
data$hp_forecast[data$C1_cent50>=+40] = NA #sample restriction
data$hp_iqr_unc                       = as.numeric(data$C1_iqr)

data_sce_2    = subset(data, select = c(qdate,date,id,sex,educ,age,labor_1,labor_2,labor_3,infl_forecast,infl_forecast_med, u_forecast,infl_iqr_unc, hp_forecast, hp_forecast_med, hp_iqr_unc))

ii_tmp        = unique(data_sce_2[c("id")])
counter_tmp   = nrow(ii_tmp)
data_sce_2_new = data_sce_2
for (ii in 1:counter_tmp) {
  id_tmp   = as.numeric(ii_tmp[ii,])
  data_tmp = data_sce_2_new[data_sce_2_new$id == id_tmp,]
  data_sce_2_new$age[data_sce_2_new$id == id_tmp] = min(data_tmp$age, na.rm= TRUE)
  data_sce_2_new$sex[data_sce_2_new$id == id_tmp] = min(data_tmp$sex, na.rm= TRUE)
  data_sce_2_new$educ[data_sce_2_new$id == id_tmp] = min(data_tmp$educ, na.rm= TRUE)
}

data_sce_2_new$age[data_sce_2_new$age == Inf]   = NA
data_sce_2_new$sex[data_sce_2_new$sex == Inf]   = NA
data_sce_2_new$educ[data_sce_2_new$educ == Inf] = NA

data = read.csv(sce_3)

data$id      = as.numeric(data$userid) 
data$qdate   = as.numeric(substr(data$date, 1, 4)) +(as.numeric(substr(data$date, 5,6))-1)/12
data$sex     = as.numeric(data$Q33)
data$educ    = as.numeric(data$Q36)
data$age     = as.numeric(data$Q32)
data$labor_1 = as.numeric(data$Q10_1)
data$labor_2 = as.numeric(data$Q10_2)
data$labor_3 = as.numeric(data$Q10_3)
data$infl_forecast     = as.numeric(data$Q8v2part2)
data$infl_forecast[data$Q8v2part2<=-12] = NA #sample restrictions
data$infl_forecast[data$Q8v2part2>=+12] = NA #sample restrictions
data$infl_forecast_med = as.numeric(data$Q9_cent50) 
data$infl_forecast_med[data$Q9_cent50<=-12] = NA #sample restrictions
data$infl_forecast_med[data$Q9_cent50>=+12] = NA #sample restrictions
data$infl_iqr_unc      = as.numeric(data$Q9_iqr)
data$u_forecast        = as.numeric(data$Q4new)
data$hp_forecast     = as.numeric(data$Q31v2part2)
data$hp_forecast[data$Q31v2part2<=-40] = NA #sample restrictions
data$hp_forecast[data$Q31v2part2>=+40] = NA #sample restrictions
data$hp_forecast_med = as.numeric(data$C1_cent50)
data$hp_forecast[data$C1_cent50<=-40] = NA #sample restrictions
data$hp_forecast[data$C1_cent50>=+40] = NA #sample restriction
data$hp_iqr_unc                       = as.numeric(data$C1_iqr)

data_sce_3    = subset(data, select = c(qdate,date,id,sex,educ,age,labor_1,labor_2,labor_3,infl_forecast,infl_forecast_med, u_forecast,infl_iqr_unc, hp_forecast, hp_forecast_med, hp_iqr_unc))

ii_tmp        = unique(data_sce_3[c("id")])
counter_tmp   = nrow(ii_tmp)
data_sce_3_new = data_sce_3
for (ii in 1:counter_tmp) {
  id_tmp   = as.numeric(ii_tmp[ii,])
  data_tmp = data_sce_3_new[data_sce_3_new$id == id_tmp,]
  data_sce_3_new$age[data_sce_3_new$id == id_tmp] = min(data_tmp$age, na.rm= TRUE)
  data_sce_3_new$sex[data_sce_3_new$id == id_tmp] = min(data_tmp$sex, na.rm= TRUE)
  data_sce_3_new$educ[data_sce_3_new$id == id_tmp] = min(data_tmp$educ, na.rm= TRUE)
}

data_sce_3_new$age[data_sce_3_new$age == Inf]   = NA
data_sce_3_new$sex[data_sce_3_new$sex == Inf]   = NA
data_sce_3_new$educ[data_sce_3_new$educ == Inf] = NA

data_sce      = rbind(data_sce_1_new,data_sce_2_new, data_sce_3_new)

##### DATA ON REALIZATIONS #############
data             = read_excel(fred_cpi, sheet = "Data")
tmp              = row(data)
tmp              = tmp[,1]
data$qdate       = 2011+(tmp-1)/12  #data starts 2010 -- one-year ahead forecasts though
data$P           = data$CPIAUCSL
data$infl        = 100*(data$P/lagpad(data$P,12)-1)

data             = subset(data, select = c(qdate,P, infl))
data_sce         = merge(data_sce, data, by = c("qdate"))

data             = read_excel(fred_hpi, sheet = "Data")
tmp              = row(data)
tmp              = tmp[,1]
data$qdate       = 1987+(tmp-1)/12  #data starts 1986 -- one-year ahead forecasts though
data$hp_level    = data$CSUSHPINSA
data$hp          = 100*(data$hp_level/lagpad(data$hp_level,12)-1)

data             = subset(data, select = c(qdate,hp_level, hp))
data_sce         = merge(data_sce, data, by = c("qdate"))

#data_spf        = read_dta(spf_prob_u)
data_spf         = read.csv(spf_prob_u)
data_spf$qdate   = data_spf$year +(data_spf$month-1)/12 
data_spf$u_forecast_spf  = data_spf$probupSPF_q
data_spf         = subset(data_spf, select = c(qdate,u_forecast_spf))

#data_sce         = merge(data_sce, data_spf, by = c("qdate"), all=TRUE)

data_bvar        = read.csv(bvar_prob_u)
data_bvar        = data_bvar[data_bvar$X1960.5>=2013,]
tmp              = row(data_bvar)
tmp              = tmp[,1]
data_bvar$qdate  = 2013+(tmp-1)/12
data_bvar$u_forecast_bvar  = 100*data_bvar$X0.1532
data_bvar        = subset(data_bvar, select = c(qdate,u_forecast_bvar))

data_fcast       = merge(data_spf,data_bvar, by = c("qdate"), all=TRUE)

data_sce         = merge(data_sce, data_fcast, by = c("qdate"), all=TRUE)

data_sce_prewealth = data_sce

rm(data,data_sce_1,data_sce_2, data_spf, data_bvar, data_fcast)

##### SCE DATA ON WEALTH #############
data             = read_excel(sce_wealth, sheet = "Data")
data$id          = as.numeric(data$userid) 
data$qdate       = as.numeric(substr(data$date, 1, 4)) +(as.numeric(substr(data$date, 5,6))-1)/12
data$finassets   = data$d16new_1
data$mortgage    = data$f18new_1
data$mortgage_true = data$f18new_1
data$mortgage[is.na(data$f18new_1)==1] = 0  
data$debt        = data$g1_1
data$wealth      = data$finassets-(data$debt-data$mortgage)

data             = subset(data, select = c(id,qdate, mortgage, mortgage_true, debt, wealth, finassets)) 
data_sce_new     = merge(data_sce, data, by  =c("id"))

data_sce = data_sce_new
rm(data_sce_new, data)

#### TRANSFORM DATA FOR REGRESSIONS #######
# - wealth
data_sce$wealth_real   = data_sce$wealth/data_sce$P
data_sce    =  mutate(data_sce, wealth_quantile = ntile(wealth_real, 5))

# - age
data_sce$agesq       = data_sce$age^2
data_sce$agecu       = data_sce$age^3

# - male
data_sce$male        = data_sce$sex-1

# - college
data_sce$college     = 0
data_sce$college[data_sce$educ>=4] = 1

# - participate
data_sce$labor       = data_sce$labor_1 + data_sce$labor_2 +data_sce$labor_3
data_sce$participate = 0
data_sce$participate[data_sce$labor>=1] = 1

# - errors
data_sce$infl_errors      = data_sce$infl - data_sce$infl_forecast 
data_sce$infl_errors_med  = data_sce$infl - data_sce$infl_forecast_med 

data_sce$hp_errors        = data_sce$hp - data_sce$hp_forecast 
data_sce$hp_errors_med    = data_sce$hp - data_sce$hp_forecast_med 

data_sce$u_errors         = 2*abs(data_sce$u_forecast_spf - data_sce$u_forecast)/mean(data_sce$u_forecast_spf, na.rm=TRUE)
data_sce$u_errors_bvar    = 2*abs(data_sce$u_forecast_bvar - data_sce$u_forecast)/mean(data_sce$u_forecast_bvar, na.rm=TRUE)

save(data_sce,file="data_sce.rda")


