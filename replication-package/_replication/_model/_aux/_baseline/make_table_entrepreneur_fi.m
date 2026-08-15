clear

model_to_run = 7009; % Define the model number to run
basemodel = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_fi.mat'];
exomodel = ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '_exo.mat'];
scaledmodel =  ['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/UpdatedMoments/model_' int2str(model_to_run) '.mat'];

% scaledmodel = '~/GitHub/BKKS/model_1062.mat';

base    = get_moments_table(basemodel);
exo     = get_moments_table(exomodel);
alt     = get_moments_table(scaledmodel);

% MATLAB code to generate a LaTeX table from given structures

% Assume base.bc, alt.bc, base.ineq, alt.ineq are given as 1x5 arrays

% Open the file
fid = fopen('~/Dropbox/BKKS_Shadow/_revision2/_input/table_ent_fi.tex', 'w');

% Write LaTeX header
fprintf(fid, '\\begin{tabular}{lccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, '\\toprule\n');

% Panel (a)
fprintf(fid, '&\\multicolumn{5}{c}{Panel (a): Business Cycle Moments}\\\\\n');
fprintf(fid, '& $\\sigma(K)$ & $\\sigma(Y)$ & $\\sigma(I)$ & $\\sigma(C)$ & $\\text{Corr}(C,Y)$\\\\\n');
fprintf(fid, '\\midrule\n');

% Entrepreneur FI
fprintf(fid, 'Entrepreneur FI');
fprintf(fid, ' & %.2f', base.bc);
fprintf(fid, '\\\\ \n');

% Entrepreneur FI
fprintf(fid, 'Entrepreneur Exo');
fprintf(fid, ' & %.2f', exo.bc);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Entrepreneur');
fprintf(fid, ' & %.2f', alt.bc);
fprintf(fid, '\\\\ \n');

% Difference
diff_bc = 100*(alt.bc - base.bc)./base.bc;
fprintf(fid, 'Difference \\%%');
fprintf(fid, ' & %.2f', diff_bc);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\midrule\n');

% Panel (b)
fprintf(fid, '&\\multicolumn{5}{c}{Panel (b): Inequality Moments}\\\\\n');
fprintf(fid, '& $\\text{Gini}(K)$ & $90/10$ & $99/1$ & $\\text{Cor}(K,Y)$ & $\\text{Cor}(G,Y)$\\\\\n');
fprintf(fid, '\\midrule\n');

% Entrepreneur FI
fprintf(fid, 'Entrepreneur FI');
fprintf(fid, ' & %.2f', base.ineq);
fprintf(fid, '\\\\ \n');

% Entrepreneur Exo
fprintf(fid, 'Entrepreneur Exo');
fprintf(fid, ' & %.2f', exo.ineq);
fprintf(fid, '\\\\ \n');

% Entrepreneur
fprintf(fid, 'Entrepreneur');
fprintf(fid, ' & %.2f', alt.ineq);
fprintf(fid, '\\\\ \n');

% Difference

diff_ineq = 100*(alt.ineq - base.ineq)./base.ineq;
fprintf(fid, 'Difference \\%%');
fprintf(fid, ' & %.2f', diff_ineq);
fprintf(fid, '\\\\ \n');

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);

% alt.forecast