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


data_cpi   = paste0(dirname(WD),"/_data/_data_var/CPIAUCSL.xls","", collapse = NULL)
data_gdp   = paste0(dirname(WD),"/_data/_data_var/GDPC1.xls","", collapse = NULL)
data_u     = paste0(dirname(WD),"/_data/_data_var/UNRATE.xls","", collapse = NULL)
data_i     = paste0(dirname(WD),"/_data/_data_var/FEDFUNDS.xls","", collapse = NULL)

data_avr_hours  = paste0(dirname(WD),"/_data/_data_var/PRS85006023.xls","", collapse = NULL)
data_empl       = paste0(dirname(WD),"/_data/_data_var/CE16OV.xls","", collapse = NULL)
data_pop        = paste0(dirname(WD),"/_data/_data_var/CNP16OV.xls","", collapse = NULL)


data             = read_excel(data_cpi)
tmp              = row(data)
tmp              = tmp[,1]
data$qdate       = 1947+(tmp-1)/4 
data$P           = data$CPIAUCSL
data$infl        = 100*(data$P/lagpad(data$P,4)-1)
data             = subset(data, select = c(qdate,P, infl))
data_all         = data[data$qdate>=1960,]

data             = read_excel(data_gdp)
tmp              = row(data)
tmp              = tmp[,1]
data$qdate       = 1947+(tmp-1)/4 
data$Y           = data$GDPC1
data$y           = 100*(data$Y/lagpad(data$Y,4)-1)
data$yqoq        = 400*(data$Y/lagpad(data$Y,1)-1)
data             = subset(data, select = c(qdate,Y, y, yqoq))
data             = data[data$qdate>=1960,]

data_all         = merge(data_all, data, by = c("qdate"))

data             = read_excel(data_u, sheet = "Data")
tmp              = row(data)
tmp              = tmp[,1]
data$qdate       = 1948+(tmp-1)/4 
data$u           = data$UNRATE
data             = subset(data, select = c(qdate,u))
data             = data[data$qdate>=1960,]

data_all         = merge(data_all, data, by = c("qdate"))

data             = read_excel(data_i)
data$irate       = data$FEDFUNDS
data             = subset(data, select = c(qdate,irate))
data             = data[data$qdate>=1960,]
data             = aggregate(data, by = list(data$qdate),FUN = mean)

data_main         = merge(data_all, data, by = c("qdate"))


data             = read_excel(data_avr_hours)
tmp              = row(data)
tmp              = tmp[,1]
data$qdate       = 1947+(tmp-1)/4 
data$hours       = data$PRS85006023
data             = subset(data, select = c(qdate,hours))
data_all         = data[data$qdate>=1960,]

data             = read_excel(data_empl)
data$empl        = data$CE16OV
data             = subset(data, select = c(qdate,empl))
data             = data[data$qdate>=1960,]
data             = aggregate(data, by = list(data$qdate),FUN = mean)

data_all         = merge(data_all, data, by = c("qdate"))

data             = read_excel(data_pop)
tmp              = row(data)
tmp              = tmp[,1]
data$qdate       = 1948+(tmp-1)/4 
data$pop         = data$CNP16OV
data             = subset(data, select = c(qdate,pop))
data             = data[data$qdate>=1960,]

data_other       = merge(data_all, data, by = c("qdate"))
data_other$n     = data_other$hours*data_other$empl/data_other$pop

data_save        = merge(data_main, data_other, by = c("qdate"))

write.csv(data_save, paste0(dirname(WD),"/_aux/data_bvar.csv"))

