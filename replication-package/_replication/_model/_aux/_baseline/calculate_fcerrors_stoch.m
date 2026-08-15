function forecast_moments = calculate_fcerrors_stoch(kmts,panel,agshock,params,a0,a1)
% Translate Tobi code to Kurt code
% kmts      = Kvec
% kcross    = kdist
% pcross    = pdist
% kmcross   = pKdist
% ind_info  = info_t
% idshock   = ishocks this is just the emp/unemp dimension
% agshock   = zvec          
% a         = z
% ur_b      = Urec
% ur_g      = Uboom
% alpha     = params.alpha
% l_bar     = params.l_bar
% prob_unc_agg  = params.piz?
% B         = params.a0/params.a1 4x1 int/slope bad int/slope good a0(1)
% a1(1) a0(2) a1(2)
% burnin    = params.drop
% weight    = weight of the beta in case we have heterogeneity

kcross      = panel.kdistT;
pcross      = panel.pdistT;
kmcross     = panel.pKdistT;
ind_info    = panel.info_acT;


a           = params.z;
ur_b        = params.u(1);
ur_g        = params.u(2);
alpha       = params.alpha;
burnin      = params.drop;
l_bar       = params.lbar;
B           = [a0(1);a1(1);a0(2);a1(2)];
weight      = ones(params.N,1)/params.N; %weight of the beta in case we have heterogeneity
prob_unc_ag = params.piz;

N = size(kcross,1);
T = min(size(kcross,2),10000);
kmts=kmts(1:T);
kcross=kcross(:,1:T);
kmcross=kmcross(:,1:T);
pcross=pcross(:,1:T);
agshock=agshock(1:T);
ind_info=ind_info(1:T);
ur = [ur_b ur_g];

%__________________________________________________________________________
%
% CALCULATE QUINTILES/DECILES (DEFINED SEPARATELY EACH PERIOD)
%__________________________________________________________________________

kquintiles = NaN(N,T);
kdeciles = NaN(N,T);
for t=1:T
    cutoff_quintiles = wprctile(kcross(:,t),(20:20:80),weight);
    cutoff_deciles = wprctile(kcross(:,t),(10:10:90),weight);
    
    kquintiles(:,t) = 1 + double(kcross(:,t)>cutoff_quintiles(1)) + double(kcross(:,t)>cutoff_quintiles(2)) + double(kcross(:,t)>cutoff_quintiles(3)) + double(kcross(:,t)>cutoff_quintiles(4));
    kdeciles(:,t)   = 1 + double(kcross(:,t)>cutoff_deciles(1)) + double(kcross(:,t)>cutoff_deciles(2)) + double(kcross(:,t)>cutoff_deciles(3)) + double(kcross(:,t)>cutoff_deciles(4)) + ...
                      double(kcross(:,t)>cutoff_deciles(5)) + double(kcross(:,t)>cutoff_deciles(6)) + double(kcross(:,t)>cutoff_deciles(7)) + double(kcross(:,t)>cutoff_deciles(8)) + double(kcross(:,t)>cutoff_deciles(9));
end

%__________________________________________________________________________
%
% COMPUTE FORECAST ERRORS
%__________________________________________________________________________

%-------------------------
% REAL INTEREST RATE

%real interest rate: truth 
prod_ag = (agshock==1)*a(1) + (agshock==2)*a(2);
labor_ag = (agshock==1)*(1-ur(1)) + (agshock==2)*(1-ur(2));
irate=alpha*prod_ag'.*(kmts./labor_ag'./l_bar).^(alpha-1);

%real interest rate: 1 quarter ahead 
fc_irate_1q = NaN(N,T);
for t=1:T-1
    fc_irate_1q(:,t) = pcross(:,t+1) .* (alpha*a(2)*(kmcross(:,t+1)/(1-ur(2))/l_bar).^(alpha-1) ) + ...
                       (1-pcross(:,t+1)) .* (alpha*a(1)*(kmcross(:,t+1)/(1-ur(1))/l_bar).^(alpha-1) );
end
fcerror_irate_1q = (fc_irate_1q(:,1:end-1) - repmat(irate(2:end),N,1)) *100;

%real interest rate: 4 quarters ahead 
fc_irate_4q = NaN(N,T);
for t=1:T-4
    fc_irate_4q_temp = NaN(N,2^4);
    weight_temp = NaN(N,2^4);
    icol = 0;
    for i1q=1:2 %state 1q ahead
        p1q = (pcross(:,t+1).*(i1q==2) + (1-pcross(:,t+1)).*(i1q==1));  %subjective probability of landing in state i1q tomorrow
        km2q = (i1q==1)*exp( B(1)+B(2)*log(kmcross(:,t+1)) ) + (i1q==2)*exp( B(3)+B(4)*log(kmcross(:,t+1)) );
        for i2q=1:2 %state 2q ahead (from then onwards use known transition probabilities and LOM)
            p2q = prob_unc_ag(i1q,i2q); 
            km3q = (i2q==1)*exp( B(1)+B(2)*log(km2q) ) + (i2q==2)*exp( B(3)+B(4)*log(km2q) );
            for i3q=1:2 %state 3q ahead
                p3q = prob_unc_ag(i2q,i3q);
                km4q = (i3q==1)*exp( B(1)+B(2)*log(km3q) ) + (i3q==2)*exp( B(3)+B(4)*log(km3q) );
                for i4q=1:2 %state 4q ahead
                    p4q = prob_unc_ag(i3q,i4q);
                    icol = icol+1;
                    weight_temp(:,icol) = p1q*p2q*p3q*p4q;
                    fc_irate_4q_temp(:,icol) = alpha*a(i4q)*(km4q/(1-ur(i4q))/l_bar).^(alpha-1);
                end
            end
        end
    end
    fc_irate_4q(:,t) = sum(weight_temp.*fc_irate_4q_temp,2);
end
fcerror_irate_4q = (fc_irate_1q(:,1:end-4) - repmat(irate(5:end),N,1)) *100;


%-------------------------
% UNEMPLOYMENT RATE UP

%unemployment rate up: truth 
ur_up_1q = (agshock'==2)* prob_unc_ag(2,1); %in recession: zero; in boom: prob of moving to recession

prob_temp = NaN(2^3,T);
irow = 0;
for i1q=1:2 %state 1q ahead
    p1q = (agshock==2) * prob_unc_ag(2,i1q); %note: prob always zero if currently in a recession (UR cannot increase)
    for i2q=1:2 %state 2q ahead (from then onwards use known transition probabilities and LOM)
        p2q = prob_unc_ag(i1q,i2q); 
        for i3q=1:2 %state 3q ahead
            p3q = prob_unc_ag(i2q,i3q);
            p4q = prob_unc_ag(i3q,1); %state 4q ahead: has to be a recession!

            irow = irow+1;
            prob_temp(irow,:) = p1q*p2q*p3q*p4q;
        end
    end
end
ur_up_4q = sum(prob_temp);
clear prob_temp

%unemployment rate up: forecast 1 quarter ahead 
fc_ur_up_1q = ((1-ind_info) .* pcross + ind_info .* (repmat(agshock',N,1)==2)) * prob_unc_ag(2,1); %posterior that we are in a boom now times prob of moving to recession
fcerror_ur_up_1q = 2*(fc_ur_up_1q - repmat(ur_up_1q,N,1)) / mean(ur_up_1q(burnin+1:end)) ;

%unemployment rate up: forecast 4 quarters ahead 
prob_temp = NaN(N,T,2^3);
irow = 0;
for i1q=1:2 %state 1q ahead
    p1q = ((1-ind_info) .* pcross + ind_info .* (repmat(agshock',N,1)==2)) * prob_unc_ag(2,i1q); %note: posterior of being in boom times transition prob
    for i2q=1:2 %state 2q ahead (from then onwards use known transition probabilities and LOM)
        p2q = prob_unc_ag(i1q,i2q); 
        for i3q=1:2 %state 3q ahead
            p3q = prob_unc_ag(i2q,i3q);
            p4q = prob_unc_ag(i3q,1); %state 4q ahead: has to be a recession!

            irow = irow+1;
            prob_temp(:,:,irow) = p1q*p2q*p3q*p4q;
        end
    end
end
fc_ur_up_4q = sum(prob_temp,3);
fcerror_ur_up_4q = 2*(fc_ur_up_4q - repmat(ur_up_4q,N,1)) / mean(ur_up_4q(burnin+1:end)) ;
clear prob_temp

%__________________________________________________________________________
%
% COMPUTE MOMENTS OF FORECAST ERRORS
%__________________________________________________________________________

%---------------------------
%unconditional means:
forecast_moments.fcerror_irate_1q_mean = mean(sum(repmat(weight,1,T-burnin-1).*abs(fcerror_irate_1q(:,burnin+1:end))));
forecast_moments.fcerror_irate_4q_mean = mean(sum(repmat(weight,1,T-burnin-4).*abs(fcerror_irate_4q(:,burnin+1:end))));
forecast_moments.fcerror_ur_up_1q_mean = mean(sum(repmat(weight,1,T-burnin).*abs(fcerror_ur_up_1q(:,burnin+1:end))));
forecast_moments.fcerror_ur_up_4q_mean = mean(sum(repmat(weight,1,T-burnin).*abs(fcerror_ur_up_4q(:,burnin+1:end))));
forecast_moments.fcerror_irate_1q_stdev = std(reshape(abs(fcerror_irate_1q(:,burnin+1:end)),[],1),repmat(weight,T-burnin-1,1));
forecast_moments.fcerror_irate_4q_stdev = std(reshape(abs(fcerror_irate_4q(:,burnin+1:end)),[],1),repmat(weight,T-burnin-4,1));
forecast_moments.fcerror_ur_up_1q_stdev = std(reshape(abs(fcerror_ur_up_1q(:,burnin+1:end)),[],1),repmat(weight,T-burnin,1));
forecast_moments.fcerror_ur_up_4q_stdev = std(reshape(abs(fcerror_ur_up_4q(:,burnin+1:end)),[],1),repmat(weight,T-burnin,1));

%---------------------------
%means by quintile/decile

%irate_1q
kquintiles_net = kquintiles(:,burnin+1:end-1);
kdeciles_net = kdeciles(:,burnin+1:end-1);
fcerror_irate_1q_net = fcerror_irate_1q(:,burnin+1:end);
weight_net = repmat(weight,1,T-burnin-1);
forecast_moments.fcerror_irate_1q_quintiles = NaN(1,5);
for i=1:5 
    forecast_moments.fcerror_irate_1q_quintiles(i) = weight_net(kquintiles_net==i)'*abs(fcerror_irate_1q_net(kquintiles_net==i)) / sum(weight_net(kquintiles_net==i));
end
forecast_moments.fcerror_irate_1q_deciles = NaN(1,10);
for i=1:10 
    forecast_moments.fcerror_irate_1q_deciles(i) = weight_net(kdeciles_net==i)'*abs(fcerror_irate_1q_net(kdeciles_net==i)) / sum(weight_net(kdeciles_net==i));
end
fcerror_irate_1q_net = fcerror_irate_1q_net(:);
kquintiles_net = kquintiles_net(:);
kdeciles_net = kdeciles_net(:);
weights_net = repmat(weight,length(kquintiles_net)/N,1);

forecast_moments.coeffs_irate_1q_quintiles = regress(abs(fcerror_irate_1q_net),[(kquintiles_net==1), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4), ones(length(fcerror_irate_1q_net),1)]);
forecast_moments.coeffs_irate_1q_deciles = regress(abs(fcerror_irate_1q_net),[(kdeciles_net==1), (kdeciles_net==2), (kdeciles_net==3), (kdeciles_net==4), (kdeciles_net==5), (kdeciles_net==6), (kdeciles_net==7), (kdeciles_net==8), (kdeciles_net==9), ones(length(fcerror_irate_1q_net),1)]);
forecast_moments.coeffs_irate_1q_mix = regress(abs(fcerror_irate_1q_net),[(kdeciles_net==1), (kdeciles_net==2), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4), ones(length(fcerror_irate_1q_net),1)]);

tempresult = fitlm([(kquintiles_net==1), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4)],abs(fcerror_irate_1q_net),'Weights',weights_net);
forecast_moments.coeffs_weighted_irate_1q_quintiles = tempresult.Coefficients; 
tempresult = fitlm([(kdeciles_net==1), (kdeciles_net==2), (kdeciles_net==3), (kdeciles_net==4), (kdeciles_net==5), (kdeciles_net==6), (kdeciles_net==7), (kdeciles_net==8), (kdeciles_net==9)],abs(fcerror_irate_1q_net),'Weights',weights_net);
forecast_moments.coeffs_weighted_irate_1q_deciles = tempresult.Coefficients;
tempresult = fitlm([(kdeciles_net==1), (kdeciles_net==2), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4)],abs(fcerror_irate_1q_net),'Weights',weights_net);
forecast_moments.coeffs_weighted_irate_1q_mix = tempresult.Coefficients; 

clear *_net

%irate_4q
kquintiles_net = kquintiles(:,burnin+1:end-4);
kdeciles_net = kdeciles(:,burnin+1:end-4);
fcerror_irate_4q_net = fcerror_irate_4q(:,burnin+1:end);
weight_net = repmat(weight,1,T-burnin-4);
forecast_moments.fcerror_irate_4q_quintiles = NaN(1,5);
for i=1:5 
    forecast_moments.fcerror_irate_4q_quintiles(i) = weight_net(kquintiles_net==i)'*abs(fcerror_irate_4q_net(kquintiles_net==i)) / sum(weight_net(kquintiles_net==i));
end
forecast_moments.fcerror_irate_4q_deciles = NaN(1,10);
for i=1:10 
    forecast_moments.fcerror_irate_4q_deciles(i) = weight_net(kdeciles_net==i)'*abs(fcerror_irate_4q_net(kdeciles_net==i)) / sum(weight_net(kdeciles_net==i));
end
fcerror_irate_4q_net = fcerror_irate_4q_net(:);
kquintiles_net = kquintiles_net(:);
kdeciles_net = kdeciles_net(:);
weights_net = repmat(weight,length(kquintiles_net)/N,1);

forecast_moments.coeffs_irate_4q_quintiles = regress(abs(fcerror_irate_4q_net),[(kquintiles_net==1), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4), ones(length(fcerror_irate_4q_net),1)]);
forecast_moments.coeffs_irate_4q_deciles = regress(abs(fcerror_irate_4q_net),[(kdeciles_net==1), (kdeciles_net==2), (kdeciles_net==3), (kdeciles_net==4), (kdeciles_net==5), (kdeciles_net==6), (kdeciles_net==7), (kdeciles_net==8), (kdeciles_net==9), ones(length(fcerror_irate_4q_net),1)]);
forecast_moments.coeffs_irate_4q_mix = regress(abs(fcerror_irate_4q_net),[(kdeciles_net==1), (kdeciles_net==2), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4), ones(length(fcerror_irate_4q_net),1)]);

tempresult = fitlm([(kquintiles_net==1), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4)],abs(fcerror_irate_4q_net),'Weights',weights_net);
forecast_moments.coeffs_weighted_irate_4q_quintiles = tempresult.Coefficients; 
tempresult = fitlm([(kdeciles_net==1), (kdeciles_net==2), (kdeciles_net==3), (kdeciles_net==4), (kdeciles_net==5), (kdeciles_net==6), (kdeciles_net==7), (kdeciles_net==8), (kdeciles_net==9)],abs(fcerror_irate_4q_net),'Weights',weights_net);
forecast_moments.coeffs_weighted_irate_4q_deciles = tempresult.Coefficients;
tempresult = fitlm([(kdeciles_net==1), (kdeciles_net==2), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4)],abs(fcerror_irate_4q_net),'Weights',weights_net);
forecast_moments.coeffs_weighted_irate_4q_mix = tempresult.Coefficients; 

clear *_net

%ur_up_1q & ur_up_4q (same loop since same length or errors)
kquintiles_net = kquintiles(:,burnin+1:end);
kdeciles_net = kdeciles(:,burnin+1:end);
fcerror_ur_up_1q_net = fcerror_ur_up_1q(:,burnin+1:end);
fcerror_ur_up_4q_net = fcerror_ur_up_4q(:,burnin+1:end);
weight_net = repmat(weight,1,T-burnin);
forecast_moments.fcerror_ur_up_1q_quintiles = NaN(1,5);
forecast_moments.fcerror_ur_up_4q_quintiles = NaN(1,5);
for i=1:5 
    forecast_moments.fcerror_ur_up_1q_quintiles(i) = weight_net(kquintiles_net==i)'*abs(fcerror_ur_up_1q_net(kquintiles_net==i)) / sum(weight_net(kquintiles_net==i));
    forecast_moments.fcerror_ur_up_4q_quintiles(i) = weight_net(kquintiles_net==i)'*abs(fcerror_ur_up_4q_net(kquintiles_net==i)) / sum(weight_net(kquintiles_net==i));
end
forecast_moments.fcerror_ur_up_1q_deciles = NaN(1,10);
forecast_moments.fcerror_ur_up_4q_deciles = NaN(1,10);
for i=1:10 
    forecast_moments.fcerror_ur_up_1q_deciles(i) = weight_net(kdeciles_net==i)'*abs(fcerror_ur_up_1q_net(kdeciles_net==i)) / sum(weight_net(kdeciles_net==i));
    forecast_moments.fcerror_ur_up_4q_deciles(i) = weight_net(kdeciles_net==i)'*abs(fcerror_ur_up_4q_net(kdeciles_net==i)) / sum(weight_net(kdeciles_net==i));
end
fcerror_ur_up_1q_net = fcerror_ur_up_1q_net(:);
fcerror_ur_up_4q_net = fcerror_ur_up_4q_net(:);
kquintiles_net = kquintiles_net(:);
kdeciles_net = kdeciles_net(:);
weights_net = repmat(weight,length(kquintiles_net)/N,1);
forecast_moments.coeffs_ur_up_1q_quintiles = regress(abs(fcerror_ur_up_1q_net),[(kquintiles_net==1), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4), ones(length(fcerror_ur_up_1q_net),1)]);
forecast_moments.coeffs_ur_up_1q_deciles = regress(abs(fcerror_ur_up_1q_net),[(kdeciles_net==1), (kdeciles_net==2), (kdeciles_net==3), (kdeciles_net==4), (kdeciles_net==5), (kdeciles_net==6), (kdeciles_net==7), (kdeciles_net==8), (kdeciles_net==9), ones(length(fcerror_ur_up_1q_net),1)]);
forecast_moments.coeffs_ur_up_1q_mix = regress(abs(fcerror_ur_up_1q_net),[(kdeciles_net==1), (kdeciles_net==2), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4), ones(length(fcerror_ur_up_1q_net),1)]);
forecast_moments.coeffs_ur_up_4q_quintiles = regress(abs(fcerror_ur_up_4q_net),[(kquintiles_net==1), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4), ones(length(fcerror_ur_up_4q_net),1)]);
forecast_moments.coeffs_ur_up_4q_deciles = regress(abs(fcerror_ur_up_4q_net),[(kdeciles_net==1), (kdeciles_net==2), (kdeciles_net==3), (kdeciles_net==4), (kdeciles_net==5), (kdeciles_net==6), (kdeciles_net==7), (kdeciles_net==8), (kdeciles_net==9), ones(length(fcerror_ur_up_4q_net),1)]);
forecast_moments.coeffs_ur_up_4q_mix = regress(abs(fcerror_ur_up_4q_net),[(kdeciles_net==1), (kdeciles_net==2), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4), ones(length(fcerror_ur_up_4q_net),1)]);

tempresult = fitlm([(kquintiles_net==1), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4)],abs(fcerror_ur_up_1q_net),'Weights',weights_net);
forecast_moments.coeffs_weighted_ur_up_1q_quintiles = tempresult.Coefficients; 
tempresult = fitlm([(kdeciles_net==1), (kdeciles_net==2), (kdeciles_net==3), (kdeciles_net==4), (kdeciles_net==5), (kdeciles_net==6), (kdeciles_net==7), (kdeciles_net==8), (kdeciles_net==9)],abs(fcerror_ur_up_1q_net),'Weights',weights_net);
forecast_moments.coeffs_weighted_ur_up_1q_deciles = tempresult.Coefficients;
tempresult = fitlm([(kdeciles_net==1), (kdeciles_net==2), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4)],abs(fcerror_ur_up_1q_net),'Weights',weights_net);
forecast_moments.coeffs_weighted_ur_up_1q_mix = tempresult.Coefficients; 
tempresult = fitlm([(kquintiles_net==1), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4)],abs(fcerror_ur_up_4q_net),'Weights',weights_net);
forecast_moments.coeffs_weighted_ur_up_4q_quintiles = tempresult.Coefficients;
tempresult = fitlm([(kdeciles_net==1), (kdeciles_net==2), (kdeciles_net==3), (kdeciles_net==4), (kdeciles_net==5), (kdeciles_net==6), (kdeciles_net==7), (kdeciles_net==8), (kdeciles_net==9)],abs(fcerror_ur_up_4q_net),'Weights',weights_net);
forecast_moments.coeffs_weighted_ur_up_4q_deciles = tempresult.Coefficients;
tempresult = fitlm([(kdeciles_net==1), (kdeciles_net==2), (kquintiles_net==2), (kquintiles_net==3), (kquintiles_net==4)],abs(fcerror_ur_up_4q_net),'Weights',weights_net);
forecast_moments.coeffs_weighted_ur_up_4q_mix = tempresult.Coefficients;

%export panel
forecast_moments.fcerror_ur_up_4q_panel = abs(fcerror_ur_up_4q(:,burnin+1:end));

clear *_net tempresult

end