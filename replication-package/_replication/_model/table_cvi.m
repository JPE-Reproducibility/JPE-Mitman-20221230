% Table CV
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));
addpath(fullfile(scriptDir, '_aux'));


%Endogenous      =  fullfile(scriptDir, '_aux/_models/model_1001.mat');
%Full               =  fullfile(scriptDir, '_aux/_models/model_1023.mat');
%Exogenous          =  fullfile(scriptDir, '_aux/_models/model_1026.mat');
%Full_no            =  fullfile(scriptDir, '_aux/_models/model_1033.mat');
%Exogenous_no       =  fullfile(scriptDir, '_aux/_models/model_1036.mat');

Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
Full               =  fullfile(scriptDir, '_aux/_models_tmp/model_1023.mat');
Exogenous          =  fullfile(scriptDir, '_aux/_models_tmp/model_1026.mat');
Full_no            =  fullfile(scriptDir, '_aux/_models_tmp/model_1033.mat');
Exogenous_no       =  fullfile(scriptDir, '_aux/_models_tmp/model_1036.mat');


endogenous     = get_moments_table(Endogenous);
full           = get_moments_table(Full);
exogenous      = get_moments_table(Exogenous);
full_no        = get_moments_table(Full_no);
exogenous_no   = get_moments_table(Exogenous_no);

% MATLAB code to generate a LaTeX table from given structures

% Assume base.bc, alt.bc, base.ineq, alt.ineq are given as 1x5 arrays

% Open the file
fid = fopen(fullfile(scriptDir, '_table/table_cvi.tex'), 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

fprintf(fid, '& $\\sigma(K)$ & $\\sigma(Y)$ & $\\sigma(I)$ & $\\sigma(C)$ & $\\text{Corr}(C,Y)$ \\\\\n');
fprintf(fid, '\\midrule\n');

fprintf(fid, 'Benchmark Model');
fprintf(fid, ' & %.2f', [endogenous.bc]);
fprintf(fid, '\\\\ \n');

fprintf(fid, '&\\multicolumn{5}{c}{Panel (a): With Costs of Information}\\\\\n');
fprintf(fid, '\\midrule\n');
fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', [exogenous.bc]);
fprintf(fid, '\\\\ \n');

fprintf(fid, 'Full Information');
fprintf(fid, ' & %.2f', [full.bc]);
fprintf(fid, '\\\\ \n');

fprintf(fid, '&\\multicolumn{5}{c}{Panel (b): Without Costs of Information}\\\\\n');
fprintf(fid, '\\midrule\n');

fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', [exogenous_no.bc]);
fprintf(fid, '\\\\ \n');

fprintf(fid, 'Full Information');
fprintf(fid, ' & %.2f', [full_no.bc]);
fprintf(fid, '\\\\ \n');


fprintf(fid, '&\\multicolumn{5}{c}{Panel (b): Percent Difference due to Costs }\\\\\n');
fprintf(fid, '\\midrule\n');

diff1_bc = 100.*((exogenous_no.bc - exogenous.bc)./exogenous_no.bc);
diff2_bc = 100.*((full_no.bc - full.bc)./full_no.bc);

fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', diff1_bc);
fprintf(fid, '\\\\ \n');

fprintf(fid, 'Full Information');
fprintf(fid, ' & %.2f', diff2_bc);
fprintf(fid, '\\\\ \n');


fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);
