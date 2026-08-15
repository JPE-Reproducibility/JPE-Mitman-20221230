%% business cycle moments data
clear all; clc; close all;

currentFile = mfilename( 'fullpath' );
[pathstr,~,~] = fileparts( currentFile );
addpath( fullfile( pathstr, '_data/' ) );
addpath( fullfile( pathstr, '_tables/' ) );

delta = 0.025;
burn  = 50;

start = 1; 

opts = spreadsheetImportOptions("NumVariables", 6);

opts.Sheet = "Data";
opts.DataRange = "A2:F313";

opts.VariableNames = ["Date", "Y", "Pop", "I", "C", "K"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "categorical"];
opts = setvaropts(opts, "K", "EmptyFieldRule", "auto");

businesscycledata = readtable(fullfile(pathstr, '_data', 'business_cycle_data.xlsx'), opts, "UseExcel", false);

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

fid = fopen('_tables/table_b2_a.tex', 'w');

fprintf(fid, '\\begin{tabular}{lccccc}\n');
fprintf(fid, '\\toprule\n');
fprintf(fid, 'Variable $(x)$ & $\\sigma_x$ & $\\sigma_x/\\sigma_y$ & $\\mathrm{Corr}(x_t,x_{t-1})$ & $\\mathrm{Corr}(x_t,y_t)$ & $\\mathrm{Corr}(x_t,y_{t-1})$ \\\\\n');
fprintf(fid, '\\midrule\n');

for i = 1:height(T1)
    fprintf(fid, '%s & %.2f & %.2f & %.2f & %.2f & %.2f \\\\[4pt]\n', ...
        T1.names{i}, T1.std(i), T1.rel(i), T1.cor(i), T1.corxy(i), T1.corxy1(i));
end

fprintf(fid, '\\bottomrule\n');
fprintf(fid, '\\end{tabular}\n');

fclose(fid);
