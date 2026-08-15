% Figure [B.2] 
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
stop2      = 3*stop;

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

y1_pred_1   = smooth(Data(:,1),Data(:,2),0.65,'loess');

x_model    = Data(:,1);            x1_model = x_model;     
y1_model   = normalize(y1_pred_1); 

m_1_tmp    = mean(y1_pred_1);
s_1_tmp    = sqrt(var(y1_pred_1));

k80        = prctile(Data(:,1),80);
m80        = mean(Data(Data(:,1) > k80, :)); m80 =m80(:,2);


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


adj_tmp = 1000*mean(x1_model)/mean(x1_data);

x_interp      = [min(x):0.01:stop2];
y_interp      = interp1(x,y,x_interp,'linear','extrap');
lo_interp     = interp1(x,lo,x_interp,'linear','extrap');
hi_interp     = interp1(x,hi,x_interp,'linear','extrap');

x_model_interp = [0:0.01:stop2];
y_model_interp = interp1(x1_smpl_unique, y1_smpl_unique, x_model_interp, 'linear','extrap');

XData1 = [x_interp'; x_interp(end:-1:1)'; x_interp(1)']*adj_tmp;
YData1 = [lo_interp'; hi_interp(end:-1:1)'; lo_interp(1)'];     
YData1 = m_2_tmp+s_2_tmp*YData1;
YData1 = m_1_tmp+s_1_tmp*YData1;
YData1 = YData1/m80;

XData2 = x_interp'*adj_tmp;               
YData2 = y_interp';
YData2 = m_2_tmp+s_2_tmp*YData2;
YData2 = m_1_tmp+s_1_tmp*YData2;
YData2 = YData2/m80;

XData3 = x_model_interp'*adj_tmp;                
YData3 = y_model_interp';
YData3 = (m_1_tmp+s_1_tmp*(y_model_interp'))/m80;

figure1 = figure;                       
axes1 = axes('Parent',figure1);
hold(axes1,'on');
patch('Parent',axes1,'YData',YData1,'XData',XData1,'FaceColor',[1 0.8 0.8], 'EdgeColor','none');

line(XData2,YData2,'Parent',axes1,'MarkerSize',7,'Marker','x','LineWidth',3, 'Color',[0.850980392156863 0.325490196078431 0.0980392156862745]);
line(XData3,YData3,'Parent',axes1,'LineWidth',3,'Color',[0 0.447058823529412 0.741176470588235]);

ylabel('Normalized Errors Relative to 80th Percentile','Interpreter','latex');
xlabel('Wealth Level (''000 $)','Interpreter','latex');

xlim(axes1,[start*adj_tmp stop2*adj_tmp]);
hold(axes1,'off');
set(axes1,'FontSize',12,'YTickLabel',{'0.2','0.4','0.6','0.8','1.0','1.2','1.4','1.6'});

annotation(figure1,'line',[0.217142857142858 0.215714285714286], [0.1065 0.9125], 'Color',[0.650980392156863 0.650980392156863 0.650980392156863], 'LineStyle','--');
annotation(figure1,'textbox',[0.826714285714286 0.1425 0.130428571428572 0.0849999999999999],'Color',[0 0.447058823529412 0.741176470588235], 'String',{'Model'}, 'FontWeight','bold', 'FontSize',12,'FitBoxToText','off','EdgeColor','none');
annotation(figure1,'textbox',[0.822428571428572 0.295 0.0804285714285714 0.0750000000000001],'Color',[0.850980392156863 0.325490196078431 0.0980392156862745], 'String',{'Data'}, 'FontWeight','bold', 'FontSize',12,'FitBoxToText','off','EdgeColor','none');
f = gcf;  
f.Position = [100, 100, 600, 400]; 
set(f,'Renderer','opengl');  
print(f, '_figures/figure_B2.pdf', '-dpdf', '-image');


