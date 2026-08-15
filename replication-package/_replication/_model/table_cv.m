% Table CV
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));
addpath(fullfile(scriptDir, '_aux'));

%Endogenous      =  fullfile(scriptDir, '_aux/_models/model_1018.mat');
%Full            =  fullfile(scriptDir, '_aux/_models/model_1047.mat');
%Exogenous       =  fullfile(scriptDir, '_aux/_models/model_1050.mat');

Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1018.mat');
Full            =  fullfile(scriptDir, '_aux/_models_tmp/model_1047.mat');
Exogenous       =  fullfile(scriptDir, '_aux/_models_tmp/model_1050.mat');


endogenous    = get_moments_table2(Endogenous);
full          = get_moments_table2(Full);
exogenous     = get_moments_table2(Exogenous);

% MATLAB code to generate a LaTeX table from given structures

% Assume base.bc, alt.bc, base.ineq, alt.ineq are given as 1x5 arrays

% Open the file
fid = fopen(fullfile(scriptDir, '_table/table_cv.tex'), 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

% Panel (a)
fprintf(fid, '&\\multicolumn{5}{c}{Panel (a): Level of Moments}\\\\\n');
fprintf(fid, '& $ Gini (G) $ & $ 90/10 $ & $99/1$ & $90/50$ & $\\text{Corr}(K,Y)$\\\\\n');
fprintf(fid, '\\midrule\n');

% Baseline
fprintf(fid, 'Benchmark Model');
fprintf(fid, ' & %.2f', endogenous.ineq);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', exogenous.ineq);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Full  Information');
fprintf(fid, ' & %.2f', full.ineq);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\midrule\n');

fprintf(fid, '&\\multicolumn{5}{c}{Panel (b): Percent Difference wrt Full Information}\\\\\n');
fprintf(fid, '& $ Gini (G) $ & $ 90/10 $ & $99/1$ & $90/50$ & $\\text{Corr}(K,Y)$\\\\\n');
fprintf(fid, '\\midrule\n');

diff1_bc = 100*(endogenous.ineq - full.ineq)./full.ineq;
diff2_bc = 100*(exogenous.ineq - full.ineq)./full.ineq;

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
