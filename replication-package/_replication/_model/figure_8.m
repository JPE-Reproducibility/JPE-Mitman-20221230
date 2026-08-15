% Figure [8] 
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));


opts = optimset('Display','off');

TT          = 7000;
T_smpl      = 1000; %250;

rng(11);

adj_factor = 1/(38.1/10.26)*65300/4;


x_values         = [0:0.01:500]';
nn               = 2;

x_lim_fig7       = 300; %000 USD
x_lim_end        = 2000;


load('model_1001.mat','kdist_panel'); 
kdist_ii = kdist_panel(:,1:TT)'; 

load('model_1023.mat','kdist_panel'); 
kdist_fi = kdist_panel(:,1:TT)'; 

clearvars -except kdist_ii kdist_fi TT T_smpl rng(11) adj_factor x_values nn x_lim_fig7 x_lim_end


k = randperm(TT, T_smpl);
k = sort(k');


kdist_ii_tmp = kdist_ii(k,:);
kdist_fi_tmp = kdist_fi(k,:);

dist_save = zeros(T_smpl,length(x_values),2);

for tt=1:T_smpl
    k_cross = kdist_ii_tmp(tt,:)';
    pd_tmp  = fitdist(k_cross,'Kernel','Kernel','epanechnikov');
    y_tmp   = pdf(pd_tmp,x_values);

    dist_save(tt,:,1) = y_tmp';
end


for tt=1:T_smpl
    k_cross = kdist_fi_tmp(tt,:)';
    pd_tmp  = fitdist(k_cross,'Kernel','Kernel','epanechnikov');
    y_tmp   = pdf(pd_tmp,x_values);

    dist_save(tt,:,2) = y_tmp';
end



mean_dist_save = zeros(length(x_values),nn);

for jj = 1:nn
    
    dist_tmp  = squeeze(dist_save(:,:,jj));

    dist_mean = mean(dist_tmp);

    mean_dist_save(:,jj)= dist_mean';

end

[~, idx] = min(abs(x_values*adj_factor - x_lim_fig7));
y_tmp    = smooth(x_values(idx:end)*adj_factor,mean_dist_save(idx:end,1)'-mean_dist_save(idx:end,2)',0.25,'loess');



%% ------------------  PLOT ------------------------ %%
X1 = x_values*adj_factor/1000;
Y1 = mean_dist_save(:,1)'-mean_dist_save(:,2)';
X2 = x_values(idx:end)*adj_factor/1000;
Y2 = y_tmp;

X1  = X1;
Y1  = Y1;
Y2   = mean_dist_save(:,1)';
XData1 = X1;
YData1 = zeros(1,length(Y1));
X2  = X2;
Y3  = y_tmp;
XData2 = X2;
YData2 = zeros(1,length(Y3));


cBlue   = [0 0.447058823529412 0.741176470588235];
cOrange = [0.850980392156863 0.325490196078431 0.0980392156862745];

figure1 = figure( ...
    'Units','pixels', ...
    'Position',[1 1 1047 340], ...
    'Resize','off');

% ---------------------------------------------------------------
% Left panel
% ---------------------------------------------------------------

subplot1 = subplot(1,2,1,'Parent',figure1);
hold(subplot1,'on');

yyaxis(subplot1,'left');

plot(subplot1,X1,Y1, ...
    'DisplayName','Endogenous Information - Full Information low', ...
    'LineWidth',2, ...
    'Color',cBlue);

ylim(subplot1,[-4e-4 1.25e-3]);

yticks(subplot1,[-4e-4 -2e-4 0 2e-4 4e-4 6e-4 8e-4 1e-3 1.2e-3]);

subplot1.YTickLabelMode = 'auto';

yyaxis(subplot1,'right');

plot(subplot1,X1,Y2, ...
    'LineWidth',1, ...
    'Color',cOrange);

ylim(subplot1,[-0.01 0.03]);

yticks(subplot1,[-0.01 0 0.01 0.02 0.03]);
yticklabels(subplot1,{'-0.01','0','0.01','0.02','0.03'});

yline(subplot1,0,'--', ...
    'Color',cOrange, ...
    'LineWidth',0.75);

xlabel(subplot1,'Wealth (''000 \$)', ...
    'Interpreter','latex');

xlim(subplot1,[0 300]);
box(subplot1,'on');
hold(subplot1,'off');


% ---------------------------------------------------------------
% Right panel
% ---------------------------------------------------------------

axes1 = axes( ...
    'Parent',figure1, ...
    'Position',[0.570340909090909 ...
                0.107150997150997 ...
                0.334659090909091 ...
                0.815]);

hold(axes1,'on');

yyaxis(axes1,'left');

plot(axes1,X2,Y3, ...
    'DisplayName','Endogenous Information - Full Information low', ...
    'LineWidth',2, ...
    'Color',cBlue);

ylim(axes1,[-4e-5 1e-5]);
yticks(axes1,(-4:1)*1e-5);
axes1.YTickLabelMode = 'auto';

yyaxis(axes1,'right');

plot(axes1,X1,Y2, ...
    'LineWidth',1, ...
    'Color',cOrange);

ylim(axes1,[-0.016 0.004]);
yticks(axes1,[-0.016 -0.012 -0.008 -0.004 0 0.004]);

yline(axes1,0,'--', ...
    'Color',cOrange, ...
    'LineWidth',0.75);

xlabel(axes1,'Wealth (''000 \$)', ...
    'Interpreter','latex');

xlim(axes1,[300 2000]);
xticks(axes1,[400 600 800 1000 1200 1400 1600 1800 2000]);

box(axes1,'on');
hold(axes1,'off');

% Create textbox
annotation(figure1,'textbox',...
    [0.197480938416422 0.3 0.189615835777126 0.116809116809117],...
    'Color',[0 0.447058823529412 0.741176470588235],...
    'String',{'Benchmark - Full Information (lhs)'},...
    'Interpreter','latex',...
    'FontWeight','bold',...
    'FontSize',13.2,...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.252 0.547008547008547 0.189615835777126 0.116809116809117],...
    'Color',[0.850980392156863 0.325490196078431 0.0980392156862745],...
    'String',{'Wealth Distribution (rhs)'},...
    'Interpreter','latex',...
    'FontWeight','bold',...
    'FontSize',13.2,...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.623 0.3 0.197435972629521 0.168091168091168],...
    'Color',[0 0.447058823529412 0.741176470588235],...
    'String',{'Benchmark - Full Information (lhs)'},...
    'Interpreter','latex',...
    'FontSize',13.2,...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.585 0.8 0.189615835777126 0.116809116809117],...
    'Color',[0.850980392156863 0.325490196078431 0.0980392156862745],...
    'String',{'Wealth Distribution (rhs)'},...
    'Interpreter','latex',...
    'FontWeight','bold',...
    'FontSize',13.2,...
    'FitBoxToText','off',...
    'EdgeColor','none');

drawnow;

% if ~isfolder('_figures')
%     mkdir('_figures');
% end

exportgraphics(figure1,'_figures/figure_8.pdf', ...
    'ContentType','image', ...
    'Resolution',300, ...
    'Padding','figure');