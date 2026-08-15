% Figure D.i -- new
% ----------------------------------------------------------------
clearvars;
clc;
close all;

scriptDir = fileparts(mfilename("fullpath"));
modelDir  = fullfile(scriptDir, "_aux", "_models_tmp");
figureDir = fullfile(scriptDir, "_figures");

addpath(modelDir);

if ~isfolder(figureDir)
    mkdir(figureDir);
end

Bandwidth = 10;
TT        = 5000;
T_smpl    = 1000;
nn        = 4;

rng(11);

adj_factor = 1/(38.1/10.26)*65300/4;

x_values    = (0:0.01:500)';
x_lim_start = 0;
x_lim_end   = 2000;

%% Load distributions

S = load(fullfile(modelDir, "model_1001.mat"), "kdist_panel");
kdist_ii = S.kdist_panel(:,1:TT)';
clear S
disp("...done with benchmark reprate...")

S = load(fullfile(modelDir, "model_1007.mat"), "kdist_panel");
kdist_ii_tax = S.kdist_panel(:,1:TT)';
clear S
disp("...done with benchmark reprate with tax...")

S = load(fullfile(modelDir, "model_1023.mat"), "kdist_panel");
kdist_fi = S.kdist_panel(:,1:TT)';
clear S
disp("...done with full information reprate...")

S = load(fullfile(modelDir, "model_1025.mat"), "kdist_panel");
kdist_fi_tax = S.kdist_panel(:,1:TT)';
clear S
disp("...done with full information with tax reprate...")

%% Draw common sample

k = sort(randperm(TT, T_smpl))';

kdist_all = {
    kdist_ii(k,:)
    kdist_ii_tax(k,:)
    kdist_fi(k,:)
    kdist_fi_tax(k,:)
    };

clear kdist_ii kdist_ii_tax kdist_fi kdist_fi_tax

%% Start process pool

pool = gcp("nocreate");

if isempty(pool)
    pool = parpool("Processes", 10);
end

%% Estimate distributions

dist_save = zeros(T_smpl, numel(x_values), nn);

for jj = 1:nn
    kdist_tmp = kdist_all{jj};

    parfor tt = 1:T_smpl
        k_cross = kdist_tmp(tt,:)';

        pd_tmp = fitdist( ...
            k_cross, ...
            "Kernel", ...
            "Kernel", "epanechnikov", ...
            "Width", Bandwidth);

        y_tmp = pdf(pd_tmp, x_values);

        dist_save(tt,:,jj) = y_tmp';
    end

    fprintf("Done with model %d\n", jj);
end

%% Take averages

mean_dist_save = squeeze(mean(dist_save, 1));

%% Plot Distributions
mult_factor = adj_factor/1000;                          % wealth in '000 $

x_plot   = x_values*mult_factor;
diff_ben = mean_dist_save(:,2)-mean_dist_save(:,1);     % benchmark (tax-notax)
diff_fi  = mean_dist_save(:,4)-mean_dist_save(:,3);     % full information (tax-notax)

x_tail_start  = 600;
[~, idx]      = min(abs(x_plot - x_tail_start));
%diff_ben_tail = smooth(x_plot(idx:end),diff_ben(idx:end),0.001,'loess');
%diff_fi_tail  = smooth(x_plot(idx:end),diff_fi(idx:end),0.001,'loess');
diff_ben_tail = diff_ben(idx:end);
diff_fi_tail  = diff_fi(idx:end);

% color_blue   = [0 0.447058823529412 0.741176470588235];
% color_orange = [0.850980392156863 0.325490196078431 0.0980392156862745];
% 
% figure1 = figure('Theme','light','Color',[1 1 1]);
% 
% % -- left panel: full distribution difference
% subplot1 = subplot(1,2,1,'Parent',figure1);
% hold(subplot1,'on');
% plot(x_plot,diff_ben,'LineWidth',2,'Color',color_blue);
% plot(x_plot,diff_fi,'LineWidth',2,'Color',color_orange);
% yline(0,'--k','LineWidth',2);
% xlim(subplot1,[x_lim_start 1000]);
% ylim(subplot1,[-9.75e-4 15e-4]);
% xticks(subplot1,200:200:1000);
% xticklabels(subplot1,{'200','400','600','800','1,000'});
% xlabel('Wealth (''000 \$)','Interpreter','latex');
% ylabel('Density difference','Interpreter','latex');
% text(130,9.5e-4,'Benchmark','Color',color_blue,...
%     'Interpreter','latex','FontSize',13.2);
% text(330,4e-4,'Full information','Color',color_orange,...
%     'Interpreter','latex','FontSize',13.2);
% box(subplot1,'on');
% hold(subplot1,'off');
% 
% % -- right panel: right tail, smoothed
% subplot2 = subplot(1,2,2,'Parent',figure1);
% hold(subplot2,'on');
% plot(x_plot(idx:end),diff_ben_tail,'LineWidth',2,'Color',color_blue);
% plot(x_plot(idx:end),diff_fi_tail,'LineWidth',2,'Color',color_orange);
% yline(0,'--k','LineWidth',2);
% xlim(subplot2,[x_tail_start 2200]);
% ylim(subplot2,[-0.5e-5 2.5e-5]);
% xticks(subplot2,600:400:2200);
% xticklabels(subplot2,{'600','1,000','1,400','1,800','2,200'});
% xlabel('Wealth (''000 \$)','Interpreter','latex');
% ylabel('Density difference','Interpreter','latex');
% text(750,2e-5,'Full information','Color',color_orange,...
%     'Interpreter','latex','FontSize',13.2);
% text(1450,0.8e-5,'Benchmark','Color',color_blue,...
%     'Interpreter','latex','FontSize',13.2);
% box(subplot2,'on');
% hold(subplot2,'off');
% 
% figure1.Position = [150, 150, 600, 290];
% 
% exportgraphics(figure1, '_figures/figure_d1.pdf', ...
%     'ContentType','vector', ...
%     'BackgroundColor','white');


% ============================================================= %

X1 = x_plot;
X2 = x_plot(idx:end);
YMatrix1 = [diff_ben  diff_fi];
YMatrix2 = [diff_ben_tail  diff_fi_tail];

color_blue   = [0 0.447058823529412 0.741176470588235];
color_orange = [0.850980392156863 0.325490196078431 0.0980392156862745];

figure1 = figure('Theme','light','Color',[1 1 1]);

% Create subplot
subplot1 = subplot(1,2,1,'Parent',figure1);
hold(subplot1,'on');

% Create multiple line objects using matrix input to plot
plot1 = plot(X1,YMatrix1,'Parent',subplot1,'LineWidth',2);
set(plot1(1),'Color',[0 0.447058823529412 0.741176470588235]);
set(plot1(2),...
    'Color',[0.850980392156863 0.325490196078431 0.0980392156862745]);

% Create yline
yline(0,'Parent',subplot1,'LineStyle','--','Color',[0 0 0],'LineWidth',2);

% Create text
text('Parent',subplot1,'Interpreter','latex','String','Benchmark',...
    'Position',[83.8461538461538 0.00095 0],...
    'Color',[0 0.447058823529412 0.741176470588235]);

% Create text
text('Parent',subplot1,'Interpreter','latex','String','Full information',...
    'Position',[330 0.0004 0],...
    'Color',[0.850980392156863 0.325490196078431 0.0980392156862745]);

% Create ylabel
ylabel('Density difference','Interpreter','latex');

% Create xlabel
xlabel('Wealth (''000 \$)','Interpreter','latex');

% Uncomment the following line to preserve the X-limits of the axes
xlim(subplot1,[0 1000]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot1,[-0.000975 0.0015]);
box(subplot1,'on');
hold(subplot1,'off');
% Set the remaining axes properties
set(subplot1,'XTick',[200 400 600 800 1000],'XTickLabel',...
    {'200','400','600','800','1,000'});
% Create subplot
subplot2 = subplot(1,2,2,'Parent',figure1);
hold(subplot2,'on');

% Create multiple line objects using matrix input to plot
plot2 = plot(X2,YMatrix2,'Parent',subplot2,'LineWidth',2);
set(plot2(1),'Color',[0 0.447058823529412 0.741176470588235]);
set(plot2(2),...
    'Color',[0.850980392156863 0.325490196078431 0.0980392156862745]);

% Create yline
yline(0,'Parent',subplot2,'LineStyle','--','Color',[0 0 0],'LineWidth',2);

% Create text
text('Parent',subplot2,'Interpreter','latex','String','Full information',...
    'Position',[750 2e-05 0],...
    'Color',[0.850980392156863 0.325490196078431 0.0980392156862745]);

% Create text
text('Parent',subplot2,'Interpreter','latex','String','Benchmark',...
    'Position',[1450 8e-06 0],...
    'Color',[0 0.447058823529412 0.741176470588235]);

% Create ylabel
ylabel('Density difference','Interpreter','latex');

% Create xlabel
xlabel('Wealth (''000 \$)','Interpreter','latex');

% Uncomment the following line to preserve the X-limits of the axes
xlim(subplot2,[600 2200]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot2,[-5e-06 2.5e-05]);
box(subplot2,'on');
hold(subplot2,'off');
% Set the remaining axes properties
set(subplot2,'XTick',[600 1000 1400 1800 2200],'XTickLabel',...
    {'600','1,000','1,400','1,800','2,200'},'YTickLabel',...
    {'-0.5','0','0.5','1.0','1.5','2.0','2.5'});

exportgraphics(figure1, '_figures/figure_d1.pdf', ...
    'ContentType','vector', ...
    'BackgroundColor','white');
