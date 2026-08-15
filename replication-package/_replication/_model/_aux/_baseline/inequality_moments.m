baseline_model=1;
[SaveDir,CodeDir] = getDirs;
addpath(CodeDir)
lambda = 100;
if(baseline_model==1)

    load([SaveDir 'BKKS_Shadow/_modelresults/model_1001.mat'])
    params.lambda = lambda;
    ineq_moments_bench = calculate_ineq_moments_stoch(Kvec',kdist_panel,zvec,params);
    load([SaveDir 'BKKS_Shadow/_modelresults/model_1023.mat'])
    params.lambda = lambda;
    ineq_moments_FI = calculate_ineq_moments_stoch(Kvec',kdist_panel,zvec,params);
    load([ SaveDir 'BKKS_Shadow/_modelresults/model_1026.mat'])
    params.lambda = lambda;
    ineq_moments_exo = calculate_ineq_moments_stoch(Kvec',kdist_panel,zvec,params);
else
    load("NE3Shocks2.mat",'zvec');
    load([SaveDir 'BKKS_Shadow/_modelresults/entrepreneur/model_98.mat'])
    params.lambda = lambda;
    ineq_moments_bench = calculate_ineq_moments_stoch(Kvec',kdist_panel,zvec,params);
    load([SaveDir 'BKKS_Shadow/_modelresults/entrepreneur/model_96.mat'])
    params.lambda = lambda;
    ineq_moments_FI = calculate_ineq_moments_stoch(Kvec',kdist_panel,zvec,params);
    load([ SaveDir 'BKKS_Shadow/_modelresults/entrepreneur/model_97.mat'])
    params.lambda = lambda;
    ineq_moments_exo = calculate_ineq_moments_stoch(Kvec',kdist_panel,zvec,params);
end

%%
rel_moments=zeros(5,4);
rel_moments_c=zeros(5,4);
relu_moments=zeros(5,4);
relu_moments_c=zeros(5,4);
mean_moments=zeros(5,4);
acf_moments=zeros(7,4);
corr_moments=zeros(6,4);
corr_moments_lev=zeros(6,4);
corru_moments=zeros(6,4);
corru_moments_lev=zeros(6,4);
% rel_moments(:,2)=[ineq_moments_bench.std_top_one_share/ineq_moments_bench.y_log_stdev
%     ineq_moments_bench.std_fifty_ninety_share/ineq_moments_bench.y_log_stdev
%     ineq_moments_bench.std_bottom_fifty_share/ineq_moments_bench.y_log_stdev];
% 
% 
% rel_moments(:,3)=[ineq_moments_FI.std_top_one_share/ineq_moments_FI.y_log_stdev
%     ineq_moments_FI.std_fifty_ninety_share/ineq_moments_FI.y_log_stdev
%     ineq_moments_FI.std_bottom_fifty_share/ineq_moments_FI.y_log_stdev];
% 
% rel_moments(:,4)=[ineq_moments_exo.std_top_one_share/ineq_moments_exo.y_log_stdev
%     ineq_moments_exo.std_fifty_ninety_share/ineq_moments_exo.y_log_stdev
%     ineq_moments_exo.std_bottom_fifty_share/ineq_moments_exo.y_log_stdev];

% rel_moments(:,1)=[0.38;0.41;0.23;0.11;0.40]*100;
% rel_moments(:,2)=ineq_moments_bench.std_table;
% rel_moments(:,3)=ineq_moments_FI.std_table;
% rel_moments(:,4)=ineq_moments_exo.std_table;
% 
% rel_moments_c(:,1)=[0.38;0.41;0.23;0.11;0.40]*100;
% rel_moments_c(:,2)=ineq_moments_bench.std_table_c;
% rel_moments_c(:,3)=ineq_moments_FI.std_table_c;
% rel_moments_c(:,4)=ineq_moments_exo.std_table_c;
% 
% relu_moments(:,1)=[2.96;3.15;1.78;0.86;3.12];
% relu_moments(:,2)=ineq_moments_bench.ustd_table;
% relu_moments(:,3)=ineq_moments_FI.ustd_table;
% relu_moments(:,4)=ineq_moments_exo.ustd_table;
% 
% relu_moments_c(:,1)=[2.96;3.15;1.78;0.86;3.12];
% relu_moments_c(:,2)=ineq_moments_bench.ustd_table_c;
% relu_moments_c(:,3)=ineq_moments_FI.ustd_table_c;
% relu_moments_c(:,4)=ineq_moments_exo.ustd_table_c;
% 
% mean_moments(:,1)=[27.85;65.3;37.4;32.46;2.3];
% mean_moments(:,2)=ineq_moments_bench.means_table;
% mean_moments(:,3)=ineq_moments_FI.means_table;
% mean_moments(:,4)=ineq_moments_exo.means_table;
% 
% acf_moments(:,1)=[0.617;0.732;0.782;0.761;0.917;0.792;0.789];
% acf_moments(:,2)=ineq_moments_bench.acf_table;
% acf_moments(:,3)=ineq_moments_FI.acf_table;
% acf_moments(:,4)=ineq_moments_exo.acf_table;
% 
% corr_moments(1:5,1)=[0.558;0.521;-0.005;-0.605;0.227];
% corr_moments(:,2)=ineq_moments_bench.ineq_corr_table(2:7,1);
% corr_moments(:,3)=ineq_moments_FI.ineq_corr_table(2:7,1);
% corr_moments(:,4)=ineq_moments_exo.ineq_corr_table(2:7,1);
% 
% corr_moments_lev(1:5,1)=[0.558;0.521;-0.005;-0.605;0.227];
% corr_moments_lev(:,2)=ineq_moments_bench.ineq_corr_table_lev(2:7,1);
% corr_moments_lev(:,3)=ineq_moments_FI.ineq_corr_table_lev(2:7,1);
% corr_moments_lev(:,4)=ineq_moments_exo.ineq_corr_table_lev(2:7,1);
% 
% 
% corru_moments(1:5,1)=[-0.376;-0.292;0.108;-0.21;0.353];
% corru_moments(:,2)=ineq_moments_bench.ineq_corru_table(2:7,1);
% corru_moments(:,3)=ineq_moments_FI.ineq_corru_table(2:7,1);
% corru_moments(:,4)=ineq_moments_exo.ineq_corru_table(2:7,1);
% 
% corru_moments_lev(1:5,1)=[-0.376;-0.292;0.108;-0.21;0.353];
% corru_moments_lev(:,2)=ineq_moments_bench.ineq_corru_table_lev(2:7,1);
% corru_moments_lev(:,3)=ineq_moments_FI.ineq_corru_table_lev(2:7,1);
% corru_moments_lev(:,4)=ineq_moments_exo.ineq_corru_table_lev(2:7,1);

%%
% ---------------------------------------------------------
% Define common names
% ---------------------------------------------------------
varNames    = {'Data','Bench','FI','Exo'};
rowNames5   = {'Top 1 Share','Top 10 Share','99 Share','50-90 Share','Bottom 50 Share'};
rowNames6   = {'Top 1 Share','Top 10 Share','99 Share','50-90 Share','Bottom 50 Share','Gini'};
rowNamesACF = {'Lag 1','Lag 2','Lag 3','Lag 4','Lag 5','Lag 6','Lag 7'};

% ---------------------------------------------------------
% 1) rel_moments
% ---------------------------------------------------------
rel_momentsT = table( ...
    [0.38;0.41;0.23;0.11;0.40]*100, ...
    ineq_moments_bench.std_table, ...
    ineq_moments_FI.std_table, ...
    ineq_moments_exo.std_table );
rel_momentsT.Properties.VariableNames = varNames;
rel_momentsT.Properties.RowNames      = rowNames5;

% ---------------------------------------------------------
% 2) rel_moments_c
% ---------------------------------------------------------
rel_moments_cT = table( ...
    [0.38;0.41;0.23;0.11;0.40]*100, ...
    ineq_moments_bench.std_table_c, ...
    ineq_moments_FI.std_table_c, ...
    ineq_moments_exo.std_table_c );
rel_moments_cT.Properties.VariableNames = varNames;
rel_moments_cT.Properties.RowNames      = rowNames5;

% ---------------------------------------------------------
% 3) relu_moments
% ---------------------------------------------------------
relu_momentsT = table( ...
    [2.96;3.15;1.78;0.86;3.12], ...
    ineq_moments_bench.ustd_table, ...
    ineq_moments_FI.ustd_table, ...
    ineq_moments_exo.ustd_table );
relu_momentsT.Properties.VariableNames = varNames;
relu_momentsT.Properties.RowNames      = rowNames5;

% ---------------------------------------------------------
% 4) relu_moments_c
% ---------------------------------------------------------
relu_moments_cT = table( ...
    [2.96;3.15;1.78;0.86;3.12], ...
    ineq_moments_bench.ustd_table_c, ...
    ineq_moments_FI.ustd_table_c, ...
    ineq_moments_exo.ustd_table_c );
relu_moments_cT.Properties.VariableNames = varNames;
relu_moments_cT.Properties.RowNames      = rowNames5;

% ---------------------------------------------------------
% 5) mean_moments
% ---------------------------------------------------------
mean_momentsT = table( ...
    [27.85;65.3;37.4;32.46;2.3], ...
    ineq_moments_bench.means_table, ...
    ineq_moments_FI.means_table, ...
    ineq_moments_exo.means_table );
mean_momentsT.Properties.VariableNames = varNames;
mean_momentsT.Properties.RowNames      = rowNames5;

% ---------------------------------------------------------
% 6) acf_moments (7 lags)
% ---------------------------------------------------------
acf_momentsT = table( ...
    [0.617;0.732;0.782;0.761;0.917;0.792;0.789], ...
    ineq_moments_bench.acf_table, ...
    ineq_moments_FI.acf_table, ...
    ineq_moments_exo.acf_table );
acf_momentsT.Properties.VariableNames = varNames;
acf_momentsT.Properties.RowNames      = rowNamesACF;

% ---------------------------------------------------------
% 7) corr_moments
% ---------------------------------------------------------
corr_momentsT = table( ...
    [0.558;0.521;-0.005;-0.605;0.227;0], ...
    ineq_moments_bench.ineq_corr_table(2:7,1), ...
    ineq_moments_FI.ineq_corr_table(2:7,1), ...
    ineq_moments_exo.ineq_corr_table(2:7,1) );
corr_momentsT.Properties.VariableNames = varNames;
corr_momentsT.Properties.RowNames      = rowNames6;

% ---------------------------------------------------------
% 8) corr_moments_lev
% ---------------------------------------------------------
corr_moments_levT = table( ...
    [0.558;0.521;-0.005;-0.605;0.227;0], ...
    ineq_moments_bench.ineq_corr_table_lev(2:7,1), ...
    ineq_moments_FI.ineq_corr_table_lev(2:7,1), ...
    ineq_moments_exo.ineq_corr_table_lev(2:7,1) );
corr_moments_levT.Properties.VariableNames = varNames;
corr_moments_levT.Properties.RowNames      = rowNames6;

% ---------------------------------------------------------
% 9) corru_moments
% ---------------------------------------------------------
corru_momentsT = table( ...
    [-0.376;-0.292;0.108;-0.21;0.353;0], ...
    ineq_moments_bench.ineq_corru_table(2:7,1), ...
    ineq_moments_FI.ineq_corru_table(2:7,1), ...
    ineq_moments_exo.ineq_corru_table(2:7,1) );
corru_momentsT.Properties.VariableNames = varNames;
corru_momentsT.Properties.RowNames      = rowNames6;

% ---------------------------------------------------------
% 10) corru_moments_lev
% ---------------------------------------------------------
corru_moments_levT = table( ...
    [-0.376;-0.292;0.108;-0.21;0.353;0], ...
    ineq_moments_bench.ineq_corru_table_lev(2:7,1), ...
    ineq_moments_FI.ineq_corru_table_lev(2:7,1), ...
    ineq_moments_exo.ineq_corru_table_lev(2:7,1) );
corru_moments_levT.Properties.VariableNames = varNames;
corru_moments_levT.Properties.RowNames      = rowNames6;

% ---------------------------------------------------------
% Display all tables
% ---------------------------------------------------------
disp(rel_momentsT)
disp(rel_moments_cT)
disp(relu_momentsT)
disp(relu_moments_cT)
disp(mean_momentsT)
disp(acf_momentsT)
disp(corr_momentsT)
disp(corr_moments_levT)
disp(corru_momentsT)
disp(corru_moments_levT)

if(baseline_model==1)
    cd([SaveDir 'BKKS_Shadow/_modelresults/']);

else
    cd([SaveDir 'BKKS_Shadow/_modelresults/entrepreneur/']);
end
table2latex(rel_momentsT,       'rel_momentsT.tex');
table2latex(rel_moments_cT,     'rel_moments_cT.tex');
table2latex(relu_momentsT,      'relu_momentsT.tex');
table2latex(relu_moments_cT,    'relu_moments_cT.tex');
table2latex(mean_momentsT,      'mean_momentsT.tex');
table2latex(acf_momentsT,       'acf_momentsT.tex');
table2latex(corr_momentsT,      'corr_momentsT.tex');
table2latex(corr_moments_levT,  'corr_moments_levT.tex');
table2latex(corru_momentsT,     'corru_momentsT.tex');
table2latex(corru_moments_levT, 'corru_moments_levT.tex');
cd(CodeDir)
