% Table C.II
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


endogenous    = get_moments_table2(Endogenous);
full          = get_moments_table2(Full);
exogenous     = get_moments_table2(Exogenous);

% MATLAB code to generate a LaTeX table from given structures

% Assume base.bc, alt.bc, base.ineq, alt.ineq are given as 1x5 arrays

% Open the file
fid = fopen(fullfile(scriptDir, '_table/table_cii.tex'), 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

% Panel (a)
fprintf(fid, '& $ \\sigma{Gini}$ & $\\sigma(90/50) $ & $\\sigma(99/50)$ & $\\text{Corr}(90,10)$ & $\\text{Corr}(99,10)$\\\\\n');
fprintf(fid, '\\midrule\n');

% Baseline
fprintf(fid, 'Benchmark Model');
fprintf(fid, ' & %.2f', endogenous.ineqdyn);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', exogenous.ineqdyn);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Full  Information');
fprintf(fid, ' & %.2f', full.ineqdyn);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);
