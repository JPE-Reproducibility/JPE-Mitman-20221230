% Table cx
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));
addpath(fullfile(scriptDir, '_aux'));


%Endogenous        =  fullfile(scriptDir, '_aux/_models/model_7009.mat');
%Exogenous         =  fullfile(scriptDir, '_aux/_models/model_7009_exo.mat');
%Fullinformation   =  fullfile(scriptDir, '_aux/_models/model_7009_exo.mat');

Endogenous        =  fullfile(scriptDir, '_aux/_models_tmp/model_7009.mat');
Exogenous         =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_exo.mat');
Fullinformation   =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_fi.mat');


endogenous         = get_moments_table2(Endogenous);
exogenous          = get_moments_table2(Exogenous);
fullinformation    = get_moments_table2(Fullinformation);

% MATLAB code to generate a LaTeX table from given structures

% Assume base.bc, alt.bc, base.ineq, alt.ineq are given as 1x5 arrays

% Open the file
fid = fopen(fullfile(scriptDir, '_table/table_cx.tex'), 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

fprintf(fid, '&\\multicolumn{5}{c}{Panel (a): Business Cycle Moments}\\\\\n');
fprintf(fid, '& $ \\sigma (K) $ & $\\sigma(Y)$ & $\\sigma(I)$ & $\\sigma(C)$ & $\\text{Corr}(C,Y)$\\\\\n');
fprintf(fid, '\\midrule\n');

fprintf(fid, 'Endogenous (A)');
fprintf(fid, ' & %.2f', [endogenous.bc]);
fprintf(fid, '\\\\ \n');

fprintf(fid, 'Exogenous (B)');
fprintf(fid, ' & %.2f', [exogenous.bc]);
fprintf(fid, '\\\\ \n');

fprintf(fid, 'Full Information (C)');
fprintf(fid, ' & %.2f', [fullinformation.bc]);
fprintf(fid, '\\\\ \n');

diff1 = 100.*(endogenous.bc./fullinformation.bc-1);
fprintf(fid, 'Difference pct. (A vs C)');
fprintf(fid, ' & %.2f', [diff1]);
fprintf(fid, '\\\\ \n');


fprintf(fid, '&\\multicolumn{5}{c}{Panel (b): Inequality Moments}\\\\\n');
fprintf(fid, '& $ Gini (K) $ &   & $ 90/50$  &  & $\\text{Corr}(K,Y)$\\\\\n');
fprintf(fid, '\\midrule\n');

tmp1 = [endogenous.ineq(1) 0 endogenous.ineq(4) 0 endogenous.ineq(5)]; 
fprintf(fid, 'Endogenous (A)');
fprintf(fid, ' & %.2f', tmp1);
fprintf(fid, '\\\\ \n');

tmp2 = [exogenous.ineq(1) 0 exogenous.ineq(4) 0 exogenous.ineq(5)]; 
fprintf(fid, 'Exogenous (B)');
fprintf(fid, ' & %.2f', tmp2);
fprintf(fid, '\\\\ \n');

tmp3 = [fullinformation.ineq(1) 0 fullinformation.ineq(4) 0 fullinformation.ineq(5)]; 
fprintf(fid, 'Full Information (C)');
fprintf(fid, ' & %.2f', tmp3);
fprintf(fid, '\\\\ \n');

diff2 = 100*[tmp1(1)/tmp3(1)-1 0 tmp1(3)/tmp3(3)-1 0 tmp1(5)/tmp3(5)-1];
fprintf(fid, 'Difference pct. (A vs C)');
fprintf(fid, ' & %.2f', [diff2]);
fprintf(fid, '\\\\ \n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);
