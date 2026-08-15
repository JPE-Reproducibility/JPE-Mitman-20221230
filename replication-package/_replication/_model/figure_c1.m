% Figure [C.1]
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));

opts = optimset('Display','off');

TT          = 7000;
T_smpl      = 1000; 

rng(11);

adj_factor = 1/(38.1/10.26)*65300/4;

x_values         = [0:0.01:500]';
nn               = 4;

x_lim_start      = 0; 
x_lim_end        = 2000;


%% [1] Derive Distributions
%load('model_1001_wPanel.mat','kdist_panel');         %baseline
load('model_1001.mat','kdist_panel');                 %baseline
kdist_ii = kdist_panel(:,1:TT)'; 
clearvars -except kdist_ii TT T_smpl rng(11) adj_factor x_values nn x_lim_start x_lim_end 
disp('...done with baseline...')

load('model_1023.mat','kdist_panel');                %full information 
%load('model_1023_wPanel.mat','kdist_panel');         %full information 
kdist_fi = kdist_panel(:,1:TT)'; 
clearvars -except kdist_ii kdist_fi TT T_smpl rng(11) adj_factor x_values nn x_lim_start x_lim_end
disp('...done with full information...')

load('model_1023_LOMendo.mat','kdist_panel'); %full information w/ baseline lom
kdist_fi_lom  = kdist_panel(:,1:TT)'; 
clearvars -except kdist_ii kdist_fi kdist_fi_lom TT T_smpl rng(11) adj_factor x_values nn x_lim_start x_lim_end
disp('...done with full information with lom...')

load('model_1026_LOMendo.mat','kdist_panel'); %exogenous information w/ baseline lom 
kdist_ei_lom  = kdist_panel(:,1:TT)'; 
clearvars -except kdist_ii kdist_fi  kdist_fi_lom  kdist_ei_lom TT T_smpl rng(11) adj_factor x_values nn x_lim_start x_lim_end
disp('...done with exogenous information with lom...')

k = randperm(TT, T_smpl);
k = sort(k');

kdist_ii_tmp     = kdist_ii(k,:);
kdist_fi_tmp     = kdist_fi(k,:);
kdist_fi_lom_tmp = kdist_fi_lom(k,:);
kdist_ei_lom_tmp = kdist_ei_lom(k,:);


% -- estimate distributions
dist_save = zeros(T_smpl,length(x_values),nn);
gini_save = zeros(T_smpl,nn);

for jj=1:nn
    
    if jj==1
        kdist_tmp = kdist_ii_tmp;
    elseif jj==2
        kdist_tmp = kdist_fi_tmp;
    elseif jj==3
        kdist_tmp = kdist_fi_lom_tmp;
    else
        kdist_tmp = kdist_ei_lom_tmp;
    end


    for tt=1:T_smpl
        k_cross = kdist_tmp(tt,:)';
        pd_tmp  = fitdist(k_cross,'Kernel','Kernel','epanechnikov');
        y_tmp   = pdf(pd_tmp,x_values);

        dist_save(tt,:,jj) = y_tmp';

        [W, I] = sort(k_cross);
        NN_tmp = length(W);
        gini_save(tt,jj) = 1-2*sum(cumsum(W)/sum(W))/NN_tmp;
    end

    disp('done with model'); disp(jj);
end

% -- take averages
mean_dist_save = zeros(length(x_values),nn);
for jj = 1:nn
    
    dist_tmp  = squeeze(dist_save(:,:,jj));

    dist_mean = mean(dist_tmp);

    mean_dist_save(:,jj)= dist_mean';

end


% -- compute ginis 
mean_ginis = mean(gini_save);

decomposition    = zeros(1,4);
decomposition(1) = 100*(mean_ginis(1)/mean_ginis(2)-1);
decomposition(2) = 100*(mean_ginis(3)/mean_ginis(2)-1);
decomposition(3) = 100*(mean_ginis(4)/mean_ginis(3)-1);
decomposition(4) = 100*(mean_ginis(1)/mean_ginis(4)-1);

% mean_ginis = zeros(1,nn);
% for kk=1:nn
% 
%     [W, I]=sort(mean_dist_save(:,kk));
% 
%     NN = length(W);
%     G = 1-2*sum(cumsum(W)/sum(W))/NN;

    % x = mean_dist_save(:,kk);
    % x = x(:);
    % x = sort(x);
    % n = length(x);
    % index = (1:n)';
    % G = (2 * sum(index .* x) - (n + 1) * sum(x)) / (n * sum(x));
% 
%     mean_ginis(kk) = G;
% end




%% [1] Plot Distributions
mult_factor = adj_factor;

X1        = x_values*mult_factor;
YMatrix1  = [mean_dist_save(:,1)'-mean_dist_save(:,2)'; zeros(1,length(x_values))];
YMatrix2  = [mean_dist_save(:,3)'-mean_dist_save(:,2)'; zeros(1,length(x_values))];
YMatrix3  = [mean_dist_save(:,4)'-mean_dist_save(:,3)'; zeros(1,length(x_values))];
YMatrix4  = [mean_dist_save(:,1)'-mean_dist_save(:,4)'; zeros(1,length(x_values))];


% figure1 = figure;
% 
% % Create subplot
% subplot1 = subplot(2,2,1,'Parent',figure1);
% hold(subplot1,'on');
% 
% % Create multiple line objects using matrix input to plot
% plot1 = plot(X1,YMatrix1,'Parent',subplot1);
% set(plot1(1),'DisplayName','Benchmark - Full Information','LineWidth',3,...
%     'Color',[0 0.447058823529412 0.741176470588235]);
% set(plot1(2),'LineWidth',1,'LineStyle','--',...
%     'Color',[0.149019607843137 0.149019607843137 0.149019607843137]);
% 
% % Create xlabel
% xlabel('Wealth (''000 $)','Interpreter','latex');
% 
% % Uncomment the following line to preserve the X-limits of the axes
% xlim(subplot1,[0 1000000]);
% ylim(subplot1,[-5*10^(-4) 15*10^(-4)]);
% box(subplot1,'on');
% hold(subplot1,'off');
% % Set the remaining axes properties
% set(subplot1,'FontSize',11,'XTick',[0 250000 500000 750000 1000000],...
%     'XTickLabel',{'0','250','500','750','1000'});
% % Create subplot
% subplot2 = subplot(2,2,2,'Parent',figure1);
% hold(subplot2,'on');
% 
% % Create multiple line objects using matrix input to plot
% plot2 = plot(X1,YMatrix2,'Parent',subplot2);
% set(plot2(1),'DisplayName','Full Information w/ New LOM - Full Information',...
%     'LineWidth',3,...
%     'Color',[0 0.447058823529412 0.741176470588235]);
% set(plot2(2),'LineWidth',1,'LineStyle','--',...
%     'Color',[0.149019607843137 0.149019607843137 0.149019607843137]);
% 
% % Create xlabel
% xlabel('Wealth (''000 $)','Interpreter','latex');
% 
% % Uncomment the following line to preserve the X-limits of the axes
% xlim(subplot2,[0 1000000]);
% box(subplot2,'on');
% hold(subplot2,'off');
% % Set the remaining axes properties
% set(subplot2,'FontSize',11,'XTick',[0 250000 500000 750000 1000000],...
%     'XTickLabel',{'0','250','500','750','1000'},'YTickLabel',...
%     {'-1.5','-1.0','-0.5','0','0.5','1.0'});
% % Create axes
% axes1 = axes('Parent',figure1,...
%     'Position',[0.13 0.0879411764705882 0.334659090909091 0.341162790697674]);
% hold(axes1,'on');
% 
% % Create multiple line objects using matrix input to plot
% plot3 = plot(X1,YMatrix3,'Parent',axes1);
% set(plot3(1),...
%     'DisplayName','Exogenous Information - Full Information (w/ NEW LOM',...
%     'LineWidth',3,...
%     'Color',[0 0.447058823529412 0.741176470588235]);
% set(plot3(2),'LineWidth',1,'LineStyle','--',...
%     'Color',[0.149019607843137 0.149019607843137 0.149019607843137]);
% 
% % Create xlabel
% xlabel('Wealth (''000 $)','Interpreter','latex');
% 
% % Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 1000000]);
% box(axes1,'on');
% hold(axes1,'off');
% % Set the remaining axes properties
% set(axes1,'FontSize',11,'XTick',[0 250000 500000 750000 1000000],...
%     'XTickLabel',{'0','250','500','750','1000'});
% % Create axes
% axes2 = axes('Parent',figure1,...
%     'Position',[0.570340909090909 0.0879411764705882 0.334659090909091 0.341162790697674]);
% hold(axes2,'on');
% 
% % Create multiple line objects using matrix input to plot
% plot4 = plot(X1,YMatrix4,'Parent',axes2);
% set(plot4(1),'DisplayName','Benchmark - Exogenous Information (w/ NEW LOM',...
%     'LineWidth',3,...
%     'Color',[0 0.447058823529412 0.741176470588235]);
% set(plot4(2),'LineWidth',1,'LineStyle','--',...
%     'Color',[0.149019607843137 0.149019607843137 0.149019607843137]);
% 
% % Create xlabel
% xlabel('Wealth (''000 $)','Interpreter','latex');
% 
% % Uncomment the following line to preserve the X-limits of the axes
% xlim(axes2,[0 1000000]);
% box(axes2,'on');
% hold(axes2,'off');
% % Set the remaining axes properties
% set(axes2,'FontSize',11,'XTick',[0 250000 500000 750000 1000000],...
%     'XTickLabel',{'0','250','500','750','1000'});
% % Create textbox
% annotation(figure1,'textbox',...
%     [0.562971830985916 0.926470588235294 0.0539295774647887 0.0392156862745098],...
%     'String',{'$\times 10^{-3}$'},...
%     'Interpreter','latex',...
%     'FontSize',12,...
%     'FitBoxToText','off',...
%     'EdgeColor','none');
% 
% % Create textbox
% annotation(figure1,'textbox',...
%     [0.602408450704226 0.661764705882353 0.291957746478873 0.0563725490196079],...
%     'Color',[0 0.447058823529412 0.741176470588235],...
%     'String',{'Full Info (w/ benchmark l.o.m) -','Full Info'},...
%     'Interpreter','latex',...
%     'FontWeight','bold',...
%     'FontSize',12,...
%     'FitBoxToText','off',...
%     'EdgeColor','none');
% 
% % Create textbox
% annotation(figure1,'textbox',...
%     [0.153112676056339 0.725490196078431 0.187732394366197 0.0735294117647058],...
%     'Color',[0 0.447058823529412 0.741176470588235],...
%     'String',{'Benchmark-Full Info'},...
%     'Interpreter','latex',...
%     'FontWeight','bold',...
%     'FontSize',12,...
%     'FitBoxToText','off',...
%     'EdgeColor','none');
% 
% % Create textbox
% annotation(figure1,'textbox',...
%     [0.16156338028169 0.281862745098039 0.304633802816901 0.0882352941176471],...
%     'Color',[0 0.447058823529412 0.741176470588235],...
%     'String',{'Exogenous Info -','Full Info (both w/ benchmark l.o.m)'},...
%     'Interpreter','latex',...
%     'FontSize',12,...
%     'FitBoxToText','off',...
%     'EdgeColor','none');
% 
% % Create textbox
% annotation(figure1,'textbox',...
%     [0.606633802816901 0.156862745098039 0.307450704225352 0.102941176470588],...
%     'Color',[0 0.447058823529412 0.741176470588235],...
%     'String',{'Benchmark -','Exogenous Info (w/ benchmark l.o.m)'},...
%     'Interpreter','latex',...
%     'FontWeight','bold',...
%     'FontSize',12,...
%     'FitBoxToText','off',...
%     'EdgeColor','none');
% 
% f = gcf;  
% f.Position = [100, 100, 600, 353]; 
% set(f,'Renderer','opengl');  
% print(f, '_figures/figure_c1.pdf', '-dpdf', '-image');



% Create figure
figure1 = figure;

% Create subplot
subplot1 = subplot(2,2,1,'Parent',figure1);
hold(subplot1,'on');

% Create multiple line objects using matrix input to plot
plot1 = plot(X1,YMatrix1,'Parent',subplot1);
set(plot1(1),'DisplayName','Benchmark - Full Information','LineWidth',3,...
    'Color',[0 0.447058823529412 0.741176470588235]);
set(plot1(2),'LineWidth',1,'LineStyle','--',...
    'Color',[0.149019607843137 0.149019607843137 0.149019607843137]);

% Create xlabel
xlabel('Wealth (''000 $)','Interpreter','latex');

% Uncomment the following line to preserve the X-limits of the axes
xlim(subplot1,[0 1000000]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot1,[-0.0005 0.0015]);
box(subplot1,'on');
hold(subplot1,'off');
% Set the remaining axes properties
set(subplot1,'FontSize',11,'XTick',[0 250000 500000 750000 1000000],...
    'XTickLabel',{'0','250','500','750','1000'});
% Create subplot
subplot2 = subplot(2,2,2,'Parent',figure1);
hold(subplot2,'on');

% Create multiple line objects using matrix input to plot
plot2 = plot(X1,YMatrix2,'Parent',subplot2);
set(plot2(1),'DisplayName','Full Information w/ New LOM - Full Information',...
    'LineWidth',3,...
    'Color',[0 0.447058823529412 0.741176470588235]);
set(plot2(2),'LineWidth',1,'LineStyle','--',...
    'Color',[0.149019607843137 0.149019607843137 0.149019607843137]);

% Create xlabel
xlabel('Wealth (''000 $)','Interpreter','latex');

% Uncomment the following line to preserve the X-limits of the axes
xlim(subplot2,[0 1000000]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot2,[-0.0015 0.001]);
box(subplot2,'on');
hold(subplot2,'off');
% Set the remaining axes properties
set(subplot2,'FontSize',11,'XTick',[0 250000 500000 750000 1000000],...
    'XTickLabel',{'0','250','500','750','1000'},'YTickLabel',...
    {'-1.5','-1.0','-0.5','0','0.5','1.0'});
% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.13 0.0879411764705882 0.334659090909091 0.341162790697674]);
hold(axes1,'on');

% Create multiple line objects using matrix input to plot
plot3 = plot(X1,YMatrix3,'Parent',axes1);
set(plot3(1),...
    'DisplayName','Exogenous Information - Full Information (w/ NEW LOM',...
    'LineWidth',3,...
    'Color',[0 0.447058823529412 0.741176470588235]);
set(plot3(2),'LineWidth',1,'LineStyle','--',...
    'Color',[0.149019607843137 0.149019607843137 0.149019607843137]);

% Create xlabel
xlabel('Wealth (''000 $)','Interpreter','latex');

% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[0 1000000]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes1,[-0.001 0.004]);
box(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'FontSize',11,'XTick',[0 250000 500000 750000 1000000],...
    'XTickLabel',{'0','250','500','750','1000'});
% Create axes
axes2 = axes('Parent',figure1,...
    'Position',[0.570340909090909 0.0879411764705882 0.334659090909091 0.341162790697674]);
hold(axes2,'on');

% Create multiple line objects using matrix input to plot
plot4 = plot(X1,YMatrix4,'Parent',axes2);
set(plot4(1),'DisplayName','Benchmark - Exogenous Information (w/ NEW LOM',...
    'LineWidth',3,...
    'Color',[0 0.447058823529412 0.741176470588235]);
set(plot4(2),'LineWidth',1,'LineStyle','--',...
    'Color',[0.149019607843137 0.149019607843137 0.149019607843137]);

% Create xlabel
xlabel('Wealth (''000 $)','Interpreter','latex');

% Uncomment the following line to preserve the X-limits of the axes
xlim(axes2,[0 1000000]);
box(axes2,'on');
hold(axes2,'off');
% Set the remaining axes properties
set(axes2,'FontSize',11,'XTick',[0 250000 500000 750000 1000000],...
    'XTickLabel',{'0','250','500','750','1000'});
% Create textbox
annotation(figure1,'textbox',...
    [0.562971830985916 0.926470588235294 0.0539295774647887 0.0392156862745098],...
    'String',{'$\times 10^{-3}$'},...
    'Interpreter','latex',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.602408450704226 0.661764705882353 0.291957746478873 0.0563725490196079],...
    'Color',[0 0.447058823529412 0.741176470588235],...
    'String',{'Full Info (w/ benchmark l.o.m) -','Full Info'},...
    'Interpreter','latex',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.153112676056339 0.725490196078431 0.187732394366197 0.0735294117647058],...
    'Color',[0 0.447058823529412 0.741176470588235],...
    'String',{'Benchmark-Full Info'},...
    'Interpreter','latex',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.16156338028169 0.281862745098039 0.304633802816901 0.0882352941176471],...
    'Color',[0 0.447058823529412 0.741176470588235],...
    'String',{'Exogenous Info -','Full Info (both w/ benchmark l.o.m)'},...
    'Interpreter','latex',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.606633802816901 0.156862745098039 0.307450704225352 0.102941176470588],...
    'Color',[0 0.447058823529412 0.741176470588235],...
    'String',{'Benchmark -','Exogenous Info (w/ benchmark l.o.m)'},...
    'Interpreter','latex',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');

f = gcf;  
%f.Position = [100, 100, 600, 353]; 
set(f,'Renderer','opengl');  
print(f, '_figures/figure_c1.pdf', '-dpdf', '-image');