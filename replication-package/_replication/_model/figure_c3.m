% FIGURE C3
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux'));


rng(11);

TT          = 7000;


%% [1] Baseline model
%load('model_1001_wPanel.mat');
load('model_1001.mat');


x1 = kdist_panel(:,1:TT)'; x1 = x1(:);
y1 = forecast_moments.fcerror_ur_up_4q_panel'; y1 = abs(y1(:));

percentile_x = prctile(x1,[10,20,40,60,80]);

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

%% [1] Baseline model
load('model_1074.mat');

TT          = 7000;

x1 = kdist_panel(:,1:TT)'; x1 = x1(:);
y1 = forecast_moments.fcerror_ur_up_4q_panel'; y1 = abs(y1(:));

percentile_x = prctile(x1,[10,20,40,60,80]);

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

categories = {'0-10', '10-20', '20-40', '40-60', '60-80','>80'};

b1_star     = [b_1(1)+ [b_1(2:end)' 0]]'- m_1;
b2_star     = [b_2_old(1)+ [b_2_old(2:end)' 0]]' - m_2;
values      = [b1_star b2_star];

groupLabels = {'Benchmark', 'No-resource Cost'};  

colors = [1.0, 0.8, 0.6;  0.6, 0.8, 1.0];


f = figure('Color', 'w');
b = bar(values, 'grouped');
for i = 1:length(b)
    b(i).FaceColor = colors(i, :);
    b(i).EdgeColor = 'k';
    b(i).LineWidth = 1.5;
end

set(gca, 'XTickLabel', categories, 'XTick', 1:length(categories));

legend(groupLabels, 'Location', 'southwest');

ylabel('Absolute Error', 'FontSize', 12);
xlabel('Wealth Percentile', 'FontSize', 12);

title('', 'FontSize', 14, 'FontWeight', 'bold');
grid on;
box off;

for i = 1:length(values)
    text(i, values(i) + 1, num2str(values(i)), ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 11, 'Color', 'black');
end

ylim([-0.5 0.21]);
set(gca, 'FontSize', 11);

f.Position = [100, 100, 500, 300]; 
set(f,'Renderer','opengl');  
print(f, '_figures/figure_c3.pdf', '-dpdf', '-image');