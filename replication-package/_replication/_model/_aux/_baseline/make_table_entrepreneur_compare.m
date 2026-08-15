clear
model_to_run = 7009;
base_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_fi.mat'];
base_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_exo.mat'];
base_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '.mat'];
% scaledmodel = '~/GitHub/BKKS/model_1062.mat';
% wtax_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/model_' int2str(model_to_run) '_fi_wtax_kink2.mat'];
% wtax_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/model_' int2str(model_to_run) '_exo_wtax_kink.mat'];
wtax_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_wtax_rebate.mat'];
wtax_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_fi_wtax_rebate.mat'];
wtax_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_exo_wtax_rebate.mat'];
% wtax_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/model_' int2str(model_to_run) '_wtax_kink.mat'];

ui_fi_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_fi_ui.mat'];
ui_exo_name = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_exo_ui.mat'];
ui_endo_name =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_ui.mat'];


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
fid = fopen('~/Dropbox/BKKS_Shadow/_revision2/_input/table_ent_comp_wtax_final.tex', 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lccccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

% Panel (a)
% fprintf(fid, '&\\multicolumn{5}{c}{Panel (a): Business Cycle Moments}\\\\\n');
fprintf(fid, 'Entrepreneur Model & $\\mu(K)$ & $\\sigma(Y)$ & $\\text{Gini}(K)$ & $90/50$ & Info U. & Info E.\\\\\n');
fprintf(fid, '\\midrule\n');

% Entrepreneur FI
fprintf(fid, 'Endogenous Information');
fprintf(fid, ' & %.2f', 100*(wtax_endo.ent_comp-base_endo.ent_comp)./base_endo.ent_comp);
fprintf(fid, '\\\\ \n');

% Entrepreneur FI
fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', 100*(wtax_exo.ent_comp-base_exo.ent_comp)./base_exo.ent_comp);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Full Information');
fprintf(fid, ' & %.2f', 100*(wtax_fi.ent_comp-base_fi.ent_comp)./base_fi.ent_comp);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);

% Open the file
fid = fopen('~/Dropbox/BKKS_Shadow/_revision2/_input/table_ent_comp_ui_final.tex', 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lccccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

% Panel (a)
% fprintf(fid, '&\\multicolumn{5}{c}{Panel (a): Business Cycle Moments}\\\\\n');
fprintf(fid, 'Entrepreneur Model & $\\mu(K)$ & $\\sigma(Y)$ & $\\text{Gini}(K)$ & $90/50$  & Info U. & Info E.\\\\\n');
fprintf(fid, '\\midrule\n');

% Entrepreneur FI
fprintf(fid, 'Endogenous Information');
fprintf(fid, ' & %.2f', 100*(ui_endo.ent_comp-base_endo.ent_comp)./base_endo.ent_comp);
fprintf(fid, '\\\\ \n');

% Entrepreneur FI
fprintf(fid, 'Exogenous Information');
fprintf(fid, ' & %.2f', 100*(ui_exo.ent_comp-base_exo.ent_comp)./base_exo.ent_comp);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Full Information');
fprintf(fid, ' & %.2f', 100*(ui_fi.ent_comp-base_fi.ent_comp)./base_fi.ent_comp);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);
