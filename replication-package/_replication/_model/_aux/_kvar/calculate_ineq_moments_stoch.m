function [moments] = calculate_ineq_moments_stoch(kmts,kcross,agshock,params)
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



a         = params.z;
ur_b      = params.u(1);
ur_g      = params.u(2);
alpha     = params.alpha;
delta     = params.delta;
burnin    = params.drop;
weight    = ones(params.N,1)/params.N; %weight of the beta in case we have heterogeneity
nu        = params.nu;



% %aggregate capital
% moments.kbar_log_mean = mean(log(kmts(burnin+1:end)));
% moments.kbar_log_stdev = std(log(kmts(burnin+1:end)));
% moments.kbar_dlog_stdev = std(log(kmts(burnin+1:end))-log(kmts(burnin:end-1)));
% moments.kbar_mean = mean(kmts(burnin+1:end));
% moments.kbar_stdev = std(kmts(burnin+1:end));
% moments.kbar_stdev = std(log(kmts(burnin+2:end))-log(kmts(burnin+1:end-1)));
% [trend,cycle]=hpfilter(log(kmts(burnin+1:end))); %default is 1600
% moments.kbar_hplog_stdev = std(cycle(1:end)); clear trend cycle
% %investment
% invest = [kmts(2:end) kmts(end)]-(1-delta)*kmts(1:end);
% 
% moments.inv_log_mean = mean(log(invest));
% moments.inv_log_stdev = std(log(invest));
% moments.inv_dlog_mean = mean(log(invest(2:end))-log(invest(1:end-1)));
% moments.inv_dlog_stdev = std(log(invest(2:end))-log(invest(1:end-1)));
% [trend,cycle]=hpfilter(log(invest));
% moments.inv_hplog_stdev = std(cycle(1:end)); clear trend cycle
% moments.inv_mean = mean(invest);
% moments.inv_stdev = std(invest);

T = length(kmts);

%output
prod_ag = (agshock==1)*a(1) + (agshock==2)*a(2);
labor_ag = (agshock==1)*(1-ur_b) + (agshock==2)*(1-ur_g);
y=prod_ag'.*kmts.^alpha.*labor_ag'.^(1-alpha);
unemp = params.u(agshock);
moments.y = y;
moments.y_log_mean = mean(log(y(burnin+1:end)));
moments.y_log_stdev = std(log(y(burnin+1:end)));
moments.y_dlog_mean = mean(log(y(burnin+2:end))-log(y(burnin+1:end-1)));
moments.y_dlog_stdev = std(log(y(burnin+2:end))-log(y(burnin+1:end-1)));
[y_trend,y_cycle]=hpfilter(log(y(burnin+1:end)));
moments.y_hplog_stdev = std(y_cycle(1:end)); 
moments.y_mean = mean(y(burnin+1:end));
moments.y_stdev = std(y(burnin+1:end));

moments.u_log_stdev = std(log(unemp(burnin+1:end)));
[u_trend,u_cycle]=hpfilter(log(unemp(burnin+1:end)));
moments.u_hplog_stdev = std(u_cycle(1:end)); 

% moments.kyrat = mean(kmts(burnin+1:end)./y(burnin+1:end));


%aggregate consumption
% ccross = xcross(:,1:end-1)-kcross(:,2:end)-nu*ind_info(:,1:end-1);
% cmts = weight'*ccross;
%cmtsalt=y(1:end-1)-kmts(2:end);

% moments.c_log_mean = mean(log(cmts(burnin+1:end)));
% moments.c_log_stdev = std(log(cmts(burnin+1:end)));
% moments.c_dlog_mean = mean(log(cmts(burnin+2:end))-log(cmts(burnin+1:end-1)));
% moments.c_dlog_stdev = std(log(cmts(burnin+2:end))-log(cmts(burnin+1:end-1)));
% [trend,cycle]=hpfilter(log(cmts(burnin+1:end)));
% moments.c_hplog_stdev = std(cycle(1:end)); clear trend cycle
% moments.c_mean = mean(cmts(burnin+1:end));
% moments.c_stdev = std(cmts(burnin+1:end));
% 
% moments.c_corr_y_log=corr(log(y(burnin+1:end-1)'),log(cmts(burnin+1:end)'));
% moments.k_corr_y_log=corr(log(y(burnin+1:end)'),log(kmts(burnin+1:end)'));
% moments.inv_corr_y_log=corr(log(y(burnin+1:end)'),log(invest(burnin+1:end)'));

clear  ccross  prod_ag labor_ag 

%info acquisition

%wealth inequality
bottom_fifty_share = NaN(T-burnin,1);
top_one_share = NaN(T-burnin,1);
top_ten_share = NaN(T-burnin,1);
ninety_nine_share = NaN(T-burnin,1);
fifty_ninety_share = NaN(T-burnin,1);
gini = NaN(T-burnin,1);

N=length(kcross(:,1));
for i=1:T-burnin
    
    [W, I]=sort(kcross(:,i));

    cumW = cumsum(W);
    top_one_share(i) = 100*(cumW(end)-cumW(0.99*N))/cumW(end);
    top_ten_share(i) = 100*(cumW(end)-cumW(0.9*N))/cumW(end);
    ninety_nine_share(i) = 100*(cumW(0.99*N)-cumW(0.9*N))/cumW(end);
    fifty_ninety_share(i) = 100*(cumW(0.9*N)-cumW(0.5*N))/cumW(end);
    bottom_fifty_share(i) = 100*(cumW(0.5*N))/cumW(end);
    gini(i)=1-2*sum(cumsum(W)/sum(W))/N;



end

moments.gini = mean(gini);
moments.top_one_share = mean(top_one_share(1:end));
moments.top_ten_share = mean(top_ten_share(1:end));
moments.ninety_nine_share = mean(ninety_nine_share(1:end));
moments.fifty_ninety_share = mean(fifty_ninety_share(1:end));
moments.bottom_fifty_share = mean(bottom_fifty_share(1:end));


[top_one_trend,top_one_cycle]=hpfilter(top_one_share(1:end));
[top_ten_trend,top_ten_cycle]=hpfilter(top_ten_share(1:end));
[ninety_nine_trend,ninety_nine_cycle]=hpfilter(ninety_nine_share(1:end));
[fifty_ninety_trend,fifty_ninety_cycle]=hpfilter(fifty_ninety_share(1:end));
[bottom_fifty_trend,bottom_fifty_cycle]=hpfilter(bottom_fifty_share(1:end));
[gini_trend,gini_cycle]=hpfilter(gini);

moments.std_top_one_share = std(top_one_share(1:end));
moments.std_top_ten_share = std(top_ten_share(1:end));
moments.std_ninety_nine_share = std(ninety_nine_share(1:end));
moments.std_fifty_ninety_share = std(fifty_ninety_share(1:end));
moments.std_bottom_fifty_share = std(bottom_fifty_share(1:end));

moments.std_top_one_share_c = std(top_one_cycle(1:end))/moments.y_hplog_stdev;
moments.std_top_ten_share_c = std(top_ten_cycle(1:end))/moments.y_hplog_stdev;
moments.std_fifty_ninety_share_c = std(fifty_ninety_cycle(1:end))/moments.y_hplog_stdev;
moments.std_bottom_fifty_share_c = std(bottom_fifty_cycle(1:end))/moments.y_hplog_stdev;

moments.std_table = [std(top_one_share(1:end));std(top_ten_share(1:end));std(ninety_nine_share(1:end));std(fifty_ninety_share(1:end));std(bottom_fifty_share(1:end))]/moments.y_log_stdev;
moments.std_table_c = [std(top_one_cycle(1:end));std(top_ten_cycle(1:end));std(ninety_nine_cycle(1:end));std(fifty_ninety_cycle(1:end));std(bottom_fifty_cycle(1:end))]/moments.y_hplog_stdev;
moments.ustd_table = [std(top_one_share(1:end));std(top_ten_share(1:end));std(ninety_nine_share(1:end));std(fifty_ninety_share(1:end));std(bottom_fifty_share(1:end))]/moments.u_log_stdev;
moments.ustd_table_c = [std(top_one_cycle(1:end));std(top_ten_cycle(1:end));std(ninety_nine_cycle(1:end));std(fifty_ninety_cycle(1:end));std(bottom_fifty_cycle(1:end))]/moments.u_hplog_stdev;

moments.means_table=[moments.top_one_share;moments.top_ten_share;moments.ninety_nine_share;moments.fifty_ninety_share;moments.bottom_fifty_share];


ineq_corr_table=corr([y_cycle top_one_cycle top_ten_cycle ninety_nine_cycle fifty_ninety_cycle bottom_fifty_cycle gini_cycle]);
ineq_corr_table_lev=corr([(log(y(burnin+1:end))') (top_one_share) top_ten_share ninety_nine_share (fifty_ninety_share) (bottom_fifty_share) (gini)]);
ineq_corr_table_fd=corr([diff(log(y(burnin+1:end))') diff(top_one_share) diff(top_ten_share) diff(ninety_nine_share) diff(fifty_ninety_share) diff(bottom_fifty_share) diff(gini)]);

ineq_corru_table=corr([u_cycle top_one_cycle top_ten_cycle ninety_nine_cycle fifty_ninety_cycle bottom_fifty_cycle gini_cycle]);
ineq_corru_table_lev=corr([(log(unemp(burnin+1:end))') (top_one_share) top_ten_share ninety_nine_share (fifty_ninety_share) (bottom_fifty_share) (gini)]);
ineq_corru_table_fd=corr([diff(log(unemp(burnin+1:end))') diff(top_one_share) diff(top_ten_share) diff(ninety_nine_share) diff(fifty_ninety_share) diff(bottom_fifty_share) diff(gini)]);

moments.ineq_corr_table = ineq_corr_table;
moments.ineq_corr_table_lev = ineq_corr_table_lev;
moments.ineq_corr_table_fd = ineq_corr_table_fd;

moments.ineq_corru_table = ineq_corru_table;
moments.ineq_corru_table_lev = ineq_corru_table_lev;
moments.ineq_corru_table_fd = ineq_corru_table_fd;


acf = autocorr(y_cycle);
moments.acy = acf(2);
acf = autocorr(u_cycle);
moments.acu = acf(2);
acf = autocorr(top_one_cycle);
moments.actop1 = acf(2);
acf = autocorr(top_ten_cycle);
moments.actop10 = acf(2);
acf = autocorr(ninety_nine_cycle);
moments.ac9099 = acf(2);
acf = autocorr(fifty_ninety_cycle);
moments.ac5090 = acf(2);
acf = autocorr(bottom_fifty_cycle);
moments.acb50 = acf(2);
moments.acf_table=[moments.acy;moments.acu;moments.actop1;moments.actop10;moments.ac9099;moments.ac5090;moments.acb50];




end