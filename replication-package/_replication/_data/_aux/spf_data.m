clear all; clc; close all;
currentFile = mfilename( 'fullpath' );
[pathstr,~,~] = fileparts( currentFile );
rootpath = fileparts( pathstr );   % script lives in _aux; data folders sit in the parent
addpath( fullfile( rootpath, '_data/' ) );
addpath( fullfile( rootpath, '_aux/' ) );

bin  = 0.25;

unrate_end_year  = 2019;  unrate_end_month = 4;   
sample_end_year  = 2019;  sample_end_month = 5;   


%% [1] LOAD AND CLEAN SPF DATA
data    =  readtable('PROB_SPF_RAW.xlsx');

tmp         = [data.PRUNEMP1 data.PRUNEMP2 data.PRUNEMP3 data.PRUNEMP4 data.PRUNEMP5 data.PRUNEMP6 data.PRUNEMP7 data.PRUNEMP8 data.PRUNEMP9 data.PRUNEMP10 ...
               data.PRUNEMP11 data.PRUNEMP12 data.PRUNEMP13 data.PRUNEMP14 data.PRUNEMP15 data.PRUNEMP16 data.PRUNEMP17 data.PRUNEMP18 data.PRUNEMP19 data.PRUNEMP20];
prunemp     = str2double(tmp);

nn          = find( ~isnan(prunemp(:,1)) & data.YEAR>2009 & data.YEAR<2022 );
prunemp     = prunemp(nn,:);
spf_year    = data.YEAR(nn);
spf_qtr     = data.QUARTER(nn);

spf_month   = (spf_qtr-1)*3+2;  % SPF is conducted in the second month of every quarter


w_curr      = [10 7 4 1]/12;

spf_fcast   = nan(length(nn),10);
for ii=1:length(nn)
    ww              = w_curr(spf_qtr(ii));
    spf_fcast(ii,:) = ww*prunemp(ii,1:10) + (1-ww)*prunemp(ii,11:20);
end

kk          = find(~isnan(spf_fcast(:,1)));
spf_fcast   = spf_fcast(kk,:);
spf_year    = spf_year(kk);
spf_month   = spf_month(kk);


%% [2] MONTHLY UNRATE, 1-Y-AHEAD UNRATE, AND UNRATEUP
%data_u      = readtable(fullfile(rootpath,'_data','_data_var','UNRATE.xls'));
data_u      = readtable(fullfile(rootpath,'_data','_data_var','UNRATE_ALFRED.xls'));


u_date      = data_u{:,1};                  
u_rate      = data_u{:,2};                  
u_year      = year(u_date);
u_month     = month(u_date);


u_cut       = (u_year>unrate_end_year) | (u_year==unrate_end_year & u_month>unrate_end_month);
u_rate(u_cut) = NaN;

u_1y        = [u_rate(13:end); nan(12,1)];

mm          = find( ~isnan(u_rate) & ~isnan(u_1y) );
u_rate      = u_rate(mm);   u_1y = u_1y(mm);
u_year      = u_year(mm);   u_month = u_month(mm);

unrateup    = double(u_1y > u_rate);


%% [3] BIN BOUNDARIES (PRUNEMPbin1,...,PRUNEMPbin11 BY VINTAGE)

xx_2013     = [12 11 10 9.5 9 8.5 8 7.5 7 6 5];
xx_2014     = [10 9 8 7.5 7 6.5 6 5.5 5 4 3];
xx_2020     = [16 15 12 10 8 7 6 5 4 3 2];


%% [4] PROB UP AND EXPECTED UNRATE AT SPF SURVEY DATES

probup_spf  = nan(length(spf_year),1);
spf_exp_u   = nan(length(spf_year),1);

for tt=1:length(spf_year)

    pos = find( u_year==spf_year(tt) & u_month==spf_month(tt) );
    if isempty(pos)
        probup_spf(tt) = sum( spf_fcast(tt,:) );
        continue;
    end
    u_tmp = u_rate(pos);

    if spf_year(tt)==2013
        xx = xx_2013;
    elseif spf_year(tt)>=2014 && spf_year(tt)<2020
        xx = xx_2014;
    elseif spf_year(tt)==2020 && spf_month(tt)<4
        xx = xx_2014;
    elseif spf_year(tt)>=2020
        xx = xx_2020;
    else
        continue;
    end

    prob_tmp = 0;
    exp_tmp  = 0;
    for ii=1:10
        jj = ii+1;

        unrate_bindev     = (xx(ii) - u_tmp - bin) / (xx(ii) - xx(jj));
        unrate_bindev_dum = min(max(unrate_bindev,0),1);

        prob_tmp = prob_tmp + spf_fcast(tt,ii)*unrate_bindev_dum;
        exp_tmp  = exp_tmp  + spf_fcast(tt,ii)*( xx(jj) + 0.5*(xx(ii)-xx(jj)) );
    end

    probup_spf(tt) = prob_tmp;
    spf_exp_u(tt)  = exp_tmp;

end


%% [5] MONTHLY PANEL FROM 2013M1 
pp          = find( u_year>=2013 );
year_m      = u_year(pp);
month_m     = u_month(pp);
unrate_m    = u_rate(pp);
unrateup_m  = unrateup(pp);


sample_end_ym = (sample_end_year-2013)*12 + sample_end_month;
ym_m          = (year_m-2013)*12 + month_m;
spf_ym        = (spf_year-2013)*12 + spf_month;
extra         = find( ~ismember(spf_ym,ym_m) & spf_ym>=1 & spf_ym<=sample_end_ym );

year_m      = [year_m;     spf_year(extra)];
month_m     = [month_m;    spf_month(extra)];
unrate_m    = [unrate_m;   nan(numel(extra),1)];
unrateup_m  = [unrateup_m; nan(numel(extra),1)];

yearmonth   = (year_m-2013)*12 + month_m;
keep        = yearmonth <= sample_end_ym;
year_m      = year_m(keep);   month_m = month_m(keep);
unrate_m    = unrate_m(keep);  unrateup_m = unrateup_m(keep);
yearmonth   = yearmonth(keep);
[yearmonth,ord] = sort(yearmonth);
year_m      = year_m(ord);   month_m = month_m(ord);
unrate_m    = unrate_m(ord);  unrateup_m = unrateup_m(ord);

T           = length(year_m);
probupSPF   = nan(T,1);
spf_exp_m   = nan(T,1);

for tt=1:length(spf_year)
    pos = find( year_m==spf_year(tt) & month_m==spf_month(tt) );
    if ~isempty(pos)
        probupSPF(pos) = probup_spf(tt);
        spf_exp_m(pos) = spf_exp_u(tt);
    end
end



%% [6] QUARTERLY-TO-MONTHLY INTERPOLATION OF PROBUP
probupSPF_q = probupSPF;

for tt=1:T
    if ismember(month_m(tt),[3 6 9 12])
        if tt-1>=1 && tt+2<=T
            probupSPF_q(tt) = ( probupSPF(tt-1) + 2*probupSPF(tt+2) )/3;
        else
            probupSPF_q(tt) = NaN;
        end
    elseif ismember(month_m(tt),[1 4 7 10])
        if tt-2>=1 && tt+1<=T
            probupSPF_q(tt) = ( 2*probupSPF(tt+1) + probupSPF(tt-2) )/3;
        else
            probupSPF_q(tt) = NaN;
        end
    end
end


%% [7] FORECAST ERRORS AND BRIER SCORES
probupSPF_error   = unrateup_m.*(100-probupSPF)   + (1-unrateup_m).*probupSPF;
probupSPF_brier   = 2*abs(unrateup_m*100 - probupSPF);
probupSPF_q_error = unrateup_m.*(100-probupSPF_q) + (1-unrateup_m).*probupSPF_q;
probupSPF_q_brier = 2*abs(unrateup_m*100 - probupSPF_q);


%% [8] SAVE
T_save = table(year_m, month_m, probupSPF, unrateup_m, yearmonth, ...
               probupSPF_q, probupSPF_error, probupSPF_brier, ...
               probupSPF_q_error, probupSPF_q_brier, ...
               'VariableNames', {'year','month','probupSPF','UNRATEUP','yearmonth', ...
                                 'probupSPF_q','probupSPF_error','probupSPF_brier', ...
                                 'probupSPF_q_error','probupSPF_q_brier'});
writetable(T_save, fullfile(rootpath,'_aux','spf_prob_u.csv'));
