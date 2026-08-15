% %%%%%%%%%%%%%
% Table B.2 in the appendix - BC statistics
% %%%%%%%%%%%%%%

clear all; clc; close all;

%% empirical moments:
currentFile = mfilename( 'fullpath' );
[pathstr,~,~] = fileparts( currentFile );
parentFolder = fileparts( pathstr );
%addpath( fullfile( parentFolder, '_data/_data/' ) );
%addpath( fullfile( pathstr, '_tables/' ) );

delta = 0.025;
burn  = 50;

start = 1; 

opts = spreadsheetImportOptions("NumVariables", 6);

opts.Sheet = "Data";
opts.DataRange = "A2:F313";

opts.VariableNames = ["Date", "Y", "Pop", "I", "C", "K"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "categorical"];
opts = setvaropts(opts, "K", "EmptyFieldRule", "auto");

businesscycledata = readtable([parentFolder '/_data/_data/business_cycle_data.xlsx'], opts, "UseExcel", false);

%clear temporary variables
%clear opts

Y = businesscycledata.Y;  Y  = Y(start:end);
C = businesscycledata.C;  C  = C(start:end);
I = businesscycledata.I;  I  = I(start:end);

idx = find(isnan(I), 1); 

I = I(1:idx-1);

[Y_trend,Y_cycle] = hpfilter(log(Y));
[C_trend,C_cycle] = hpfilter(log(C));
[I_trend,I_cycle] = hpfilter(log(I));

K = zeros(length(I),1); K(1) = 1;
for ii=2:length(I_cycle)
    K(ii) = (1-delta)*K(ii-1)+I(ii);
end
K = K(burn+1:end);
[K_trend,K_cycle] = hpfilter(log(K));

disp('.....Raw Data Moments.....')
names = {'Output $(y)$', 'Investment','Consumption'}';
std    = [var(Y_cycle)^0.5*100, var(I_cycle)^0.5*100, var(C_cycle)^0.5*100]';
rel    = 1/(var(Y_cycle)^0.5*100)*std;
cor    = [corr(Y_cycle(2:end),Y_cycle(1:end-1)), corr(I_cycle(2:end),I_cycle(1:end-1)), corr(C_cycle(2:end),C_cycle(1:end-1))]';
corxy  = [corr(Y_cycle,Y_cycle), corr(I_cycle,Y_cycle(1:idx-1)), corr(C_cycle,Y_cycle)]';
corxy1 = [corr(Y_cycle(2:end),Y_cycle(1:end-1)), corr(I_cycle(2:end),Y_cycle(1:idx-2)), corr(C_cycle(2:end),Y_cycle(1:end-1))]';
T1 = table(names, std, rel, cor, corxy, corxy1)
clear std rel cor corxy corxy1

%% model moments
%folder locations:
%resultsfolder = [pathstr '\_aux\_models\']; 
resultsfolder = [pathstr '/_aux/_models_tmp/']; 

%benchmark:
load([resultsfolder 'model_1001.mat'],'moments')
moments_bench=moments;

table_b2_bench = [ ...
    moments_bench.y_dollar_log_stdev*100,   moments_bench.y_dollar_log_stdev/moments_bench.y_dollar_log_stdev,   moments_bench.autocorr_y_dollar_log,   1,                                   moments_bench.autocorr_y_dollar_log; ... 
    moments_bench.inv_dollar_log_stdev*100, moments_bench.inv_dollar_log_stdev/moments_bench.y_dollar_log_stdev, moments_bench.autocorr_inv_dollar_log, moments_bench.inv_dollar_corr_y_log, moments_bench.inv_dollar_corr_y2_log; ...
    moments_bench.c_dollar_log_stdev*100,   moments_bench.c_dollar_log_stdev/moments_bench.y_dollar_log_stdev,   moments_bench.autocorr_c_dollar_log,   moments_bench.c_dollar_corr_y_log,   moments_bench.c_dollar_corr_y2_log; ...
];
std = table_b2_bench(:,1);
rel = table_b2_bench(:,2);
cor = table_b2_bench(:,3);
corxy = table_b2_bench(:,4);
corxy1 = table_b2_bench(:,5);
T2 = table(names, std, rel, cor, corxy, corxy1)
clear std rel cor corxy corxy1

%full information:
load([resultsfolder 'model_1023.mat'],'moments')
moments_FI=moments;

table_b2_FI = [ ...
    moments_FI.y_dollar_log_stdev*100,   moments_FI.y_dollar_log_stdev/moments_FI.y_dollar_log_stdev,   moments_FI.autocorr_y_dollar_log,   1,                                moments_FI.autocorr_y_dollar_log; ... 
    moments_FI.inv_dollar_log_stdev*100, moments_FI.inv_dollar_log_stdev/moments_FI.y_dollar_log_stdev, moments_FI.autocorr_inv_dollar_log, moments_FI.inv_dollar_corr_y_log, moments_FI.inv_dollar_corr_y2_log; ...
    moments_FI.c_dollar_log_stdev*100,   moments_FI.c_dollar_log_stdev/moments_FI.y_dollar_log_stdev,   moments_FI.autocorr_c_dollar_log,   moments_FI.c_dollar_corr_y_log,   moments_FI.c_dollar_corr_y2_log; ...
];
std = table_b2_FI(:,1);
rel = table_b2_FI(:,2);
cor = table_b2_FI(:,3);
corxy = table_b2_FI(:,4);
corxy1 = table_b2_FI(:,5);
T3 = table(names, std, rel, cor, corxy, corxy1)
clear std rel cor corxy corxy1



%% print table
fid = fopen('_table/table_bii.tex', 'w');

fprintf(fid, '\\begin{tabular}{lccccc}\n');
fprintf(fid, '\\toprule\n');

%data
fprintf(fid, '\\multicolumn{6}{c}{Panel (a): U.S. Data (1947Q1-2024Q4)}\\\\\n');
fprintf(fid, '\\midrule\n');
fprintf(fid, 'Variable $(x)$ & $\\sigma_x$ & $\\sigma_x/\\sigma_y$ & $\\mathrm{Corr}(x_t,x_{t-1})$ & $\\mathrm{Corr}(x_t,y_t)$ & $\\mathrm{Corr}(x_t,y_{t-1})$ \\\\\n');
fprintf(fid, '\\midrule\n');

for i = 1:height(T1)
    fprintf(fid, '%s & %.2f & %.2f & %.2f & %.2f & %.2f \\\\[4pt]\n', ...
        T1.names{i}, T1.std(i), T1.rel(i), T1.cor(i), T1.corxy(i), T1.corxy1(i));
end
fprintf(fid, '\\midrule\n');


%benchmark
fprintf(fid, '\\multicolumn{6}{c}{Panel (b): Benchmark Model}\\\\\n');
fprintf(fid, '\\midrule\n');
fprintf(fid, 'Variable $(x)$ & $\\sigma_x$ & $\\sigma_x/\\sigma_y$ & $\\mathrm{Corr}(x_t,x_{t-1})$ & $\\mathrm{Corr}(x_t,y_t)$ & $\\mathrm{Corr}(x_t,y_{t-1})$ \\\\\n');
fprintf(fid, '\\midrule\n');

for i = 1:height(T2)
    fprintf(fid, '%s & %.2f & %.2f & %.2f & %.2f & %.2f \\\\[4pt]\n', ...
        T2.names{i}, T2.std(i), T2.rel(i), T2.cor(i), T2.corxy(i), T2.corxy1(i));
end
fprintf(fid, '\\midrule\n');

%full information
fprintf(fid, '\\multicolumn{6}{c}{Panel (c): Full Information}\\\\\n');
fprintf(fid, '\\midrule\n');
fprintf(fid, 'Variable $(x)$ & $\\sigma_x$ & $\\sigma_x/\\sigma_y$ & $\\mathrm{Corr}(x_t,x_{t-1})$ & $\\mathrm{Corr}(x_t,y_t)$ & $\\mathrm{Corr}(x_t,y_{t-1})$ \\\\\n');
fprintf(fid, '\\midrule\n');

for i = 1:height(T3)
    fprintf(fid, '%s & %.2f & %.2f & %.2f & %.2f & %.2f \\\\[4pt]\n', ...
        T3.names{i}, T3.std(i), T3.rel(i), T3.cor(i), T3.corxy(i), T3.corxy1(i));
end

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

fclose(fid);




