% Table cxi
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));
addpath(fullfile(scriptDir, '_aux'));

nn          = 3; 

%% [1] Load and Store Moments
load('model_7009_decomp.mat');         

moments_ii.gini            = moments.gini; 
moments_ii.ninetyten       = moments.ninetyten; 
moments_ii.ninetynineone   = moments.ninetynineone;
moments_ii.gini_corr_y_log = moments.gini_corr_y_log;
moments_ii.gini_corr_k_log = moments.gini_corr_k_log;

clearvars -except moments_ii nn 

load('model_7009_fi.mat');         %full information 
moments_fi.gini            = moments.gini; 
moments_fi.ninetyten       = moments.ninetyten; 
moments_fi.ninetynineone   = moments.ninetynineone;
moments_fi.gini_corr_y_log = moments.gini_corr_y_log;
moments_fi.gini_corr_k_log = moments.gini_corr_k_log;

clearvars -except moments_ii moments_fi nn

load('model_7009_decomp.mat'); %full information w/ baseline lom
moments_fi_lom.gini            = moments_fi2.gini; 
moments_fi_lom.ninetyten       = moments_fi2.ninetyten; 
moments_fi_lom.ninetynineone   = moments_fi2.ninetynineone;
moments_fi_lom.gini_corr_y_log = moments_fi2.gini_corr_y_log;
moments_fi_lom.gini_corr_k_log = moments_fi2.gini_corr_k_log;

clearvars -except nn moments_ii moments_fi moments_fi_lom


load('model_7009_decomp.mat'); %exogenous information w/ baseline lom
moments_ex_lom.gini            = moments_exo.gini; 
moments_ex_lom.ninetyten       = moments_exo.ninetyten; 
moments_ex_lom.ninetynineone   = moments_exo.ninetynineone;
moments_ex_lom.gini_corr_y_log = moments_exo.gini_corr_y_log;
moments_ex_lom.gini_corr_k_log = moments_exo.gini_corr_k_log;


%% [2] Derive Numbers

benchmark_full_info = 100.*[moments_ii.gini/moments_fi.gini-1; moments_ii.ninetyten/moments_fi.ninetyten-1; moments_ii.ninetynineone/moments_fi.ninetynineone-1; moments_ii.gini_corr_y_log/moments_fi.gini_corr_y_log-1; moments_ii.gini_corr_k_log/moments_fi.gini_corr_k_log-1];

ge                  = 100.*[moments_fi_lom.gini/moments_fi.gini-1; moments_fi_lom.ninetyten/moments_fi.ninetyten-1; moments_fi_lom.ninetynineone/moments_fi.ninetynineone-1; moments_fi_lom.gini_corr_y_log/moments_fi.gini_corr_y_log-1; moments_fi_lom.gini_corr_k_log/moments_fi.gini_corr_k_log-1];

info                = 100.*[moments_ex_lom.gini/moments_fi_lom.gini-1; moments_ex_lom.ninetyten/moments_fi_lom.ninetyten-1; moments_ex_lom.ninetynineone/moments_fi_lom.ninetynineone-1; moments_ex_lom.gini_corr_y_log/moments_fi_lom.gini_corr_y_log-1; moments_ex_lom.gini_corr_k_log/moments_fi_lom.gini_corr_k_log-1];

het                 = 100.*[moments_ii.gini/moments_ex_lom.gini-1; moments_ii.ninetyten/moments_ex_lom.ninetyten-1; moments_ii.ninetynineone/moments_ex_lom.ninetynineone-1; moments_ii.gini_corr_y_log/moments_ex_lom.gini_corr_y_log-1; moments_ii.gini_corr_k_log/moments_ex_lom.gini_corr_k_log-1];


LastName         = ["Gini";"90/10";"99/1"; "corr-g-y"; "corr-g-k"];
Overall          = benchmark_full_info;
General_eq       = ge;
Incomplete_info  = info;
Het_info         = het;
Interaction      = benchmark_full_info-ge-info-het;

Decomposition = table(LastName,Overall,General_eq,Incomplete_info,Het_info, Interaction);

scriptDir = fileparts(mfilename('fullpath'));
if isempty(scriptDir)
    scriptDir = pwd;   % fallback when not running from a saved .m file
end

outDir = fullfile(scriptDir, '_table');
if ~exist(outDir, 'dir')
    mkdir(outDir);
end


writetable(Decomposition(1,:), fullfile(outDir, 'table_cxi.txt'), 'Delimiter', '\t');

