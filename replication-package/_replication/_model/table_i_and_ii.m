% Table I + II
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));
addpath(fullfile(scriptDir, '_aux'));


%Endogenous      =  fullfile(scriptDir, '_aux/_models/model_1001.mat');
%Full            =  fullfile(scriptDir, '_aux/_models/model_1023.mat');
%Exogenous       =  fullfile(scriptDir, '_aux/_models/model_1026.mat');

Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
Full            =  fullfile(scriptDir, '_aux/_models_tmp/model_1023.mat');
Exogenous       =  fullfile(scriptDir, '_aux/_models_tmp/model_1026.mat');


endogenous    = get_moments_table(Endogenous);
full          = get_moments_table(Full);
exogenous     = get_moments_table(Exogenous);

% MATLAB code to generate a LaTeX table from given structures

% Assume base.bc, alt.bc, base.ineq, alt.ineq are given as 1x5 arrays

% Open the file
fid = fopen(fullfile(scriptDir, '_table/table_ii.tex'), 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

% Panel (a)
fprintf(fid, '&\\multicolumn{5}{c}{Panel (a): Level of Moments}\\\\\n');
fprintf(fid, '& $\\sigma(K)$ & $\\sigma(Y)$ & $\\sigma(I)$ & $\\sigma(C)$ & $\\text{Corr}(C,Y)$\\\\\n');
fprintf(fid, '\\midrule\n');

% Baseline
fprintf(fid, 'Benchmark Model');
fprintf(fid, ' & %.2f', endogenous.bc);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', exogenous.bc);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Full  Information');
fprintf(fid, ' & %.2f', full.bc);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\midrule\n');

fprintf(fid, '&\\multicolumn{5}{c}{Panel (b): Percent Difference wrt Full Information}\\\\\n');
fprintf(fid, '& $\\sigma(K)$ & $\\sigma(Y)$ & $\\sigma(I)$ & $\\sigma(C)$ & $\\text{Corr}(C,Y)$\\\\\n');
fprintf(fid, '\\midrule\n');

diff1_bc = 100*(endogenous.bc - full.bc)./full.bc;
diff2_bc = 100*(exogenous.bc - full.bc)./full.bc;

% Baseline
fprintf(fid, 'Benchmark Model');
fprintf(fid, ' & %.2f', diff1_bc);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', diff2_bc);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);


clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));
addpath(fullfile(scriptDir, '_aux'));

Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
load(Endogenous,'forecast_moments')

T = readtable('_aux/_models_tmp/calibration.csv');

tmp1 = [forecast_moments.fcerror_ur_up_4q_mean   forecast_moments.fcerror_ur_up_4q_stdev];
tmp2 = [round(T.value(1),2) round(T.value(2),2)];

fid = fopen(fullfile(scriptDir, '_table/table_i.tex'), 'w');

fprintf(fid, '\\begin{tabular}{lcc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

fprintf(fid, '& Mean Abs. Error &  Std. Dev. of Abs. Error \\\\\n');
fprintf(fid, '\\midrule\n');

%Baseline
fprintf(fid, 'Survey of Consumer Expectations');
fprintf(fid, ' & %.2f', tmp1);
fprintf(fid, '\\\\ \n');


fprintf(fid, 'Model Simulated Data');
fprintf(fid, ' & %.2f', tmp2);
fprintf(fid, '\\\\ \n');

% Entrepreneur

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);
