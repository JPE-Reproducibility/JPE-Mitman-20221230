% Table II
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



endogenous    = get_moments_table(Endogenous);
full          = get_moments_table(Full);
exogenous     = get_moments_table(Exogenous);

% MATLAB code to generate a LaTeX table from given structures

% Assume base.bc, alt.bc, base.ineq, alt.ineq are given as 1x5 arrays

% Open the file
fid = fopen(fullfile(scriptDir, '_table/table_civ.tex'), 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lcccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

% Panel (a)
fprintf(fid, '&\\multicolumn{5}{c}{Panel (a): Level of Moments}\\\\\n');
fprintf(fid, '& $\\sigma(K)$ & $\\sigma(Y)$ & $\\sigma(I)$ & $\\sigma(C)$ & $\\text{Corr}(C,Y)$ & $\\text{Corr}(I,Y)$\\\\\n');
fprintf(fid, '\\midrule\n');

% Baseline
fprintf(fid, 'Benchmark Model');
fprintf(fid, ' & %.2f', [endogenous.bc endogenous.add]);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', [exogenous.bc exogenous.add]);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Full  Information');
fprintf(fid, ' & %.2f', [full.bc full.add]);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\midrule\n');

fprintf(fid, '&\\multicolumn{5}{c}{Panel (b): Percent Difference wrt Full Information}\\\\\n');
fprintf(fid, '& $\\sigma(K)$ & $\\sigma(Y)$ & $\\sigma(I)$ & $\\sigma(C)$ & $\\text{Corr}(C,Y)$ & $\\text{Corr}(I,Y)$\\\\\n');
fprintf(fid, '\\midrule\n');

diff1_bc = 100.*[(endogenous.bc - full.bc)./full.bc  (endogenous.add - full.add)./full.add];
diff2_bc = 100.*[(exogenous.bc - full.bc)./full.bc (exogenous.add - full.add)./full.add];

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
