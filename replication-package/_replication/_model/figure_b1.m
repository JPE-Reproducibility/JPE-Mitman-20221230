% FIGURE b1
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));

addpath(fullfile(scriptDir, '_aux'));


rng(11);

load(fullfile(scriptDir, '_aux', '_models_tmp', 'model_1001.mat'));
load(fullfile(scriptDir, '_aux', '_models_tmp', 'NewShocks.mat'), 'zvec');

TT          = 7000;

sample_N    = [1:params.N];
sample_T    = [1:1:params.T - params.drop];


%% [1] Baseline model

kdist_panel_bench=kdist_panel(sample_N,sample_T); 

plotkdist_panel_bench=fitdist(kdist_panel_bench(:),'Kernel','Kernel','epanechnikov');

plotkdist_panel_bench_pdf = pdf(plotkdist_panel_bench,params.sav_grid); %clear kdist_panel_bench

for t=1:params.T-params.drop
        meanpK(t)=mean(pKdist_panel(:,t));
    if t==1
        FIpK(t)=35;
    else
        FIpK(t)=exp(a0(zvec(t+params.drop))+a1(zvec(t+params.drop))*log(FIpK(t-1)));
    end
end



figureB1=figure
hold on
plot(Kvec(params.drop+1:end),'LineWidth',1.5)
plot(FIpK,'LineWidth',1.5)
plot(meanpK,'LineWidth',1.5)

xlim([1,4000])
 h = legend('Capital stock $\bar k_t$','Prior $\hat k_t$ with full information about $\{z_s\}_{s=1}^t$','Average prior in the benchmark model', ...
        'Location', 'Southeast','Orientation','vertical');
    set(h,'fontsize',12,'FontWeight','bold','Interpreter','Latex')%,'FontName','Times');
set(figureB1,'Renderer','opengl');  
print(figureB1, '_figures/figure_B1.pdf', '-dpdf', '-image');