function forecast_moments = calculate_fcerrors_stoch_optimized(kmts,panel,agshock,params,a0,a1)
% Optimized version with lower memory footprint
% Computes summary statistics incrementally rather than storing full N×T matrices

%% Helper function to build design matrices without creating large temporary arrays
    function X = build_design_quintiles(quint_vec)
        % Build quintile dummies (1-4, with 5 as reference)
        n = length(quint_vec);
        X = zeros(n, 5);  % 4 dummies + intercept
        for i = 1:4
            X(:,i) = double(quint_vec == i);
        end
        X(:,5) = 1;  % intercept
    end

    function X = build_design_deciles(dec_vec)
        % Build decile dummies (1-9, with 10 as reference)
        n = length(dec_vec);
        X = zeros(n, 10);  % 9 dummies + intercept
        for i = 1:9
            X(:,i) = double(dec_vec == i);
        end
        X(:,10) = 1;  % intercept
    end

    function X = build_design_mix(dec_vec, quint_vec)
        % Build mixed design: decile 1-2, quintile 2-4
        n = length(dec_vec);
        X = zeros(n, 6);  % 5 dummies + intercept
        X(:,1) = double(dec_vec == 1);
        X(:,2) = double(dec_vec == 2);
        X(:,3) = double(quint_vec == 2);
        X(:,4) = double(quint_vec == 3);
        X(:,5) = double(quint_vec == 4);
        X(:,6) = 1;  % intercept
    end

%% Extract and prepare data
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
weight      = ones(params.N,1)/params.N;
prob_unc_ag = params.piz;

N = size(kcross,1);
T = min(size(kcross,2),10000);
kmts = kmts(1:T);
kcross = kcross(:,1:T);
kmcross = kmcross(:,1:T);
pcross = pcross(:,1:T);
agshock = agshock(1:T);
ind_info = ind_info(1:T);
ur = [ur_b ur_g];

%% Compute truth variables (small memory footprint)
prod_ag = (agshock==1)*a(1) + (agshock==2)*a(2);
labor_ag = (agshock==1)*(1-ur(1)) + (agshock==2)*(1-ur(2));
irate = alpha*prod_ag'.*(kmts./labor_ag'./l_bar).^(alpha-1);

ur_up_1q = (agshock'==2)* prob_unc_ag(2,1);

% Compute ur_up_4q (truth)
prob_temp = zeros(2^3,T);
irow = 0;
for i1q=1:2
    p1q = (agshock==2) * prob_unc_ag(2,i1q);
    for i2q=1:2
        p2q = prob_unc_ag(i1q,i2q); 
        for i3q=1:2
            p3q = prob_unc_ag(i2q,i3q);
            p4q = prob_unc_ag(i3q,1);
            irow = irow+1;
            prob_temp(irow,:) = p1q*p2q*p3q*p4q;
        end
    end
end
ur_up_4q = sum(prob_temp);
clear prob_temp

%% Initialize accumulators for summary statistics
% For unconditional means (no need to store full matrices)
sum_abserror_irate_1q = 0;
sum_abserror_irate_4q = 0;
sum_abserror_ur_up_1q = 0;
sum_abserror_ur_up_4q = 0;

% For quintile/decile means
sum_abserror_irate_1q_quint = zeros(5,1);
sum_weight_irate_1q_quint = zeros(5,1);
sum_abserror_irate_1q_dec = zeros(10,1);
sum_weight_irate_1q_dec = zeros(10,1);

sum_abserror_irate_4q_quint = zeros(5,1);
sum_weight_irate_4q_quint = zeros(5,1);
sum_abserror_irate_4q_dec = zeros(10,1);
sum_weight_irate_4q_dec = zeros(10,1);

sum_abserror_ur_up_1q_quint = zeros(5,1);
sum_weight_ur_up_1q_quint = zeros(5,1);
sum_abserror_ur_up_1q_dec = zeros(10,1);
sum_weight_ur_up_1q_dec = zeros(10,1);

sum_abserror_ur_up_4q_quint = zeros(5,1);
sum_weight_ur_up_4q_quint = zeros(5,1);
sum_abserror_ur_up_4q_dec = zeros(10,1);
sum_weight_ur_up_4q_dec = zeros(10,1);

% For standard deviations, store only post-burnin data
fcerror_irate_1q_all = [];
fcerror_irate_4q_all = [];
fcerror_ur_up_1q_all = [];
fcerror_ur_up_4q_all = [];

% For regressions, need to store quintile/decile assignments and errors
fcerror_irate_1q_reg = [];
kquint_irate_1q_reg = [];
kdec_irate_1q_reg = [];

fcerror_irate_4q_reg = [];
kquint_irate_4q_reg = [];
kdec_irate_4q_reg = [];

fcerror_ur_up_1q_reg = [];
fcerror_ur_up_4q_reg = [];
kquint_ur_up_reg = [];
kdec_ur_up_reg = [];

%% Main computation loop - start at burnin+1 since earlier periods aren't used
fprintf('Processing time periods (starting after burnin)...\n');
for t = burnin+1:T
    if mod(t,1000)==0
        fprintf('  t = %d/%d\n', t, T);
    end
    
    % Compute quintiles and deciles for this period
    cutoff_quintiles = wprctile(kcross(:,t),(20:20:80),weight);
    cutoff_deciles = wprctile(kcross(:,t),(10:10:90),weight);
    
    kquint_t = 1 + double(kcross(:,t)>cutoff_quintiles(1)) + ...
                   double(kcross(:,t)>cutoff_quintiles(2)) + ...
                   double(kcross(:,t)>cutoff_quintiles(3)) + ...
                   double(kcross(:,t)>cutoff_quintiles(4));
    
    kdec_t = 1 + double(kcross(:,t)>cutoff_deciles(1)) + ...
                 double(kcross(:,t)>cutoff_deciles(2)) + ...
                 double(kcross(:,t)>cutoff_deciles(3)) + ...
                 double(kcross(:,t)>cutoff_deciles(4)) + ...
                 double(kcross(:,t)>cutoff_deciles(5)) + ...
                 double(kcross(:,t)>cutoff_deciles(6)) + ...
                 double(kcross(:,t)>cutoff_deciles(7)) + ...
                 double(kcross(:,t)>cutoff_deciles(8)) + ...
                 double(kcross(:,t)>cutoff_deciles(9));
    
    %% Interest rate 1q forecast error
    if t <= T-1
        fc_irate_1q_t = pcross(:,t+1) .* (alpha*a(2)*(kmcross(:,t+1)/(1-ur(2))/l_bar).^(alpha-1)) + ...
                        (1-pcross(:,t+1)) .* (alpha*a(1)*(kmcross(:,t+1)/(1-ur(1))/l_bar).^(alpha-1));
        
        % Store fc_irate_1q for use in 4q error calculation (needed even if t >= T-1)
        if t < T-4
            if t == burnin+1
                fc_irate_1q_stored = NaN(N, T-4-burnin);
            end
            fc_irate_1q_stored(:,t-burnin) = fc_irate_1q_t;
        end
        
        if t < T-1  % Can compute forecast error
            fcerror_irate_1q_t = (fc_irate_1q_t - irate(t+1)) * 100;
            abs_fcerror = abs(fcerror_irate_1q_t);
            
            % Accumulate for unconditional mean
            sum_abserror_irate_1q = sum_abserror_irate_1q + sum(weight .* abs_fcerror);
            
            % Accumulate by quintile
            for q = 1:5
                idx_q = (kquint_t == q);
                sum_abserror_irate_1q_quint(q) = sum_abserror_irate_1q_quint(q) + sum(weight(idx_q) .* abs_fcerror(idx_q));
                sum_weight_irate_1q_quint(q) = sum_weight_irate_1q_quint(q) + sum(weight(idx_q));
            end
            
            % Accumulate by decile
            for d = 1:10
                idx_d = (kdec_t == d);
                sum_abserror_irate_1q_dec(d) = sum_abserror_irate_1q_dec(d) + sum(weight(idx_d) .* abs_fcerror(idx_d));
                sum_weight_irate_1q_dec(d) = sum_weight_irate_1q_dec(d) + sum(weight(idx_d));
            end
            
            % Store for std and regressions
            fcerror_irate_1q_all = [fcerror_irate_1q_all; abs_fcerror];
            fcerror_irate_1q_reg = [fcerror_irate_1q_reg; abs_fcerror];
            kquint_irate_1q_reg = [kquint_irate_1q_reg; kquint_t];
            kdec_irate_1q_reg = [kdec_irate_1q_reg; kdec_t];
        end
    end
    
    %% Interest rate 4q forecast error
    if t <= T-4
        % Compute 4q ahead forecast
        fc_irate_4q_temp = zeros(N,2^4);
        weight_temp = zeros(N,2^4);
        icol = 0;
        for i1q=1:2
            p1q = (pcross(:,t+1).*(i1q==2) + (1-pcross(:,t+1)).*(i1q==1));
            km2q = (i1q==1)*exp(B(1)+B(2)*log(kmcross(:,t+1))) + ...
                   (i1q==2)*exp(B(3)+B(4)*log(kmcross(:,t+1)));
            for i2q=1:2
                p2q = prob_unc_ag(i1q,i2q);
                km3q = (i2q==1)*exp(B(1)+B(2)*log(km2q)) + ...
                       (i2q==2)*exp(B(3)+B(4)*log(km2q));
                for i3q=1:2
                    p3q = prob_unc_ag(i2q,i3q);
                    km4q = (i3q==1)*exp(B(1)+B(2)*log(km3q)) + ...
                           (i3q==2)*exp(B(3)+B(4)*log(km3q));
                    for i4q=1:2
                        p4q = prob_unc_ag(i3q,i4q);
                        icol = icol+1;
                        weight_temp(:,icol) = p1q*p2q*p3q*p4q;
                        fc_irate_4q_temp(:,icol) = alpha*a(i4q)*(km4q/(1-ur(i4q))/l_bar).^(alpha-1);
                    end
                end
            end
        end
        fc_irate_4q_t = sum(weight_temp.*fc_irate_4q_temp,2);
        
        % Note: Original code uses fc_irate_1q here (line 110), not fc_irate_4q
        % This appears to be a bug but we replicate it for consistency
        fcerror_irate_4q_t = (fc_irate_1q_stored(:,t-burnin) - irate(t+4)) * 100;
        abs_fcerror = abs(fcerror_irate_4q_t);
        
        sum_abserror_irate_4q = sum_abserror_irate_4q + sum(weight .* abs_fcerror);
        
        for q = 1:5
            idx_q = (kquint_t == q);
            sum_abserror_irate_4q_quint(q) = sum_abserror_irate_4q_quint(q) + sum(weight(idx_q) .* abs_fcerror(idx_q));
            sum_weight_irate_4q_quint(q) = sum_weight_irate_4q_quint(q) + sum(weight(idx_q));
        end
        
        for d = 1:10
            idx_d = (kdec_t == d);
            sum_abserror_irate_4q_dec(d) = sum_abserror_irate_4q_dec(d) + sum(weight(idx_d) .* abs_fcerror(idx_d));
            sum_weight_irate_4q_dec(d) = sum_weight_irate_4q_dec(d) + sum(weight(idx_d));
        end
        
        fcerror_irate_4q_all = [fcerror_irate_4q_all; abs_fcerror];
        fcerror_irate_4q_reg = [fcerror_irate_4q_reg; abs_fcerror];
        kquint_irate_4q_reg = [kquint_irate_4q_reg; kquint_t];
        kdec_irate_4q_reg = [kdec_irate_4q_reg; kdec_t];
        
        clear fc_irate_4q_temp weight_temp
    end
    
    %% Unemployment rate up 1q forecast error
    % Combine subjective belief (pcross) with information about actual state (ind_info)
    % When ind_info=0: use subjective belief pcross
    % When ind_info=1: use actual state (agshock(t)==2)
    posterior_boom_t = (1-ind_info(t)) * pcross(:,t) + ind_info(t) * (agshock(t)==2);
    fc_ur_up_1q_t = posterior_boom_t * prob_unc_ag(2,1);
    
    fcerror_ur_up_1q_t = 2*(fc_ur_up_1q_t - ur_up_1q(t)) / mean(ur_up_1q(burnin+1:end));
    abs_fcerror = abs(fcerror_ur_up_1q_t);
    
    sum_abserror_ur_up_1q = sum_abserror_ur_up_1q + sum(weight .* abs_fcerror);
    
    for q = 1:5
        idx_q = (kquint_t == q);
        sum_abserror_ur_up_1q_quint(q) = sum_abserror_ur_up_1q_quint(q) + sum(weight(idx_q) .* abs_fcerror(idx_q));
        sum_weight_ur_up_1q_quint(q) = sum_weight_ur_up_1q_quint(q) + sum(weight(idx_q));
    end
    
    for d = 1:10
        idx_d = (kdec_t == d);
        sum_abserror_ur_up_1q_dec(d) = sum_abserror_ur_up_1q_dec(d) + sum(weight(idx_d) .* abs_fcerror(idx_d));
        sum_weight_ur_up_1q_dec(d) = sum_weight_ur_up_1q_dec(d) + sum(weight(idx_d));
    end
    
    fcerror_ur_up_1q_all = [fcerror_ur_up_1q_all; abs_fcerror];
    fcerror_ur_up_1q_reg = [fcerror_ur_up_1q_reg; abs_fcerror];
    kquint_ur_up_reg = [kquint_ur_up_reg; kquint_t];
    kdec_ur_up_reg = [kdec_ur_up_reg; kdec_t];
    
    %% Unemployment rate up 4q forecast error
    posterior_boom_t = (1-ind_info(t)) * pcross(:,t) + ind_info(t) * (agshock(t)==2);
    
    prob_temp = zeros(N,2^3);
    icol = 0;
    for i1q=1:2
        p1q = posterior_boom_t * prob_unc_ag(2,i1q);
        for i2q=1:2
            p2q = prob_unc_ag(i1q,i2q);
            for i3q=1:2
                p3q = prob_unc_ag(i2q,i3q);
                p4q = prob_unc_ag(i3q,1);
                icol = icol+1;
                prob_temp(:,icol) = p1q*p2q*p3q*p4q;
            end
        end
    end
    fc_ur_up_4q_t = sum(prob_temp,2);
    fcerror_ur_up_4q_t = 2*(fc_ur_up_4q_t - ur_up_4q(t)) / mean(ur_up_4q(burnin+1:end));
    abs_fcerror = abs(fcerror_ur_up_4q_t);
    
    sum_abserror_ur_up_4q = sum_abserror_ur_up_4q + sum(weight .* abs_fcerror);
    
    for q = 1:5
        idx_q = (kquint_t == q);
        sum_abserror_ur_up_4q_quint(q) = sum_abserror_ur_up_4q_quint(q) + sum(weight(idx_q) .* abs_fcerror(idx_q));
        sum_weight_ur_up_4q_quint(q) = sum_weight_ur_up_4q_quint(q) + sum(weight(idx_q));
    end
    
    for d = 1:10
        idx_d = (kdec_t == d);
        sum_abserror_ur_up_4q_dec(d) = sum_abserror_ur_up_4q_dec(d) + sum(weight(idx_d) .* abs_fcerror(idx_d));
        sum_weight_ur_up_4q_dec(d) = sum_weight_ur_up_4q_dec(d) + sum(weight(idx_d));
    end
    
    fcerror_ur_up_4q_all = [fcerror_ur_up_4q_all; abs_fcerror];
    fcerror_ur_up_4q_reg = [fcerror_ur_up_4q_reg; abs_fcerror];
    
    clear prob_temp
end

fprintf('Computing final statistics...\n');

%% Compute final unconditional means
forecast_moments.fcerror_irate_1q_mean = sum_abserror_irate_1q / (T-burnin-1);
forecast_moments.fcerror_irate_4q_mean = sum_abserror_irate_4q / (T-burnin-4);
forecast_moments.fcerror_ur_up_1q_mean = sum_abserror_ur_up_1q / (T-burnin);
forecast_moments.fcerror_ur_up_4q_mean = sum_abserror_ur_up_4q / (T-burnin);

%% Compute standard deviations
weights_rep_1q = repmat(weight, length(fcerror_irate_1q_all)/N, 1);
weights_rep_4q = repmat(weight, length(fcerror_irate_4q_all)/N, 1);
weights_rep_ur = repmat(weight, length(fcerror_ur_up_1q_all)/N, 1);

forecast_moments.fcerror_irate_1q_stdev = std(fcerror_irate_1q_all, weights_rep_1q);
forecast_moments.fcerror_irate_4q_stdev = std(fcerror_irate_4q_all, weights_rep_4q);
forecast_moments.fcerror_ur_up_1q_stdev = std(fcerror_ur_up_1q_all, weights_rep_ur);
forecast_moments.fcerror_ur_up_4q_stdev = std(fcerror_ur_up_4q_all, weights_rep_ur);

%% Compute quintile/decile means
forecast_moments.fcerror_irate_1q_quintiles = sum_abserror_irate_1q_quint ./ sum_weight_irate_1q_quint;
forecast_moments.fcerror_irate_1q_deciles = sum_abserror_irate_1q_dec ./ sum_weight_irate_1q_dec;

forecast_moments.fcerror_irate_4q_quintiles = sum_abserror_irate_4q_quint ./ sum_weight_irate_4q_quint;
forecast_moments.fcerror_irate_4q_deciles = sum_abserror_irate_4q_dec ./ sum_weight_irate_4q_dec;

forecast_moments.fcerror_ur_up_1q_quintiles = sum_abserror_ur_up_1q_quint ./ sum_weight_ur_up_1q_quint;
forecast_moments.fcerror_ur_up_1q_deciles = sum_abserror_ur_up_1q_dec ./ sum_weight_ur_up_1q_dec;

forecast_moments.fcerror_ur_up_4q_quintiles = sum_abserror_ur_up_4q_quint ./ sum_weight_ur_up_4q_quint;
forecast_moments.fcerror_ur_up_4q_deciles = sum_abserror_ur_up_4q_dec ./ sum_weight_ur_up_4q_dec;

%% Run regressions - irate 1q
fprintf('Running regressions for irate_1q...\n');
weights_reg = repmat(weight, length(fcerror_irate_1q_reg)/N, 1);

X_quint = build_design_quintiles(kquint_irate_1q_reg);
forecast_moments.coeffs_irate_1q_quintiles = regress(fcerror_irate_1q_reg, X_quint);

X_dec = build_design_deciles(kdec_irate_1q_reg);
forecast_moments.coeffs_irate_1q_deciles = regress(fcerror_irate_1q_reg, X_dec);

X_mix = build_design_mix(kdec_irate_1q_reg, kquint_irate_1q_reg);
forecast_moments.coeffs_irate_1q_mix = regress(fcerror_irate_1q_reg, X_mix);

tempresult = fitlm(X_quint(:,1:end-1), fcerror_irate_1q_reg, 'Weights', weights_reg);
forecast_moments.coeffs_weighted_irate_1q_quintiles = tempresult.Coefficients;

tempresult = fitlm(X_dec(:,1:end-1), fcerror_irate_1q_reg, 'Weights', weights_reg);
forecast_moments.coeffs_weighted_irate_1q_deciles = tempresult.Coefficients;

tempresult = fitlm(X_mix(:,1:end-1), fcerror_irate_1q_reg, 'Weights', weights_reg);
forecast_moments.coeffs_weighted_irate_1q_mix = tempresult.Coefficients;

clear X_quint X_dec X_mix

%% Run regressions - irate 4q
fprintf('Running regressions for irate_4q...\n');
weights_reg = repmat(weight, length(fcerror_irate_4q_reg)/N, 1);

X_quint = build_design_quintiles(kquint_irate_4q_reg);
forecast_moments.coeffs_irate_4q_quintiles = regress(fcerror_irate_4q_reg, X_quint);

X_dec = build_design_deciles(kdec_irate_4q_reg);
forecast_moments.coeffs_irate_4q_deciles = regress(fcerror_irate_4q_reg, X_dec);

X_mix = build_design_mix(kdec_irate_4q_reg, kquint_irate_4q_reg);
forecast_moments.coeffs_irate_4q_mix = regress(fcerror_irate_4q_reg, X_mix);

tempresult = fitlm(X_quint(:,1:end-1), fcerror_irate_4q_reg, 'Weights', weights_reg);
forecast_moments.coeffs_weighted_irate_4q_quintiles = tempresult.Coefficients;

tempresult = fitlm(X_dec(:,1:end-1), fcerror_irate_4q_reg, 'Weights', weights_reg);
forecast_moments.coeffs_weighted_irate_4q_deciles = tempresult.Coefficients;

tempresult = fitlm(X_mix(:,1:end-1), fcerror_irate_4q_reg, 'Weights', weights_reg);
forecast_moments.coeffs_weighted_irate_4q_mix = tempresult.Coefficients;

clear X_quint X_dec X_mix

%% Run regressions - ur_up (both 1q and 4q use same quintiles/deciles)
fprintf('Running regressions for unemployment...\n');
weights_reg = repmat(weight, length(fcerror_ur_up_1q_reg)/N, 1);

X_quint = build_design_quintiles(kquint_ur_up_reg);
X_dec = build_design_deciles(kdec_ur_up_reg);
X_mix = build_design_mix(kdec_ur_up_reg, kquint_ur_up_reg);

% ur_up_1q regressions
forecast_moments.coeffs_ur_up_1q_quintiles = regress(fcerror_ur_up_1q_reg, X_quint);
forecast_moments.coeffs_ur_up_1q_deciles = regress(fcerror_ur_up_1q_reg, X_dec);
forecast_moments.coeffs_ur_up_1q_mix = regress(fcerror_ur_up_1q_reg, X_mix);

tempresult = fitlm(X_quint(:,1:end-1), fcerror_ur_up_1q_reg, 'Weights', weights_reg);
forecast_moments.coeffs_weighted_ur_up_1q_quintiles = tempresult.Coefficients;

tempresult = fitlm(X_dec(:,1:end-1), fcerror_ur_up_1q_reg, 'Weights', weights_reg);
forecast_moments.coeffs_weighted_ur_up_1q_deciles = tempresult.Coefficients;

tempresult = fitlm(X_mix(:,1:end-1), fcerror_ur_up_1q_reg, 'Weights', weights_reg);
forecast_moments.coeffs_weighted_ur_up_1q_mix = tempresult.Coefficients;

% ur_up_4q regressions
forecast_moments.coeffs_ur_up_4q_quintiles = regress(fcerror_ur_up_4q_reg, X_quint);
forecast_moments.coeffs_ur_up_4q_deciles = regress(fcerror_ur_up_4q_reg, X_dec);
forecast_moments.coeffs_ur_up_4q_mix = regress(fcerror_ur_up_4q_reg, X_mix);

tempresult = fitlm(X_quint(:,1:end-1), fcerror_ur_up_4q_reg, 'Weights', weights_reg);
forecast_moments.coeffs_weighted_ur_up_4q_quintiles = tempresult.Coefficients;

tempresult = fitlm(X_dec(:,1:end-1), fcerror_ur_up_4q_reg, 'Weights', weights_reg);
forecast_moments.coeffs_weighted_ur_up_4q_deciles = tempresult.Coefficients;

tempresult = fitlm(X_mix(:,1:end-1), fcerror_ur_up_4q_reg, 'Weights', weights_reg);
forecast_moments.coeffs_weighted_ur_up_4q_mix = tempresult.Coefficients;

clear X_quint X_dec X_mix

%% Optionally save panel of forecast errors
if params.save_panel==1
    forecast_moments.fcerror_ur_up_4q_panel = reshape(fcerror_ur_up_4q_all,N,[]);
end
fprintf('Done!\n');

end
