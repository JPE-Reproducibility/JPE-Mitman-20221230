% Table VI
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));
addpath(fullfile(scriptDir, '_aux'));

%Endogenous      =  fullfile(scriptDir, '_aux/_models/model_1001.mat');
%Full            =  fullfile(scriptDir, '_aux/_models/model_1023.mat');
%Exogenous       =  fullfile(scriptDir, '_aux/_models/model_1026.mat');

%Endogenous_rep    =  fullfile(scriptDir, '_aux/_models/model_1007.mat');
%Full_rep          =  fullfile(scriptDir, '_aux/_models/model_1025.mat');
%Exogenous_rep     =  fullfile(scriptDir, '_aux/_models/model_1028.mat');

Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
Full            =  fullfile(scriptDir, '_aux/_models_tmp/model_1023.mat');
Exogenous       =  fullfile(scriptDir, '_aux/_models_tmp/model_1026.mat');

Endogenous_rep    =  fullfile(scriptDir, '_aux/_models_tmp/model_1007.mat');
Full_rep          =  fullfile(scriptDir, '_aux/_models_tmp/model_1025.mat');
Exogenous_rep     =  fullfile(scriptDir, '_aux/_models_tmp/model_1028.mat');


endogenous    = get_moments_table2(Endogenous);
full          = get_moments_table2(Full);
exogenous     = get_moments_table2(Exogenous);

endogenous_rep    = get_moments_table2(Endogenous_rep);
full_rep          = get_moments_table2(Full_rep);
exogenous_rep     = get_moments_table2(Exogenous_rep);

benchmark         = (endogenous_rep.comp_alt./endogenous.comp_alt-1).*100; 
exogenous_info    = (exogenous_rep.comp_alt./exogenous.comp_alt-1).*100;
full_info         = (full_rep.comp_alt./full.comp_alt-1).*100;

% MATLAB code to generate a LaTeX table from given structures

% Assume base.bc, alt.bc, base.ineq, alt.ineq are given as 1x5 arrays

% Open the file
fid = fopen(fullfile(scriptDir, '_table/table_vi.tex'), 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lcccccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

% Panel (a)
fprintf(fid, '& $\\mu(K)$ & $\\sigma(Y) $ & Gini (G)  & $ 90/10 $ & $99/1$ & $90/50$ & $\\text{Info U.}$ & $\\text{Info E.}$\\\\\n');
fprintf(fid, '\\midrule\n');

% Baseline
fprintf(fid, 'Benchmark Model');
fprintf(fid, ' & %.2f', benchmark);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', exogenous_info);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Full  Information');
fprintf(fid, ' & %.2f', full_info);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);
