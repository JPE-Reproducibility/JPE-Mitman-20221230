clear


% 1001
% benchmark
% 1007
% bench w/ higher rep rate
% 1017
% bench w/ wtax + rebate
% 1023
% FI recalibrated
% 1025
% Fi recalibrated >rep
% 1026
% exog recalibrated
% 1028
% exog recalibrated >rep
% 1029
% exog recalibrated w/ wtax + rebate
% 1030
% FI recalibrated w/ wtax+ rebate



model_to_run = 1023;

base_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];

model_to_run = 1026;

base_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];

model_to_run = 1001;

base_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];

model_to_run = 1017;

wtax_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];

model_to_run = 1030;


wtax_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];


model_to_run = 1029;

wtax_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];


model_to_run = 1025;

ui_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];

model_to_run = 1028;

ui_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];

model_to_run = 1007;

ui_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/_updatedmoments/model_' int2str(model_to_run) '.mat'];


base_fi    = get_moments_table(base_fi_name);
base_exo     = get_moments_table(base_exo_name);
base_endo     = get_moments_table(base_endo_name);

wtax_fi    = get_moments_table(wtax_fi_name);
wtax_exo     = get_moments_table(wtax_exo_name);
wtax_endo     = get_moments_table(wtax_endo_name);

ui_fi    = get_moments_table(ui_fi_name);
ui_exo     = get_moments_table(ui_exo_name);
ui_endo     = get_moments_table(ui_endo_name);

% MATLAB code to generate a LaTeX table from given structures

% Assume base.bc, alt.bc, base.ineq, alt.ineq are given as 1x5 arrays

% Open the file
fid = fopen('~/Dropbox/BKKS_Shadow/_revision2/_input/table_comp_wtax_final.tex', 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lccccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

% Panel (a)
% fprintf(fid, '&\\multicolumn{5}{c}{Panel (a): Business Cycle Moments}\\\\\n');
fprintf(fid, ' & $\\mu(K)$ & $\\sigma(Y)$ & $\\text{Gini}(K)$ & $90/10$& $99/1$& $90/50$ & Info U. & Info E.\\\\\n');
fprintf(fid, '\\midrule\n');

% Entrepreneur FI
fprintf(fid, 'Benchmark Model');
fprintf(fid, ' & %.2f', 100*(wtax_endo.comp-base_endo.comp)./base_endo.comp);
fprintf(fid, '\\\\ \n');

% Entrepreneur FI
fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', 100*(wtax_exo.comp-base_exo.comp)./base_exo.comp);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Full Information');
fprintf(fid, ' & %.2f', 100*(wtax_fi.comp-base_fi.comp)./base_fi.comp);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);

% Open the file
fid = fopen('~/Dropbox/BKKS_Shadow/_revision2/_input/table_comp_ui_final.tex', 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lccccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

% Panel (a)
% fprintf(fid, '&\\multicolumn{5}{c}{Panel (a): Business Cycle Moments}\\\\\n');
fprintf(fid, ' & $\\mu(K)$ & $\\sigma(Y)$ & $\\text{Gini}(K)$ & $90/10$& $99/1$& $90/50$  & Info U. & Info E.\\\\\n');
fprintf(fid, '\\midrule\n');

% Entrepreneur FI
fprintf(fid, 'Benchmark Model');
fprintf(fid, ' & %.2f', 100*(ui_endo.comp-base_endo.comp)./base_endo.comp);
fprintf(fid, '\\\\ \n');

% Entrepreneur FI
fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', 100*(ui_exo.comp-base_exo.comp)./base_exo.comp);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Full Information');
fprintf(fid, ' & %.2f', 100*(ui_fi.comp-base_fi.comp)./base_fi.comp);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);
