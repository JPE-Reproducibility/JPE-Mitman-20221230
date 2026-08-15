% FIGURE C4
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));
addpath(fullfile(scriptDir, '_aux'));


rng(11);

TT          = 7000;


%% [1] Baseline model
%load('model_1001_wPanel.mat');
load('model_1001.mat');

x1 = kdist_panel(:,1:TT)'; x1 = x1(:);
y1 = forecast_moments.fcerror_ur_up_4q_panel'; y1 = abs(y1(:));

percentile_x = prctile(x1,[10,20,40,60,80,50]);

bucket_10  = zeros(length(y1),1);
bucket_20  = zeros(length(y1),1);
bucket_40  = zeros(length(y1),1);
bucket_60  = zeros(length(y1),1);
bucket_80  = zeros(length(y1),1);
bucket_100 = zeros(length(y1),1);

for ii=1:length(y1)

    if x1(ii)<=percentile_x(1)

        bucket_10(ii) = 1;
    
    elseif x1(ii)>percentile_x(1) && x1(ii)<=percentile_x(2)

        bucket_20(ii) = 1;

    elseif x1(ii)>percentile_x(2) && x1(ii)<=percentile_x(3)

        bucket_40(ii) = 1;    

    elseif x1(ii)>percentile_x(3) && x1(ii)<=percentile_x(4)

        bucket_60(ii) = 1;

    elseif x1(ii)>percentile_x(4) && x1(ii)<=percentile_x(5)

        bucket_80(ii) = 1;

    elseif x1(ii)>percentile_x(5)

        bucket_100(ii) = 1;

    end

end

X = [ones(length(y1),1) bucket_10 bucket_20 bucket_40 bucket_60 bucket_80];
Y = y1;

b_1 = X\Y; 

b_1_norm = X\normalize(Y); 

percentile_old = percentile_x;

m_1  = mean(y1);

clearvars -except b_1 b_1_norm percentile_old m_1

%% [1] Extended model
%load('model_7009_panel.mat','panel','forecast_moments');
load('model_7009.mat','kdist_panel','forecast_moments');
TT          = 2000;

fcerror_ur_up_4q_panel = forecast_moments.fcerror_ur_up_4q_panel;
%kdist_panel            = panel.kdistT;

x1 = kdist_panel(:,end-TT+1:end)'; x1 = x1(:);
y1 = fcerror_ur_up_4q_panel'; y1 = abs(y1(:));

percentile_x = prctile(x1,[10,20,40,60,80,50]);

bucket_10  = zeros(length(y1),1);
bucket_20  = zeros(length(y1),1);
bucket_40  = zeros(length(y1),1);
bucket_60  = zeros(length(y1),1);
bucket_80  = zeros(length(y1),1);
bucket_100 = zeros(length(y1),1);

for ii=1:length(y1)

    if x1(ii)<=percentile_x(1)

        bucket_10(ii) = 1;
    
    elseif x1(ii)>percentile_x(1) && x1(ii)<=percentile_x(2)

        bucket_20(ii) = 1;

    elseif x1(ii)>percentile_x(2) && x1(ii)<=percentile_x(3)

        bucket_40(ii) = 1;    

    elseif x1(ii)>percentile_x(3) && x1(ii)<=percentile_x(4)

        bucket_60(ii) = 1;

    elseif x1(ii)>percentile_x(4) && x1(ii)<=percentile_x(5)

        bucket_80(ii) = 1;

    elseif x1(ii)>percentile_x(5)

        bucket_100(ii) = 1;

    end

end

X = [ones(length(y1),1) bucket_10 bucket_20 bucket_40 bucket_60 bucket_80];
Y = y1;

b_2 = X\Y; 

b_2_norm = X\normalize(Y); 

bucket_10_old  = zeros(length(y1),1);
bucket_20_old  = zeros(length(y1),1);
bucket_40_old  = zeros(length(y1),1);
bucket_60_old  = zeros(length(y1),1);
bucket_80_old  = zeros(length(y1),1);
bucket_100_old = zeros(length(y1),1);


for ii=1:length(y1)

    if x1(ii)<=percentile_old(1)

        bucket_10_old(ii) = 1;
    
    elseif x1(ii)>percentile_old(1) && x1(ii)<=percentile_old(2)

        bucket_20_old(ii) = 1;

    elseif x1(ii)>percentile_old(2) && x1(ii)<=percentile_old(3)

        bucket_40_old(ii) = 1;    

    elseif x1(ii)>percentile_old(3) && x1(ii)<=percentile_old(4)

        bucket_60_old(ii) = 1;

    elseif x1(ii)>percentile_old(4) && x1(ii)<=percentile_old(5)

        bucket_80_old(ii) = 1;

    elseif x1(ii)>percentile_old(5)

        bucket_100_old(ii) = 1;

    end

end


X = [ones(length(y1),1) bucket_10_old bucket_20_old bucket_40_old bucket_60_old bucket_80_old];
Y = y1;

m_2 = mean(y1);

b_2_old = X\Y; 

clearvars -except b_1 b_2 b_1_norm b_2_norm b_2_old m_2 m_1;



%% [xx] Plots


categories = {'0-10', '10-20', '20-40', '40-60', '60-80','80'};

b1_star     = [b_1(1)+ [b_1(2:end)' 0]]'- m_1;
b2_star     = [b_2(1)+ [b_2(2:end)' 0]]' - m_2;
values      = [b1_star b2_star];


figure1 = figure('Color',[1 1 1]);

axes1 = axes('Parent',figure1);
hold(axes1,'on');

bar1 = bar(values,'LineWidth',1.5);
set(bar1(2),'DisplayName','Benchmark','FaceColor',[0.6 0.8 1.0]);
set(bar1(1),'DisplayName','Extended','FaceColor',[1.0 0.8 0.6]);

text('Parent',axes1,'HorizontalAlignment','center','FontSize',11,...
    'String','0.10531',...
    'Position',[1 1.10531426481058 0]);

text('Parent',axes1,'HorizontalAlignment','center','FontSize',11,...
    'String','0.15353',...
    'Position',[2 1.15352876299916 0]);
text('Parent',axes1,'HorizontalAlignment','center','FontSize',11,...
    'String','0.13935',...
    'Position',[3 1.13934684304584 0]);

text('Parent',axes1,'HorizontalAlignment','center','FontSize',11,...
    'String','0.085185',...
    'Position',[4 1.08518497247357 0]);

text('Parent',axes1,'HorizontalAlignment','center','FontSize',11,...
    'String','-0.037956',...
    'Position',[5 0.962044042681465 0]);

text('Parent',axes1,'HorizontalAlignment','center','FontSize',11,...
    'String','-0.316',...
    'Position',[6 0.684002627272527 0]);
ylabel('Absolute Error');
xlabel('Wealth Percentile');
ylim(axes1,[-0.35 0.2]);
grid(axes1,'on');
hold(axes1,'off');
set(axes1,'FontSize',11,'XTick',[1 2 3 4 5 6],'XTickLabel',...
    {'0-10','10-20','20-40','40-60','60-80','80'},'YTick',...
    [-0.3 -0.2 -0.1 0 0.1 0.2]);
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.141071432328803 0.359523813942552 0.164285714285714 0.0678571428571428]);

figure1.Position = [100, 100, 600, 400]; 
set(figure1,'Renderer','opengl');  
print(figure1, '_figures/figure_c4.pdf', '-dpdf', '-image');

