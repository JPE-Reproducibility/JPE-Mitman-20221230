% %%%%%%%%%%%%%
% Table C.1 in the appendix - Mean-Biased Capital Expectations
% %%%%%%%%%%%%%%

clear all; clc; close all;

%% empirical moments:
currentFile = mfilename( 'fullpath' );
[pathstr,~,~] = fileparts( currentFile );

%folder locations:
%resultsfolder = [pathstr '\_aux\_models\']; 
resultsfolder = [pathstr '/_aux/_models_tmp/']; 

%benchmark:
load([resultsfolder 'model_1001.mat'],'moments')
moments_bench=moments;

load([resultsfolder 'model_105902.mat'],'moments')
moments_PrK_010=moments;

load([resultsfolder 'model_106002.mat'],'moments')
moments_PrK_100=moments;

load([resultsfolder 'model_1023.mat'],'moments')
moments_FI=moments;

sigmaK = [ (moments_PrK_100.kbar_log_stdev/moments_FI.kbar_log_stdev -1)*100; ...
           (moments_PrK_010.kbar_log_stdev/moments_FI.kbar_log_stdev -1)*100; ...
           (moments_bench.kbar_log_stdev/moments_FI.kbar_log_stdev -1)*100];

sigmaY = [ (moments_PrK_100.y_log_stdev/moments_FI.y_log_stdev-1)*100; ...
           (moments_PrK_010.y_log_stdev/moments_FI.y_log_stdev-1)*100; ...
           (moments_bench.y_log_stdev/moments_FI.y_log_stdev-1)*100];

sigmaI = [ (moments_PrK_100.inv_log_stdev/moments_FI.inv_log_stdev-1)*100; ...
           (moments_PrK_010.inv_log_stdev/moments_FI.inv_log_stdev-1)*100; ...
           (moments_bench.inv_log_stdev/moments_FI.inv_log_stdev-1)*100];

sigmaC = [ (moments_PrK_100.c_log_stdev/moments_FI.c_log_stdev-1)*100; ...
           (moments_PrK_010.c_log_stdev/moments_FI.c_log_stdev-1)*100; ...
           (moments_bench.c_log_stdev/moments_FI.c_log_stdev-1)*100];

CorrCY = [ (moments_PrK_100.c_corr_y_log/moments_FI.c_corr_y_log-1)*100; ...
           (moments_PrK_010.c_corr_y_log/moments_FI.c_corr_y_log-1)*100; ...
           (moments_bench.c_corr_y_log/moments_FI.c_corr_y_log-1)*100];

Gini = [   (moments_PrK_100.gini/moments_FI.gini-1)*100; ...
           (moments_PrK_010.gini/moments_FI.gini-1)*100; ...
           (moments_bench.gini/moments_FI.gini-1)*100];

stat9010 = [ (moments_PrK_100.ninetyten/moments_FI.ninetyten-1)*100; ...
             (moments_PrK_010.ninetyten/moments_FI.ninetyten-1)*100; ...
             (moments_bench.ninetyten/moments_FI.ninetyten-1)*100];

stat9901 = [ (moments_PrK_100.ninetynineone/moments_FI.ninetynineone-1)*100; ...
             (moments_PrK_010.ninetynineone/moments_FI.ninetynineone-1)*100; ...
             (moments_bench.ninetynineone/moments_FI.ninetynineone-1)*100];

stat9050 = [ (moments_PrK_100.ninetyfifty/moments_FI.ninetyfifty-1)*100; ...
             (moments_PrK_010.ninetyfifty/moments_FI.ninetyfifty-1)*100; ...
             (moments_bench.ninetyfifty/moments_FI.ninetyfifty-1)*100];

CorrKY = [ (moments_PrK_100.k_corr_y_log/moments_FI.k_corr_y_log-1)*100; ...
           (moments_PrK_010.k_corr_y_log/moments_FI.k_corr_y_log-1)*100; ...
           (moments_bench.k_corr_y_log/moments_FI.k_corr_y_log-1)*100];

names = {'Endog. Info (P(learn K) = 1.0))', 'Endog. Info (P(learn K) = 0.1))','Benchmark Model'}';
T1 = table(names, sigmaK, sigmaY, sigmaI, sigmaC, CorrCY);
T2 = table(names, Gini, stat9010, stat9901, stat9050, CorrKY);





%% print table
fid = fopen('_table/table_ci.tex', 'w');

fprintf(fid, '\\begin{tabular}{lccccc}\n');
fprintf(fid, '\\toprule\n');

%BC moments
fprintf(fid, ' & \\multicolumn{5}{c}{Panel (a): Business Cycle Moments}\\\\\n');
fprintf(fid, '\\midrule\n');
fprintf(fid, ' & $\\sigma(K)$ & $\\sigma(Y)$ & $\\sigma(I)$ & $\\sigma(C)$ & $\\mathrm{Cor}(C,Y)$ \\\\\n');
fprintf(fid, '\\midrule\n');

for i = 1:height(T1)
    fprintf(fid, '%s & %.2f & %.2f & %.2f & %.2f & %.2f \\\\[4pt]\n', ...
        T1.names{i}, T1.sigmaK(i), T1.sigmaY(i), T1.sigmaI(i), T1.sigmaC(i), T1.CorrCY(i));
end
fprintf(fid, '\\midrule\n');


%inequality moments
fprintf(fid, ' & \\multicolumn{5}{c}{Panel (b): Inequality Moments}\\\\\n');
fprintf(fid, '\\midrule\n');
fprintf(fid, '& Gini & 90/10 & 99/1 & 90/50 & $\\mathrm{Cor}(K,Y)$ \\\\\n');
fprintf(fid, '\\midrule\n');

for i = 1:height(T2)
    fprintf(fid, '%s & %.2f & %.2f & %.2f & %.2f & %.2f \\\\[4pt]\n', ...
        T2.names{i}, T2.Gini(i), T2.stat9010(i), T2.stat9901(i), T2.stat9050(i), T2.CorrKY(i));
end

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

fclose(fid);




