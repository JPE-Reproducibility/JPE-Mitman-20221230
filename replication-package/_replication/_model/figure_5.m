% Figure [5] Heatmap 
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
addpath(fullfile(scriptDir, '_aux'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));


load('model_1001.mat');

fontsize  = 12;
centerPoint = 0.50;
dataMin     = 0.00;
dataMax     = 1/00;

scale       = (38.1/10.26)*65300/4;
slope       = 5;


%% [1] Things to plot
sav_to_coh;

vec_nsnpk_emp                     = 2*linspace(1,params.npk,params.npk);
vec_nsnpk_unemp                   = vec_nsnpk_emp-1;


stdev_kbar=std(Kvec(params.drop+1:end));
interp_kbar_mean                  = moments.kbar_mean;
interp_kbar_meanplus              = 1.25*moments.kbar_mean; 
interp_kbar_meanminus             = 0.75*moments.kbar_mean;

for ii=1:size(ipol,1)
    for jj=1:size(ipol,2)
        ipol_emp_meankbar(ii,jj)=interp1(params.Kgrid,squeeze(ipol(ii,jj,vec_nsnpk_emp)),interp_kbar_mean);
        ipol_emp_meankbarplus(ii,jj)=interp1(params.Kgrid,squeeze(ipol(ii,jj,vec_nsnpk_emp)),interp_kbar_meanplus);
        ipol_emp_meankbarminus(ii,jj)=interp1(params.Kgrid,squeeze(ipol(ii,jj,vec_nsnpk_emp)),interp_kbar_meanminus);
        ipol_unemp_meankbar(ii,jj)=interp1(params.Kgrid,squeeze(ipol(ii,jj,vec_nsnpk_unemp)),interp_kbar_mean);
        ipol_unemp_meankbarplus(ii,jj)=interp1(params.Kgrid,squeeze(ipol(ii,jj,vec_nsnpk_unemp)),interp_kbar_meanplus);
        ipol_unemp_meankbarminus(ii,jj)=interp1(params.Kgrid,squeeze(ipol(ii,jj,vec_nsnpk_unemp)),interp_kbar_meanminus);

        if jj==1 || jj==size(ipol,2)
                cah_today_emp_meankbar(ii,min(jj,2))=interp1(params.Kgrid,squeeze(cah_today(ii,min(jj,2),vec_nsnpk_emp)),interp_kbar_mean);
                cah_today_emp_meankbarplus(ii,min(jj,2))=interp1(params.Kgrid,squeeze(cah_today(ii,min(jj,2),vec_nsnpk_emp)),interp_kbar_meanplus);
                cah_today_emp_meankbarminus(ii,min(jj,2))=interp1(params.Kgrid,squeeze(cah_today(ii,min(jj,2),vec_nsnpk_emp)),interp_kbar_meanminus);
                cah_today_unemp_meankbar(ii,min(jj,2))=interp1(params.Kgrid,squeeze(cah_today(ii,min(jj,2),vec_nsnpk_unemp)),interp_kbar_mean);
                cah_today_unemp_meankbarplus(ii,min(jj,2))=interp1(params.Kgrid,squeeze(cah_today(ii,min(jj,2),vec_nsnpk_unemp)),interp_kbar_meanplus);
                cah_today_unemp_meankbarminus(ii,min(jj,2))=interp1(params.Kgrid,squeeze(cah_today(ii,min(jj,2),vec_nsnpk_unemp)),interp_kbar_meanminus);
        end
    end
end

cah_today_emp_meankbar=mean(cah_today_emp_meankbar,2);
cah_today_emp_meankbarplus=mean(cah_today_emp_meankbarplus,2);
cah_today_emp_meankbarminus=mean(cah_today_emp_meankbarminus,2);
cah_today_unemp_meankbar=mean(cah_today_unemp_meankbar,2);
cah_today_unemp_meankbarplus=mean(cah_today_unemp_meankbarplus,2);
cah_today_unemp_meankbarminus=mean(cah_today_unemp_meankbarminus,2);


%% [2] Low prior of K

figure(53); orient landscape

cmap = colormap;
x = linspace(0,1,length(cmap));
x = x.^slope;  
newMap = interp1(x, cmap, linspace(0,1,512));
colormap(newMap);

x_vals_u = log(cah_today_unemp_meankbarminus/(38.1/10.26)*65300/4);     
x_vals_e = log(cah_today_emp_meankbarminus/(38.1/10.26)*65300/4);     
y_vals   = [0.1800 0.3561 0.5323 0.7085 0.8846];                        

[X_u, Y] = meshgrid(x_vals_u, y_vals);
[X_e, Y] = meshgrid(x_vals_e, y_vals);

Z1 = ipol_unemp_meankbarminus';  
Z2 = ipol_emp_meankbarminus';

plot1 = subplot(1,2,1);
surf(X_u, Y, Z1);
view(2);             
shading interp;      
xticks(log([2.5 5 10 20 40 100 250 750]*1000))
xticklabels([2.5 5 10 20 40 100 250 750])
xlim(log([min(cah_today_unemp_meankbarminus) 100]/(38.1/10.26)*65300/4));
ylim([min(y_vals) max(y_vals)]);
title('Unemployed, low prior $K$', 'FontSize', fontsize, 'Interpreter', 'Latex');
xlabel('Cash-at-hand (000\$)', 'Interpreter', 'Latex', 'FontSize', fontsize);
ylabel('Prior over $Z_t=Z_h$', 'Interpreter', 'Latex', 'FontSize', fontsize);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', fontsize);

plot2 = subplot(1,2,2);
surf(X_e, Y, Z2);
view(2);
shading interp;
xticks(log([2.5 5 10 20 40 100 250 750]*1000))
xticklabels([2.5 5 10 20 40 100 250 750])
xlim(log([min(cah_today_emp_meankbarminus) 100]/(38.1/10.26)*65300/4));
ylim([min(y_vals) max(y_vals)]);
title('Employed, low prior $K$', 'FontSize', fontsize, 'Interpreter', 'Latex');
xlabel('Cash-at-hand (000\$)', 'Interpreter', 'Latex', 'FontSize', fontsize);
ylabel('Prior over $Z_t=Z_h$', 'Interpreter', 'Latex', 'FontSize', fontsize);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', fontsize);

caxis([0 1]);  

set(plot1, 'Position', [0.08 0.25 0.37 0.65]);
set(plot2, 'Position', [0.55 0.25 0.37 0.65]);

cb = colorbar('southoutside');
cb.Position = [0.2 0.08 0.6 0.03];
cb.TickLabelInterpreter = 'latex';
cb.FontSize = fontsize;

f = gcf;  %
f.Position = [100, 100, 800, 400];  
set(f,'Renderer','opengl');  
print(f, '_figures/figure_5ab.pdf', '-dpdf', '-image');


%% [2] High prior of K
figure(54); orient landscape

cmap = colormap;
x = linspace(0,1,length(cmap));
x = x.^slope;  
newMap = interp1(x, cmap, linspace(0,1,512));
colormap(newMap);

x_vals_u = log(cah_today_unemp_meankbarplus/(38.1/10.26)*65300/4);    
x_vals_e = log(cah_today_emp_meankbarplus/(38.1/10.26)*65300/4);     
y_vals   = [0.1800 0.3561 0.5323 0.7085 0.8846];                        

[X_u, Y] = meshgrid(x_vals_u, y_vals);
[X_e, Y] = meshgrid(x_vals_e, y_vals);

Z1 = ipol_unemp_meankbarplus';  
Z2 = ipol_emp_meankbarplus';

plot1 = subplot(1,2,1);
surf(X_u, Y, Z1);
view(2);             
shading interp;      
xticks(log([2.5 5 10 20 40 100 250 750]*1000))
xticklabels([2.5 5 10 20 40 100 250 750])
xlim(log([min(cah_today_unemp_meankbarplus) 100]/(38.1/10.26)*65300/4));
ylim([min(y_vals) max(y_vals)]);
title('Unemployed, high prior $K$', 'FontSize', fontsize, 'Interpreter', 'Latex');
xlabel('Cash-at-hand (000\$)', 'Interpreter', 'Latex', 'FontSize', fontsize);
ylabel('Prior over $Z_t=Z_h$', 'Interpreter', 'Latex', 'FontSize', fontsize);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', fontsize);

plot2 = subplot(1,2,2);
surf(X_e, Y, Z2);
view(2);
shading interp;
xticks(log([2.5 5 10 20 40 100 250 750]*1000))
xticklabels([2.5 5 10 20 40 100 250 750])
xlim(log([min(cah_today_emp_meankbarplus) 100]/(38.1/10.26)*65300/4));
ylim([min(y_vals) max(y_vals)]);
title('Employed, high prior $K$', 'FontSize', fontsize, 'Interpreter', 'Latex');
xlabel('Cash-at-hand (000\$)', 'Interpreter', 'Latex', 'FontSize', fontsize);
ylabel('Prior over $Z_t=Z_h$', 'Interpreter', 'Latex', 'FontSize', fontsize);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', fontsize);

caxis([0 1]);  

% Adjust subplot spacing
set(plot1, 'Position', [0.08 0.25 0.37 0.65]);
set(plot2, 'Position', [0.55 0.25 0.37 0.65]);

% Shared colorbar below
%cb = colorbar('southoutside');
%cb.Position = [0.2 0.08 0.6 0.03];
%cb.TickLabelInterpreter = 'latex';
%cb.FontSize = fontsize;

f = gcf;  
f.Position = [100, 100, 800, 400]; 
set(f,'Renderer','opengl');  
print(f, '_figures/figure_5cd.pdf', '-dpdf', '-image');
