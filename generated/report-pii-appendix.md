## Appendix: Detailed PII Detection Results

*Generated on 2026-08-15 19:44:43*

This appendix lists all detected instances of potential personally identifiable information (PII) in the project files. Each entry shows the matched PII terms and, for data files, sample values to help verify whether the flagged content is indeed sensitive.

### Data Files

**/replication-package/_replication/LICENSE.txt**

- Variable: `to any person obtaining a copy`
  - Matched terms: son
  - Sample values: 

**/replication-package/_replication/_data/_data/FRBNY-SCE-Public-Microdata-Complete-13-16.csv**

- Variable: `C1_probdeflation`
  - Matched terms: lat
  - Sample values: 1, 0
- Variable: `Q24_probdeflation`
  - Matched terms: lat
  - Sample values: 0, 1
- Variable: `Q9_probdeflation`
  - Matched terms: lat
  - Sample values: 1, 0
- Variable: `Q9c_probdeflation`
  - Matched terms: lat
  - Sample values: 0, 1

**/replication-package/_replication/_data/_data/FRBNY-SCE-Public-Microdata-Complete-17-19.csv**

- Variable: `C1_probdeflation`
  - Matched terms: lat
  - Sample values: 0, 1
- Variable: `Q24_probdeflation`
  - Matched terms: lat
  - Sample values: 0, 1
- Variable: `Q9_probdeflation`
  - Matched terms: lat
  - Sample values: 0, 1
- Variable: `Q9c_probdeflation`
  - Matched terms: lat
  - Sample values: 0, 1

**/replication-package/_replication/_data/_data/FRBNY-SCE-Public-Microdata-latest.csv**

- Variable: `C1_probdeflation`
  - Matched terms: lat
  - Sample values: 0, 1
- Variable: `Q24_probdeflation`
  - Matched terms: lat
  - Sample values: 0, 1
- Variable: `Q9_probdeflation`
  - Matched terms: lat
  - Sample values: 0, 1
- Variable: `Q9c_probdeflation`
  - Matched terms: lat
  - Sample values: 0, 1

**/replication-package/_replication/_data/_data/psid_2004_2010.csv**

- Variable: `HOUSE`
  - Matched terms: house
  - Sample values: 4546, 2445, 2660
- Variable: `PHONE`
  - Matched terms: phone
  - Sample values: 2856, 1680, 1200
- Variable: `SEXHD`
  - Matched terms: sex
  - Sample values: 1, 2
- Variable: `depchild`
  - Matched terms: child
  - Sample values: 1, 0, 2
- Variable: `housevalue`
  - Matched terms: house
  - Sample values: 120000, 100000, 0
- Variable: `wifepres`
  - Matched terms: wife
  - Sample values: 1, 0

**/replication-package/_replication/_data/_data/psid_2004_2010.dta**

- Variable: `HOUSE`
  - Matched terms: house
  - Sample values: 4546.0, 2445.0, 2660.0
- Variable: `I` (label: *Household total income before taxes = IL+IBF+ISS+IT+IA*)
  - Matched terms: house
  - Sample values: 23440.0, 66400.0, 20200.0
- Variable: `IA` (label: *Household asset income*)
  - Matched terms: house
  - Sample values: 0.0, 6400.0, 80.0
- Variable: `IBF` (label: *Household business and farm income*)
  - Matched terms: house
  - Sample values: 0.0, 60000.0, 15000.0
- Variable: `IL` (label: *Household labor income*)
  - Matched terms: house
  - Sample values: 16000.0, 0.0, 19000.0
- Variable: `Ipriv` (label: *Household private income*)
  - Matched terms: house
  - Sample values: 16000.0, 66400.0, 19000.0
- Variable: `PHONE`
  - Matched terms: phone
  - Sample values: 2856.0, 1680.0, 1200.0
- Variable: `SEXHD`
  - Matched terms: sex
  - Sample values: 1.0, 2.0
- Variable: `c1r` (label: *Benchmark Real Household consumption*)
  - Matched terms: house
  - Sample values: 14419.6162109375, 9181.953125, 7536.4423828125
- Variable: `c2r` (label: *Benchmark Real Household consumption*)
  - Matched terms: house
  - Sample values: 15569.8291015625, 19427.73046875, 12472.9765625
- Variable: `depchild`
  - Matched terms: child
  - Sample values: 1.0, 0.0, 2.0
- Variable: `edudum1` (label: *EDUHD==Completed no grades of school*)
  - Matched terms: school
  - Sample values: 0.0, 1.0
- Variable: `housevalue` (label: *Value of main residence*)
  - Matched terms: house
  - Sample values: 120000.0, 100000.0, 0.0
- Variable: `idispr` (label: *Real Household disposable income*)
  - Matched terms: house
  - Sample values: 19935.4453125, 38012.13671875, 12762.380859375
- Variable: `iprivr` (label: *Real Household labor income*)
  - Matched terms: house
  - Sample values: 13164.0908203125, 54630.9765625, 15632.3583984375
- Variable: `wifepres`
  - Matched terms: wife
  - Sample values: 1.0, 0.0

### Code Files

**/replication-package/_replication/.ipynb_checkpoints/make_readme_pdf-checkpoint.py**

- Line 2: lat
  ```
  """Render the replication-package README.md to LaTeX, then PDF.
  ```
- Line 24: lat
  ```
  """Convert inline markdown to LaTeX, protecting code spans first."""
  ```
- Line 33: url
  ```
  # [text](url)
  ```
- Line 39: url
  ```
  # bare <url>
  ```
- Line 41: url
  ```
  lambda m: stash(r'\url{%s}' % m.group(1).replace('%', r'\%').replace('#', r'\#')), s)
  ```
- Line 65: lon
  ```
  # (a long path or code span) sets a hard floor so it cannot overlap
  ```
- Line 66: lon
  ```
  longest = max((len(c) for c in cells), default=1)
  ```
- Line 69: lon
  ```
  longest_token = max((max((len(t) for t in re.split(r'\s+', c)), default=1)
  ```
- Line 71: lon
  ```
  weights.append((math.sqrt(longest), longest_token))
  ```
- Line 78: zip
  ```
  frac = [max(d / scale, f) for d, f in zip(damped, floors)]
  ```
- Line 93: loc
  ```
  nonlocal list_open
  ```
- Line 151: lon
  ```
  out.append(r'\begin{longtable}{%s}' % spec)
  ```
- Line 159: lon
  ```
  out.append(r'\end{longtable}\endgroup')
  ```
- Line 221: lat
  ```
  # join a wrapped paragraph into one LaTeX paragraph
  ```
- Line 244: lon
  ```
  \usepackage{longtable}
  ```
- Line 252: url
  ```
  \urlstyle{same}
  ```
- Line 278: name
  ```
  if __name__ == '__main__':
  ```

**/replication-package/_replication/_data/_aux/bvar_data.R**

- Line 28: name
  ```
  data_cpi   = paste0(dirname(WD),"/_data/_data_var/CPIAUCSL.xls","", collapse = NULL)
  ```
- Line 29: name
  ```
  data_gdp   = paste0(dirname(WD),"/_data/_data_var/GDPC1.xls","", collapse = NULL)
  ```
- Line 30: name
  ```
  data_u     = paste0(dirname(WD),"/_data/_data_var/UNRATE.xls","", collapse = NULL)
  ```
- Line 31: name
  ```
  data_i     = paste0(dirname(WD),"/_data/_data_var/FEDFUNDS.xls","", collapse = NULL)
  ```
- Line 33: name
  ```
  data_avr_hours  = paste0(dirname(WD),"/_data/_data_var/PRS85006023.xls","", collapse = NULL)
  ```
- Line 34: name
  ```
  data_empl       = paste0(dirname(WD),"/_data/_data_var/CE16OV.xls","", collapse = NULL)
  ```
- Line 35: name
  ```
  data_pop        = paste0(dirname(WD),"/_data/_data_var/CNP16OV.xls","", collapse = NULL)
  ```
- Line 107: name
  ```
  write.csv(data_save, paste0(dirname(WD),"/_aux/data_bvar.csv"))
  ```

**/replication-package/_replication/_data/_aux/bvar_est.m**

- Line 6: name
  ```
  currentFile = mfilename( 'fullpath' );
  ```
- Line 24: name
  ```
  opts.VariableNames = ["VarName1", "qdate", "P", "infl", "Y", "y", "yqoq", "u", "Group1x", "irate", "
  ```
- Line 44: lat
  ```
  [Coeff,Vol] = simulate(PosteriorMdl,'NumDraws',smpl);
  ```

**/replication-package/_replication/_data/_aux/sce_data.R**

- Line 28: name
  ```
  sce_1      = paste0(dirname(WD),"/_data/FRBNY-SCE-Public-Microdata-Complete-13-16.csv","", collapse 
  ```
- Line 29: name
  ```
  sce_2      = paste0(dirname(WD),"/_data/FRBNY-SCE-Public-Microdata-Complete-17-19.csv","", collapse 
  ```
- Line 30: lat, name
  ```
  sce_3      = paste0(dirname(WD),"/_data/FRBNY-SCE-Public-Microdata-latest.csv","", collapse = NULL)
  ```
- Line 31: name
  ```
  sce_wealth = paste0(dirname(WD),"/_data/SCE_public_HH-finance_quarterly_microdata.xlsx","", collapse
  ```
- Line 32: name
  ```
  fred_cpi   = paste0(dirname(WD),"/_data/CPIAUCSL.xls","", collapse = NULL)
  ```
- Line 33: name
  ```
  fred_hpi   = paste0(dirname(WD),"/_data/CSUSHPINSA.xls","", collapse = NULL)
  ```
- Line 34: name
  ```
  #spf_prob_u = paste0(dirname(WD),"/_aux/spf_prob_u.dta","", collapse = NULL)
  ```
- Line 35: name
  ```
  spf_prob_u = paste0(dirname(WD),"/_aux/spf_prob_u.csv","", collapse = NULL)
  ```
- Line 37: name
  ```
  bvar_prob_u = paste0(dirname(WD),"/_aux/prob_up_bvar.csv","", collapse = NULL)
  ```
- Line 44: sex
  ```
  data$sex     = as.numeric(data$Q33)
  ```
- Line 66: sex
  ```
  data_sce_1    = subset(data, select = c(qdate,date,id,sex,educ,age,labor_1,labor_2,labor_3,infl_fore
  ```
- Line 75: sex
  ```
  data_sce_1_new$sex[data_sce_1_new$id == id_tmp] = min(data_tmp$sex, na.rm= TRUE)
  ```
- Line 80: sex
  ```
  data_sce_1_new$sex[data_sce_1_new$sex == Inf]   = NA
  ```
- Line 87: sex
  ```
  data$sex     = as.numeric(data$Q33)
  ```
- Line 109: sex
  ```
  data_sce_2    = subset(data, select = c(qdate,date,id,sex,educ,age,labor_1,labor_2,labor_3,infl_fore
  ```
- Line 118: sex
  ```
  data_sce_2_new$sex[data_sce_2_new$id == id_tmp] = min(data_tmp$sex, na.rm= TRUE)
  ```
- Line 123: sex
  ```
  data_sce_2_new$sex[data_sce_2_new$sex == Inf]   = NA
  ```
- Line 130: sex
  ```
  data$sex     = as.numeric(data$Q33)
  ```
- Line 152: sex
  ```
  data_sce_3    = subset(data, select = c(qdate,date,id,sex,educ,age,labor_1,labor_2,labor_3,infl_fore
  ```
- Line 161: sex
  ```
  data_sce_3_new$sex[data_sce_3_new$id == id_tmp] = min(data_tmp$sex, na.rm= TRUE)
  ```
- Line 166: sex
  ```
  data_sce_3_new$sex[data_sce_3_new$sex == Inf]   = NA
  ```
- Line 243: sex
  ```
  data_sce$male        = data_sce$sex-1
  ```

**/replication-package/_replication/_data/_aux/spf_data.m**

- Line 2: name
  ```
  currentFile = mfilename( 'fullpath' );
  ```
- Line 26: second
  ```
  spf_month   = (spf_qtr-1)*3+2;  % SPF is conducted in the second month of every quarter
  ```
- Line 158: lat
  ```
  %% [6] QUARTERLY-TO-MONTHLY INTERPOLATION OF PROBUP
  ```
- Line 189: name
  ```
  'VariableNames', {'year','month','probupSPF','UNRATEUP','yearmonth', ...
  ```

**/replication-package/_replication/_data/data_master.R**

- Line 21: loc
  ```
  ## Locate MATLAB and Stata ------------------------------------------------
  ```
- Line 43: loc
  ```
  "/usr/local/MATLAB/R*/bin/matlab",
  ```
- Line 53: loc
  ```
  "/usr/local/stata*/stata-mp",
  ```
- Line 54: loc
  ```
  "/usr/local/stata*/stata-se",
  ```
- Line 55: loc
  ```
  "/usr/local/stata*/stata"),
  ```

**/replication-package/_replication/_data/figure_1_ab_table_a7a9.R**

- Line 75: lat, name
  ```
  barplot(cond_mean,  main="",xlab="Wealth Percentile", ylab="Absolute Error Relative to Sample Mean",
  ```
- Line 113: name
  ```
  barCenters = barplot(betas,   main="",xlab="Wealth Percentile", ylab="Absolute Error", border="darko
  ```

**/replication-package/_replication/_data/figure_1_cd.R**

- Line 71: lat, name
  ```
  barplot(cond_mean,  main="",xlab="Wealth Percentile", ylab="Absolute Error Relative to Sample Mean",
  ```
- Line 96: name
  ```
  barCenters = barplot(betas,   main="",xlab="Wealth Percentile", ylab="Absolute Error", border="darko
  ```

**/replication-package/_replication/_data/figure_2_a.R**

- Line 76: name
  ```
  barCenters = barplot(betas,   main="",xlab="Wealth Percentile", ylab="Absolute Error", border="darko
  ```
- Line 110: name
  ```
  barCenters = barplot(betas,   main="",xlab="Wealth Percentile", ylab="Absolute Error", border="darko
  ```

**/replication-package/_replication/_data/figure_2_b.R**

- Line 95: name
  ```
  barCenters = barplot(betas,   main="",xlab="Wealth Percentile", ylab="Absolute Error", border="darko
  ```
- Line 129: name
  ```
  barCenters = barplot(betas,   main="",xlab="Wealth Percentile", ylab="Absolute Error", border="darko
  ```

**/replication-package/_replication/_data/figure_6_data.R**

- Line 62: name
  ```
  write.csv(df_data, "../_model/_aux/_models_tmp/figure_6.csv", row.names = FALSE)
  ```
- Line 63: name
  ```
  #write.csv(df_data,"_data/figure_6.csv", row.names = FALSE)
  ```

**/replication-package/_replication/_data/make_table3_data.do**

- Line 8: house
  ```
  gen c2_hv=c1+RENT+PTAX+INS+HOME+intrate*housevalue
  ```
- Line 12: house
  ```
  gen Idisposable=I-fica-fiitax-siitax+intrate*housevalue
  ```
- Line 13: house
  ```
  label var Idisposable "Disposable Income = I-fica-fiitax-siitax+intrate*housevalue"
  ```
- Line 36: house
  ```
  * eliminate households with too low consumption
  ```
- Line 118: lat
  ```
  * Export LaTeX table: shares of wealth, earnings, consumption
  ```
- Line 125: loc
  ```
  * allocate (optional but clean)
  ```
- Line 175: loc
  ```
  local w1 = varx1s[1]
  ```
- Line 176: loc
  ```
  local w2 = varx2s[1]
  ```
- Line 177: loc
  ```
  local w3 = varx3s[1]
  ```
- Line 178: loc
  ```
  local w4 = varx4s[1]
  ```
- Line 179: loc
  ```
  local w5 = varx5s[1]
  ```
- Line 180: loc
  ```
  local w6 = varx6s[1]
  ```
- Line 185: loc
  ```
  local c1 = var21s[1]
  ```
- Line 186: loc
  ```
  local c2 = var22s[1]
  ```
- Line 187: loc
  ```
  local c3 = var23s[1]
  ```
- Line 188: loc
  ```
  local c4 = var24s[1]
  ```
- Line 189: loc
  ```
  local c5 = var25s[1]
  ```
- Line 190: loc
  ```
  local c6 = var26s[1]
  ```
- Line 194: lat
  ```
  * --- 3) Write LaTeX table (percent) ---
  ```
- Line 195: loc
  ```
  local texfile "_tables/table3_data.tex"
  ```
- Line 207: loc
  ```
  local wlist "`w1' `w2' `w3' `w4' `w5' `w6'"
  ```
- Line 208: loc
  ```
  local clist "`c1' `c2' `c3' `c4' `c5' `c6'"
  ```
- Line 212: loc
  ```
  local wval : word `i' of `wlist'
  ```
- Line 213: loc
  ```
  local cval : word `i' of `clist'
  ```
- Line 215: loc
  ```
  local wi : display %6.1f (100*`wval')
  ```
- Line 216: loc
  ```
  local ci : display %6.1f (100*`cval')
  ```
- Line 218: loc, name
  ```
  local rowname "Q5 (80--100)"
  ```
- Line 219: loc, name
  ```
  if `i'==1 local rowname "D1 (0--10)"
  ```
- Line 220: loc, name
  ```
  if `i'==2 local rowname "D2 (10--20)"
  ```
- Line 221: loc, name
  ```
  if `i'==3 local rowname "Q2 (20--40)"
  ```
- Line 222: loc, name
  ```
  if `i'==4 local rowname "Q3 (40--60)"
  ```
- Line 223: loc, name
  ```
  if `i'==5 local rowname "Q4 (60--80)"
  ```
- Line 225: name
  ```
  file write fh "`rowname' & `wi' & & `ci' & \\\\" _n
  ```
- Line 235: lat
  ```
  display "Wrote LaTeX table to: `texfile'"
  ```

**/replication-package/_replication/_data/packages_rstudio.R**

- Line 7: lat
  ```
  "dplyr",        # data manipulation
  ```
- Line 26: name
  ```
  missing <- pkgs[!(pkgs %in% rownames(installed.packages()))]
  ```

**/replication-package/_replication/_data/table_a10.R**

- Line 133: lat
  ```
  sectionB("Panel b: Inflation")
  ```
- Line 145: lat
  ```
  writeLines("error of individual inflation forecasts (column 2), the standard deviation", con)
  ```
- Line 166: name
  ```
  write.csv(df, file.path("..", "_model/_aux/_models_tmp/", "calibration.csv"), row.names = FALSE)
  ```

**/replication-package/_replication/_data/table_a8.R**

- Line 163: name
  ```
  tbl$names = c('Figure 1', 'Figure A.10', 'Figure 2', 'Figure 3')
  ```
- Line 164: name
  ```
  #write.table(tbl, "_tables/table_a8.txt", sep = "\t", row.names = FALSE)
  ```
- Line 169: lname, name
  ```
  colnames(tbl) <- c("lhs", "rhs")
  ```
- Line 191: city
  ```
  writeLines("Table A.8: Test for the Monotonicity of Regression Coefficients", con)
  ```
- Line 200: lat
  ```
  section("Inflation Forecasts")
  ```
- Line 205: house
  ```
  section("House Price Forecasts")
  ```

**/replication-package/_replication/_data/table_b2_a.m**

- Line 4: name
  ```
  currentFile = mfilename( 'fullpath' );
  ```
- Line 19: name
  ```
  opts.VariableNames = ["Date", "Y", "Pop", "I", "C", "K"];
  ```
- Line 48: name
  ```
  names = {'Output $(y)$', 'Investment','Consumption'}';
  ```
- Line 54: name
  ```
  T1 = table(names, std, rel, cor, corxy, corxy1)
  ```
- Line 65: name
  ```
  T1.names{i}, T1.std(i), T1.rel(i), T1.cor(i), T1.corxy(i), T1.corxy1(i));
  ```

**/replication-package/_replication/_model/_aux/_baseline/BKKS_GIRFs.m**

- Line 16: son
  ```
  path = 'D:\Dropbox (Personal)\BKKS_Shadow\_modelresults\';
  ```
- Line 33: son
  ```
  path = 'D:\Dropbox (Personal)\BKKS_Shadow\_modelresults\entrepreneur\';
  ```
- Line 34: son
  ```
  shockpath = 'D:\Dropbox (Personal)\BKKS_Shadow\_modelresults\entrepreneur\';
  ```
- Line 54: lat
  ```
  %simulate the full model
  ```
- Line 55: lat
  ```
  fprintf('simulating the full model... ')
  ```
- Line 101: lat
  ```
  %compute counterfactual shock series and resimulate
  ```
- Line 102: lat
  ```
  fprintf('simulating the counterfactuals... ')
  ```
- Line 130: loc
  ```
  param_local = params;
  ```
- Line 131: loc
  ```
  param_local.T = Nwindow+1;
  ```
- Line 142: loc
  ```
  [Kvec_tmp,~,panel_tmp,stats_tmp] =simKS(dec,ipol,dists,zvec,shocks,param_local);
  ```
- Line 160: loc
  ```
  [Kvec_tmp,~,panel_tmp,stats_tmp] =simKS(dec,ipol,dists,zvec,shocks,param_local);
  ```
- Line 171: lat
  ```
  %calculate output, investment, and consumption
  ```
- Line 224: loc
  ```
  param_local = params;
  ```
- Line 225: loc
  ```
  param_local.T = Nwindow+1;
  ```
- Line 236: loc
  ```
  [Kvec_tmp,~,panel_tmp,stats_tmp] =simKS(dec,ipol,dists,zvec,shocks,param_local);
  ```
- Line 254: loc
  ```
  [Kvec_tmp,~,panel_tmp,stats_tmp] =simKS(dec,ipol,dists,zvec,shocks,param_local);
  ```
- Line 265: lat
  ```
  %calculate output, investment, and consumption
  ```
- Line 330: lat
  ```
  plot_cumulative = 0;
  ```
- Line 339: son
  ```
  path = 'D:\Dropbox (Personal)\BKKS_Shadow\_modelresults\';
  ```
- Line 340: loc, location, son
  ```
  printlocation = 'D:\Dropbox (Personal)\BKKS_Shadow\_revision2\_input\';
  ```
- Line 344: son
  ```
  path = 'D:\Dropbox (Personal)\BKKS_Shadow\_modelresults\entrepreneur\';
  ```
- Line 345: loc, location, son
  ```
  printlocation = 'D:\Dropbox (Personal)\BKKS_Shadow\_revision2\_input\entrepreneur_';
  ```
- Line 352: lat
  ```
  set(groot, 'DefaultTextInterpreter', 'latex');
  ```
- Line 353: lat
  ```
  set(groot, 'DefaultAxesTickLabelInterpreter', 'latex');
  ```
- Line 354: lat
  ```
  set(groot, 'DefaultLegendInterpreter', 'latex');
  ```
- Line 401: lat
  ```
  %cumulative responses
  ```
- Line 430: name
  ```
  plot(IRFwindow',Kvec_trans_mean_neg(2:end,1),'LineWidth',3, 'Color',colors(1,:), 'DisplayName','Benc
  ```
- Line 432: name
  ```
  plot(IRFwindow',Kvec_trans_mean_neg(2:end,2),'LineWidth',2, 'Color',colors(2,:),'LineStyle','--','Di
  ```
- Line 433: name
  ```
  plot(IRFwindow',Kvec_trans_mean_neg(2:end,3),'LineWidth',2, 'Color',colors(2,:),'DisplayName','Full 
  ```
- Line 434: name
  ```
  % plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
  ```
- Line 438: loc, location
  ```
  legend('Location','northeast','FontSize',12,'Box','off')
  ```
- Line 444: loc, location
  ```
  savefig([printlocation 'figure_IRF_k_Q' int2str(plotuntilquarter) '.fig'])
  ```
- Line 445: loc, location
  ```
  exportgraphics(h, [printlocation 'figure_IRF_k_Q' int2str(plotuntilquarter) '.pdf'], 'ContentType', 
  ```
- Line 449: name
  ```
  plot(IRFwindow',y_trans_mean_neg(2:end,1),'LineWidth',3, 'Color',colors(1,:),'DisplayName','Benchmar
  ```
- Line 451: name
  ```
  plot(IRFwindow',y_trans_mean_neg(2:end,2),'LineWidth',2, 'Color',colors(2,:),'LineStyle','--','Displ
  ```
- Line 452: name
  ```
  plot(IRFwindow',y_trans_mean_neg(2:end,3),'LineWidth',2, 'Color',colors(2,:),'DisplayName','Full Inf
  ```
- Line 453: name
  ```
  % plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
  ```
- Line 457: loc, location
  ```
  legend('Location','southeast','FontSize',12,'Box','off')
  ```
- Line 466: loc, location
  ```
  savefig([printlocation 'figure_IRF_y_Q' int2str(plotuntilquarter) '.fig'])
  ```
- Line 467: loc, location
  ```
  exportgraphics(h, [printlocation 'figure_IRF_y_Q' int2str(plotuntilquarter) '.pdf'], 'ContentType', 
  ```
- Line 471: name
  ```
  plot(IRFwindow(1:end-1)',invest_trans_mean_neg(2:end,1),'LineWidth',3, 'Color',colors(1,:),'DisplayN
  ```
- Line 473: name
  ```
  plot(IRFwindow(1:end-1)',invest_trans_mean_neg(2:end,2),'LineWidth',2, 'Color',colors(2,:),'LineStyl
  ```
- Line 474: name
  ```
  plot(IRFwindow(1:end-1)',invest_trans_mean_neg(2:end,3),'LineWidth',2, 'Color',colors(2,:),'DisplayN
  ```
- Line 478: loc, location
  ```
  legend('Location','southeast','FontSize',12,'Box','off')
  ```
- Line 487: loc, location
  ```
  savefig([printlocation 'figure_IRF_inv_Q' int2str(plotuntilquarter) '.fig'])
  ```
- Line 488: loc, location
  ```
  exportgraphics(h, [printlocation 'figure_IRF_inv_Q' int2str(plotuntilquarter) '.pdf'], 'ContentType'
  ```
- Line 492: name
  ```
  % plot(IRFwindow(1:end-1)',c_trans_mean_neg(2:end,1),'LineWidth',3,'DisplayName','Benchmark')
  ```
- Line 494: name
  ```
  % plot(IRFwindow(1:end-1)',c_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName','E
  ```
- Line 495: name
  ```
  % plot(IRFwindow(1:end-1)',c_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
  ```
- Line 499: loc, location
  ```
  % legend('Location','southeast','FontSize',12,'Box','off')
  ```
- Line 507: loc, location
  ```
  %     savefig([printlocation 'figure_IRF_c_Q' int2str(plotuntilquarter) '.fig'])
  ```
- Line 508: loc, location
  ```
  %     exportgraphics(h, [printlocation 'figure_IRF_c_Q' int2str(plotuntilquarter) '.pdf'], 'ContentT
  ```
- Line 514: name
  ```
  % plot(IRFwindow(1:end)',prod_trans_mean_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Informa
  ```
- Line 515: name
  ```
  % plot(IRFwindow(1:end)',prod_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information'
  ```
- Line 519: loc, location
  ```
  % legend('Location','southeast','FontSize',12)
  ```
- Line 528: loc, location
  ```
  savefig([printlocation 'figure_IRF_prod_Q' int2str(plotuntilquarter) '.fig'])
  ```
- Line 529: loc, location
  ```
  exportgraphics(h, [printlocation 'figure_IRF_prod_Q' int2str(plotuntilquarter) '.pdf'], 'ContentType
  ```
- Line 533: name
  ```
  % plot(IRFwindow(1:end)',r_trans_mean_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
  ```
- Line 535: name
  ```
  % plot(IRFwindow(1:end)',r_trans_mean_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Informatio
  ```
- Line 536: name
  ```
  % plot(IRFwindow(1:end)',r_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
  ```
- Line 544: loc, location
  ```
  % legend('Location','southeast','FontSize',12,'Box','off')
  ```
- Line 548: loc, location
  ```
  %     savefig([printlocation 'figure_IRF_r_Q' int2str(plotuntilquarter) '.fig'])
  ```
- Line 549: loc, location
  ```
  %     exportgraphics(h, [printlocation 'figure_IRF_r_Q' int2str(plotuntilquarter) '.pdf'], 'ContentT
  ```
- Line 553: name
  ```
  % plot(IRFwindow',pK_trans_mean_neg(2:end,1),'LineWidth',3,'DisplayName','Benchmark')
  ```
- Line 555: name
  ```
  % plot(IRFwindow',pK_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName','Exogenous
  ```
- Line 556: name
  ```
  % plot(IRFwindow',pK_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
  ```
- Line 557: name
  ```
  % % plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
  ```
- Line 561: loc, location
  ```
  % legend('Location','southeast','FontSize',12)
  ```
- Line 566: loc, location
  ```
  %     savefig([printlocation 'figure_IRF_pK_Q' int2str(plotuntilquarter) '.fig'])
  ```
- Line 567: loc, location
  ```
  %     exportgraphics(h, [printlocation 'figure_IRF_pK_Q' int2str(plotuntilquarter) '.pdf'], 'Content
  ```
- Line 571: name
  ```
  % plot(IRFwindow',pK_w_trans_mean_neg(2:end,1),'LineWidth',3,'DisplayName','Benchmark')
  ```
- Line 573: name
  ```
  % plot(IRFwindow',pK_w_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName','Exogeno
  ```
- Line 574: name
  ```
  % plot(IRFwindow',pK_w_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
  ```
- Line 575: name
  ```
  % % plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
  ```
- Line 579: loc, location
  ```
  % legend('Location','east','FontSize',12)
  ```
- Line 584: loc, location
  ```
  %     savefig([printlocation 'figure_IRF_pK_w_Q' int2str(plotuntilquarter) '.fig'])
  ```
- Line 585: loc, location
  ```
  %     exportgraphics(h, [printlocation 'figure_IRF_pK_w_Q' int2str(plotuntilquarter) '.pdf'], 'Conte
  ```
- Line 589: name
  ```
  % plot(IRFwindow',info_trans_mean_neg(2:end,1),'LineWidth',3,'DisplayName','Benchmark')
  ```
- Line 591: name
  ```
  % plot(IRFwindow',info_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName','Exogeno
  ```
- Line 592: name
  ```
  % plot(IRFwindow',info_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
  ```
- Line 593: name
  ```
  % % plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
  ```
- Line 597: loc, location
  ```
  % legend('Location','east','FontSize',12)
  ```
- Line 602: loc, location
  ```
  %     savefig([printlocation 'figure_IRF_info_Q' int2str(plotuntilquarter) '.fig'])
  ```
- Line 603: loc, location
  ```
  %     exportgraphics(h, [printlocation 'figure_IRF_info_Q' int2str(plotuntilquarter) '.pdf'], 'Conte
  ```
- Line 606: lat
  ```
  % ----------- cumulative responses ------------- %
  ```
- Line 607: lat
  ```
  if plot_cumulative==1
  ```
- Line 609: name
  ```
  plot(IRFwindow',Kvec_trans_mean_cum_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
  ```
- Line 611: name
  ```
  plot(IRFwindow',Kvec_trans_mean_cum_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Information'
  ```
- Line 612: name
  ```
  plot(IRFwindow',Kvec_trans_mean_cum_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
  ```
- Line 613: name
  ```
  % plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
  ```
- Line 617: loc, location
  ```
  legend('Location','northeast','FontSize',12)
  ```
- Line 621: loc, location
  ```
  savefig([printlocation 'figure_IRF_kcum.fig'])
  ```
- Line 622: loc, location
  ```
  % exportgraphics(h, [printlocation 'figure_IRF_kcum.pdf'], 'ContentType', 'vector');
  ```
- Line 625: name
  ```
  plot(IRFwindow',y_trans_mean_cum_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
  ```
- Line 627: name
  ```
  plot(IRFwindow',y_trans_mean_cum_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Information')
  ```
- Line 628: name
  ```
  plot(IRFwindow',y_trans_mean_cum_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
  ```
- Line 629: name
  ```
  % plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
  ```
- Line 633: loc, location
  ```
  legend('Location','southeast','FontSize',12)
  ```
- Line 640: loc, location
  ```
  savefig([printlocation 'figure_IRF_ycum.fig'])
  ```
- Line 641: loc, location
  ```
  % exportgraphics(h, [printlocation 'figure_IRF_ycum.pdf'], 'ContentType', 'vector');
  ```
- Line 644: name
  ```
  plot(IRFwindow(1:end-1)',invest_trans_mean_cum_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
  ```
- Line 646: name
  ```
  plot(IRFwindow(1:end-1)',invest_trans_mean_cum_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous I
  ```
- Line 647: name
  ```
  plot(IRFwindow(1:end-1)',invest_trans_mean_cum_neg(2:end,3),'LineWidth',2,'DisplayName','Full Inform
  ```
- Line 651: loc, location
  ```
  legend('Location','southeast','FontSize',12)
  ```
- Line 658: loc, location
  ```
  savefig([printlocation 'figure_IRF_invcum.fig'])
  ```
- Line 659: loc, location
  ```
  % exportgraphics(h, [printlocation 'figure_IRF_invcum.pdf'], 'ContentType', 'vector');
  ```
- Line 662: name
  ```
  plot(IRFwindow(1:end-1)',c_trans_mean_cum_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
  ```
- Line 664: name
  ```
  plot(IRFwindow(1:end-1)',c_trans_mean_cum_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Inform
  ```
- Line 665: name
  ```
  plot(IRFwindow(1:end-1)',c_trans_mean_cum_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information
  ```
- Line 669: loc, location
  ```
  legend('Location','northeast','FontSize',12)
  ```
- Line 675: lat
  ```
  ylabel('\% change in consumption (cumulative)','FontSize',14)
  ```
- Line 676: loc, location
  ```
  savefig([printlocation 'figure_IRF_ccum.fig'])
  ```
- Line 677: loc, location
  ```
  % exportgraphics(h, [printlocation 'figure_IRF_ccum.pdf'], 'ContentType', 'vector');
  ```
- Line 680: name
  ```
  plot(IRFwindow(1:end)',prod_trans_mean_cum_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
  ```
- Line 682: name
  ```
  plot(IRFwindow(1:end)',prod_trans_mean_cum_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Infor
  ```
- Line 683: name
  ```
  plot(IRFwindow(1:end)',prod_trans_mean_cum_neg(2:end,3),'LineWidth',2,'DisplayName','Full Informatio
  ```
- Line 687: loc, location
  ```
  % legend('Location','southeast','FontSize',12)
  ```
- Line 694: loc, location
  ```
  savefig([printlocation 'figure_IRF_prodcum.fig'])
  ```
- Line 695: loc, location
  ```
  % exportgraphics(h, [printlocation 'figure_IRF_prodcum.pdf'], 'ContentType', 'vector');
  ```
- Line 698: name
  ```
  plot(IRFwindow(1:end)',u_trans_mean_cum_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
  ```
- Line 700: name
  ```
  plot(IRFwindow(1:end)',u_trans_mean_cum_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Informat
  ```
- Line 701: name
  ```
  plot(IRFwindow(1:end)',u_trans_mean_cum_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
  ```
- Line 705: loc, location
  ```
  % legend('Location','southeast','FontSize',12)
  ```
- Line 712: loc, location
  ```
  savefig([printlocation 'figure_IRF_ucum.fig'])
  ```
- Line 713: loc, location
  ```
  % exportgraphics(h, [printlocation 'figure_IRF_ucum.pdf'], 'ContentType', 'vector');
  ```

**/replication-package/_replication/_model/_aux/_baseline/BKKS_load_parameters.m**

- Line 7: loc, location, name
  ```
  filename = [excellocation 'modelsMasterExcel.xlsx'];
  ```
- Line 8: name
  ```
  CellData = readcell(filename);
  ```
- Line 9: name
  ```
  parnames=CellData(2:end,1);
  ```
- Line 13: name
  ```
  parvalues=CellData(2:length(parnames)+1,2+index);
  ```
- Line 17: name
  ```
  for i=1:length(parnames)
  ```
- Line 18: name
  ```
  eval(['par.' parnames{i} '=parvalues{i};'])
  ```

**/replication-package/_replication/_model/_aux/_baseline/BKKS_main.m**

- Line 120: lat
  ```
  % Simulation length
  ```
- Line 148: lon
  ```
  params.upsilon=ones(nx,1);
  ```
- Line 518: lat
  ```
  disp('interpolated info pol on new grid')
  ```
- Line 638: lat
  ```
  % Next step - do the simulation
  ```
- Line 677: lat
  ```
  lambda0=parIn.lambda0_lateIter;
  ```
- Line 678: lat
  ```
  lambda1=parIn.lambda1_lateIter;
  ```
- Line 721: lat
  ```
  [moments,TS] = calculate_moments_stoch(Kvec',panel,ishocks,zvec,params);
  ```
- Line 723: lat
  ```
  forecast_moments = calculate_fcerrors_stoch_optimized(Kvec',panel,zvec,params,a0,a1);
  ```

**/replication-package/_replication/_model/_aux/_baseline/BKKS_start_runs.m**

- Line 13: loc, location
  ```
  excellocation = '';
  ```
- Line 14: loc, location
  ```
  guesslocation = '../_models_tmp/';
  ```
- Line 15: loc, location
  ```
  savelocation  = guesslocation;
  ```
- Line 17: loc, location
  ```
  parIn = BKKS_load_parameters(model_to_run,excellocation);
  ```
- Line 18: loc, location
  ```
  parIn.readInitialGuessFile = [guesslocation parIn.readInitialGuessFile];
  ```
- Line 19: loc, location
  ```
  parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '.mat'];
  ```
- Line 20: loc, location
  ```
  parIn.readShocksFile = [guesslocation parIn.readShocksFile];
  ```
- Line 35: loc, location
  ```
  excellocation = '';
  ```
- Line 36: loc, location
  ```
  guesslocation = '../_models_tmp/';
  ```
- Line 37: loc, location
  ```
  savelocation  = guesslocation;
  ```
- Line 38: loc, location
  ```
  parIn = BKKS_load_parameters(model_to_run,excellocation);
  ```
- Line 45: loc, location
  ```
  parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_exoki.mat'];
  ```
- Line 46: loc, location
  ```
  parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '.mat']
  ```
- Line 47: loc, location
  ```
  parIn.readShocksFile = [guesslocation parIn.readShocksFile];
  ```
- Line 52: loc, location
  ```
  parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_exo.mat'];
  ```
- Line 53: loc, location
  ```
  parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '_exoki.mat']
  ```
- Line 54: loc, location
  ```
  parIn.readShocksFile = [guesslocation parIn.readShocksFile];
  ```
- Line 60: loc, location
  ```
  parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_exo_ui.mat'];
  ```
- Line 61: loc, location
  ```
  parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '_exo.mat']
  ```
- Line 62: loc, location
  ```
  parIn.readShocksFile = [guesslocation parIn.readShocksFile];
  ```
- Line 79: loc, location
  ```
  excellocation = '';
  ```
- Line 80: loc, location
  ```
  guesslocation = '../_models_tmp/';
  ```
- Line 81: loc, location
  ```
  savelocation  = guesslocation;
  ```
- Line 82: loc, location
  ```
  parIn = BKKS_load_parameters(model_to_run,excellocation);
  ```
- Line 88: loc, location
  ```
  parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_fiki.mat'];
  ```
- Line 89: loc, location
  ```
  parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '.mat']
  ```
- Line 90: loc, location
  ```
  parIn.readShocksFile = [guesslocation parIn.readShocksFile];
  ```
- Line 94: loc, location
  ```
  parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_fi.mat'];
  ```
- Line 95: loc, location
  ```
  parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '_fiki.mat']
  ```
- Line 96: loc, location
  ```
  parIn.readShocksFile = [guesslocation parIn.readShocksFile];
  ```
- Line 101: loc, location
  ```
  parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_fi_ui.mat'];
  ```
- Line 102: loc, location
  ```
  parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '_fi.mat']
  ```
- Line 103: loc, location
  ```
  parIn.readShocksFile = [guesslocation parIn.readShocksFile];
  ```
- Line 119: loc, location
  ```
  excellocation = '';
  ```
- Line 120: loc, location
  ```
  guesslocation = '../_models_tmp/';
  ```
- Line 121: loc, location
  ```
  savelocation  = guesslocation;
  ```
- Line 122: loc, location
  ```
  parIn = BKKS_load_parameters(model_to_run,excellocation);
  ```
- Line 126: loc, location
  ```
  parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '.mat'];
  ```
- Line 127: loc, location
  ```
  parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_ui.mat'];
  ```
- Line 128: loc, location
  ```
  parIn.readShocksFile = [guesslocation parIn.readShocksFile];
  ```
- Line 140: loc, location
  ```
  excellocation = '';
  ```
- Line 141: loc, location
  ```
  guesslocation = '../_models_tmp/';
  ```
- Line 142: loc, location
  ```
  savelocation  = guesslocation;
  ```
- Line 145: loc, location
  ```
  parIn = BKKS_load_parameters(model_to_run,excellocation);
  ```
- Line 146: loc, location
  ```
  parIn.readInitialGuessFile = [guesslocation parIn.readInitialGuessFile];
  ```
- Line 147: loc, location
  ```
  parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '.mat'];
  ```
- Line 148: loc, location
  ```
  parIn.readShocksFile = [guesslocation parIn.readShocksFile];
  ```
- Line 159: loc, location
  ```
  excellocation = '';
  ```
- Line 160: loc, location
  ```
  guesslocation = '../_models_tmp/';
  ```
- Line 161: loc, location
  ```
  savelocation  = guesslocation;
  ```
- Line 163: loc, location
  ```
  parIn = BKKS_load_parameters(model_to_run,excellocation);
  ```
- Line 164: loc, location
  ```
  parIn.readInitialGuessFile = [savelocation 'model_1001.mat'];
  ```
- Line 166: loc, location
  ```
  parIn.saveResultsFile = [savelocation 'model_' int2str(model_to_run) '_LOMendo.mat'];
  ```
- Line 167: loc, location
  ```
  parIn.readShocksFile = [guesslocation parIn.readShocksFile];
  ```

**/replication-package/_replication/_model/_aux/_baseline/DoMomentsTouchup.m**

- Line 9: lat
  ```
  [moments,TS] = calculate_moments_stoch(Kvec',panel,ishocks,zvec,params);
  ```

**/replication-package/_replication/_model/_aux/_baseline/InfoDecomposition.m**

- Line 17: name
  ```
  thisDir = fileparts(mfilename('fullpath'));
  ```
- Line 41: lat
  ```
  [moments_fi1,~] = calculate_moments_stoch(Kvec_fi1',panel_fi1,ishocks,zvec,params);
  ```
- Line 46: lat
  ```
  [moments_fi2,~] = calculate_moments_stoch(Kvec_fi2',panel_fi2,ishocks,zvec,params);
  ```
- Line 55: lat
  ```
  [moments_exo,~] = calculate_moments_stoch(Kvec_exo',panel_exo,ishocks,zvec,params);
  ```

**/replication-package/_replication/_model/_aux/_baseline/PanelForAlex.m**

- Line 17: lat
  ```
  [moments,TS] = calculate_moments_stoch(Kvec',panel,ishocks,zvec,params);
  ```
- Line 19: lat
  ```
  forecast_moments = calculate_fcerrors_stoch(Kvec',panel,zvec,params,a0,a1);
  ```
- Line 33: lat
  ```
  % [moments4,TS] = calculate_moments_stoch(Kvec',panel,ishocks,zvec,params);
  ```
- Line 35: lat
  ```
  % forecast_moments3 = calculate_fcerrors_stoch_optimized(Kvec',panel,zvec,params,a0,a1);
  ```

**/replication-package/_replication/_model/_aux/_baseline/Redo_Wealth_Moments.m**

- Line 18: loc, location
  ```
  excellocation = '';
  ```

**/replication-package/_replication/_model/_aux/_baseline/Redo_Wealth_Moments_Ent.m**

- Line 26: loc, location
  ```
  excellocation = '';
  ```

**/replication-package/_replication/_model/_aux/_baseline/calculate_fcerrors_stoch.m**

- Line 2: lat
  ```
  % Translate Tobi code to Kurt code
  ```
- Line 49: lat
  ```
  % CALCULATE QUINTILES/DECILES (DEFINED SEPARATELY EACH PERIOD)
  ```

**/replication-package/_replication/_model/_aux/_baseline/calculate_fcerrors_stoch_optimized.m**

- Line 89: lat
  ```
  %% Initialize accumulators for summary statistics
  ```
- Line 168: lat
  ```
  % Store fc_irate_1q for use in 4q error calculation (needed even if t >= T-1)
  ```
- Line 180: lat
  ```
  % Accumulate for unconditional mean
  ```
- Line 183: lat
  ```
  % Accumulate by quintile
  ```
- Line 190: lat
  ```
  % Accumulate by decile
  ```

**/replication-package/_replication/_model/_aux/_baseline/calculate_ineq_moments_stoch.m**

- Line 1: lat
  ```
  function [moments] = calculate_ineq_moments_stoch(kmts,kcross,agshock,params)
  ```
- Line 3: lat
  ```
  %simulation of BKKS
  ```
- Line 4: lat
  ```
  % Translate Tobi code to Kurt code
  ```

**/replication-package/_replication/_model/_aux/_baseline/calculate_moments_stoch.m**

- Line 1: lat
  ```
  function [moments,TS] = calculate_moments_stoch(kmts,panel,idshock,agshock,params)
  ```
- Line 3: lat
  ```
  %simulation of BKKS
  ```
- Line 4: lat
  ```
  % Translate Tobi code to Kurt code
  ```
- Line 113: lat
  ```
  %(auto)correlations in logs
  ```
- Line 137: lat
  ```
  %(auto)correlations in hp-filtered logs
  ```
- Line 162: lat
  ```
  %autocorrelations and correlations with output
  ```

**/replication-package/_replication/_model/_aux/_baseline/getDirs.m**

- Line 5: name
  ```
  user = getenv('USERNAME');
  ```

**/replication-package/_replication/_model/_aux/_baseline/get_moments_table.m**

- Line 4: lname, name
  ```
  load(modelname,'*moments')
  ```

**/replication-package/_replication/_model/_aux/_baseline/inequality_moments.m**

- Line 9: lat
  ```
  ineq_moments_bench = calculate_ineq_moments_stoch(Kvec',kdist_panel,zvec,params);
  ```
- Line 12: lat
  ```
  ineq_moments_FI = calculate_ineq_moments_stoch(Kvec',kdist_panel,zvec,params);
  ```
- Line 15: lat
  ```
  ineq_moments_exo = calculate_ineq_moments_stoch(Kvec',kdist_panel,zvec,params);
  ```
- Line 20: lat
  ```
  ineq_moments_bench = calculate_ineq_moments_stoch(Kvec',kdist_panel,zvec,params);
  ```
- Line 23: lat
  ```
  ineq_moments_FI = calculate_ineq_moments_stoch(Kvec',kdist_panel,zvec,params);
  ```
- Line 26: lat
  ```
  ineq_moments_exo = calculate_ineq_moments_stoch(Kvec',kdist_panel,zvec,params);
  ```
- Line 106: name
  ```
  % Define common names
  ```
- Line 108: name
  ```
  varNames    = {'Data','Bench','FI','Exo'};
  ```
- Line 109: name
  ```
  rowNames5   = {'Top 1 Share','Top 10 Share','99 Share','50-90 Share','Bottom 50 Share'};
  ```
- Line 110: name
  ```
  rowNames6   = {'Top 1 Share','Top 10 Share','99 Share','50-90 Share','Bottom 50 Share','Gini'};
  ```
- Line 111: name
  ```
  rowNamesACF = {'Lag 1','Lag 2','Lag 3','Lag 4','Lag 5','Lag 6','Lag 7'};
  ```
- Line 121: name
  ```
  rel_momentsT.Properties.VariableNames = varNames;
  ```
- Line 122: name
  ```
  rel_momentsT.Properties.RowNames      = rowNames5;
  ```
- Line 132: name
  ```
  rel_moments_cT.Properties.VariableNames = varNames;
  ```
- Line 133: name
  ```
  rel_moments_cT.Properties.RowNames      = rowNames5;
  ```
- Line 143: name
  ```
  relu_momentsT.Properties.VariableNames = varNames;
  ```
- Line 144: name
  ```
  relu_momentsT.Properties.RowNames      = rowNames5;
  ```
- Line 154: name
  ```
  relu_moments_cT.Properties.VariableNames = varNames;
  ```
- Line 155: name
  ```
  relu_moments_cT.Properties.RowNames      = rowNames5;
  ```
- Line 165: name
  ```
  mean_momentsT.Properties.VariableNames = varNames;
  ```
- Line 166: name
  ```
  mean_momentsT.Properties.RowNames      = rowNames5;
  ```
- Line 176: name
  ```
  acf_momentsT.Properties.VariableNames = varNames;
  ```
- Line 177: name
  ```
  acf_momentsT.Properties.RowNames      = rowNamesACF;
  ```
- Line 187: name
  ```
  corr_momentsT.Properties.VariableNames = varNames;
  ```
- Line 188: name
  ```
  corr_momentsT.Properties.RowNames      = rowNames6;
  ```
- Line 198: name
  ```
  corr_moments_levT.Properties.VariableNames = varNames;
  ```
- Line 199: name
  ```
  corr_moments_levT.Properties.RowNames      = rowNames6;
  ```
- Line 209: name
  ```
  corru_momentsT.Properties.VariableNames = varNames;
  ```
- Line 210: name
  ```
  corru_momentsT.Properties.RowNames      = rowNames6;
  ```
- Line 220: name
  ```
  corru_moments_levT.Properties.VariableNames = varNames;
  ```
- Line 221: name
  ```
  corru_moments_levT.Properties.RowNames      = rowNames6;
  ```
- Line 243: lat
  ```
  table2latex(rel_momentsT,       'rel_momentsT.tex');
  ```
- Line 244: lat
  ```
  table2latex(rel_moments_cT,     'rel_moments_cT.tex');
  ```
- Line 245: lat
  ```
  table2latex(relu_momentsT,      'relu_momentsT.tex');
  ```
- Line 246: lat
  ```
  table2latex(relu_moments_cT,    'relu_moments_cT.tex');
  ```
- Line 247: lat
  ```
  table2latex(mean_momentsT,      'mean_momentsT.tex');
  ```
- Line 248: lat
  ```
  table2latex(acf_momentsT,       'acf_momentsT.tex');
  ```
- Line 249: lat
  ```
  table2latex(corr_momentsT,      'corr_momentsT.tex');
  ```
- Line 250: lat
  ```
  table2latex(corr_moments_levT,  'corr_moments_levT.tex');
  ```
- Line 251: lat
  ```
  table2latex(corru_momentsT,     'corru_momentsT.tex');
  ```
- Line 252: lat
  ```
  table2latex(corru_moments_levT, 'corru_moments_levT.tex');
  ```

**/replication-package/_replication/_model/_aux/_baseline/make_table_bench_compare.m**

- Line 27: name
  ```
  base_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '
  ```
- Line 31: name
  ```
  base_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) 
  ```
- Line 35: name
  ```
  base_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run
  ```
- Line 39: name
  ```
  wtax_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run
  ```
- Line 44: name
  ```
  wtax_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '
  ```
- Line 49: name
  ```
  wtax_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) 
  ```
- Line 54: name
  ```
  ui_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.m
  ```
- Line 58: name
  ```
  ui_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.
  ```
- Line 62: name
  ```
  ui_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) 
  ```
- Line 65: name
  ```
  base_fi    = get_moments_table(base_fi_name);
  ```
- Line 66: name
  ```
  base_exo     = get_moments_table(base_exo_name);
  ```
- Line 67: name
  ```
  base_endo     = get_moments_table(base_endo_name);
  ```
- Line 69: name
  ```
  wtax_fi    = get_moments_table(wtax_fi_name);
  ```
- Line 70: name
  ```
  wtax_exo     = get_moments_table(wtax_exo_name);
  ```
- Line 71: name
  ```
  wtax_endo     = get_moments_table(wtax_endo_name);
  ```
- Line 73: name
  ```
  ui_fi    = get_moments_table(ui_fi_name);
  ```
- Line 74: name
  ```
  ui_exo     = get_moments_table(ui_exo_name);
  ```
- Line 75: name
  ```
  ui_endo     = get_moments_table(ui_endo_name);
  ```
- Line 84: lat
  ```
  % Write LaTeX header
  ```
- Line 119: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/_aux/_baseline/make_table_entrepreneur_compare.m**

- Line 3: name
  ```
  base_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(mod
  ```
- Line 4: name
  ```
  base_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(mo
  ```
- Line 5: name
  ```
  base_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(
  ```
- Line 7: name
  ```
  % wtax_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/model_' int2str(model_to_run) '_
  ```
- Line 8: name
  ```
  % wtax_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/model_' int2str(model_to_run) '
  ```
- Line 9: name
  ```
  wtax_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(
  ```
- Line 10: name
  ```
  wtax_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(mod
  ```
- Line 11: name
  ```
  wtax_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(mo
  ```
- Line 12: name
  ```
  % wtax_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/model_' int2str(model_to_run)
  ```
- Line 14: name
  ```
  ui_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model
  ```
- Line 15: name
  ```
  ui_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(mode
  ```
- Line 16: name
  ```
  ui_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(mo
  ```
- Line 19: name
  ```
  base_fi    = get_moments_table(base_fi_name);
  ```
- Line 20: name
  ```
  base_exo     = get_moments_table(base_exo_name);
  ```
- Line 21: name
  ```
  base_endo     = get_moments_table(base_endo_name);
  ```
- Line 23: name
  ```
  wtax_fi    = get_moments_table(wtax_fi_name);
  ```
- Line 24: name
  ```
  wtax_exo     = get_moments_table(wtax_exo_name);
  ```
- Line 25: name
  ```
  wtax_endo     = get_moments_table(wtax_endo_name);
  ```
- Line 27: name
  ```
  ui_fi    = get_moments_table(ui_fi_name);
  ```
- Line 28: name
  ```
  ui_exo     = get_moments_table(ui_exo_name);
  ```
- Line 29: name
  ```
  ui_endo     = get_moments_table(ui_endo_name);
  ```
- Line 38: lat
  ```
  % Write LaTeX header
  ```
- Line 73: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/_aux/_baseline/make_table_entrepreneur_fi.m**

- Line 21: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/_aux/_baseline/simKS.m**

- Line 144: son
  ```
  % First thing, for each person, we have to figure out their info choice
  ```

**/replication-package/_replication/_model/_aux/_baseline/solve_EGM.m**

- Line 211: lat
  ```
  % Need to interpolate the info choice
  ```
- Line 217: lat, lon
  ```
  % instead of cash at hand, we no longer need to interpolate the ipol
  ```
- Line 243: lat
  ```
  % To figure out cp we interpolate the guess for the consumption policy
  ```
- Line 346: lat
  ```
  % Now interpolate back onto the cah grid, with dimension nA
  ```

**/replication-package/_replication/_model/_aux/_baseline/solve_experience.m**

- Line 302: lat
  ```
  % Interpolate Wpre in terms of yesterday's posterior
  ```

**/replication-package/_replication/_model/_aux/_baseline/wprctile.m**

- Line 6: lat
  ```
  % for Monte Carlo simulations where some simulations are very bad (in terms of
  ```
- Line 7: lat
  ```
  % goodness of fit between simulated and actual value) than the others and to
  ```
- Line 25: lat
  ```
  %         Type 4: p(k) = k/n. That is, linear interpolation of the empirical cdf.
  ```
- Line 41: lat
  ```
  %         Interpolating between the points pk and X(k) gives the sample
  ```
- Line 49: lat, lon
  ```
  %        When X is a matrix, WPRCTILE calculates percentiles along dimension DIM
  ```
- Line 163: lat
  ```
  k = cumsum(sortedW);           % cumulative weight
  ```
- Line 187: lat
  ```
  % Interpolation between q and xx for given value of p
  ```

**/replication-package/_replication/_model/_aux/_kvar/BKKS_load_parameters.m**

- Line 7: loc, location, name
  ```
  filename = [excellocation 'modelsMasterExcel.xlsx'];
  ```
- Line 8: name
  ```
  CellData = readcell(filename);
  ```
- Line 9: name
  ```
  parnames=CellData(2:end,1);
  ```
- Line 13: name
  ```
  parvalues=CellData(2:length(parnames)+1,2+index);
  ```
- Line 17: name
  ```
  for i=1:length(parnames)
  ```
- Line 18: name
  ```
  eval(['par.' parnames{i} '=parvalues{i};'])
  ```

**/replication-package/_replication/_model/_aux/_kvar/BKKS_main.m**

- Line 119: lat
  ```
  % Simulation length
  ```
- Line 147: lon
  ```
  params.upsilon=ones(nx,1);
  ```
- Line 512: lat
  ```
  disp('interpolated info pol on new grid')
  ```
- Line 613: lat
  ```
  % bilinear interpolation
  ```
- Line 633: lat
  ```
  % reduces to linear in K only (accumulate to the single j=1 column)
  ```
- Line 636: second
  ```
  wLU = 0;                   % no second dimension
  ```
- Line 879: lat
  ```
  % Next step - do the simulation
  ```
- Line 919: lat
  ```
  lambda0=parIn.lambda0_lateIter;
  ```
- Line 920: lat
  ```
  lambda1=parIn.lambda1_lateIter;
  ```
- Line 963: lat
  ```
  [moments,TS] = calculate_moments_stoch(Kvec',panel,ishocks,zvec,params);
  ```
- Line 965: lat
  ```
  forecast_moments = calculate_fcerrors_stoch(Kvec',panel,zvec,params,a0,a1);
  ```

**/replication-package/_replication/_model/_aux/_kvar/BKKS_start_runs.m**

- Line 13: loc, location
  ```
  excellocation = '';
  ```
- Line 14: loc, location
  ```
  guesslocation = '../_models_tmp/';
  ```
- Line 15: loc, location
  ```
  savelocation  = guesslocation;
  ```
- Line 16: loc, location
  ```
  parIn = BKKS_load_parameters(model_to_run,excellocation);
  ```
- Line 17: loc, location
  ```
  parIn.readInitialGuessFile = [guesslocation parIn.readInitialGuessFile];
  ```
- Line 18: loc, location
  ```
  parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '.mat'];
  ```
- Line 19: loc, location
  ```
  parIn.readShocksFile = [guesslocation parIn.readShocksFile];
  ```

**/replication-package/_replication/_model/_aux/_kvar/DoPanelExPost.m**

- Line 18: lat
  ```
  [moments,TS] = calculate_moments_stoch(Kvec',panel,ishocks,zvec,params);
  ```
- Line 19: lat
  ```
  forecast_moments = calculate_fcerrors_stoch(Kvec',panel,zvec,params,a0,a1);
  ```

**/replication-package/_replication/_model/_aux/_kvar/GaussHermite_2.m**

- Line 6: degree
  ```
  % (of the n'th degree Hermite polynomial) is constructed as a
  ```

**/replication-package/_replication/_model/_aux/_kvar/calculate_fcerrors_stoch.m**

- Line 2: lat
  ```
  % Translate Tobi code to Kurt code
  ```
- Line 49: lat
  ```
  % CALCULATE QUINTILES/DECILES (DEFINED SEPARATELY EACH PERIOD)
  ```

**/replication-package/_replication/_model/_aux/_kvar/calculate_ineq_moments_stoch.m**

- Line 1: lat
  ```
  function [moments] = calculate_ineq_moments_stoch(kmts,kcross,agshock,params)
  ```
- Line 3: lat
  ```
  %simulation of BKKS
  ```
- Line 4: lat
  ```
  % Translate Tobi code to Kurt code
  ```

**/replication-package/_replication/_model/_aux/_kvar/calculate_moments_stoch.m**

- Line 1: lat
  ```
  function [moments,TS] = calculate_moments_stoch(kmts,panel,idshock,agshock,params)
  ```
- Line 3: lat
  ```
  %simulation of BKKS
  ```
- Line 4: lat
  ```
  % Translate Tobi code to Kurt code
  ```

**/replication-package/_replication/_model/_aux/_kvar/get_moments_table.m**

- Line 4: lname, name
  ```
  load(modelname,'*moments')
  ```

**/replication-package/_replication/_model/_aux/_kvar/rouwenhorst.m**

- Line 15: lon
  ```
  %            sigma   scalar, std. dev. of epsilons
  ```
- Line 26: lat
  ```
  % and autocorrelations of the AR(1) process. The method however tends to
  ```
- Line 28: lat
  ```
  % than the Tauchen methods (the kurtosis of the simulated eps is too high
  ```

**/replication-package/_replication/_model/_aux/_kvar/simKS.m**

- Line 161: son
  ```
  % First thing, for each person, we have to figure out their info choice
  ```

**/replication-package/_replication/_model/_aux/_kvar/solve_EGM.m**

- Line 281: lat
  ```
  % Need to interpolate the info choice
  ```
- Line 287: lat, lon
  ```
  % instead of cash at hand, we no longer need to interpolate the ipol
  ```
- Line 313: lat
  ```
  % To figure out cp we interpolate the guess for the consumption policy
  ```
- Line 466: lat
  ```
  % Now interpolate back onto the cah grid, with dimension nA
  ```

**/replication-package/_replication/_model/_aux/_kvar/solve_experience.m**

- Line 191: lat
  ```
  % These are for the cah calculations, which only depend on s,K, and z, they
  ```
- Line 343: lat
  ```
  % Interpolate Wpre in terms of yesterday's posterior
  ```
- Line 463: lat
  ```
  % Linear weights (NO clamping; allow extrapolation on [1,2] and [nX-1,nX])
  ```
- Line 494: lat
  ```
  EXp_flat = zeros(nA, nz, npk, NT, 'like', Wpostpre);   % sliced in dim 4
  ```
- Line 501: lat, loc
  ```
  % --- local accumulator for this (j,pzc) ---
  ```
- Line 502: loc
  ```
  EXloc = zeros(nA, nz, npk, 'like', Wpostpre);
  ```
- Line 512: block, loc
  ```
  % weights over jp blocks (size 1×J), expand to columns (1×(J*npk
  ```
- Line 518: block, loc
  ```
  % 1) build Wmat: nA × (J*npk), with ksigkprob scaling per jp-bloc
  ```
- Line 537: loc
  ```
  EXloc(:,zc,:) = EXloc(:,zc,:) + reshape(add,[nA,1,npk]);
  ```
- Line 542: lat, loc
  ```
  EXp_flat(:,:,:,tj) = EXloc;
  ```
- Line 546: lat
  ```
  EXp = reshape(EXp_flat, [nA, nz, npk, npzp, J]);
  ```

**/replication-package/_replication/_model/_aux/_kvar/wprctile.m**

- Line 6: lat
  ```
  % for Monte Carlo simulations where some simulations are very bad (in terms of
  ```
- Line 7: lat
  ```
  % goodness of fit between simulated and actual value) than the others and to
  ```
- Line 25: lat
  ```
  %         Type 4: p(k) = k/n. That is, linear interpolation of the empirical cdf.
  ```
- Line 41: lat
  ```
  %         Interpolating between the points pk and X(k) gives the sample
  ```
- Line 49: lat, lon
  ```
  %        When X is a matrix, WPRCTILE calculates percentiles along dimension DIM
  ```
- Line 163: lat
  ```
  k = cumsum(sortedW);           % cumulative weight
  ```
- Line 187: lat
  ```
  % Interpolation between q and xx for given value of p
  ```

**/replication-package/_replication/_model/_aux/get_moments_table.m**

- Line 4: lname, name
  ```
  load(modelname,'*moments')
  ```

**/replication-package/_replication/_model/_aux/get_moments_table2.m**

- Line 4: lname, name
  ```
  load(modelname,'*moments')
  ```

**/replication-package/_replication/_model/_aux/slim_models_tmp.m**

- Line 6: name
  ```
  %    (A) For every .mat file whose name corresponds to a model identifier in
  ```
- Line 28: name
  ```
  %    * Atomic: each file is rewritten to <name>.slimtmp in the SAME
  ```
- Line 29: name
  ```
  %      directory, verified by reopening it, and only then renamed over the
  ```
- Line 50: name
  ```
  datapath = fullfile(fileparts(mfilename('fullpath')), '_models_tmp');
  ```
- Line 110: name
  ```
  fprintf('  [CLEAN]   removing stale temp %s\n', stale(s).name);
  ```
- Line 112: name
  ```
  delete(fullfile(datapath, stale(s).name));
  ```
- Line 123: name
  ```
  name = KEEP_FILES{i};
  ```
- Line 124: name
  ```
  f    = fullfile(datapath, name);
  ```
- Line 127: name
  ```
  fprintf('  [MISSING] %-24s  -- not present, cannot slim\n', name);
  ```
- Line 129: block, loc
  ```
  allOK    = false;          % a missing keep-file blocks the deletes
  ```
- Line 139: name
  ```
  fprintf('  [ERROR]   %-24s  -- unreadable: %s\n', name, ME.message);
  ```
- Line 142: name
  ```
  names = {w.name};
  ```
- Line 144: name
  ```
  hasPanelVar = any(ismember(names, PANEL_VARS));
  ```
- Line 145: name
  ```
  fmIdx       = find(strcmp(names, 'forecast_moments'), 1);
  ```
- Line 150: name
  ```
  fprintf('  [SKIP]    %-24s  %7.1f MB  already slim\n', name, before/1e6);
  ```
- Line 155: name
  ```
  keepVars = setdiff(names, PANEL_VARS, 'stable');
  ```
- Line 157: name
  ```
  fprintf('  [ERROR]   %-24s  -- nothing would remain\n', name);
  ```
- Line 161: name
  ```
  fprintf('  [SLIM]    %-24s  %7.1f MB -> ', name, before/1e6);
  ```
- Line 164: name
  ```
  dropped = intersect(names, PANEL_VARS, 'stable');
  ```
- Line 171: name
  ```
  % NOTE: the temp name MUST still end in ".mat" -- MATLAB's load() refuses
  ```
- Line 191: name
  ```
  vname = {v.name};
  ```
- Line 193: name
  ```
  missingV = setdiff(keepVars, vname);
  ```
- Line 197: name
  ```
  strayV = intersect(vname, PANEL_VARS);
  ```
- Line 201: name
  ```
  fmI = find(strcmp(vname, 'forecast_moments'), 1);
  ```
- Line 241: name
  ```
  name = DELETE_FILES{i};
  ```
- Line 242: name
  ```
  f    = fullfile(datapath, name);
  ```
- Line 244: name
  ```
  fprintf('  [GONE]    %-24s  already absent\n', name);
  ```
- Line 249: name
  ```
  fprintf('  [DELETE]  %-24s  %7.2f GB  (dry run)\n', name, d.bytes/1e9);
  ```
- Line 253: name
  ```
  fprintf('  [ERROR]   %-24s  delete failed\n', name);
  ```
- Line 255: name
  ```
  fprintf('  [DELETE]  %-24s  %7.2f GB  removed\n', name, d.bytes/1e9);
  ```
- Line 279: lat
  ```
  ' re-run first, which repopulates the panels and the shock files.\n']);
  ```

**/replication-package/_replication/_model/figure_3_and_4.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 154: lat
  ```
  ylabel('Density','Interpreter','latex');
  ```
- Line 155: lat
  ```
  xlabel('Savings Errors (''000 $)','Interpreter','latex');
  ```
- Line 193: name
  ```
  set(plot1(1),'DisplayName','Employed ($z_h$, lhs)','LineStyle','--',...
  ```
- Line 195: name
  ```
  set(plot1(2),'DisplayName','Employed ($z_l$, lhs)','LineStyle','-',...
  ```
- Line 197: name
  ```
  set(plot1(3),'DisplayName','Unemployed ($z_h$, lhs)','LineStyle','--',...
  ```
- Line 199: name
  ```
  set(plot1(4),'DisplayName','Unemployed ($z_l$, lhs)','LineStyle','-',...
  ```
- Line 201: lat
  ```
  ylabel('Percent of Income','Interpreter','latex');
  ```
- Line 211: lat
  ```
  ylabel('Density','Interpreter','latex');
  ```
- Line 213: lat
  ```
  xlabel('Cash-at-hand (''000 \$)','Interpreter','latex');
  ```
- Line 221: lat
  ```
  'Interpreter','latex',...
  ```
- Line 228: lat
  ```
  'Interpreter','latex',...
  ```
- Line 235: lat
  ```
  'Interpreter','latex',...
  ```
- Line 245: lat
  ```
  'String','$m_{99}$', 'Interpreter','latex', ...
  ```
- Line 262: name
  ```
  set(plot1(1),'DisplayName','Employed ($z_h$, lhs)','LineStyle','--',...
  ```
- Line 264: name
  ```
  set(plot1(2),'DisplayName','Employed ($z_l$, lhs)','LineStyle','-',...
  ```
- Line 266: name
  ```
  set(plot1(3),'DisplayName','Unemployed ($z_h$, lhs)','LineStyle','--',...
  ```
- Line 268: name
  ```
  set(plot1(4),'DisplayName','Unemployed ($z_l$, lhs)','LineStyle','-',...
  ```
- Line 270: lat
  ```
  ylabel('Percent of Income','Interpreter','latex');
  ```
- Line 280: lat
  ```
  ylabel('Density','Interpreter','latex');
  ```
- Line 282: lat
  ```
  xlabel('Cash-at-hand (''000 \$)','Interpreter','latex');
  ```
- Line 290: lat
  ```
  'Interpreter','latex',...
  ```
- Line 298: lat
  ```
  'Interpreter','latex',...
  ```
- Line 305: lat
  ```
  'Interpreter','latex',...
  ```
- Line 315: lat
  ```
  'String','$m_{99}$', 'Interpreter','latex', ...
  ```
- Line 332: name
  ```
  set(plot1(1),'DisplayName','Employed ($z_h + \sigma(K_t)$, lhs)','LineStyle','--',...
  ```
- Line 334: name
  ```
  set(plot1(2),'DisplayName','Employed ($z_l - \sigma(K_t)$, lhs)','LineStyle','-',...
  ```
- Line 336: name
  ```
  set(plot1(3),'DisplayName','Unemployed ($z_h + \sigma(K_t)$, lhs)','LineStyle','--',...
  ```
- Line 338: name
  ```
  set(plot1(4),'DisplayName','Unemployed ($z_l - \sigma(K_t)$, lhs)','LineStyle','-',...
  ```
- Line 340: lat
  ```
  ylabel('Percent of Income','Interpreter','latex');
  ```
- Line 350: lat
  ```
  ylabel('Density','Interpreter','latex');
  ```
- Line 352: lat
  ```
  xlabel('Cash-at-hand (''000 \$)','Interpreter','latex');
  ```
- Line 360: lat
  ```
  'Interpreter','latex',...
  ```
- Line 368: lat
  ```
  'Interpreter','latex',...
  ```
- Line 375: lat
  ```
  'Interpreter','latex',...
  ```
- Line 385: lat
  ```
  'String','$m_{99}$', 'Interpreter','latex', ...
  ```

**/replication-package/_replication/_model/figure_5.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 90: lat
  ```
  title('Unemployed, low prior $K$', 'FontSize', fontsize, 'Interpreter', 'Latex');
  ```
- Line 91: lat
  ```
  xlabel('Cash-at-hand (000\$)', 'Interpreter', 'Latex', 'FontSize', fontsize);
  ```
- Line 92: lat
  ```
  ylabel('Prior over $Z_t=Z_h$', 'Interpreter', 'Latex', 'FontSize', fontsize);
  ```
- Line 93: lat
  ```
  set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', fontsize);
  ```
- Line 103: lat
  ```
  title('Employed, low prior $K$', 'FontSize', fontsize, 'Interpreter', 'Latex');
  ```
- Line 104: lat
  ```
  xlabel('Cash-at-hand (000\$)', 'Interpreter', 'Latex', 'FontSize', fontsize);
  ```
- Line 105: lat
  ```
  ylabel('Prior over $Z_t=Z_h$', 'Interpreter', 'Latex', 'FontSize', fontsize);
  ```
- Line 106: lat
  ```
  set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', fontsize);
  ```
- Line 115: lat
  ```
  cb.TickLabelInterpreter = 'latex';
  ```
- Line 151: lat
  ```
  title('Unemployed, high prior $K$', 'FontSize', fontsize, 'Interpreter', 'Latex');
  ```
- Line 152: lat
  ```
  xlabel('Cash-at-hand (000\$)', 'Interpreter', 'Latex', 'FontSize', fontsize);
  ```
- Line 153: lat
  ```
  ylabel('Prior over $Z_t=Z_h$', 'Interpreter', 'Latex', 'FontSize', fontsize);
  ```
- Line 154: lat
  ```
  set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', fontsize);
  ```
- Line 164: lat
  ```
  title('Employed, high prior $K$', 'FontSize', fontsize, 'Interpreter', 'Latex');
  ```
- Line 165: lat
  ```
  xlabel('Cash-at-hand (000\$)', 'Interpreter', 'Latex', 'FontSize', fontsize);
  ```
- Line 166: lat
  ```
  ylabel('Prior over $Z_t=Z_h$', 'Interpreter', 'Latex', 'FontSize', fontsize);
  ```
- Line 167: lat
  ```
  set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', fontsize);
  ```
- Line 178: lat
  ```
  %cb.TickLabelInterpreter = 'latex';
  ```

**/replication-package/_replication/_model/figure_6.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 117: lat
  ```
  ylabel('Normalized Errors','Interpreter','latex');
  ```
- Line 118: lat
  ```
  xlabel('Wealth Level (''000 $)','Interpreter','latex');
  ```

**/replication-package/_replication/_model/figure_7.m**

- Line 10: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 13: loc, location, son
  ```
  printlocation = [scriptDir '/_figures/'];%'D:\Dropbox (Personal)\BKKS Kathrin local\testfigures_repl
  ```
- Line 43: lat
  ```
  %simulate the full model
  ```
- Line 44: lat
  ```
  fprintf('simulating the full model... ')
  ```
- Line 84: lat
  ```
  %compute counterfactual shock series and resimulate
  ```
- Line 85: lat
  ```
  fprintf('simulating the counterfactuals... ')
  ```
- Line 112: loc
  ```
  param_local = params;
  ```
- Line 113: loc
  ```
  param_local.T = Nwindow+1;
  ```
- Line 124: loc
  ```
  [Kvec_tmp,~,panel_tmp,stats_tmp] =simKS(dec,ipol,dists,zvec,shocks,param_local);
  ```
- Line 142: loc
  ```
  [Kvec_tmp,~,panel_tmp,stats_tmp] =simKS(dec,ipol,dists,zvec,shocks,param_local);
  ```
- Line 153: lat
  ```
  %calculate output, investment, and consumption
  ```
- Line 186: loc, location
  ```
  clearvars -except models_to_run path shockpath datapath im Nwindow shockfile printlocation
  ```
- Line 201: lat
  ```
  set(groot, 'DefaultTextInterpreter', 'latex');
  ```
- Line 202: lat
  ```
  set(groot, 'DefaultAxesTickLabelInterpreter', 'latex');
  ```
- Line 203: lat
  ```
  set(groot, 'DefaultLegendInterpreter', 'latex');
  ```
- Line 250: loc, location
  ```
  exportgraphics(h, [printlocation 'figure_7a.pdf'], 'ContentType', 'vector');
  ```
- Line 254: name
  ```
  plot(IRFwindow',Kvec_trans_mean_neg(2:end,1),'LineWidth',3, 'DisplayName','Benchmark')
  ```
- Line 256: name
  ```
  plot(IRFwindow',Kvec_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName','Exogenous
  ```
- Line 257: name
  ```
  plot(IRFwindow',Kvec_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
  ```
- Line 259: loc, location
  ```
  legend('Location','northeast','FontSize',12,'Box','off')
  ```
- Line 265: loc, location
  ```
  exportgraphics(h, [printlocation 'figure_7b.pdf'], 'ContentType', 'vector');
  ```
- Line 269: name
  ```
  plot(IRFwindow',y_trans_mean_neg(2:end,1),'LineWidth',3,'DisplayName','Benchmark')
  ```
- Line 271: name
  ```
  plot(IRFwindow',y_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName','Exogenous In
  ```
- Line 272: name
  ```
  plot(IRFwindow',y_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
  ```
- Line 274: loc, location
  ```
  legend('Location','southeast','FontSize',12,'Box','off')
  ```
- Line 283: loc, location
  ```
  exportgraphics(h, [printlocation 'figure_7c.pdf'], 'ContentType', 'vector');
  ```
- Line 287: name
  ```
  plot(IRFwindow(1:end-1)',invest_trans_mean_neg(2:end,1),'LineWidth',3,'DisplayName','Benchmark')
  ```
- Line 289: name
  ```
  plot(IRFwindow(1:end-1)',invest_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName'
  ```
- Line 290: name
  ```
  plot(IRFwindow(1:end-1)',invest_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Informatio
  ```
- Line 292: loc, location
  ```
  legend('Location','southeast','FontSize',12,'Box','off')
  ```
- Line 301: loc, location
  ```
  exportgraphics(h, [printlocation 'figure_7d.pdf'], 'ContentType', 'vector');
  ```

**/replication-package/_replication/_model/figure_8.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 116: name
  ```
  'DisplayName','Endogenous Information - Full Information low', ...
  ```
- Line 142: lat
  ```
  'Interpreter','latex');
  ```
- Line 165: name
  ```
  'DisplayName','Endogenous Information - Full Information low', ...
  ```
- Line 187: lat
  ```
  'Interpreter','latex');
  ```
- Line 200: lat
  ```
  'Interpreter','latex',...
  ```
- Line 211: lat
  ```
  'Interpreter','latex',...
  ```
- Line 222: lat
  ```
  'Interpreter','latex',...
  ```
- Line 232: lat
  ```
  'Interpreter','latex',...
  ```

**/replication-package/_replication/_model/figure_b1.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 50: loc, location
  ```
  'Location', 'Southeast','Orientation','vertical');
  ```
- Line 51: lat, name
  ```
  set(h,'fontsize',12,'FontWeight','bold','Interpreter','Latex')%,'FontName','Times');
  ```

**/replication-package/_replication/_model/figure_b2.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 134: lat
  ```
  ylabel('Normalized Errors Relative to 80th Percentile','Interpreter','latex');
  ```
- Line 135: lat
  ```
  xlabel('Wealth Level (''000 $)','Interpreter','latex');
  ```

**/replication-package/_replication/_model/figure_c1.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 150: name
  ```
  % set(plot1(1),'DisplayName','Benchmark - Full Information','LineWidth',3,...
  ```
- Line 156: lat
  ```
  % xlabel('Wealth (''000 $)','Interpreter','latex');
  ```
- Line 172: name
  ```
  % set(plot2(1),'DisplayName','Full Information w/ New LOM - Full Information',...
  ```
- Line 179: lat
  ```
  % xlabel('Wealth (''000 $)','Interpreter','latex');
  ```
- Line 197: name
  ```
  %     'DisplayName','Exogenous Information - Full Information (w/ NEW LOM',...
  ```
- Line 204: lat
  ```
  % xlabel('Wealth (''000 $)','Interpreter','latex');
  ```
- Line 220: name
  ```
  % set(plot4(1),'DisplayName','Benchmark - Exogenous Information (w/ NEW LOM',...
  ```
- Line 227: lat
  ```
  % xlabel('Wealth (''000 $)','Interpreter','latex');
  ```
- Line 240: lat
  ```
  %     'Interpreter','latex',...
  ```
- Line 250: lat
  ```
  %     'Interpreter','latex',...
  ```
- Line 261: lat
  ```
  %     'Interpreter','latex',...
  ```
- Line 272: lat
  ```
  %     'Interpreter','latex',...
  ```
- Line 282: lat
  ```
  %     'Interpreter','latex',...
  ```
- Line 304: name
  ```
  set(plot1(1),'DisplayName','Benchmark - Full Information','LineWidth',3,...
  ```
- Line 310: lat
  ```
  xlabel('Wealth (''000 $)','Interpreter','latex');
  ```
- Line 327: name
  ```
  set(plot2(1),'DisplayName','Full Information w/ New LOM - Full Information',...
  ```
- Line 334: lat
  ```
  xlabel('Wealth (''000 $)','Interpreter','latex');
  ```
- Line 354: name
  ```
  'DisplayName','Exogenous Information - Full Information (w/ NEW LOM',...
  ```
- Line 361: lat
  ```
  xlabel('Wealth (''000 $)','Interpreter','latex');
  ```
- Line 379: name
  ```
  set(plot4(1),'DisplayName','Benchmark - Exogenous Information (w/ NEW LOM',...
  ```
- Line 386: lat
  ```
  xlabel('Wealth (''000 $)','Interpreter','latex');
  ```
- Line 399: lat
  ```
  'Interpreter','latex',...
  ```
- Line 409: lat
  ```
  'Interpreter','latex',...
  ```
- Line 420: lat
  ```
  'Interpreter','latex',...
  ```
- Line 431: lat
  ```
  'Interpreter','latex',...
  ```
- Line 441: lat
  ```
  'Interpreter','latex',...
  ```

**/replication-package/_replication/_model/figure_c2.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 208: loc, location
  ```
  legend(groupLabels, 'Location', 'southwest');
  ```

**/replication-package/_replication/_model/figure_c3.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 203: loc, location
  ```
  legend(groupLabels, 'Location', 'southwest');
  ```

**/replication-package/_replication/_model/figure_c4.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 198: name
  ```
  set(bar1(2),'DisplayName','Benchmark','FaceColor',[0.6 0.8 1.0]);
  ```
- Line 199: name
  ```
  set(bar1(1),'DisplayName','Extended','FaceColor',[1.0 0.8 0.6]);
  ```

**/replication-package/_replication/_model/figure_d1.m**

- Line 7: name
  ```
  scriptDir = fileparts(mfilename("fullpath"));
  ```
- Line 130: lat
  ```
  % xlabel('Wealth (''000 \$)','Interpreter','latex');
  ```
- Line 131: lat
  ```
  % ylabel('Density difference','Interpreter','latex');
  ```
- Line 133: lat
  ```
  %     'Interpreter','latex','FontSize',13.2);
  ```
- Line 135: lat
  ```
  %     'Interpreter','latex','FontSize',13.2);
  ```
- Line 149: lat
  ```
  % xlabel('Wealth (''000 \$)','Interpreter','latex');
  ```
- Line 150: lat
  ```
  % ylabel('Density difference','Interpreter','latex');
  ```
- Line 152: lat
  ```
  %     'Interpreter','latex','FontSize',13.2);
  ```
- Line 154: lat
  ```
  %     'Interpreter','latex','FontSize',13.2);
  ```
- Line 191: lat
  ```
  text('Parent',subplot1,'Interpreter','latex','String','Benchmark',...
  ```
- Line 196: lat
  ```
  text('Parent',subplot1,'Interpreter','latex','String','Full information',...
  ```
- Line 201: lat
  ```
  ylabel('Density difference','Interpreter','latex');
  ```
- Line 204: lat
  ```
  xlabel('Wealth (''000 \$)','Interpreter','latex');
  ```
- Line 229: lat
  ```
  text('Parent',subplot2,'Interpreter','latex','String','Full information',...
  ```
- Line 234: lat
  ```
  text('Parent',subplot2,'Interpreter','latex','String','Benchmark',...
  ```
- Line 239: lat
  ```
  ylabel('Density difference','Interpreter','latex');
  ```
- Line 242: lat
  ```
  xlabel('Wealth (''000 \$)','Interpreter','latex');
  ```

**/replication-package/_replication/_model/make_shocks.m**

- Line 3: lat
  ```
  % MAKE_SHOCKS -- regenerate the simulation shock panels
  ```
- Line 16: minute
  ```
  % Takes about 45 minutes for the pair: genShocks walks an interpreted N-by-T
  ```
- Line 22: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```

**/replication-package/_replication/_model/model_master.m**

- Line 8: lat
  ```
  % Always operate relative to this file, not to whatever the caller's cwd is.
  ```
- Line 9: name
  ```
  cd(fileparts(mfilename('fullpath')))
  ```
- Line 13: lat
  ```
  % uses relative paths rather than a saved variable, which would not survive.
  ```
- Line 15: lat
  ```
  %% [1] REGENERATE THE SIMULATION SHOCK PANELS
  ```

**/replication-package/_replication/_model/table_bii.m**

- Line 8: name
  ```
  currentFile = mfilename( 'fullpath' );
  ```
- Line 24: name
  ```
  opts.VariableNames = ["Date", "Y", "Pop", "I", "C", "K"];
  ```
- Line 53: name
  ```
  names = {'Output $(y)$', 'Investment','Consumption'}';
  ```
- Line 59: name
  ```
  T1 = table(names, std, rel, cor, corxy, corxy1)
  ```
- Line 63: loc, location
  ```
  %folder locations:
  ```
- Line 81: name
  ```
  T2 = table(names, std, rel, cor, corxy, corxy1)
  ```
- Line 98: name
  ```
  T3 = table(names, std, rel, cor, corxy, corxy1)
  ```
- Line 117: name
  ```
  T1.names{i}, T1.std(i), T1.rel(i), T1.cor(i), T1.corxy(i), T1.corxy1(i));
  ```
- Line 130: name
  ```
  T2.names{i}, T2.std(i), T2.rel(i), T2.cor(i), T2.corxy(i), T2.corxy1(i));
  ```
- Line 142: name
  ```
  T3.names{i}, T3.std(i), T3.rel(i), T3.cor(i), T3.corxy(i), T3.corxy1(i));
  ```

**/replication-package/_replication/_model/table_ci.m**

- Line 8: name
  ```
  currentFile = mfilename( 'fullpath' );
  ```
- Line 11: loc, location
  ```
  %folder locations:
  ```
- Line 68: name
  ```
  names = {'Endog. Info (P(learn K) = 1.0))', 'Endog. Info (P(learn K) = 0.1))','Benchmark Model'}';
  ```
- Line 69: name
  ```
  T1 = table(names, sigmaK, sigmaY, sigmaI, sigmaC, CorrCY);
  ```
- Line 70: name
  ```
  T2 = table(names, Gini, stat9010, stat9901, stat9050, CorrKY);
  ```
- Line 90: name
  ```
  T1.names{i}, T1.sigmaK(i), T1.sigmaY(i), T1.sigmaI(i), T1.sigmaC(i), T1.CorrCY(i));
  ```
- Line 103: name
  ```
  T2.names{i}, T2.Gini(i), T2.stat9010(i), T2.stat9901(i), T2.stat9050(i), T2.CorrKY(i));
  ```

**/replication-package/_replication/_model/table_cii.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 31: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/table_ciii.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 118: name
  ```
  LastName        = ["Gini"; "90/10"; "99/1"];
  ```
- Line 125: name
  ```
  Decomposition = table(LastName, Overall, General_eq, Incomplete_info, Het_info, Interaction);
  ```
- Line 127: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```

**/replication-package/_replication/_model/table_civ.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 32: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/table_cix.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 27: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/table_cv.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 30: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/table_cvi.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 37: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/table_cvii.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 37: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/table_cviii.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 27: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/table_cx.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 30: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/table_cxi.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 60: name
  ```
  LastName         = ["Gini";"90/10";"99/1"; "corr-g-y"; "corr-g-k"];
  ```
- Line 67: name
  ```
  Decomposition = table(LastName,Overall,General_eq,Incomplete_info,Het_info, Interaction);
  ```
- Line 69: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```

**/replication-package/_replication/_model/table_cxii.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 29: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/table_di.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 46: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/table_i_and_ii.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 31: lat
  ```
  % Write LaTeX header
  ```
- Line 85: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 112: lat
  ```
  fprintf(fid, 'Model Simulated Data');
  ```

**/replication-package/_replication/_model/table_iii.m**

- Line 3: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 70: name
  ```
  names=['D1','D2','Q2','Q3','Q4','Q5'];
  ```
- Line 83: name
  ```
  fprintf(fid,names(is));
  ```

**/replication-package/_replication/_model/table_iv.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 31: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_model/table_vi.m**

- Line 5: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 46: lat
  ```
  % Write LaTeX header
  ```

**/replication-package/_replication/_paper/01_paper.tex**

- Line 7: lat
  ```
  \usepackage[latin9]{inputenc}
  ```
- Line 22: lat
  ```
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LyX specific LaTeX commands.
  ```
- Line 28: lat
  ```
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Textclass specific LaTeX commands.
  ```
- Line 32: lat
  ```
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% User specified LaTeX commands.
  ```
- Line 41: lon, name
  ```
  %\usepackage[longnamesfirst]{natbib}
  ```
- Line 61: lon, name
  ```
  %\usepackage[authoryear,longnamesfirst]{natbib}
  ```
- Line 91: lon, name
  ```
  \TOCclone[\contentsname]{toc}{atoc}
  ```
- Line 118: loc, location
  ```
  conference participants at various locations. A previous version of
  ```
- Line 119: lat
  ```
  this paper was circulated under the title ``Heterogeneous Information
  ```
- Line 139: house
  ```
  U.S. households and rationalize our findings with a theory of information
  ```
- Line 144: lat
  ```
  volatility and inequality. We show through the example of an increase
  ```
- Line 148: lat
  ```
  insurance raises macroeconomic volatility by an order of magnitude
  ```
- Line 163: house
  ```
  that all households, at all moments in time, have the same expectations
  ```
- Line 167: house
  ```
  dispersion of expectations that exists among households. Recent empirical
  ```
- Line 168: house
  ```
  work has stressed that household expectations are not only heterogeneous
  ```
- Line 169: house, lat
  ```
  but also correlate systematically with household characteristics.
  ```
- Line 171: house
  ```
  of expectations across the distribution of households (e.g., \citealp{carroll2003macroeconomic};
  ```
- Line 193: house
  ```
  We first provide new evidence on the heterogeneity in household expectations
  ```
- Line 197: house
  ```
  variables differ substantially across households. Importantly, we
  ```
- Line 198: house
  ```
  document that the accuracy of household expectations is systematically
  ```
- Line 199: house, lat
  ```
  related to household wealth: All else equal, wealthier households
  ```
- Line 203: house
  ```
  distribution, where the accuracy of household expectations appears
  ```
- Line 206: lat
  ```
  within groups (e.g., \citealp{coibion2018formation}; \citealp{coibion2020inflation};
  ```
- Line 209: lat
  ```
  the systematic (non-monotone) relationship between the accuracy of
  ```
- Line 210: house
  ```
  expectations and household wealth. Our estimates of the effects of
  ```
- Line 211: sex
  ```
  other characteristics (e.g., education and sex) are consistent with
  ```
- Line 217: house
  ```
  to explore households' heterogeneous incentives to acquire information.
  ```
- Line 218: house
  ```
  In the model, households form expectations about future returns, wages,
  ```
- Line 221: house
  ```
  to do so. The information that households can acquire approximates
  ```
- Line 222: house
  ```
  the optimal signal that households would choose to design. The gains
  ```
- Line 223: house
  ```
  to acquiring this information depend on household wealth, employment
  ```
- Line 233: house
  ```
  households make \emph{dynamic information choices} that depend on
  ```
- Line 245: lat
  ```
  challenges. In closely-related work, \citet{auclert2020micro} and
  ```
- Line 255: house
  ```
  of household expectations rationalizes the survey evidence. Heterogeneous
  ```
- Line 259: house
  ```
  households' heterogeneous incentives to acquire information\textemdash and
  ```
- Line 261: house
  ```
  is instructive to understand households' savings decisions.
  ```
- Line 263: house
  ```
  Consider first \emph{unemployed households, }who dissave to smooth
  ```
- Line 278: house
  ```
  of household resources and return risk, as a result, dominates, leading
  ```
- Line 281: house
  ```
  The value of information for \emph{employed households} is similar
  ```
- Line 282: house
  ```
  to that of wealthy unemployed households: Employed households always
  ```
- Line 283: lat
  ```
  have (relatively) higher income, and thus cash-at-hand, compared to
  ```
- Line 289: lat
  ```
  alters the equilibrium properties of the economy relative to the full-information
  ```
- Line 290: house
  ```
  benchmark, in which all households have full information (and hence
  ```
- Line 295: house
  ```
  households make disparate savings choices. Indeed, the introduction
  ```
- Line 297: house
  ```
  particular, poor households with incomplete information are unable
  ```
- Line 299: house
  ```
  to build up financial wealth; wealthy households with incomplete information
  ```
- Line 308: house
  ```
  On \emph{the macro level}, the presence of uninformed households leads
  ```
- Line 309: lat
  ```
  to an increase in business-cycle volatility, due to a stronger endogenous
  ```
- Line 310: house
  ```
  propagation of shocks. Under full information, household savings are
  ```
- Line 313: house
  ```
  response. By contrast, uninformed households' expectations about returns
  ```
- Line 314: house
  ```
  are sluggish to adjust, which makes household savings more procyclical
  ```
- Line 315: lat
  ```
  and the economy more volatile than under full information. This mechanism
  ```
- Line 318: house, lat
  ```
  when the economy is more volatile. In equilibrium, not all households
  ```
- Line 320: lat
  ```
  fluctuations in consumption and output relative to the full-information
  ```
- Line 337: house
  ```
  aggregate shocks. Because households with different wealth levels
  ```
- Line 343: lat
  ```
  relative to standard full-information heterogeneous-agent models.
  ```
- Line 348: lon
  ```
  the two groups (along with the rich) that we find acquire information
  ```
- Line 355: house
  ```
  is to decrease household wealth, due to the reduced need for poorer
  ```
- Line 356: house, lat
  ```
  households to accumulate precautionary savings; its indirect effect
  ```
- Line 360: lat
  ```
  acquisition, business-cycle volatility rises by 4 percent. In contrast,
  ```
- Line 362: lat
  ```
  has virtually no impact on aggregate volatility. Only the HetExp economy
  ```
- Line 370: lat
  ```
  when opportunities for wealth accumulation are greatest, lowering
  ```
- Line 375: lat
  ```
  the relative costs and benefits of macroeconomic policies. Our findings
  ```
- Line 379: lat
  ```
  information structure and thereby modify economy-wide dynamics relative
  ```
- Line 387: gender, lat
  ```
  as well as any relationship between, for example, education, gender,
  ```
- Line 388: house
  ```
  and household information (e.g., \citealp{lusardi2014economic} and
  ```
- Line 390: house
  ```
  we show that households' rational incentives to systematically acquire
  ```
- Line 394: house
  ```
  heuristics, salience effects, and other household drivers of information
  ```
- Line 398: house, second
  ```
  Second, our emphasis on households' rational information choices,
  ```
- Line 399: house
  ```
  highlighting that wealth-poor households produce forecasts of close-to
  ```
- Line 404: loc
  ```
  more aware of local conditions, prices, and opportunities, and devote
  ```
- Line 406: house
  ```
  households. We surmise that accounting for the full scale of such
  ```
- Line 407: house, lat
  ```
  effects would only lead to a richer relationship between household
  ```
- Line 409: lat
  ```
  closely related to that in finance, documenting that informed, wealthier
  ```
- Line 418: house
  ```
  Most notably, \citet{KS98} propose constraining households to only
  ```
- Line 420: house
  ```
  this lens, our approach is to allow households themselves to decide
  ```
- Line 427: house, lat
  ```
  We present new evidence on the relationship between household wealth
  ```
- Line 428: house
  ```
  and the accuracy of household expectations. To do so, we use micro
  ```
- Line 432: house
  ```
  survey contains detailed data on household economic characteristics.\footnote{\citet{armantier2017ov
  ```
- Line 435: house
  ```
  survey of household finances, which includes detailed data on household
  ```
- Line 440: house, lat
  ```
  We explore the relationship between the accuracy of household expectations
  ```
- Line 441: house
  ```
  and their wealth. To do so, we first focus on household forecasts
  ```
- Line 443: house
  ```
  the main source of income risk for many households.\textcolor{red}{{}
  ```
- Line 444: house
  ```
  }As such, perceived unemployment risk is a main driver of households'
  ```
- Line 451: lat
  ```
  variables (e.g., inflation) for which we can observe realized outcomes,
  ```
- Line 458: son
  ```
  and \citet{bhandari2019survey}. For interpretability reasons, we
  ```
- Line 461: lat
  ```
  the ``Brier score'' (Appendix \ref{sec:appendix-a}).} We later show how our results are robust to ot
  ```
- Line 470: lat
  ```
  \hspace{0.90cm}Panel (a): Relative Accuracy (SPF) \hspace{2.40cm}
  ```
- Line 475: lat
  ```
  \hspace{0.90cm}Panel (c): Relative Accuracy (BVAR) \hspace{1.7cm}
  ```
- Line 485: lon
  ```
  the respondent belongs to, controlling for the age, education level,
  ```
- Line 486: sex
  ```
  labor market status, and sex of the respondent, as well as time fixed
  ```
- Line 487: house, lat
  ```
  effects. Estimates are relative to the wealthiest households, those
  ```
- Line 495: house, lat
  ```
  We begin by documenting a systematic correlation between household
  ```
- Line 496: house
  ```
  forecast errors and household wealth. Panel (a) in Figure \ref{fig-1-unemployment-errors}
  ```
- Line 497: house, lat
  ```
  shows a marked, non-monotone relationship between household wealth
  ```
- Line 498: house
  ```
  and the accuracy of household expectations in the raw data. All else
  ```
- Line 499: house
  ```
  equal, wealthier households produce more accurate forecasts; however,
  ```
- Line 502: house
  ```
  for households that are above the 20th percentile of the wealth distribution.
  ```
- Line 503: house
  ```
  The poorest households\textendash\textendash those between the 0-10th
  ```
- Line 506: house
  ```
  the wealthiest households. All else equal, this suggests that household
  ```
- Line 509: lat
  ```
  The relationship in Panel (a) in Figure \ref{fig-1-unemployment-errors}
  ```
- Line 511: house
  ```
  status, or aggregate shocks that can simultaneously affect household
  ```
- Line 512: address
  ```
  wealth and the accuracy of expectations. To address this issue, Panel
  ```
- Line 515: house
  ```
  on the household wealth-decile/quintile controlling for household
  ```
- Line 517: lat
  ```
  exhibit a similar non-monotonic relationship to that in the raw data.
  ```
- Line 518: house
  ```
  All else equal, wealthier households make more accurate unemployment
  ```
- Line 519: house
  ```
  forecasts; yet the accuracy of households in the bottom decile is
  ```
- Line 522: house
  ```
  are also meaningful: Considering a household in the 30th percentile
  ```
- Line 524: house
  ```
  equal, decreases the accuracy of the household's expectations by around
  ```
- Line 525: degree
  ```
  9 percent. To benchmark the magnitude, having a university degree
  ```
- Line 528: house
  ```
  on financial literacy improves households' forecast accuracy. The
  ```
- Line 529: lat
  ```
  focus of our analysis is on the three-way relationship between wealth,
  ```
- Line 541: house
  ```
  cannot be interpreted as causal, as a household's wealth and the accuracy
  ```
- Line 546: house
  ```
  household finances is closely tied to households' economic expectations.
  ```
- Line 549: house, lat
  ```
  \caption{Inflation and House Prices Expectations Across the Wealth Distribution}
  ```
- Line 550: house, lat
  ```
  \label{fig:2-inflation-houseprice-errors}\vspace{0.47cm}
  ```
- Line 552: lat
  ```
  Panel (a): Inflation Forecasts\vspace{-0.47cm}
  ```
- Line 558: house
  ```
  Panel (b): House Price Forecasts\vspace{-0.47cm}
  ```
- Line 566: lat
  ```
  accuracy of individual forecasts of one-year ahead CPI inflation and
  ```
- Line 567: house
  ```
  the annual growth rate of U.S. house prices, respectively. All panels
  ```
- Line 569: lon
  ```
  accuracy on the wealth decile/quintile the respondent belongs to,
  ```
- Line 571: sex
  ```
  sex of the respondent, as well as time fixed effects. All estimates
  ```
- Line 572: house, lat
  ```
  are relative to the wealthiest households, those in the 80-100 percentile
  ```
- Line 579: house, lat
  ```
  We show that the systematic relationship between household wealth
  ```
- Line 581: house
  ```
  We perform the same analysis for household forecasts of one-year-ahead
  ```
- Line 582: house, lat
  ```
  inflation and the growth rate of house prices. We use real-time data
  ```
- Line 583: house, lat
  ```
  to measure the realizations of inflation and house prices, to capture
  ```
- Line 584: house, lat
  ```
  the precise definition of the variable being forecasted. Figure \ref{fig:2-inflation-houseprice-erro
  ```
- Line 585: house, lat
  ```
  summarizes the estimates. For both variables, Figure \ref{fig:2-inflation-houseprice-errors}
  ```
- Line 589: house
  ```
  households make more accurate forecasts and perceive themselves to
  ```
- Line 591: house
  ```
  are also higher for households near the 20-40th percentile of the
  ```
- Line 592: house
  ```
  distribution than for poorest households.
  ```
- Line 596: city
  ```
  to explicitly test for the monotonicity of the regression coefficients
  ```
- Line 597: house, lat
  ```
  in Figure \ref{fig-1-unemployment-errors} and \ref{fig:2-inflation-houseprice-errors}.\footnote{Note
  ```
- Line 603: lat
  ```
  relationship.} As evident, 6 of the 8 tests reject the null hypothesis at the 10
  ```
- Line 605: lat
  ```
  relationship between wealth and the accuracy of expectations.\textcolor{orange}{{}
  ```
- Line 608: house
  ```
  forecasters, household expectations are more dispersed, less accurate,
  ```
- Line 609: lat
  ```
  and perceived to be more uncertain. We will later leverage these additional
  ```
- Line 613: house
  ```
  heterogeneity in the accuracy of household expectations. The data
  ```
- Line 617: house
  ```
  allow for heterogeneity in the accuracy of household expectations.
  ```
- Line 626: house
  ```
  we assume that every period households have the option to acquire
  ```
- Line 629: house
  ```
  \subsection{Households}
  ```
- Line 631: house
  ```
  The economy consists of a continuum of heterogeneous households $i\in[0,1]$,
  ```
- Line 638: house
  ```
  denotes household $i$'s expectations conditional on its period-$0$
  ```
- Line 644: house
  ```
  of death and the per-period discount factor, respectively.\footnote{Consistent with this, a fraction
  ```
- Line 645: house, lat
  ```
  every period with zero initial wealth.} The household\textquoteright s information set $\Omega_{it}$
  ```
- Line 649: house
  ```
  with scale parameter $\alpha_{\kappa}$, and is i.i.d. across households,
  ```
- Line 654: house
  ```
  Each household is endowed with $\bar{l}$ units of time, which it
  ```
- Line 655: lon
  ```
  supplies inelastically to the labor market. Labor productivity $\epsilon_{it}$
  ```
- Line 656: lon
  ```
  is stochastic and can take on two values, $\epsilon_{it}\in\left\{ 0,1\right\} $,
  ```
- Line 658: lon
  ```
  assume that $\epsilon_{it}$ follows a two-state, first-order Markov
  ```
- Line 659: lon
  ```
  process $\Pi_{z_{t+1},\epsilon_{it+1}\mid z_{t},\epsilon_{it}}$,
  ```
- Line 660: lon
  ```
  which depends on $\epsilon_{it}$ and aggregate total factor productivity
  ```
- Line 661: house
  ```
  $z_{t}$ (described below). A household earns wage $w_{t}$ when employed
  ```
- Line 663: house
  ```
  the replacement rate equals $\mu\in(0,1$). We assume that households
  ```
- Line 667: house
  ```
  Households have access to perfect annuity markets.\footnote{The capital of the deceased is, thus, us
  ```
- Line 671: house
  ```
  on consumption, household consumption-saving choices are restricted
  ```
- Line 674: lon
  ```
  c_{it}+k_{it+1}=\left(1+r_{t}-\delta\right)\rho^{-1}k_{it}+\left(1-\tau_{t}\right)\left[\epsilon_{it
  ```
- Line 679: house
  ```
  household\textquoteright s \emph{cash-at-hand after choosing to acquire
  ```
- Line 680: house
  ```
  information}, and denote it by $m_{it}$ in what follows. A household
  ```
- Line 702: house
  ```
  Finally, we assume that the share of households in a given idiosyncratic
  ```
- Line 719: lon
  ```
  At the start of each period, idiosyncratic $\left(\epsilon_{it},\kappa_{it}\right)_{i}$
  ```
- Line 721: house
  ```
  production takes place, and factor prices are determined. Households,
  ```
- Line 726: house
  ```
  set of its ``parent'' (i.e., the corresponding household that died
  ```
- Line 728: house
  ```
  the informativeness of recently born households and found that it
  ```
- Line 730: house
  ```
  information for households to perfectly learn the current state of
  ```
- Line 732: house
  ```
  relevant for future prices (see below).\footnote{An alternative approach is to instead allow househo
  ```
- Line 740: house
  ```
  households make consumption and savings choices ($c_{it}$ and $k_{it+1}$,
  ```
- Line 743: house, lat
  ```
  \subsection{Recursive Formulation of the Household Problem\label{subsec:recursive}}
  ```
- Line 746: house, lat
  ```
  formulation of the household problem. Let $S=\left(\Gamma,z\right)$,
  ```
- Line 748: house
  ```
  and employment status. We denote an individual household's first-order
  ```
- Line 751: house
  ```
  typical elements, representing household $i$'s first-order belief
  ```
- Line 753: house
  ```
  well as the household's beliefs about productivity, respectively.
  ```
- Line 754: house, second
  ```
  $\mathcal{P}_{i}$ is hence a distribution over distributions.} Household $i$'s second-order belief a
  ```
- Line 756: house
  ```
  infinitum}. Individual household beliefs are summarized by the object
  ```
- Line 757: house
  ```
  $p_{i}$, which includes the infinite-set of household (higher-order)
  ```
- Line 763: lon
  ```
  made (\emph{Stage 2}) are described by $\sigma_{i,2}=\left(m_{i},\epsilon_{i},p_{i}\right)$,
  ```
- Line 764: house
  ```
  where $m_{i}$ is household $i$'s cash-at-hand \emph{net} of information
  ```
- Line 768: lon
  ```
  1}) are $\sigma_{i,1}=\left(k_{i},\epsilon_{i},p_{i,-1}\right)$.
  ```
- Line 772: house
  ```
  information choices, a household chooses consumption $c_{i}$ and
  ```
- Line 776: lon, second
  ```
  \mathcal{W}\left(m_{i},\epsilon_{i},p_{i}\right) & = & \max_{c_{i},k_{i}^{\prime}\geq0}\frac{c_{i}^{
  ```
- Line 781: house
  ```
  are a household's value functions \emph{after} and \emph{before} information
  ```
- Line 786: house
  ```
  We assume that households rationally use the equilibrium law of motion
  ```
- Line 792: house
  ```
  and the information choice $\mathcal{I}_{i}$ the household makes
  ```
- Line 795: house
  ```
  \noindent\emph{Stage 1:} At the beginning of the period, households
  ```
- Line 798: lon
  ```
  \mathcal{V}\left(k_{i},\epsilon_{i},p_{i,-1}\right) & = & \max_{\mathcal{I}_{i}\subseteq\left\{ \emp
  ```
- Line 800: lon
  ```
  m_{i} & = & \left[1+r\left(\Sigma\right)-\delta\right]\rho^{-1}k_{i}+\left(1-\tau\right)\left[\epsil
  ```
- Line 805: house
  ```
  the information choice $\mathcal{I}_{i}$. A household's expectation
  ```
- Line 815: lon
  ```
  \text{Prob}\left(\mathcal{I}_{i}\mid\sigma_{i,1}\right)=\frac{e^{\mathbb{E}\left[\alpha_{\kappa}\mat
  ```
- Line 820: lon
  ```
  \mathcal{V}\left(\sigma_{i,1}\right)=\frac{\gamma_{E}}{\alpha_{\kappa}}+\frac{1}{\alpha_{\kappa}}\lo
  ```
- Line 834: house, second
  ```
  solve the household's optimization problem (i.e., Equations \ref{eq:vf-second-stage}-\ref{eq:vf-init
  ```
- Line 839: lon
  ```
  process $\Pi_{z^{\prime},\epsilon^{\prime}|z,\varepsilon}$ , as well
  ```
- Line 846: lon
  ```
  H_{k}\left(\Sigma\right)\left(\Delta k,\epsilon,z\right)=\sum_{\tilde{\epsilon}}\Pi_{\epsilon,z\mid\
  ```
- Line 849: lon
  ```
  of $\left(k,\epsilon,p\right)$.}} and (iv) market-clearing conditions hold for capital and goods mar
  ```
- Line 859: lat
  ```
  The above recursive formulation helps clarify the nature of the two-sided
  ```
- Line 860: lat
  ```
  relationship between wealth and information that exists in our model.
  ```
- Line 861: house
  ```
  On the one hand, a household's capital holdings and employment status,
  ```
- Line 863: house
  ```
  the household's information acquisition at the first stage of any
  ```
- Line 865: house
  ```
  a household's information choice also helps determine the household's
  ```
- Line 866: second
  ```
  consumption-savings choice in the second stage, through its expectations,
  ```
- Line 867: house, second
  ```
  and hence the household's future wealth level (Equation \ref{eq:vf-second-stage}).
  ```
- Line 870: lat
  ```
  relationship documented in the data (Section \ref{sec:motivating-evidence}).
  ```
- Line 872: lat
  ```
  The recursive formulation further illustrates that our framework falls
  ```
- Line 874: house
  ```
  For example, although households are uncertain about the current state
  ```
- Line 878: lat
  ```
  As such, our framework is closely related to the work on ``costly
  ```
- Line 890: house
  ```
  biases that arise when households engage in ``wishful thinking'',
  ```
- Line 891: city
  ```
  in which expectations maximize average felicity, optimally balancing
  ```
- Line 898: lat
  ```
  costs associated with the acquisition of information, while the latter
  ```
- Line 905: lat
  ```
  to attention choices are necessary to match expectations in the SCE.} Crucially, the latter, for exa
  ```
- Line 916: lat
  ```
  linked to the three-way relationship between information choices,
  ```
- Line 937: house
  ```
  (\citealp{KS98}). Accurately forecasting those moments enables households
  ```
- Line 938: house
  ```
  to forecast future prices, which are necessary for solving the household
  ```
- Line 940: house
  ```
  one of ``boundedly rational'' expectations, as households only keep
  ```
- Line 942: house
  ```
  in this solution method, the information that households use to base
  ```
- Line 945: house
  ```
  in $\mathbf{m}$. By contrast, in our model, households \emph{optimally
  ```
- Line 961: house
  ```
  the law of motion $H\left(\cdot\right)$. Thus, if households knew
  ```
- Line 968: house
  ```
  Our computational strategy can be summarized as follows: Households
  ```
- Line 972: house
  ```
  $H\left(\cdot\right)$, households form expectations about the future
  ```
- Line 974: house
  ```
  maximization problem. Households then choose what information to acquire
  ```
- Line 985: lat
  ```
  as well as all other equilibrium relationships (e.g., \citealp{woodford2001imperfect};
  ```
- Line 989: lat
  ```
  about the state of the economy and not conflate any effects with those
  ```
- Line 994: house
  ```
  For the set of moments households can choose between, we follow \citet{KS98}
  ```
- Line 1002: lon
  ```
  The sequence of shocks $\left\{ z_{s}\right\} _{s=0}^{t}$ alone allows
  ```
- Line 1005: house
  ```
  so that households simply decide each period whether or not to acquire
  ```
- Line 1007: house
  ```
  we check \emph{ex post} that this assumption allows households to
  ```
- Line 1016: house
  ```
  our assumption can be viewed as allowing households to choose to observe
  ```
- Line 1026: house
  ```
  Given our assumptions, we can state the approximated household problem
  ```
- Line 1027: house
  ```
  that households solve: Households enter the period with capital $k_{i}$,
  ```
- Line 1028: lon
  ```
  their employment status $\epsilon_{i},$ their prior over whether
  ```
- Line 1030: house
  ```
  and their prior over the capital stock $p_{i,-1}^{K}$. Households
  ```
- Line 1031: house
  ```
  then choose whether to observe contemporaneous productivity $z$.\footnote{For computational tractabi
  ```
- Line 1034: house
  ```
  similar when households internalize uncertainty in their forecasts
  ```
- Line 1036: lon
  ```
  and \citet{BKKS_2}.} In line with the above notation, let $\tilde{\sigma}_{i,2}\equiv\left(m_{i},\ep
  ```
- Line 1037: lon
  ```
  and $\tilde{\sigma}_{i,1}\equiv\left(k_{i},\epsilon_{i},p_{i,-1}^{z},p_{i,-1}^{K}\right)$.
  ```
- Line 1053: lon
  ```
  m_{i} & = & \left[1+r\left(z,K\right)-\delta\right]\rho^{-1}k_{i}+\left(1-\tau\right)\left[\epsilon_
  ```
- Line 1059: house
  ```
  status, households forecast the probability of being in the high-productivity
  ```
- Line 1060: house
  ```
  state and the aggregate capital stock. Households update their priors
  ```
- Line 1073: lat
  ```
  postulate a law of motion $\tilde{H}\left(\cdot\right)$ for the aggregate
  ```
- Line 1074: lat
  ```
  state variables. As in \citet{KS98}, we assume a log-linear relationship
  ```
- Line 1076: house, second
  ```
  or bust) realization of $z$. Second, we solve the household's two-stage
  ```
- Line 1082: house, lat, lon
  ```
  simulate a large number of households for a long number of periods.
  ```
- Line 1083: lat
  ```
  From this simulation, we then calculate a time-series for $K$, and
  ```
- Line 1085: lat
  ```
  (i.e., new log-linear relationships). We iterate until convergence
  ```
- Line 1092: house
  ```
  as capture the rich heterogeneity in household expectations documented
  ```
- Line 1112: lon
  ```
  The individual transition probabilities in labor productivity $\epsilon_{it}$
  ```
- Line 1114: lat
  ```
  Current Population Survey. We choose an unemployment rate in booms
  ```
- Line 1128: degree
  ```
  with an expected work-life of 45 years. We calibrate the degree of
  ```
- Line 1129: lat
  ```
  relative risk aversion $\gamma$ and the information cost parameters
  ```
- Line 1135: house
  ```
  increases in wealth for richer households (Section \ref{subsec:results-accuracy}).\footnote{The bene
  ```
- Line 1137: lat
  ```
  capital. Yet when relative risk aversion is close to one, income and
  ```
- Line 1138: house
  ```
  substitution effects largely cancel one another, and wealthy households
  ```
- Line 1141: house
  ```
  the SCE (even for households with similar observable characteristics).
  ```
- Line 1142: house
  ```
  To check how household expectations compare to those in the SCE, we
  ```
- Line 1144: house
  ```
  compares the accuracy and standard deviation of households' one-year
  ```
- Line 1149: house
  ```
  For households in the model, we therefore compute the difference between
  ```
- Line 1150: house
  ```
  a household\textquoteright s perceived probability conditional on
  ```
- Line 1156: lat
  ```
  but that overall the model replicates both the accuracy and volatility
  ```
- Line 1174: son
  ```
  reasons, we scale the absolute value of unemployment errors in the
  ```
- Line 1184: house
  ```
  In order to understand the drivers and consequences of households'
  ```
- Line 1186: house
  ```
  different information choices affect household savings decision\textemdash the
  ```
- Line 1187: second
  ```
  intertemporal decision variable in the model. Second, we characterize
  ```
- Line 1188: house
  ```
  how household information choices depend on individual state variables,
  ```
- Line 1198: house
  ```
  We start by describing how information affects households' savings
  ```
- Line 1200: lat
  ```
  for understanding the aggregate amplification we later document. In
  ```
- Line 1201: house, lat
  ```
  the model, households save to smooth consumption in the face of volatile
  ```
- Line 1203: house
  ```
  movements in the interest rate. The state of the economy that households
  ```
- Line 1207: house
  ```
  households' labor income and future rates of return.
  ```
- Line 1236: son
  ```
  \noindent\textbf{Comparison to Full-information.} Panel (a) in Figure
  ```
- Line 1239: house
  ```
  HetExp economy and the economy in which all households exogenously
  ```
- Line 1243: house
  ```
  economy.\footnote{Notice that we assume households still pay the resource and utility
  ```
- Line 1246: house
  ```
  households do not pay these costs.{\footnotesize{} We re-calibrate the
  ```
- Line 1249: house, lat, son
  ```
  in all model simulations. }} For comparison, on average, only around 10 percent of households
  ```
- Line 1254: house, lat
  ```
  a simulated panel of households with identical idiosyncratic and aggregate
  ```
- Line 1264: house
  ```
  \emph{driven by the behavior of informed households}. It does so by
  ```
- Line 1265: house
  ```
  comparing the savings choices of a household who has just acquired
  ```
- Line 1266: house
  ```
  information in our benchmark model and a household in the full-information
  ```
- Line 1269: house
  ```
  cash-at-hand and assume both households have the same expectation
  ```
- Line 1303: house
  ```
  \noindent                {\protect\footnotesize \textit{Note:}  The figure  plots the difference bet
  ```
- Line 1310: son
  ```
  \noindent\textbf{Comparison of Informed to Uninformed. }Instead,
  ```
- Line 1312: house
  ```
  savings behavior of uninformed households}. We contrast these to informed
  ```
- Line 1313: house
  ```
  households' savings choices in Figure \ref{fig:4-savings-choices},
  ```
- Line 1316: house
  ```
  Panel (a) assumes both households share the same expectation of the
  ```
- Line 1317: house
  ```
  capital stock, while Panel (b) internalizes that an informed household's
  ```
- Line 1320: house
  ```
  much of the cash-at-hand distribution, especially for unemployed households
  ```
- Line 1321: house
  ```
  and after one accounts for how information also alters household expectations
  ```
- Line 1323: house
  ```
  bulk of households.
  ```
- Line 1327: house
  ```
  \emph{Below around the 85th percentile, uninformed households save
  ```
- Line 1329: house
  ```
  }While informed households save more in recessions ($z_{l}$) and
  ```
- Line 1330: house
  ```
  less in booms ($z_{h}$), uninformed households do the opposite; they
  ```
- Line 1332: house
  ```
  unlike this majority of households, above the 90th percentile the
  ```
- Line 1333: house
  ```
  pattern instead reverses: \emph{Uninformed rich households save more
  ```
- Line 1344: house, lon
  ```
  alone. The poorest households optimally reduce capital holdings to
  ```
- Line 1348: house
  ```
  households at low-but-positive levels of cash-at-hand, where the non-linearity
  ```
- Line 1350: house
  ```
  borrowing constraint. Information about productivity helps such households
  ```
- Line 1353: house
  ```
  consumption for low-wealth households. Informed households, as a consequence,
  ```
- Line 1356: house
  ```
  households, whose job-finding rate differs strongly across booms and
  ```
- Line 1367: house
  ```
  between informed and uninformed households.\footnote{The moderate persistence of productivity shocks
  ```
- Line 1371: house
  ```
  the bulk of household resources. Variations in returns here dominate
  ```
- Line 1372: house
  ```
  household savings choices, leading to increasing savings differences,
  ```
- Line 1373: house
  ```
  as intertemporal substitution makes informed households save more
  ```
- Line 1378: house
  ```
  also causes households to perceive the economy's endogenous dynamics
  ```
- Line 1381: house
  ```
  informed and uninformed households have the same expectation of capital.
  ```
- Line 1385: house
  ```
  uninformed households also perceive less accurately the dynamics of
  ```
- Line 1393: house
  ```
  the magnitude of savings mistakes that the vast majority of households
  ```
- Line 1395: house
  ```
  households and households above the 90th percentile, whose savings
  ```
- Line 1397: house
  ```
  mistakes are explained by errors in households' expectations of future
  ```
- Line 1398: house
  ```
  wages and returns, crucial for low- and high-wealth households' savings
  ```
- Line 1402: lat
  ```
  component} (i.e., capital accumulation). Since a higher capital stock
  ```
- Line 1405: lat
  ```
  poor are reduced by more relative to the savings of the uninformed\textemdash both
  ```
- Line 1408: compound, lat
  ```
  rich further relative to those of the uninformed.\footnote{Note the compounding effects of informati
  ```
- Line 1409: house
  ```
  the capital stock on rich households' informed savings: Higher returns
  ```
- Line 1414: lat
  ```
  further boosting savings as capital accumulates (Panel b of Figure
  ```
- Line 1421: house
  ```
  components substantially alters household savings, with the direction
  ```
- Line 1424: house
  ```
  affect macroeconomic outcomes, depending on which households are uninformed
  ```
- Line 1426: house
  ```
  households' information choices. This will cast further light on the
  ```
- Line 1429: house
  ```
  \subsection{Household Information Choices\label{subsec:information-choice}}
  ```
- Line 1438: house
  ```
  Unsurprisingly, households with less informative prior expectations
  ```
- Line 1456: house
  ```
  values of household cash-at-hand. The figure uses our baseline calibration
  ```
- Line 1460: house
  ```
  panels show the probabilities for an unemployment (employed) household.
  ```
- Line 1461: house
  ```
  We use 2020 values of U.S. household income to convert cash-at-hand
  ```
- Line 1465: house
  ```
  \emph{Employed} \emph{households}\textemdash the savers in the economy\textemdash are
  ```
- Line 1472: lat
  ```
  they expect to continue to accumulate assets over time, so that the
  ```
- Line 1477: lat
  ```
  financial wealth rises and the cost of acquiring information relative
  ```
- Line 1479: house
  ```
  Indeed, households with more than \$300,000 in cash-at-hand acquire
  ```
- Line 1484: house
  ```
  Now, consider instead \emph{unemployed households}. The unemployed
  ```
- Line 1488: house
  ```
  households almost never acquire information. These households are
  ```
- Line 1492: house
  ```
  of cash-at-hand, unemployed households start to acquire information
  ```
- Line 1498: house
  ```
  distribution, unemployed households thus almost uniformly  acquire
  ```
- Line 1500: house
  ```
  uninformed employed households, who face a smaller but positive probability
  ```
- Line 1505: house, lon
  ```
  value of information initially declines. The household is no longer
  ```
- Line 1511: son
  ```
  same reasons as discussed for the case of the employed.
  ```
- Line 1513: house
  ```
  Finally, notice that households with low-levels of wealth are, on
  ```
- Line 1523: house
  ```
  We have described how wealth and employment status affect a household\textquoteright s
  ```
- Line 1524: house
  ```
  decision to acquire information, and how a household\textquoteright s
  ```
- Line 1527: house
  ```
  interaction between household heterogeneity and information choice,
  ```
- Line 1528: house
  ```
  we study how these forces interact to shape the accuracy of household
  ```
- Line 1540: lat
  ```
  relationship between (the absolute value of) normalized errors of
  ```
- Line 1542: house, lat
  ```
  and household wealth. We plot this relationship both in the SCE data
  ```
- Line 1544: loc
  ```
  We use a local polynomial regression (the LOESS regression) to estimate
  ```
- Line 1545: house, lat
  ```
  the non-linear relationship between the accuracy of household expectations
  ```
- Line 1546: house
  ```
  and household wealth. Error bands correspond to one-standard deviation
  ```
- Line 1547: house
  ```
  confidence bounds. We use 2020 values of quarterly U.S. household
  ```
- Line 1552: house
  ```
  Figure \ref{fig-5-accuracy-u} shows how households\textquoteright{}
  ```
- Line 1553: lat
  ```
  information acquisition probabilities in equilibrium translate into
  ```
- Line 1554: house, lat
  ```
  a systematic relationship between the accuracy of household expectations
  ```
- Line 1558: lat
  ```
  shows errors relative to the top quintile and extends the horizontal
  ```
- Line 1560: house
  ```
  of household wealth $k_{i}$ instead of cash-at-hand $m_{i}$. Although
  ```
- Line 1562: house
  ```
  for households with negative wealth\textemdash recall that we assume
  ```
- Line 1563: house
  ```
  a simple no-borrowing limit $k_{i}^{\prime}\geq0$ for households\textemdash the
  ```
- Line 1569: house
  ```
  households in the model are, on average, the unemployed, who at low
  ```
- Line 1571: house
  ```
  households find jobs, their wealth increases but they also stop acquiring
  ```
- Line 1573: second
  ```
  levels of wealth. Second, as wealth increases, the probability of
  ```
- Line 1576: lat
  ```
  about its return increases and the relative cost falls\textemdash both
  ```
- Line 1577: house
  ```
  of which increase a household's information acquisition probability
  ```
- Line 1580: lat
  ```
  relationship, making it a suitable laboratory to explore the effects
  ```
- Line 1586: house
  ```
  of an individual household. In this subsection, we document how the
  ```
- Line 1588: lat
  ```
  \ref{fig:4-savings-choices} and \ref{fig-3-information-prob} accumulate
  ```
- Line 1593: house
  ```
  economy, where all households exogenously acquire information every
  ```
- Line 1594: house
  ```
  period. Recall that, on average, only around 10 percent of households
  ```
- Line 1603: son
  ```
  labels in what follows to clarify that any comparison between the
  ```
- Line 1604: son
  ```
  two focuses on the \emph{incompleteness} of information. A comparison
  ```
- Line 1607: house
  ```
  information.}\textcolor{orange}{{} }In both cases, we assume households pay the resource
  ```
- Line 1611: house
  ```
  where households do not pay these costs. Table \ref{app-tab:bc-moments}
  ```
- Line 1614: lat
  ```
  economies: Investment is too volatile, consumption too smooth, and
  ```
- Line 1632: lat
  ```
  ($C)$. In addition, the table shows the correlation between log.
  ```
- Line 1642: lat
  ```
  Relative to the full-information case, fluctuations in all aggregate
  ```
- Line 1645: lat
  ```
  and consumption are, as a result, 5-11 percent more volatile than
  ```
- Line 1653: house
  ```
  of \emph{uninformed households}. Households who choose \emph{not}
  ```
- Line 1654: lat
  ```
  to acquire information\textemdash who comprise 90 percent of the population\textemdash have
  ```
- Line 1655: lon
  ```
  expectations that are tilted towards the long-run average of the economy.
  ```
- Line 1656: house
  ```
  In booms, such households systematically underpredict productivity
  ```
- Line 1658: house
  ```
  in recessions.\footnote{We should note, however, that a hypothetical household that acquires
  ```
- Line 1660: house
  ```
  true capital stock and make negligible forecast errors (Appendix \ref{app:model-fit}).} Consequently
  ```
- Line 1663: house
  ```
  Wealthy households above 90th percentile, by contrast, make the opposite
  ```
- Line 1664: house
  ```
  mistake, but because these households acquire information more frequently
  ```
- Line 1668: lat
  ```
  ``overaccumulates'' capital in booms and ``underaccumulates''
  ```
- Line 1689: house
  ```
  Compared to the exogenous-information case, where all households have
  ```
- Line 1692: lat
  ```
  the increase in aggregate volatility (Table \ref{tab:business-cycle-moments};
  ```
- Line 1693: house
  ```
  Figure \ref{fig:IRFs}). This occurs because middle-wealth households
  ```
- Line 1697: house, lat
  ```
  economy relative to an economy in which all households have the \emph{same
  ```
- Line 1741: lat
  ```
  non-linear relationship between aggregate volatility and the accuracy
  ```
- Line 1750: house
  ```
  in the effects of incomplete information: In the case in which household
  ```
- Line 1753: lat
  ```
  volatility of capital increases by around 5 percent relative to the
  ```
- Line 1754: house
  ```
  full-information case. By contrast, if households learn capital every
  ```
- Line 1756: house
  ```
  in our benchmark model, where households are never exogenously told
  ```
- Line 1757: lat
  ```
  about the capital stock, volatilities increase by close to a factor
  ```
- Line 1759: lat
  ```
  accumulation about the capital stock, and the strong non-linearities
  ```
- Line 1764: lat
  ```
  of the capital stock relative to the full-information case. This amplification
  ```
- Line 1769: lat
  ```
  individual benefits of information rise with the volatility of the
  ```
- Line 1771: lat
  ```
  increases, the volatility of the capital stock falls, and so does
  ```
- Line 1784: house
  ```
  The more of the capital stock that is held by households whose uninformed
  ```
- Line 1787: address
  ```
  Table \ref{tab:moments} addresses the empirical validity of our
  ```
- Line 1791: lat
  ```
  related to the lack of skewness in wealth with the Aiyagari-Bewley-Huggett-Imrohoroglu
  ```
- Line 1806: house
  ```
  The table shows that a sizable share of consumption occurs for households
  ```
- Line 1808: house
  ```
  benchmark model, 52\% of consumption expenditures are made by households
  ```
- Line 1810: house
  ```
  Another 27\% occur for households above the 80th percentile, where
  ```
- Line 1812: house
  ```
  of consumption expenditures thus occur for households in the region
  ```
- Line 1817: house
  ```
  arises because (i) households with little or moderate wealth, whose
  ```
- Line 1819: house
  ```
  consumption-savings; and (ii) rich households acquire information
  ```
- Line 1850: lat
  ```
  in the wealth distribution relative to the full-information economy
  ```
- Line 1853: house
  ```
  is household wealth (capital levels) in USD '000 (\$). We use 2020
  ```
- Line 1854: house
  ```
  values of U.S. household income to convert values in the model to
  ```
- Line 1872: lat
  ```
  correlation between the logarithm of capital and log. output ($Y)$
  ```
- Line 1880: house
  ```
  case for all households and for all moments in time.}{\footnotesize\par}
  ```
- Line 1884: lat
  ```
  wealth dispersion relative to the full-information case\textemdash with
  ```
- Line 1887: house
  ```
  there are fewer households with intermediate wealth levels (between
  ```
- Line 1893: house
  ```
  is also somewhat amplified: Households\textquoteright{} endogenous
  ```
- Line 1896: lat
  ```
  of inequality to change, increasing its volatility over time. We analyze
  ```
- Line 1909: house
  ```
  of \emph{incomplete information}. Uninformed households make savings
  ```
- Line 1911: lat
  ```
  wealth accumulation. The more procyclical savings of low-to-medium
  ```
- Line 1912: house
  ```
  wealth uninformed households\textemdash combined with the more countercyclical
  ```
- Line 1913: house
  ```
  savings of rich uninformed households\textemdash amplify inequality:
  ```
- Line 1914: house
  ```
  Poor uninformed households save less precisely when returns are high,
  ```
- Line 1915: house
  ```
  while wealthy households are unable to effectively run down wealth
  ```
- Line 1923: lat
  ```
  relative to what is needed, in the benchmark model this force is not
  ```
- Line 1929: house
  ```
  in information choices} allows the most exposed households\textemdash the
  ```
- Line 1931: second
  ```
  at higher rates, reducing their savings errors, all else equal. Second,
  ```
- Line 1936: lat
  ```
  the latter, leading to a modest overall increase in inequality (Table
  ```
- Line 1969: lat
  ```
  a share of entrepreneurs in the population, who do not work but earn
  ```
- Line 1971: city
  ```
  1 percent and the elasticity of substitution to target the top 10
  ```
- Line 1972: house
  ```
  percent wealth share. We also allow households to borrow (up to $k_{\min}<0$),
  ```
- Line 1988: lat
  ```
  in the benchmark model. Although the inverse u-shaped relationship
  ```
- Line 1990: lat
  ```
  overall strength of the relationship is similar to before. Consistent
  ```
- Line 1997: house
  ```
  at the top, one might expect wealthy uninformed households' countercyclical
  ```
- Line 2002: house
  ```
  bias when uninformed). Additionally, wealthy households still acquire
  ```
- Line 2004: house
  ```
  negative-wealth households whose procyclical uninformed savings counters
  ```
- Line 2015: lat
  ```
  the latter case it contributes to the widening of the wealth distribution
  ```
- Line 2026: house
  ```
  households are workers or entrepreneurs\textemdash further complicates
  ```
- Line 2056: lat
  ```
  in moments relative to the relevant alternative economy, isolating
  ```
- Line 2058: lat
  ```
  relative to a specifications full-information counterpart. $\sigma(K)$
  ```
- Line 2069: house
  ```
  model unchanged. Thus, while households have no choice about information
  ```
- Line 2072: son
  ```
  focuses any comparison between the different models on the \emph{endogeneity}
  ```
- Line 2085: house
  ```
  it is as-if households are touched by a ``Calvo-Angel'' upon becoming
  ```
- Line 2087: house
  ```
  above, where households still have to pay the costs of information
  ```
- Line 2088: house
  ```
  upon becoming informed, it is as-if households are instead touched
  ```
- Line 2096: son
  ```
  for the above comparisons between our benchmark economy and the alternative
  ```
- Line 2099: city
  ```
  \paragraph*{Homotheticity of Information Costs:\label{sub-sect-ext:cost-2} }
  ```
- Line 2103: city
  ```
  explores the consequences that the non-homotheticity embedded in both
  ```
- Line 2107: lat
  ```
  shows that the relationship between the accuracy of unemployment expectations
  ```
- Line 2112: city
  ```
  depend much on the non-homotheticity of the utility cost. The maximum
  ```
- Line 2118: lat
  ```
  the inverse u-shaped relationship between accuracy and wealth in the
  ```
- Line 2123: house
  ```
  as a barrier for wealth-poor households' information acquisition.
  ```
- Line 2124: city
  ```
  We conclude that the non-homotheticity embedded in the resource cost
  ```
- Line 2127: city
  ```
  the non-homotheticity implied by the utility cost.
  ```
- Line 2145: lat
  ```
  the unconditional probabilities of a bust and a boom, respectively.} As expected, aggregate volatili
  ```
- Line 2147: lat
  ```
  crucially, relative to the full-information case, the increase that
  ```
- Line 2162: lat
  ```
  information amplifies business-cycle volatility and modestly increases
  ```
- Line 2165: city
  ```
  patterns, while the cyclicality of taxes and the homotheticity of
  ```
- Line 2167: house
  ```
  households face cyclical or constant taxes, or operate in economies
  ```
- Line 2169: lat
  ```
  relationship between wealth and information systematically alters
  ```
- Line 2189: house, lon, second
  ```
  posting \citep[see, e.g.,][]{karahan2025micro,hagedorn2013unemployment}.} The unemployed poor are th
  ```
- Line 2198: lat
  ```
  accumulate precautionary savings and to acquire information about
  ```
- Line 2203: house, lat
  ```
  the latter by close to 13 percent.\footnote{Since there are fewer unemployed than employed household
  ```
- Line 2204: house
  ```
  probability of information acquisition across all households falls
  ```
- Line 2208: lat
  ```
  overall volatility of output (by 3.5 percent). In contrast, in the
  ```
- Line 2209: lat
  ```
  full-information case, the volatility of output hardly changes (rises
  ```
- Line 2227: lat
  ```
  for wealth accumulation are greatest. This explains why the rise in
  ```
- Line 2250: house
  ```
  measure the percent difference in the average number of households
  ```
- Line 2258: lat
  ```
  An increase in unemployment benefits (i) \emph{increases} the volatility
  ```
- Line 2261: house
  ```
  by\emph{ more} after one accounts for households' endogenous information
  ```
- Line 2272: house
  ```
  and transfer policies. The effects on households\textquoteright{}
  ```
- Line 2276: house
  ```
  the endogeneity of household information choices acts to increase
  ```
- Line 2277: lat
  ```
  inequality relative to standard full-information environments. More
  ```
- Line 2290: house
  ```
  of household and firm heterogeneity to provide a more complete and
  ```
- Line 2292: house
  ```
  how the interaction between two important dimensions of household
  ```
- Line 2308: house
  ```
  on the wealth distribution will systematically affect household information
  ```
- Line 2315: lat
  ```
  (p. 1121, \citealp{lucas1975equilibrium}). } For the latter, studying the consequence of dispersed i
  ```
- Line 2328: lat
  ```
  particular subset of the population? And how close do market-based
  ```
- Line 2330: house
  ```
  households and distribute it to them, come to the constrained efficient
  ```
- Line 2331: loc, location
  ```
  allocation? We leave these exciting questions for future research.
  ```
- Line 2390: house, lat, lon
  ```
  respondent belongs to. Estimates are relative to the wealthiest households,
  ```
- Line 2393: sex
  ```
  (college or not), labor market status, and sex of the respondent,
  ```
- Line 2400: city
  ```
  \caption{Test for the Monotonicity of Regression Coefficients}
  ```
- Line 2429: lon
  ```
  errors on the wealth percentile that the individual respondent belongs
  ```
- Line 2431: sex
  ```
  labor market status, and sex of the respondent, as well as time fixed
  ```
- Line 2441: house
  ```
  The SCE is a monthly internet survey of c. 1,300 ``household heads'',
  ```
- Line 2442: house, son
  ```
  defined as the person in a household who owns, is buying, or rents
  ```
- Line 2447: house
  ```
  module contains monthly information about households' expectations
  ```
- Line 2450: house
  ```
  including their financial wealth.\footnote{We match wealth observations with the household's monthly
  ```
- Line 2455: house, lat
  ```
  We focus on expectations of three variables: inflation, house prices,
  ```
- Line 2460: lat
  ```
  \item Inflation:\\
  ```
- Line 2461: lat
  ```
  ``\emph{What do you expect the rate of (CPI) inflation to be over
  ```
- Line 2464: lat
  ```
  next 12 months the rate of inflation will be...} ''.
  ```
- Line 2465: house
  ```
  \item House prices:\\
  ```
- Line 2471: lat
  ```
  We calculate forecast errors as the difference between individual
  ```
- Line 2473: city, lat
  ```
  price index inflation and inflation in the S\&P Case-Shiller 20-City
  ```
- Line 2486: house
  ```
  $P_{it}\left(u_{t+12}>u_{t}\right)$, we would ideally compare household
  ```
- Line 2494: lat
  ```
  we calculate each forecaster's belief about the probability of rising
  ```
- Line 2498: house
  ```
  between a household's expectations and the consensus forecast of professional
  ```
- Line 2509: house
  ```
  In addition to survey estimates, we use the following household characteristics:
  ```
- Line 2510: house, sex
  ```
  sex, age, dummies that take values of one if the household head reports
  ```
- Line 2511: degree
  ```
  to have a college degree or to participate in the labor market (in
  ```
- Line 2513: house
  ```
  We also use a measure of household net-financial wealth, which we
  ```
- Line 2514: house
  ```
  construct as the difference between a household's total financial
  ```
- Line 2516: spouse
  ```
  is the total current value of your {[}and your spouse\textquoteright s/partner\textquoteright s{]}
  ```
- Line 2523: spouse
  ```
  of your {[}and your spouses/partners{]} current outstanding debt?}''.} We construct wealth deciles/q
  ```
- Line 2524: lat
  ```
  of data (2013 and 2014). We deflate the resulting quantities by the
  ```
- Line 2527: house
  ```
  We do not perform any sample selection other than dropping households
  ```
- Line 2528: lat
  ```
  whose median inflation expectations lie in the extreme bins (higher
  ```
- Line 2546: lat
  ```
  forecasts. Panel b shows the median error of individual inflation
  ```
- Line 2552: house, lat
  ```
  that households\textquoteright{} 12-month unemployment and inflation
  ```
- Line 2554: house
  ```
  professional forecasts. Households attach on average a higher probability
  ```
- Line 2557: lat
  ```
  steadily. We find a similar picture for CPI inflation: the median
  ```
- Line 2558: house
  ```
  of household point forecast errors are substantially larger for households
  ```
- Line 2562: house
  ```
  that household expectations are also substantially \emph{more uncertain}
  ```
- Line 2564: house, lat
  ```
  over possible inflation realizations, households report substantially
  ```
- Line 2568: house
  ```
  shows that household expectations are also substantially \emph{more}
  ```
- Line 2569: house
  ```
  \emph{heterogeneous} than SPF forecasts. Specifically, household unemployment
  ```
- Line 2570: lat
  ```
  expectations and point forecasts for CPI inflation have a much higher
  ```
- Line 2572: lat
  ```
  The standard deviation of forecast errors for CPI inflation across
  ```
- Line 2573: house
  ```
  households is, for example, about three times larger than across professional
  ```
- Line 2584: lat
  ```
  PRS85006023 multiplied by the employment-population ratio CE16OV/CNP16OV),
  ```
- Line 2593: city
  ```
  variables (e.g., consumption of non-durables, wages, and capacity
  ```
- Line 2621: lat
  ```
  \hspace{12pt}Relative risk aversion (\textbf{$\gamma$}) & 5.00 \\
  ```
- Line 2626: son
  ```
  \subsection{Business Cycle Moments: Data Comparison\label{app:bc-moments}}
  ```
- Line 2629: son
  ```
  \caption{Comparison of Business Cycle Moments}
  ```
- Line 2637: son
  ```
  {\footnotesize\emph{Note}}{\footnotesize : The table reports the comparison
  ```
- Line 2652: house
  ```
  households who choose not to acquire information will have priors
  ```
- Line 2653: lon
  ```
  about the capital stock that are more tilted towards the long-run
  ```
- Line 2657: house
  ```
  is not a consequence of our maintained assumption that households
  ```
- Line 2660: lon
  ```
  \citet{DENHAAN20101} show that the history of shocks $z^{t}$ alone
  ```
- Line 2667: son
  ```
  for comparison, plot the average prior expectation in our benchmark
  ```
- Line 2670: lat
  ```
  (with a correlation above 0.95).\footnote{In the figure, we start the prior at an arbitrary value of
  ```
- Line 2671: lat
  ```
  discard the initial 200 periods to calculate the correlation, to demonstrate
  ```
- Line 2672: lat
  ```
  that the strong correlation does not depend on an accurate initial
  ```
- Line 2681: lat
  ```
  {\footnotesize\emph{Note}}{\footnotesize : Based on a simulation of
  ```
- Line 2685: house
  ```
  of households who acquire information about the current productivity
  ```
- Line 2702: lat
  ```
  relationship between (the absolute value of) errors of the one-year
  ```
- Line 2703: house
  ```
  ahead probability of the unemployment rate increasing and household
  ```
- Line 2704: lat
  ```
  wealth. We plot this relationship both in the SCE data and in the
  ```
- Line 2706: loc
  ```
  We use a local polynomial regression (the LOESS regression) to estimate
  ```
- Line 2707: house, lat
  ```
  the non-linear relationship between the accuracy of household expectations
  ```
- Line 2708: house
  ```
  and household wealth. Error bands correspond to one-standard deviation
  ```
- Line 2709: house
  ```
  confidence bounds. We use 2020 values of quarterly U.S. household
  ```
- Line 2720: lat
  ```
  \caption{Mean-biased Capital Expectations\textemdash \% Relative to Full Information}
  ```
- Line 2734: house
  ```
  in which households exogenously obtain information about the level
  ```
- Line 2737: lat
  ```
  the percentage difference relative to the full-information version
  ```
- Line 2748: lat
  ```
  that also make inequality volatile over time. It does so by comparing
  ```
- Line 2752: lat
  ```
  that occur in the benchmark economy. Relative to the case with full
  ```
- Line 2767: lat, lon
  ```
  {\footnotesize\emph{Note}}{\footnotesize : Based on a long simulation
  ```
- Line 2771: lat
  ```
  wealth distribution ($k$), as well as the correlations ($\text{Cor})$
  ```
- Line 2776: lat
  ```
  The key to understanding this increase in the volatility of wealth
  ```
- Line 2779: house
  ```
  low-to-medium wealth households save less in booms, making their wealth
  ```
- Line 2780: lat
  ```
  accumulation \emph{countercyclical}. The rich, by contrast, save more
  ```
- Line 2781: lat
  ```
  when capital is high and returns low, but their overall wealth accumulation
  ```
- Line 2791: house
  ```
  in savings errors that households make due to the presence of incomplete
  ```
- Line 2792: lat
  ```
  information. Combined, the two explain the increased volatility of
  ```
- Line 2794: lat
  ```
  Finally, notice that\textemdash relative to the economies with \emph{exogenous
  ```
- Line 2796: house
  ```
  economy dampens the cyclicality of savings by medium-wealth households
  ```
- Line 2798: lat
  ```
  stock) further. This, in turn, causes the volatility of wealth inequality
  ```
- Line 2800: lat
  ```
  counterpart.\footnote{Because unemployment is countercyclical, individual earnings volatility
  ```
- Line 2802: house
  ```
  increases the value of information for unemployed households, causing
  ```
- Line 2804: house
  ```
  information is bought by unemployed households in a bust. Overall,
  ```
- Line 2806: lat
  ```
  behavior of the employed. This modulates the above discussed effects.}
  ```
- Line 2819: lat
  ```
  To isolate the general-equilibrium component, we conduct the following
  ```
- Line 2820: house
  ```
  experiment: We solve for household policy functions in the full-information
  ```
- Line 2822: lat
  ```
  $\tilde{H}(z,K)$, as given. We then simulate the economy with the
  ```
- Line 2824: lat
  ```
  the two wealth distributions. This experiment isolates the channel
  ```
- Line 2826: house
  ```
  wealth distribution.\footnote{To be clear, households still optimize in this experiment and markets
  ```
- Line 2827: house
  ```
  clear in every period. Household expectations are simply inconsistent
  ```
- Line 2836: lat
  ```
  income effects on savings, all else equal. Relative to the full-information
  ```
- Line 2837: lat
  ```
  economy with its own  law of motion, a stronger correlation between
  ```
- Line 2838: lat
  ```
  returns and savings at the bottom\textemdash and a lower correlation
  ```
- Line 2841: house
  ```
  wealth households when the capital stock (and hence wages) are high,
  ```
- Line 2842: house
  ```
  while the opposite is the case for wealthy households as returns (and
  ```
- Line 2845: lat
  ```
  dispersion of labor-market income increases with the volatility of
  ```
- Line 2846: lat
  ```
  wages, and hence with the volatility of the capital stock. In equilibrium,
  ```
- Line 2848: lat
  ```
  whose average is increasing in the volatility of the capital stock
  ```
- Line 2858: lat
  ```
  change in the average wealth distribution relative to the full-information
  ```
- Line 2871: house
  ```
  household income to convert values in the model to \$ amounts. Probability
  ```
- Line 2880: lat
  ```
  Our next experiment isolates the consequences that the\emph{ incompleteness}
  ```
- Line 2882: house, lat
  ```
  for the policy functions and simulate the distribution when households
  ```
- Line 2886: house
  ```
  with benchmark law of motion), we can quantify the effects of household
  ```
- Line 2892: lat
  ```
  correlation between savings and returns\textemdash caused by the incompleteness
  ```
- Line 2897: house
  ```
  For low-to-medium wealth households, the presence of incomplete information
  ```
- Line 2898: lat
  ```
  weakens the positive correlation that exists between returns and savings
  ```
- Line 2900: lat
  ```
  This, in turn, reduces their average wealth accumulation. In effect,
  ```
- Line 2901: house
  ```
  these households make more ``mistakes'' with their savings choices\textemdash as
  ```
- Line 2905: house
  ```
  The increased randomness by which households make savings choices,
  ```
- Line 2906: house
  ```
  by contrast, increases the share of wealthy households. These households'
  ```
- Line 2907: lat
  ```
  informed savings policies, as mentioned in the main text, correlate
  ```
- Line 2910: lat
  ```
  correlation between their savings and returns, increasing the average
  ```
- Line 2911: house
  ```
  wealth of high-wealth households.
  ```
- Line 2913: house
  ```
  In essence, high-wealth households in our model\textemdash who also
  ```
- Line 2915: house
  ```
  the borrowing constraint\textemdash are akin to the households described
  ```
- Line 2923: lat
  ```
  relative to what is needed, in the benchmark model this force is not
  ```
- Line 2931: lat
  ```
  motion) with the benchmark distribution. This difference isolates
  ```
- Line 2936: house
  ```
  All else equal, the more informed households in our benchmark economy
  ```
- Line 2937: house
  ```
  are the poor, unemployed households and the rich households with substantial
  ```
- Line 2938: house
  ```
  amounts of wealth (Figure \ref{fig-3-information-prob}). These households,
  ```
- Line 2944: house
  ```
  households. The decline in ``random savings'' caused by the presence
  ```
- Line 2945: house
  ```
  of additional information allows households near the bottom-end of
  ```
- Line 2946: lat
  ```
  the wealth distribution to better correlate their savings with its
  ```
- Line 2947: house, lat
  ```
  rate of return, allowing these households to better accumulate wealth.
  ```
- Line 2958: house
  ```
  dampens this increase  by allowing the more exposed households\textemdash the
  ```
- Line 2980: lat
  ```
  \caption{Decomposition of Wealth Distribution Changes\textemdash \% Relative
  ```
- Line 2992: lat
  ```
  overall change in the wealth distribution (relative to the full-information
  ```
- Line 3014: lat
  ```
  the table shows the correlation between aggregate consumption, investment,
  ```
- Line 3017: son
  ```
  as the two comparison models with full and exogenous information (``Full
  ```
- Line 3036: lat
  ```
  the table shows the correlation between the logarithm of capital and
  ```
- Line 3039: son
  ```
  comparison models.}{\footnotesize\par}
  ```
- Line 3064: lat
  ```
  shows the correlation between consumption and output ($\text{Cor}(C,Y)$).
  ```
- Line 3066: son
  ```
  Model''), the two comparison models with full and exogenously limited
  ```
- Line 3068: son
  ```
  respectively), as well as versions of the comparison models in which
  ```
- Line 3088: lat
  ```
  In addition, the table shows the correlation between the logarithm
  ```
- Line 3091: son
  ```
  the two comparison models, as well as versions of the comparison models
  ```
- Line 3096: city
  ```
  \subsection{Homotheticity of Information Costs \label{app-subsec-c2-1}}
  ```
- Line 3185: city
  ```
  with elasticity of substitution $\omega>1$. Each of the differentiated
  ```
- Line 3197: house
  ```
  There are two types of households: A mass $m\in(0,1)$ of worker-households
  ```
- Line 3198: house
  ```
  and a mass $1-m$ of entrepreneur-households. Worker-households are
  ```
- Line 3199: house
  ```
  identical to households in our benchmark model. Entrepreneurs, by
  ```
- Line 3202: house
  ```
  identical to worker-households.\textcolor{pink}{{} }We assume the existence
  ```
- Line 3204: house
  ```
  \citet{bayer2024shocks}, so that worker-households transition to
  ```
- Line 3205: house
  ```
  become entrepreneur-households, and vice versa. We allow for borrowing
  ```
- Line 3218: city
  ```
  entrepreneurs and the CES elasticity\textemdash to $1$ percent and
  ```
- Line 3235: lat
  ```
  zero in the simulation per its calibration. }\textcolor{orange}{{} }
  ```
- Line 3276: lat
  ```
  \caption{Decomposition of Wealth Distribution Changes\textemdash \% Relative
  ```
- Line 3288: lat
  ```
  overall change in the Gini of the wealth distribution (relative to
  ```
- Line 3313: house
  ```
  We let $\mu_{it}$ and $\varsigma_{it}^{2}$ denote the household's
  ```
- Line 3315: house
  ```
  The household then updates its beliefs in accordance with:\vspace{0.22cm}\\
  ```
- Line 3316: house
  ```
  \textbf{Informed Households: }Let $\alpha_{it}\equiv\varsigma_{it}^{-1}\left(\underline{\log K}-\mu_
  ```
- Line 3331: house
  ```
  \textbf{Uninformed Households: }Let $p_{it,z}=\mathbb{E}\left(z_{t}=1\mid\Omega_{it}\right)$
  ```
- Line 3332: house
  ```
  denote an uninformed household's expectation of a boom. Given $(m_{it},v_{it})$,
  ```
- Line 3343: house
  ```
  Instead of assuming households have a point expectation about tomorrow's
  ```
- Line 3345: house
  ```
  acquisition problem in \emph{Stage 1} and \emph{Stage 2}, households
  ```
- Line 3353: house
  ```
  Consistent with the greater uncertainty faced by households, to match
  ```
- Line 3398: house
  ```
  of U.S. household income to convert capital-holdings in the model
  ```
- Line 3427: house
  ```
  measure the percent difference in the average number of households
  ```

**/replication-package/_replication/_paper/_input/table_a10.tex**

- Line 12: lat
  ```
  & \multicolumn{4}{c}{\emph{Panel b: Inflation}}\\
  ```

**/replication-package/_replication/_paper/_input/table_a8.tex**

- Line 11: lat
  ```
  & \multicolumn{2}{c}{Inflation Forecasts}\\
  ```
- Line 16: house
  ```
  & \multicolumn{2}{c}{House Price Forecasts}\\
  ```

**/replication-package/_replication/_paper/_input/table_i.tex**

- Line 8: lat
  ```
  [1em]Model Simulated Data                   & 1.27   &  0.52 \\
  ```

**/replication-package/_replication/data_bib.tex**

- Line 6: name
  ```
  % Rename to data_bib.bib and \bibliography{literature,data_bib}, or copy
  ```
- Line 28: url
  ```
  url          = {https://www.newyorkfed.org/microeconomics/sce},
  ```
- Line 29: house
  ```
  note         = {Accessed 1 January 2026. Core monthly expectations module and supplemental household
  ```
- Line 37: url
  ```
  url          = {https://www.philadelphiafed.org/surveys-and-data/real-time-data-research/survey-of-p
  ```
- Line 42: social
  ```
  author       = {{Survey Research Center, Institute for Social Research, University of Michigan}},
  ```
- Line 46: url
  ```
  url          = {https://psidonline.isr.umich.edu/},
  ```
- Line 51: census
  ```
  author       = {{U.S. Census Bureau and U.S. Bureau of Labor Statistics}},
  ```
- Line 52: lat
  ```
  title        = {Current Population Survey ({CPS})},
  ```
- Line 54: census
  ```
  howpublished = {U.S. Census Bureau [distributor]},
  ```
- Line 55: census, url
  ```
  url          = {https://www.census.gov/programs-surveys/cps.html},
  ```
- Line 59: house
  ```
  %% ---- Prices and house prices -------------------------------------------
  ```
- Line 63: city
  ```
  title        = {Consumer Price Index for All Urban Consumers: All Items in {U.S.} City Average [{CPI
  ```
- Line 66: url
  ```
  url          = {https://fred.stlouisfed.org/series/CPIAUCSL},
  ```
- Line 72: city
  ```
  title        = {Consumer Price Index for All Urban Consumers: All Items Less Food and Energy in {U.S
  ```
- Line 75: url
  ```
  url          = {https://fred.stlouisfed.org/series/CPILFESL},
  ```
- Line 76: lat, son
  ```
  note         = {Accessed 1 January 2026. Used for the core-inflation comparison in Table A.10}
  ```
- Line 84: url
  ```
  url          = {https://fred.stlouisfed.org/series/CSUSHPINSA},
  ```
- Line 85: house
  ```
  note         = {Accessed 1 January 2026. Used to compute realized house-price growth for household f
  ```
- Line 95: url
  ```
  url          = {https://fred.stlouisfed.org/series/UNRATE},
  ```
- Line 104: url
  ```
  url          = {https://fred.stlouisfed.org/series/PRS85006023},
  ```
- Line 113: url
  ```
  url          = {https://fred.stlouisfed.org/series/CE16OV},
  ```
- Line 119: lat
  ```
  title        = {Population Level [{CNP16OV}]},
  ```
- Line 122: url
  ```
  url          = {https://fred.stlouisfed.org/series/CNP16OV},
  ```
- Line 133: url
  ```
  url          = {https://fred.stlouisfed.org/series/FEDFUNDS},
  ```
- Line 144: url
  ```
  url          = {https://fred.stlouisfed.org/series/GDPC1},
  ```
- Line 153: url
  ```
  url          = {https://fred.stlouisfed.org/series/A939RX0Q048SBEA},
  ```
- Line 159: son
  ```
  title        = {Real Personal Consumption Expenditures Per Capita [{A794RX0Q048SBEA}]},
  ```
- Line 162: url
  ```
  url          = {https://fred.stlouisfed.org/series/A794RX0Q048SBEA},
  ```
- Line 171: url
  ```
  url          = {https://fred.stlouisfed.org/series/NFIRSAXDCUSQ},
  ```
- Line 180: url
  ```
  url          = {https://fred.stlouisfed.org/series/RKNANPUSA666NRUG},
  ```

**/replication-package/_replication/run_all.sh**

- Line 20: loc
  ```
  #    ./run_all.sh check        locate R, MATLAB and Stata and exit
  ```
- Line 22: loc
  ```
  #  Requires R, MATLAB and Stata on the machine. Each is located
  ```
- Line 25: loc
  ```
  #    RSCRIPT_BIN=/usr/local/bin/Rscript \
  ```
- Line 39: name
  ```
  ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  ```
- Line 45: loc
  ```
  # ---- locate interpreters -------------------------------------------------
  ```
- Line 48: name
  ```
  # find_exe <ENV_VAR_NAME> <label> <glob> [<glob> ...]
  ```
- Line 49: loc
  ```
  local var="$1"; shift
  ```
- Line 50: loc
  ```
  local label="$1"; shift
  ```
- Line 51: loc
  ```
  local from_env="${!var:-}"
  ```
- Line 62: loc
  ```
  local candidate
  ```
- Line 85: loc
  ```
  local rscript
  ```
- Line 87: loc
  ```
  '/usr/local/bin/Rscript' \
  ```
- Line 94: minute
  ```
  echo "    Expected runtime: about 20-40 minutes."
  ```
- Line 99: loc
  ```
  local stata
  ```
- Line 104: loc
  ```
  '/usr/local/stata*/stata-mp' \
  ```
- Line 105: loc
  ```
  '/usr/local/stata*/stata-se')" || return 1
  ```
- Line 120: loc
  ```
  local matlab
  ```
- Line 123: loc
  ```
  '/usr/local/MATLAB/R*/bin/matlab' \
  ```
- Line 144: loc
  ```
  local rc=0 p
  ```
- Line 148: loc
  ```
  '/usr/local/bin/Rscript' '/opt/homebrew/bin/Rscript' \
  ```
- Line 156: loc
  ```
  '/Applications/MATLAB_R*.app/bin/matlab' '/usr/local/MATLAB/R*/bin/matlab' \
  ```
- Line 167: loc
  ```
  '/usr/local/stata*/stata-mp' '/usr/local/stata*/stata-se' 2>/dev/null)"; then
  ```

