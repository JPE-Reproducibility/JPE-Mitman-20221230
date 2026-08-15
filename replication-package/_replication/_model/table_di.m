% Table Di
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));
addpath(fullfile(scriptDir, '_aux'));

%Endogenous      =  fullfile(scriptDir, '_aux/_models/model_7009.mat');
%Full            =  fullfile(scriptDir, '_aux/_models/model_7009_fi.mat');
%Exogenous       =  fullfile(scriptDir, '_aux/_models/model_7009_exo.mat');

%Endogenous_rep    =  fullfile(scriptDir, '_aux/_models/model_7009_ui.mat');
%Full_rep          =  fullfile(scriptDir, '_aux/_models/model_7009_fi_ui.mat');
%Exogenous_rep     =  fullfile(scriptDir, '_aux/_models/model_7009_exo_ui.mat');

Endogenous      =  fullfile(scriptDir, '_aux/_models_tmp/model_7009.mat');
Full            =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_fi.mat');
Exogenous       =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_exo.mat');

Endogenous_rep    =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_ui.mat');
Full_rep          =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_fi_ui.mat');
Exogenous_rep     =  fullfile(scriptDir, '_aux/_models_tmp/model_7009_exo_ui.mat');

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
fid = fopen(fullfile(scriptDir, '_table/table_di.tex'), 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lcccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

% Panel (a)
fprintf(fid, '& $\\mu(K)$ & $\\sigma(Y) $ Gini (G) $ & $90/50$ & $\\text{Info U.}$ & $\\text{Info E.}$\\\\\n');
fprintf(fid, '\\midrule\n');

% Baseline
tmp = [benchmark(1:3) benchmark(end-2:end)];
fprintf(fid, 'Benchmark Model');
fprintf(fid, ' & %.2f', tmp);
fprintf(fid, '\\\\ \n');

% Entrepreneur
tmp = [exogenous_info(1:3) exogenous_info(end-2:end)];
fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', tmp);
fprintf(fid, '\\\\ \n');

% Entrepreneur
tmp = [full_info(1:3) full_info(end-2:end)];
fprintf(fid, 'Full  Information');
fprintf(fid, ' & %.2f', tmp);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);
