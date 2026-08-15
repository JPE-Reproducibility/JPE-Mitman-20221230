clear

use _data/psid_2004_2010
//  This is the master PSID file from 2005 on. It contains all relevant variable for consumption, wealth analysis
// Data obtained from replication of Krueger, Mitman, Perri (2016) 
// Do file modified from replication of Krueger, Mitman, Perri (2016) Table 2
gen intrate=0.04
gen c2_hv=c1+RENT+PTAX+INS+HOME+intrate*housevalue
label var c2_hv "Consumption including housing computed using home values"


gen Idisposable=I-fica-fiitax-siitax+intrate*housevalue
label var Idisposable "Disposable Income = I-fica-fiitax-siitax+intrate*housevalue"
gen Iearnings = IL + (2/3)*IBF+ISS+IT-fica-fiitax-siitax
label var Iearnings "Earnings = IL + (2/3)*IBF+ISS+IT-fica-fiitax-siitax"

* wealth quintiles

#delimit ;


gen w1q=.; gen w2q=.; gen w3q=. ; gen w4q=.; 
gen varx1=.; gen varx2=.; gen varx3=. ; gen varx4=.; gen varx5=.;
gen var11=.; gen var12=.; gen var13=. ; gen var14=.; gen var15=.; 
gen var11s=.; gen var12s=.; gen var13s=. ; gen var14s=.; gen var15s=.; 
gen var21=.; gen var22=.; gen var23=. ; gen var24=.; gen var25=.;
gen var21s=.; gen var22s=.; gen var23s=. ; gen var24s=.; gen var25s=.;


#delimit cr

* age limits (strict)
gen agel=22
gen aget=122

* eliminate households with too low consumption
drop if c2_hv<1000



gen refyear=2006


 

* relabel a bunch of variable from PSID, so they have the same name as in scf

gen YEAR=year
gen WGT=sam_weight


count if YEAR==refyear & AGE>agel & AGE<aget

tsset ID year


* choose your by var here

gen varx = new_WW


* choose your descriptive variables

gen var1 = Idisposable
gen var2 = c2_hv


* Quantiles / cutpoints of varx (by variable)

_pctile varx if YEAR==refyear & AGE>agel & AGE<aget  [w=WGT], nq(100)

* cutpoints: 10,20,40,60,80 percentiles
replace w1q = r(r10) if YEAR == refyear   // p10
replace w2q = r(r20) if YEAR == refyear   // p20
replace w3q = r(r40) if YEAR == refyear   // p40
replace w4q = r(r60) if YEAR == refyear   // p60
gen     w5q = . 
replace w5q = r(r80) if YEAR == refyear   // p80



* ---------- var2 (consumption) by bins ----------
sum var2 [w=WGT] if YEAR==refyear & AGE>agel & AGE<aget
scalar v2mean=r(mean)
scalar v2tot=v2mean*r(sum_w)

sum var2 [w=WGT] if varx < w1q & YEAR==refyear & AGE>agel & AGE<aget
replace var21=r(mean) if YEAR==refyear
replace var21s=r(mean)*r(sum_w)/v2tot if YEAR==refyear

sum var2 [w=WGT] if varx>=w1q & varx<w2q & YEAR==refyear & AGE>agel & AGE<aget
replace var22=r(mean) if YEAR==refyear
replace var22s=r(mean)*r(sum_w)/v2tot if YEAR==refyear

sum var2 [w=WGT] if varx>=w2q & varx<w3q & YEAR==refyear & AGE>agel & AGE<aget
replace var23=r(mean) if YEAR==refyear
replace var23s=r(mean)*r(sum_w)/v2tot if YEAR==refyear

sum var2 [w=WGT] if varx>=w3q & varx<w4q & YEAR==refyear & AGE>agel & AGE<aget
replace var24=r(mean) if YEAR==refyear
replace var24s=r(mean)*r(sum_w)/v2tot if YEAR==refyear

sum var2 [w=WGT] if varx>=w4q & varx<w5q & YEAR==refyear & AGE>agel & AGE<aget
replace var25=r(mean) if YEAR==refyear
replace var25s=r(mean)*r(sum_w)/v2tot if YEAR==refyear

gen var26=.
gen var26s=.
sum var2 [w=WGT] if varx>=w5q & YEAR==refyear & AGE>agel & AGE<aget
replace var26=r(mean) if YEAR==refyear
replace var26s=r(mean)*r(sum_w)/v2tot if YEAR==refyear


sum var2*


*******************************************************
* Export LaTeX table: shares of wealth, earnings, consumption
* (Bins: D1, D2, Q2, Q3, Q4, Q5)
*******************************************************

* --- 1) Compute wealth shares by the same 6 bins ---
* (Requires cutpoints w1q..w5q already defined as p10,p20,p40,p60,p80)

* allocate (optional but clean)
capture confirm variable varx1s
if _rc {
    gen varx1s = .
    gen varx2s = .
    gen varx3s = .
    gen varx4s = .
    gen varx5s = .
    gen varx6s = .
}

* total wealth (weighted)
sum varx [w=WGT] if YEAR==refyear & AGE>agel & AGE<aget
scalar vxmean = r(mean)
scalar vxtot  = vxmean * r(sum_w)

* Bin 1: bottom 10%
sum varx [w=WGT] if varx < w1q & YEAR==refyear & AGE>agel & AGE<aget
replace varx1s = r(mean)*r(sum_w)/vxtot if YEAR==refyear

* Bin 2: 10–20
sum varx [w=WGT] if varx>=w1q & varx<w2q & YEAR==refyear & AGE>agel & AGE<aget
replace varx2s = r(mean)*r(sum_w)/vxtot if YEAR==refyear

* Bin 3: 20–40
sum varx [w=WGT] if varx>=w2q & varx<w3q & YEAR==refyear & AGE>agel & AGE<aget
replace varx3s = r(mean)*r(sum_w)/vxtot if YEAR==refyear

* Bin 4: 40–60
sum varx [w=WGT] if varx>=w3q & varx<w4q & YEAR==refyear & AGE>agel & AGE<aget
replace varx4s = r(mean)*r(sum_w)/vxtot if YEAR==refyear

* Bin 5: 60–80
sum varx [w=WGT] if varx>=w4q & varx<w5q & YEAR==refyear & AGE>agel & AGE<aget
replace varx5s = r(mean)*r(sum_w)/vxtot if YEAR==refyear

* Bin 6: 80–100
sum varx [w=WGT] if varx>=w5q & YEAR==refyear & AGE>agel & AGE<aget
replace varx6s = r(mean)*r(sum_w)/vxtot if YEAR==refyear


* --- 2) Grab one observation in refyear (shares are constant within refyear) ---
preserve
keep if YEAR==refyear
keep varx1s varx2s varx3s varx4s varx5s varx6s ///
     var21s var22s var23s var24s var25s var26s
keep in 1


* wealth shares
local w1 = varx1s[1]
local w2 = varx2s[1]
local w3 = varx3s[1]
local w4 = varx4s[1]
local w5 = varx5s[1]
local w6 = varx6s[1]



* consumption shares
local c1 = var21s[1]
local c2 = var22s[1]
local c3 = var23s[1]
local c4 = var24s[1]
local c5 = var25s[1]
local c6 = var26s[1]
restore


* --- 3) Write LaTeX table (percent) ---
local texfile "_tables/table3_data.tex"

file open fh using "`texfile'", write replace text
file write fh "\begin{table}[!htbp]\centering" _n
file write fh "\caption{Shares by net worth bins}" _n
file write fh "\label{tab:shares_by_wealthbin}" _n
file write fh "\begin{tabular}{lcc}" _n
file write fh "\hline\hline" _n
file write fh "Bin & Wealth share (\%) & Consumption share (\%) \\\\" _n
file write fh "\hline" _n

* Put the shares into space-separated lists (numbers)
local wlist "`w1' `w2' `w3' `w4' `w5' `w6'"
local clist "`c1' `c2' `c3' `c4' `c5' `c6'"

forvalues i=1/6 {

    local wval : word `i' of `wlist'
    local cval : word `i' of `clist'

    local wi : display %6.1f (100*`wval')
    local ci : display %6.1f (100*`cval')

    local rowname "Q5 (80--100)"
    if `i'==1 local rowname "D1 (0--10)"
    if `i'==2 local rowname "D2 (10--20)"
    if `i'==3 local rowname "Q2 (20--40)"
    if `i'==4 local rowname "Q3 (40--60)"
    if `i'==5 local rowname "Q4 (60--80)"

    file write fh "`rowname' & `wi' & & `ci' & \\\\" _n
}


file write fh "\hline\hline" _n
file write fh "\end{tabular}" _n
file write fh "\end{table}" _n
file close fh


display "Wrote LaTeX table to: `texfile'"

