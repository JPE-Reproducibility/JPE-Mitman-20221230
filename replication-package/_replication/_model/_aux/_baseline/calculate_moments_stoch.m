function [moments,TS] = calculate_moments_stoch(kmts,panel,idshock,agshock,params)
%function calculates the aggregate moments from the stochastic
%simulation of BKKS
% Translate Tobi code to Kurt code
% kmts      = Kvec
% kcross    = kdist
% xcross    = cah
% ind_info  = info_t
% idshock   = ishocks this is just the emp/unemp dimension
% agshock   = zvec
% a         = z
% ur_b      = Urec
% ur_g      = Uboom
% alpha     = params.alpha
% delta     = params.delta
% burnin    = params.drop
% weight    = weight of the beta in case we have heterogeneity
% kappa     = params.nu for us nu is monetary cost

kcross    = panel.kdistT;
xcross    = panel.cahT;
ind_info  = panel.info_acT;

a         = params.z;
ur_b      = params.u(1);
ur_g      = params.u(2);
alpha     = params.alpha;
delta     = params.delta;
burnin    = params.drop;
weight    = ones(params.N,1)/params.N; %weight of the beta in case we have heterogeneity
nu        = params.nu;


conversion_to_dollars = (38.1/10.26)*65300/4;

%aggregate capital
moments.kbar_log_mean = mean(log(kmts(burnin+1:end)));
moments.kbar_log_stdev = std(log(kmts(burnin+1:end)));
moments.kbar_dlog_stdev = std(log(kmts(burnin+1:end))-log(kmts(burnin:end-1)));
moments.kbar_mean = mean(kmts(burnin+1:end));
moments.kbar_stdev = std(kmts(burnin+1:end));
[~,cycle_k]=hpfilter(log(kmts(burnin+1:end))); %default is 1600
moments.kbar_hplog_stdev = std(cycle_k(1:end)); 

kmts_dollar = kmts/conversion_to_dollars;
moments.kbar_dollar_log_stdev = std(log(kmts_dollar(burnin+1:end)));
[~,cycle_k_dollar]=hpfilter(log(kmts_dollar(burnin+1:end))); %default is 1600
moments.kbar_dollar_hplog_stdev = std(cycle_k_dollar(1:end)); 

%investment
invest = [kmts(2:end) kmts(end)]-(1-delta)*kmts(1:end);
moments.inv_log_mean = mean(log(invest));
moments.inv_log_stdev = std(log(invest));
moments.inv_dlog_mean = mean(log(invest(2:end))-log(invest(1:end-1)));
moments.inv_dlog_stdev = std(log(invest(2:end))-log(invest(1:end-1)));
[~,cycle_inv]=hpfilter(log(invest(burnin+1:end)));
moments.inv_hplog_stdev = std(cycle_inv(1:end));
moments.inv_mean = mean(invest);
moments.inv_stdev = std(invest);
% moments.inv = invest;

invest_dollar = invest/conversion_to_dollars;
moments.inv_dollar_log_stdev = std(log(invest_dollar(burnin+1:end)));
[~,cycle_inv_dollar]=hpfilter(log(invest_dollar(burnin+1:end))); %default is 1600
moments.inv_dollar_hplog_stdev = std(cycle_inv_dollar(1:end));

%output
prod_ag = (agshock==1)*a(1) + (agshock==2)*a(2);
labor_ag = (agshock==1)*(1-ur_b) + (agshock==2)*(1-ur_g);
y=prod_ag'.*kmts.^alpha.*labor_ag'.^(1-alpha);
moments.y = y;
moments.y_log_mean = mean(log(y(burnin+1:end)));
moments.y_log_stdev = std(log(y(burnin+1:end)));
moments.y_dlog_mean = mean(log(y(burnin+2:end))-log(y(burnin+1:end-1)));
moments.y_dlog_stdev = std(log(y(burnin+2:end))-log(y(burnin+1:end-1)));
[~,cycle_y]=hpfilter(log(y(burnin+1:end)));
moments.y_hplog_stdev = std(cycle_y(1:end)); 
moments.y_mean = mean(y(burnin+1:end));
moments.y_stdev = std(y(burnin+1:end));

y_dollar = y/conversion_to_dollars;
moments.y_dollar_log_stdev = std(log(y_dollar(burnin+1:end)));
[~,cycle_y_dollar]=hpfilter(log(y_dollar(burnin+1:end))); %default is 1600
moments.y_dollar_hplog_stdev = std(cycle_y_dollar(1:end)); 


moments.kyrat = mean(kmts(burnin+1:end)./y(burnin+1:end));

moments.w_mean = mean(params.markdown*(1-alpha)*prod_ag'.*(kmts./labor_ag').^(alpha));
moments.r_mean = mean(params.markdown*alpha*prod_ag'.*(labor_ag'./kmts).^(1-alpha));

%aggregate consumption
ccross = xcross(:,1:end-1)-kcross(:,2:end)-nu*ind_info(:,1:end-1);
cmts = weight'*ccross;
%moments.c = cmts;
%cmtsalt=y(1:end-1)-kmts(2:end);

moments.c_log_mean = mean(log(cmts(burnin+1:end)));
moments.c_log_stdev = std(log(cmts(burnin+1:end)));
moments.c_dlog_mean = mean(log(cmts(burnin+2:end))-log(cmts(burnin+1:end-1)));
moments.c_dlog_stdev = std(log(cmts(burnin+2:end))-log(cmts(burnin+1:end-1)));
[~,cycle_c]=hpfilter(log(cmts(burnin+1:end)));
moments.c_hplog_stdev = std(cycle_c(1:end)); 
moments.c_mean = mean(cmts(burnin+1:end));
moments.c_stdev = std(cmts(burnin+1:end));

cmts_dollar = cmts/conversion_to_dollars;
moments.c_dollar_log_stdev = std(log(cmts_dollar(burnin+1:end)));
[~,cycle_c_dollar]=hpfilter(log(cmts_dollar(burnin+1:end))); %default is 1600
moments.c_dollar_hplog_stdev = std(cycle_c_dollar(1:end)); 


%(auto)correlations in logs
moments.c_corr_y_log=corr(log(y(burnin+1:end-1)'),log(cmts(burnin+1:end)'));
moments.k_corr_y_log=corr(log(y(burnin+1:end)'),log(kmts(burnin+1:end)'));
moments.inv_corr_y_log=corr(log(y(burnin+1:end)'),log(invest(burnin+1:end)'));
moments.autocorr_y_log = corr(log(y(burnin+1:end-1)'),log(y(burnin+2:end)'));
moments.autocorr_c_log = corr(log(cmts(burnin+1:end-1)'),log(cmts(burnin+2:end)'));
moments.autocorr_k_log = corr(log(kmts(burnin+1:end-1)'),log(kmts(burnin+2:end)'));
moments.autocorr_inv_log = corr(log(invest(burnin+1:end-2)'),log(invest(burnin+2:end-1)'));
moments.c_corr_y2_log=corr(log(y(burnin+1:end-2)'),log(cmts(burnin+2:end)'));
moments.k_corr_y2_log=corr(log(y(burnin+1:end-1)'),log(kmts(burnin+2:end)'));
moments.inv_corr_y2_log=corr(log(y(burnin+1:end-1)'),log(invest(burnin+2:end)'));

moments.c_dollar_corr_y_log=corr(log(y_dollar(burnin+1:end-1)'),log(cmts_dollar(burnin+1:end)'));
moments.k_dollar_corr_y_log=corr(log(y_dollar(burnin+1:end)'),log(kmts_dollar(burnin+1:end)'));
moments.inv_dollar_corr_y_log=corr(log(y_dollar(burnin+1:end)'),log(invest_dollar(burnin+1:end)'));
moments.autocorr_y_dollar_log = corr(log(y_dollar(burnin+1:end-1)'),log(y_dollar(burnin+2:end)'));
moments.autocorr_c_dollar_log = corr(log(cmts_dollar(burnin+1:end-1)'),log(cmts_dollar(burnin+2:end)'));
moments.autocorr_k_dollar_log = corr(log(kmts_dollar(burnin+1:end-1)'),log(kmts_dollar(burnin+2:end)'));
moments.autocorr_inv_dollar_log = corr(log(invest_dollar(burnin+1:end-2)'),log(invest_dollar(burnin+2:end-1)'));
moments.c_dollar_corr_y2_log=corr(log(y_dollar(burnin+1:end-2)'),log(cmts_dollar(burnin+2:end)'));
moments.k_dollar_corr_y2_log=corr(log(y_dollar(burnin+1:end-1)'),log(kmts_dollar(burnin+2:end)'));
moments.inv_dollar_corr_y2_log=corr(log(y_dollar(burnin+1:end-1)'),log(invest_dollar(burnin+2:end)'));


%(auto)correlations in hp-filtered logs
moments.c_corr_y_hplog=corr(cycle_y(1:end-1),cycle_c(1:end));
moments.k_corr_y_hplog=corr(cycle_y(1:end),cycle_k(1:end));
moments.inv_corr_y_hplog=corr(cycle_y(1:end),cycle_inv(1:end));
moments.autocorr_y_hplog = corr(cycle_y(1:end-1),cycle_y(2:end));
moments.autocorr_c_hplog = corr(cycle_c(1:end-1),cycle_c(2:end));
moments.autocorr_k_hplog = corr(cycle_k(1:end-1),cycle_k(2:end));
moments.autocorr_inv_hplog = corr(cycle_inv(1:end-1),cycle_inv(2:end));
moments.c_corr_y2_hplog=corr(cycle_y(1:end-2),cycle_c(2:end));
moments.k_corr_y2_hplog=corr(cycle_y(1:end-1),cycle_k(2:end));
moments.inv_corr_y2_hplog=corr(cycle_y(1:end-1),cycle_inv(2:end));

moments.c_dollar_corr_y_hplog=corr(cycle_y_dollar(1:end-1),cycle_c_dollar(1:end));
moments.k_dollar_corr_y_hplog=corr(cycle_y_dollar(1:end),cycle_k_dollar(1:end));
moments.inv_dollar_corr_y_hplog=corr(cycle_y_dollar(1:end),cycle_inv_dollar(1:end));
moments.autocorr_y_dollar_hplog = corr(cycle_y_dollar(1:end-1),cycle_y_dollar(2:end));
moments.autocorr_c_dollar_hplog = corr(cycle_c_dollar(1:end-1),cycle_c_dollar(2:end));
moments.autocorr_k_dollar_hplog = corr(cycle_k_dollar(1:end-1),cycle_k_dollar(2:end));
moments.autocorr_inv_dollar_hplog = corr(cycle_inv_dollar(1:end-1),cycle_inv_dollar(2:end));
moments.c_dollar_corr_y2_hplog=corr(cycle_y_dollar(1:end-2),cycle_c_dollar(2:end));
moments.k_dollar_corr_y2_hplog=corr(cycle_y_dollar(1:end-1),cycle_k_dollar(2:end));
moments.inv_dollar_corr_y2_hplog=corr(cycle_y_dollar(1:end-1),cycle_inv_dollar(2:end));

clear  ccross  prod_ag labor_ag 

%autocorrelations and correlations with output


%info acquisition

%wealth inequality
Tsim = length(kmts)-burnin;
gini_temp = NaN(Tsim,1);
gini_temp_u = NaN(Tsim,1);
gini_temp_e = NaN(Tsim,1);

ninetyten_temp = NaN(Tsim,1);
ninetynineone_temp = NaN(Tsim,1);
ninetyninefifty_temp = NaN(Tsim,1);
ninetyfivefifty_temp = NaN(Tsim,1);
fiftyten_temp = NaN(Tsim,1);
fiftytwentyfive_temp = NaN(Tsim,1);
fiftyone_temp = NaN(Tsim,1);
twentyfiveone_temp = NaN(Tsim,1);
ninetyfifty_temp = NaN(Tsim,1);
p1_temp = NaN(Tsim,1);
p5_temp = NaN(Tsim,1);
p10_temp = NaN(Tsim,1);
p50_temp = NaN(Tsim,1);
p90_temp = NaN(Tsim,1);
p95_temp = NaN(Tsim,1);
p99_temp = NaN(Tsim,1);

ninetyten_temp_u = NaN(Tsim,1);
ninetynineone_temp_u = NaN(Tsim,1);
ninetyninefifty_temp_u = NaN(Tsim,1);
ninetyfivefifty_temp_u = NaN(Tsim,1);
fiftyten_temp_u = NaN(Tsim,1);
fiftytwentyfive_temp_u = NaN(Tsim,1);
fiftyone_temp_u = NaN(Tsim,1);
twentyfiveone_temp_u = NaN(Tsim,1);
ninetyfifty_temp_u = NaN(Tsim,1);
p1_u_temp = NaN(Tsim,1);
p5_u_temp = NaN(Tsim,1);
p10_u_temp = NaN(Tsim,1);
p50_u_temp = NaN(Tsim,1);
p90_u_temp = NaN(Tsim,1);
p95_u_temp = NaN(Tsim,1);
p99_u_temp = NaN(Tsim,1);

ninetyten_temp_e = NaN(Tsim,1);
ninetynineone_temp_e = NaN(Tsim,1);
ninetyninefifty_temp_e = NaN(Tsim,1);
ninetyfivefifty_temp_e = NaN(Tsim,1);
fiftyten_temp_e = NaN(Tsim,1);
fiftytwentyfive_temp_e = NaN(Tsim,1);
fiftyone_temp_e = NaN(Tsim,1);
twentyfiveone_temp_e = NaN(Tsim,1);
ninetyfifty_temp_e = NaN(Tsim,1);
p1_e_temp = NaN(Tsim,1);
p5_e_temp = NaN(Tsim,1);
p10_e_temp = NaN(Tsim,1);
p50_e_temp = NaN(Tsim,1);
p90_e_temp = NaN(Tsim,1);
p95_e_temp = NaN(Tsim,1);
p99_e_temp = NaN(Tsim,1);

N=params.N;
for t=1:Tsim

    [W, I]=sort(kcross(:,t+burnin));
    gini_temp(t)=1-2*sum(cumsum(W)/sum(W))/N;
    %gini_temp(i) = gini(kcross(:,t),weight);

    [W_u, ~]=sort(kcross(idshock(:,t+burnin)==1,t+burnin));
    [W_e, ~]=sort(kcross(idshock(:,t+burnin)==2,t+burnin));
    N_u = sum(idshock(:,t+burnin)==1);
    N_e = sum(idshock(:,t+burnin)==2);
    gini_temp_u(t) = 1-2*sum(cumsum(W_u)/sum(W_u))/N_u;
    gini_temp_e(t) = 1-2*sum(cumsum(W_e)/sum(W_e))/N_e;
    %gini_temp_u(t) = gini(kcross(idshock(:,t)==1,t),weight(idshock(:,t)==1));
    %gini_temp_e(t) = gini(kcross(idshock(:,t)==2,t),weight(idshock(:,t)==2));

    p1_temp(t) = W(ceil(0.01*N));
    p5_temp(t) = W(ceil(0.05*N));
    p10_temp(t) = W(ceil(0.1*N));
    p50_temp(t) = W(ceil(0.5*N));
    p90_temp(t) = W(ceil(0.9*N));
    p95_temp(t) = W(ceil(0.95*N));
    p99_temp(t) = W(ceil(0.99*N));
    p1_u_temp(t) = W_u(ceil(0.01*N_u));
    p5_u_temp(t) = W_u(ceil(0.05*N_u));
    p10_u_temp(t) = W_u(ceil(0.1*N_u));
    p50_u_temp(t) = W_u(ceil(0.5*N_u));
    p90_u_temp(t) = W_u(ceil(0.9*N_u));
    p95_u_temp(t) = W_u(ceil(0.95*N_u));
    p99_u_temp(t) = W_u(ceil(0.99*N_u));
    p1_e_temp(t) = W_e(ceil(0.01*N_e));
    p5_e_temp(t) = W_e(ceil(0.05*N_e));
    p10_e_temp(t) = W_e(ceil(0.1*N_e));
    p50_e_temp(t) = W_e(ceil(0.5*N_e));
    p90_e_temp(t) = W_e(ceil(0.9*N_e));
    p95_e_temp(t) = W_e(ceil(0.95*N_e));
    p99_e_temp(t) = W_e(ceil(0.99*N_e));

    ninetyten_temp(t) = W(ceil(0.9*N))/W(ceil(0.1*N));
    ninetyten_temp_u(t) = W_u(ceil(0.9*N_u))/W_u(ceil(0.1*N_u));
    ninetyten_temp_e(t) = W_e(ceil(0.9*N_e))/W_e(ceil(0.1*N_e));
    % ninetyten_temp(t) = wprctile(kcross(:,t),90,weight)/wprctile(kcross(:,t),10,weight);

    fiftyten_temp(t) = W(ceil(0.5*N))/W(ceil(0.1*N));
    fiftyten_temp_u(t) = W_u(ceil(0.5*N_u))/W_u(ceil(0.1*N_u));
    fiftyten_temp_e(t) = W_e(ceil(0.5*N_e))/W_e(ceil(0.1*N_e));

    fiftytwentyfive_temp(t) = W(ceil(0.5*N))/W(ceil(0.25*N));
    fiftytwentyfive_temp_u(t) = W_u(ceil(0.5*N_u))/W_u(ceil(0.25*N_u));
    fiftytwentyfive_temp_e(t) = W_e(ceil(0.5*N_e))/W_e(ceil(0.25*N_e));

    fiftyone_temp(t) = W(ceil(0.5*N))/W(ceil(0.01*N));
    fiftyone_temp_u(t) = W_u(ceil(0.5*N_u))/W_u(ceil(0.01*N_u));
    fiftyone_temp_e(t) = W_e(ceil(0.5*N_e))/W_e(ceil(0.01*N_e));

    twentyfiveone_temp(t) = W(ceil(0.25*N))/W(ceil(0.01*N));
    twentyfiveone_temp_u(t) = W_u(ceil(0.25*N_u))/W_u(ceil(0.01*N_u));
    twentyfiveone_temp_e(t) = W_e(ceil(0.25*N_e))/W_e(ceil(0.01*N_e));

    ninetynineone_temp(t) = W(ceil(0.99*N))/W(ceil(0.01*N));
    ninetynineone_temp_u(t) = W_u(ceil(0.99*N_u))/W_u(ceil(0.01*N_u));
    ninetynineone_temp_e(t) = W_e(ceil(0.99*N_e))/W_e(ceil(0.01*N_e));
   % ninetynineone_temp(t) = wprctile(kcross(:,t),99,weight)/wprctile(kcross(:,t),1,weight);

    ninetyninefifty_temp(t) = W(ceil(0.99*N))/W(ceil(0.5*N));
    ninetyninefifty_temp_u(t) = W_u(ceil(0.99*N_u))/W_u(ceil(0.5*N_u));
    ninetyninefifty_temp_e(t) = W_e(ceil(0.99*N_e))/W_e(ceil(0.5*N_e));

    ninetyfivefifty_temp(t) = W(ceil(0.95*N))/W(ceil(0.5*N));
    ninetyfivefifty_temp_u(t) = W_u(ceil(0.95*N_u))/W_u(ceil(0.5*N_u));
    ninetyfivefifty_temp_e(t) = W_e(ceil(0.95*N_e))/W_e(ceil(0.5*N_e));

    ninetyfifty_temp(t) = W(ceil(0.9*N))/W(ceil(0.5*N));
    ninetyfifty_temp_u(t) = W_u(ceil(0.9*N_u))/W_u(ceil(0.5*N_u));
    ninetyfifty_temp_e(t) = W_e(ceil(0.9*N_e))/W_e(ceil(0.5*N_e));

    k_u(t)=sum(weight(idshock(:,t+burnin)==1).*kcross(idshock(:,t+burnin)==1,t))/sum(weight(idshock(:,t+burnin)==1));
    k_e(t)=sum(weight(idshock(:,t+burnin)==2).*kcross(idshock(:,t+burnin)==2,t))/sum(weight(idshock(:,t+burnin)==2));

    moments.info_ts(t)=mean(ind_info(:,t+burnin));
    moments.info_unemp_ts(t) = sum(ind_info(idshock(:,t+burnin)==1,t+burnin)) / sum((idshock(:,t+burnin)==1));
    moments.info_emp_ts(t) = sum(ind_info(idshock(:,t+burnin)==2,t+burnin)) / sum((idshock(:,t+burnin)==2));

end
moments.info=mean(moments.info_ts);
moments.info_unemp=mean(moments.info_unemp_ts);
moments.info_emp=mean(moments.info_emp_ts);

moments.gini = mean(gini_temp);
moments.gini_u = mean(gini_temp_u);
moments.gini_e = mean(gini_temp_e);
moments.gini_stdev = std(gini_temp);
moments.gini_u_stdev = std(gini_temp_u);
moments.gini_e_stdev = std(gini_temp_e);
moments.k_u=mean(k_u);
moments.k_e=mean(k_e);

moments.p1 = mean(p1_temp);
moments.p5 = mean(p5_temp);
moments.p10 = mean(p10_temp);
moments.p50 = mean(p50_temp);
moments.p90 = mean(p90_temp);
moments.p95 = mean(p95_temp);
moments.p99 = mean(p99_temp);
moments.p1_u = mean(p1_u_temp);
moments.p5_u = mean(p5_u_temp);
moments.p10_u = mean(p10_u_temp);
moments.p50_u = mean(p50_u_temp);
moments.p90_u = mean(p90_u_temp);
moments.p95_u = mean(p95_u_temp);
moments.p99_u = mean(p99_u_temp);
moments.p1_e = mean(p1_e_temp);
moments.p5_e = mean(p5_e_temp);
moments.p10_e = mean(p10_e_temp);
moments.p50_e = mean(p50_e_temp);
moments.p90_e = mean(p90_e_temp);
moments.p95_e = mean(p95_e_temp);
moments.p99_e = mean(p99_e_temp);

moments.p1_stdev = std(p1_temp);
moments.p5_stdev = std(p5_temp);
moments.p10_stdev = std(p10_temp);
moments.p50_stdev = std(p50_temp);
moments.p90_stdev = std(p90_temp);
moments.p95_stdev = std(p95_temp);
moments.p99_stdev = std(p99_temp);
moments.p1_u_stdev = std(p1_u_temp);
moments.p5_u_stdev = std(p5_u_temp);
moments.p10_u_stdev = std(p10_u_temp);
moments.p50_u_stdev = std(p50_u_temp);
moments.p90_u_stdev = std(p90_u_temp);
moments.p95_u_stdev = std(p95_u_temp);
moments.p99_u_stdev = std(p99_u_temp);
moments.p1_e_stdev = std(p1_e_temp);
moments.p5_e_stdev = std(p5_e_temp);
moments.p10_e_stdev = std(p10_e_temp);
moments.p50_e_stdev = std(p50_e_temp);
moments.p90_e_stdev = std(p90_e_temp);
moments.p95_e_stdev = std(p95_e_temp);
moments.p99_e_stdev = std(p99_e_temp);

moments.p1_ts = p1_temp;
moments.p5_ts = p5_temp;
moments.p10_ts = p10_temp;
moments.p50_ts = p50_temp;
moments.p90_ts = p90_temp;
moments.p95_ts = p95_temp;
moments.p99_ts = p99_temp;
moments.p1_u_ts = p1_u_temp;
moments.p5_u_ts = p5_u_temp;
moments.p10_u_ts = p10_u_temp;
moments.p50_u_ts = p50_u_temp;
moments.p90_u_ts = p90_u_temp;
moments.p95_u_ts = p95_u_temp;
moments.p99_u_ts = p99_u_temp;
moments.p1_e_ts = p1_e_temp;
moments.p5_e_ts = p5_e_temp;
moments.p10_e_ts = p10_e_temp;
moments.p50_e_ts = p50_e_temp;
moments.p90_e_ts = p90_e_temp;
moments.p95_e_ts = p95_e_temp;
moments.p99_e_ts = p99_e_temp;

moments.ninetyten = mean(ninetyten_temp);
moments.ninetyfifty = mean(ninetyfifty_temp);
moments.ninetyfivefifty = mean(ninetyfivefifty_temp);
moments.ninetyninefifty = mean(ninetyninefifty_temp);
moments.ninetynineone = mean(ninetynineone_temp);
moments.fiftyten = mean(fiftyten_temp);
moments.fiftytwentyfive = mean(fiftytwentyfive_temp);
moments.fiftyone = mean(fiftyone_temp);
moments.twentyfiveone = mean(twentyfiveone_temp);

moments.ninetyten_stdev = std(ninetyten_temp);
moments.ninetyfifty_stdev = std(ninetyfifty_temp);
moments.ninetyfivefifty_stdev = std(ninetyfivefifty_temp);
moments.ninetyninefifty_stdev = std(ninetyninefifty_temp);
moments.ninetynineone_stdev = std(ninetynineone_temp);
moments.fiftyten_stdev = std(fiftyten_temp);
moments.fiftytwentyfive_stdev = std(fiftytwentyfive_temp);
moments.fiftyone_stdev = std(fiftyone_temp);
moments.twentyfiveone_stdev = std(twentyfiveone_temp);

moments.gini_ts = gini_temp;
moments.gini_u_ts = gini_temp_u;
moments.gini_e_ts = gini_temp_e;

moments.ninetyten_ts = ninetyten_temp;
moments.ninetyfifty_ts = ninetyfifty_temp;
moments.ninetyfivefifty_ts = ninetyfivefifty_temp;
moments.ninetyninefifty_ts = ninetyninefifty_temp;
moments.ninetynineone_ts = ninetynineone_temp;
moments.fiftyten_ts = fiftyten_temp;
moments.fiftytwentyfive_ts = fiftytwentyfive_temp;
moments.fiftyone_ts = fiftyone_temp;
moments.twentyfiveone_ts = twentyfiveone_temp;

moments.ninetyten_u_ts = ninetyten_temp_u;
moments.ninetyfifty_u_ts = ninetyfifty_temp_u;
moments.ninetyfivefifty_u_ts = ninetyfivefifty_temp_u;
moments.ninetyninefifty_u_ts = ninetyninefifty_temp_u;
moments.ninetynineone_u_ts = ninetynineone_temp_u;
moments.fiftyten_u_ts = fiftyten_temp_u;
moments.fiftytwentyfive_u_ts = fiftytwentyfive_temp_u;
moments.fiftyone_u_ts = fiftyone_temp_u;
moments.twentyfiveone_u_ts = twentyfiveone_temp_u;

moments.ninetyten_e_ts = ninetyten_temp_e;
moments.ninetyfifty_e_ts = ninetyfifty_temp_e;
moments.ninetyfivefifty_e_ts = ninetyfivefifty_temp_e;
moments.ninetyninefifty_e_ts = ninetyninefifty_temp_e;
moments.ninetynineone_e_ts = ninetynineone_temp_e;
moments.fiftyten_e_ts = fiftyten_temp_e;
moments.fiftytwentyfive_e_ts = fiftytwentyfive_temp_e;
moments.fiftyone_e_ts = fiftyone_temp_e;
moments.twentyfiveone_e_ts = twentyfiveone_temp_e;


%moments.gini_tsold=gini_tempold;
moments.gini_corr_y_log=corr(log(y(burnin+1:end)'),log(gini_temp(1:end)));
moments.gini_corr_k_log=corr(log(kmts(burnin+1:end)'),log(gini_temp(1:end)));

TS.k=kmts;
TS.c=cmts;
TS.y=y;
TS.inv=invest;
TS.gini=gini_temp;
clear *_temp 
% kcross_vec = reshape(kcross(:,burnin+1:end),[],1);
% moments.gini = gini(kcross_vec,weight_net(:));
% moments.ninetyten = wprctile(kcross_vec,90,weight_net(:))/prctile(kcross_vec,10,weight_net(:));
% moments.ninetynineone = prctile(kcross_vec,99,weight_net(:))/prctile(kcross_vec,1,weight_net(:));
% clear kcross_vec
end