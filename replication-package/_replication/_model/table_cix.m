% Table cix
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));
addpath(fullfile(scriptDir, '_aux'));


%Benchmark      =  fullfile(scriptDir, '_aux/_models/model_1001.mat');
%Scaledev       =  fullfile(scriptDir, '_aux/_models/model_1074.mat');
Benchmark      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
Scaledev       =  fullfile(scriptDir, '_aux/_models_tmp/model_1074.mat');


benchmark      = get_moments_table2(Benchmark);
scaledev       = get_moments_table2(Scaledev);

% MATLAB code to generate a LaTeX table from given structures

% Assume base.bc, alt.bc, base.ineq, alt.ineq are given as 1x5 arrays

% Open the file
fid = fopen(fullfile(scriptDir, '_table/table_cix.tex'), 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

fprintf(fid, '&\\multicolumn{5}{c}{Panel (a): Business Cycle Moments}\\\\\n');
fprintf(fid, '& $ \\sigma (K) $ & $\\sigma(Y)$ & $\\sigma(I)$ & $\\sigma(C)$ & $\\text{Corr}(C,Y)$\\\\\n');
fprintf(fid, '\\midrule\n');

fprintf(fid, 'With Resource Cost');
fprintf(fid, ' & %.2f', [benchmark.bc]);
fprintf(fid, '\\\\ \n');

fprintf(fid, 'Without Resource Cost');
fprintf(fid, ' & %.2f', [scaledev.bc]);
fprintf(fid, '\\\\ \n');

diff1 = 100.*(scaledev.bc./benchmark.bc-1);
fprintf(fid, 'Difference pct.');
fprintf(fid, ' & %.2f', [diff1]);
fprintf(fid, '\\\\ \n');


fprintf(fid, '&\\multicolumn{5}{c}{Panel (b): Inequality Moments}\\\\\n');
fprintf(fid, '& $ Gini (K) $ & $ 90/10 $ & $99/1$ & $ 90/50$ & $\\text{Corr}(K,Y)$\\\\\n');
fprintf(fid, '\\midrule\n');
fprintf(fid, 'With Resource Cost');
fprintf(fid, ' & %.2f', [benchmark.ineq]);
fprintf(fid, '\\\\ \n');

fprintf(fid, 'Without Resource Cost');
fprintf(fid, ' & %.2f', [scaledev.ineq]);
fprintf(fid, '\\\\ \n');

diff2 = 100.*(scaledev.ineq./benchmark.ineq-1);
fprintf(fid, 'Difference pct.');
fprintf(fid, ' & %.2f', [diff2]);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);
