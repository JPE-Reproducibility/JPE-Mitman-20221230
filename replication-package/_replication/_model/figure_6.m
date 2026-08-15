% Figure [6] 
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));


load('model_1001.mat');

opts = optimset('Display','off');

smpl_model  = 10000;
TT          = 7000;

start      = -750/1000;
stop       = 2000/1000;

rng(11);

adj_factor = 1/(38.1/10.26)*65300/4;


x1 = kdist_panel(:,1:TT)'; x1 = x1(:);
y1 = forecast_moments.fcerror_ur_up_4q_panel'; y1 = abs(y1(:));

k = randperm(size(x1,1), smpl_model);
k = sort(k');
x1_smpl  = x1(k, :);
y1_smpl  = y1(k,:);


Data      = [x1_smpl y1_smpl];
Data      = sortrows(Data);

tic;
y1_pred_1   = smooth(Data(:,1),Data(:,2),0.65,'loess');
toc;

x_model    = Data(:,1);            x1_model = x_model;     
y1_model   = normalize(y1_pred_1);

m_1_tmp    = mean(y1_pred_1);
s_1_tmp    = sqrt(var(y1_pred_1));


data = readtable('figure_6.csv');
data = data{:,:};

x1_data = data(:,1); 
y1_data = data(:,2);
se_data = data(:,3);

m1      = mean(y1_data);
s1      = sqrt(var(y1_data));

y  = (y1_data-m1)/s1;       
lo = y1_data - se_data;
lo = (lo-m1)/s1;              
hi = y1_data + se_data;
hi = (hi-m1)/s1;              
x  = x1_data;
x  = x/1000;

adj_tmp     = mean(x)/mean(x_model);  
x_model     = x_model*adj_tmp; 
data_tmp    = [x_model y1_model]; 

rowsToKeep  = data_tmp(:, 1) <= stop;
data_tmp    = data_tmp(rowsToKeep, :);

x1_smpl_unique = data_tmp(1,1);
y1_smpl_unique = data_tmp(1,2);
iter           = 1;
for ii=2:length(data_tmp)

    iter = iter + 1;

    if data_tmp(ii,1)-data_tmp(ii-1,1)==0
        tmpx =  [];
        tmpy =  [];
    else
        tmpx  = data_tmp(ii,1);
        tmpy  = data_tmp(ii,2);
    end

    x1_smpl_unique = [x1_smpl_unique; tmpx];
    y1_smpl_unique = [y1_smpl_unique; tmpy];

end

x_model_li  = [0:0.01:stop];
y_model_li  = interp1(x1_smpl_unique, y1_smpl_unique, x_model_li, 'linear');

m_2_tmp    = mean(y_model_li,'omitnan');
s_2_tmp    = sqrt(var(y_model_li,'omitnan'));


YData1 = [lo; hi(end:-1:1); lo(1)];   
XData1 = [x; x(end:-1:1); x(1)];

XData2 = x;                            
YData2 = y;

XData3 = x_model_li;                    
YData3 = normalize(y_model_li);

figure1 = figure;                    
axes1 = axes('Parent',figure1);
hold(axes1,'on');
patch('Parent',axes1,'YData',YData1,'XData',XData1,'FaceColor',[1 0.8 0.8], 'EdgeColor','none');

line(XData2,YData2,'Parent',axes1,'MarkerSize',7,'Marker','x','LineWidth',3, 'Color',[0.850980392156863 0.325490196078431 0.0980392156862745]);
line(XData3,YData3,'Parent',axes1,'LineWidth',3,'Color',[0 0.447058823529412 0.741176470588235]);

ylabel('Normalized Errors','Interpreter','latex');
xlabel('Wealth Level (''000 $)','Interpreter','latex');

xlim(axes1,[start stop]);
hold(axes1,'off');
set(axes1,'FontSize',12, 'XTick',[-0.4549 0 0.4549 0.9099 1.3649 1.82],'XTickLabel',{'-20','0','20','40','60','80'},...
    'YTick',[-2 -1 0 1 2],'YTickLabel',{'-2.0','-1.0','0','1.0','2.0'});

annotation(figure1,'line',[0.342857142857143 0.341428571428571], [0.109 0.915],  'Color',[0.650980392156863 0.650980392156863 0.650980392156863],  'LineStyle','--');
annotation(figure1,'textbox',[0.826714285714286 0.1425 0.130428571428572 0.0849999999999999],'Color',[0 0.447058823529412 0.741176470588235], 'String',{'Model'}, 'FontWeight','bold', 'FontSize',12,'FitBoxToText','off','EdgeColor','none');
annotation(figure1,'textbox',[0.822428571428572 0.295 0.0804285714285714 0.0750000000000001],'Color',[0.850980392156863 0.325490196078431 0.0980392156862745], 'String',{'Data'}, 'FontWeight','bold', 'FontSize',12,'FitBoxToText','off','EdgeColor','none');
f = gcf;  
f.Position = [100, 100, 600, 400]; 
set(f,'Renderer','opengl');  
print(f, '_figures/figure_6.pdf', '-dpdf', '-image');
