% Figure 3 and 4
%------------------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
%addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));


TT          = 7000;
T_smpl      = 1000; 

rng(11);

adj_factor = 1/(38.1/10.26)*65300/4;

x_values         = [0:0.01:500]';
nn               = 2;

x_lim_fig7       = 300; 
x_lim_end        = 2000;


%% [1] Benchmark model
load('model_1001.mat','dec','params','moments','Kvec','kdist_panel', 'cah_panel');  % benchmark endogenous information model
%load('model_1001_wPanel.mat','dec','params','moments','Kvec','zvec','kdist_panel');  % benchmark endogenous information model
%load('cah_panel_ak.mat');

kdist_benchmark = kdist_panel(:,1:TT)'; 

vec_nsnpk_emp            = 2*linspace(1,params.npk,params.npk);
vec_nsnpk_unemp          = vec_nsnpk_emp-1; 

stdev_kbar               = std(Kvec(params.drop+1:end));
interp_kbar_mean         = moments.kbar_mean;
interp_kbar_meanplus     = moments.kbar_mean+stdev_kbar;
interp_kbar_meanminus    = moments.kbar_mean-stdev_kbar;

for ii=1:size(dec,1)

    dec_emp_noinf_boom_meankbar(ii)=interp1(params.Kgrid,squeeze(dec(ii,4,vec_nsnpk_emp)),interp_kbar_mean);
    dec_emp_inf_boom_meankbarplus(ii)=interp1(params.Kgrid,squeeze(dec(ii,7,vec_nsnpk_emp)),interp_kbar_meanplus);
    dec_emp_noinf_boom_meankbarplus(ii)=interp1(params.Kgrid,squeeze(dec(ii,4,vec_nsnpk_emp)),interp_kbar_meanplus);
    dec_emp_inf_boom_meankbar(ii)=interp1(params.Kgrid,squeeze(dec(ii,7,vec_nsnpk_emp)),interp_kbar_mean);
    dec_emp_noinf_rec_meankbar(ii)=interp1(params.Kgrid,squeeze(dec(ii,4,vec_nsnpk_emp)),interp_kbar_mean);
    dec_emp_inf_rec_meankbarminus(ii)=interp1(params.Kgrid,squeeze(dec(ii,1,vec_nsnpk_emp)),interp_kbar_meanminus);
    dec_emp_inf_rec_meankbar(ii)=interp1(params.Kgrid,squeeze(dec(ii,1,vec_nsnpk_emp)),interp_kbar_mean);


    dec_unemp_noinf_rec_meankbar(ii)=interp1(params.Kgrid,squeeze(dec(ii,4,vec_nsnpk_unemp)),interp_kbar_mean);
    dec_unemp_inf_rec_meankbarminus(ii)=interp1(params.Kgrid,squeeze(dec(ii,1,vec_nsnpk_unemp)),interp_kbar_meanminus);
    dec_unemp_inf_rec_meankbar(ii)=interp1(params.Kgrid,squeeze(dec(ii,1,vec_nsnpk_unemp)),interp_kbar_mean);
    dec_unemp_noinf_boom_meankbar(ii)=interp1(params.Kgrid,squeeze(dec(ii,4,vec_nsnpk_unemp)),interp_kbar_mean);
    dec_unemp_noinf_boom_meankbarplus(ii)=interp1(params.Kgrid,squeeze(dec(ii,4,vec_nsnpk_unemp)),interp_kbar_meanplus);
    dec_unemp_inf_boom_meankbarplus(ii)=interp1(params.Kgrid,squeeze(dec(ii,7,vec_nsnpk_unemp)),interp_kbar_meanplus);
    dec_unemp_inf_boom_meankbar(ii)=interp1(params.Kgrid,squeeze(dec(ii,7,vec_nsnpk_unemp)),interp_kbar_mean);
end

moments_bench = moments;
Kvec_bench    = Kvec; 


%% [2] Disposible Income as a Function of States
ns=params.ns;
for sc=1:params.ns
    for kc=1:params.npk
        for zc=1:2
            if params.gross_benefits==1 
                tax=params.u(zc)*params.b/((1-params.u(zc))+params.b*params.u(zc));
                taxe_mat(zc,sc+(kc-1)*ns) = tax;
                taxu_mat(zc,sc+(kc-1)*ns) = tax;
                taxeu=[tax;tax];
            else 
                tax=params.u(zc)*params.b/((1-params.u(zc))*params.lbar);
                taxe_mat(zc,sc+(kc-1)*ns) = tax;
                taxu_mat(zc,sc+(kc-1)*ns) = 0;
                taxeu=[0;tax];
            end
                r_mat(zc,sc+(kc-1)*ns)=params.z(zc)*params.alpha*(params.Kgrid(kc)/params.L(zc)).^(params.alpha-1);
                w_mat(zc,sc+(kc-1)*ns)=params.z(zc)*(1-params.alpha)*(params.Kgrid(kc)/params.L(zc)).^(params.alpha);
                if(sc==3 && ne==3) 
                taxe_mat(zc,sc+(kc-1)*ns)   = 0;
                w_mat(zc,sc+(kc-1)*ns)      = params.z(zc)*params.Kgrid(kc)^(params.alpha)*params.L(zc)^(1-params.alpha); %profits
            end
                
            ki(:,zc,sc+(kc-1)*ns)    = (params.Agrid -w_mat(zc,sc+(kc-1)*ns)*(params.e(sc)*(1-taxeu(sc))))/((1+r_mat(zc,sc+(kc-1)*ns)-params.delta-params.wtax)*(1-params.probdeath));% CHECK *(1-params.probdeath) - bracket missing?
            dispy(:,zc,sc+(kc-1)*ns) = params.Agrid-ki(:,zc,sc+(kc-1)*ns);
            

        end
    end
end



%% [3] Full-information model
load('model_1023_LOMendo.mat','dec','params','moments','Kvec', 'kdist_panel');  
%load('model_1023_LOMendo.mat','dec','params','moments','Kvec','zvec', 'kdist_panel');  
vec_nsnpk_emp            = 2*linspace(1,params.npk,params.npk);
vec_nsnpk_unemp          = vec_nsnpk_emp-1; 

moments_fi               = moments_bench;
stdev_kbar_fi            = std(Kvec_bench(params.drop+1:end));
interp_kbar_mean_fi      = moments_fi.kbar_mean;
interp_kbar_meanplus_fi  = moments_fi.kbar_mean+stdev_kbar_fi;
interp_kbar_meanminus_fi = moments_fi.kbar_mean-stdev_kbar_fi;
for ii=1:size(dec,1)


    dec_emp_boom_meankbar_fi(ii)       = interp1(params.Kgrid,squeeze(dec(ii,7,vec_nsnpk_emp)),interp_kbar_mean_fi);
    dec_emp_boom_meankbarplus_fi(ii)   = interp1(params.Kgrid,squeeze(dec(ii,7,vec_nsnpk_emp)),interp_kbar_meanplus_fi);

    dec_unemp_boom_meankbar_fi(ii)     = interp1(params.Kgrid,squeeze(dec(ii,7,vec_nsnpk_unemp)),interp_kbar_mean_fi);
    dec_unemp_boom_meankbarplus_fi(ii) = interp1(params.Kgrid,squeeze(dec(ii,7,vec_nsnpk_unemp)),interp_kbar_meanplus_fi);

    dec_emp_rec_meankbar_fi(ii)        = interp1(params.Kgrid,squeeze(dec(ii,1,vec_nsnpk_emp)),interp_kbar_mean_fi);
    dec_emp_rec_meankbarminus_fi(ii)   = interp1(params.Kgrid,squeeze(dec(ii,1,vec_nsnpk_emp)),interp_kbar_meanminus_fi);

    dec_unemp_rec_meankbar_fi(ii)      = interp1(params.Kgrid,squeeze(dec(ii,1,vec_nsnpk_unemp)),interp_kbar_mean_fi);
    dec_unemp_rec_meankbarminus_fi(ii) = interp1(params.Kgrid,squeeze(dec(ii,1,vec_nsnpk_unemp)),interp_kbar_meanminus_fi);


    scale_emp_boom_meankbar_fi(ii)       = interp1(params.Kgrid,squeeze(dispy(ii,2,vec_nsnpk_emp)),interp_kbar_mean_fi);
    scale_emp_boom_meankbarplus_fi(ii)   = interp1(params.Kgrid,squeeze(dispy(ii,2,vec_nsnpk_emp)),interp_kbar_meanplus_fi);

    scale_unemp_boom_meankbar_fi(ii)     = interp1(params.Kgrid,squeeze(dispy(ii,2,vec_nsnpk_unemp)),interp_kbar_mean_fi);
    scale_unemp_boom_meankbarplus_fi(ii) = interp1(params.Kgrid,squeeze(dispy(ii,2,vec_nsnpk_unemp)),interp_kbar_meanplus_fi);

    scale_emp_rec_meankbar_fi(ii)        = interp1(params.Kgrid,squeeze(dispy(ii,1,vec_nsnpk_emp)),interp_kbar_mean_fi);
    scale_emp_rec_meankbarminus_fi(ii)   = interp1(params.Kgrid,squeeze(dispy(ii,1,vec_nsnpk_emp)),interp_kbar_meanminus_fi);

    scale_unemp_rec_meankbar_fi(ii)      = interp1(params.Kgrid,squeeze(dispy(ii,1,vec_nsnpk_unemp)),interp_kbar_mean_fi);
    scale_unemp_rec_meankbarminus_fi(ii) = interp1(params.Kgrid,squeeze(dispy(ii,1,vec_nsnpk_unemp)),interp_kbar_meanminus_fi);

end


%% [4] Figures
load('model_1023.mat','kdist_panel'); 

kdist_fullinformation = kdist_panel(:,1:TT)'; 

kdist_errors = kdist_benchmark-kdist_fullinformation;
data1        = kdist_errors(:)*adj_factor;

figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
histogram(data1,'Parent',axes1,'FaceAlpha',0.7,'EdgeColor','none',...
    'FaceColor',[0.3 0.6 0.9],...
    'Normalization','pdf',...
    'BinWidth',5000);
xline(0,'Parent',axes1,'LineStyle','--','Color',[0 0 0],'LineWidth',1.2);
ylabel('Density','Interpreter','latex');
xlabel('Savings Errors (''000 $)','Interpreter','latex');
xlim(axes1,[-40000 40000]);
ylim(axes1,[0 5.1e-05]);
grid(axes1,'on');
hold(axes1,'off');
set(axes1,'FontSize',12,'LineWidth',1,'TickDir','out','XTick',[-40000 -30000 -20000 -10000 0 10000 20000 30000 40000], 'XTickLabel',...
    {'-40','-30', '-20', '-10','0','10', '20', '30','40'},'YTick',...
    [0 1e-05 2e-05 3e-05 4e-05 5e-05]);
annotation(figure1,'textbox',...
    [0.131357142857142 0.728571428571433 0.466857142857144 0.176190476190479],...
    'Color',[0 0.447058823529412 0.741176470588235],...
    'String',{'Probability','Density Function'},...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');
set(figure1,'Renderer','opengl');  
print(figure1, '_figures/figure_3a.pdf', '-dpdf', '-image');


X1       = log(params.Agrid/(38.1/10.26)*65300/4);
YMatrix1 = [(dec_emp_inf_boom_meankbarplus-dec_emp_boom_meankbarplus_fi)./scale_emp_boom_meankbarplus_fi*100; %cash-at-hand
            (dec_emp_inf_rec_meankbarminus-dec_emp_rec_meankbarminus_fi)./scale_emp_rec_meankbarminus_fi*100;
            (dec_unemp_inf_boom_meankbarplus-dec_unemp_boom_meankbarplus_fi)./scale_unemp_boom_meankbarplus_fi*100;
            (dec_unemp_inf_rec_meankbarminus-dec_unemp_rec_meankbarminus_fi)./scale_unemp_rec_meankbarminus_fi*100]; 
YMatrix2 = [smoothdata(YMatrix1(1,:), 'sgolay', 6);
            smoothdata(YMatrix1(2,:), 'sgolay', 6);
            smoothdata(YMatrix1(3,:), 'sgolay', 6);
            smoothdata(YMatrix1(4,:), 'sgolay', 10)];
YMatrix2 = YMatrix1; 
X_hist   = log(cah_panel(:)/(38.1/10.26)*65300/4);


figure2 = figure;
axes1 = axes('Parent',figure2,'Position',[0.13 0.11 0.775 0.815],'YTick',[-4 -3 -2 -1 0 1 2 3 4]);
hold(axes1,'on');
yyaxis(axes1,'left');
plot1 = plot(X1,YMatrix2,'LineWidth',2.5,'Parent',axes1);
set(plot1(1),'DisplayName','Employed ($z_h$, lhs)','LineStyle','--',...
    'Color',[0.850980392156863 0.325490196078431 0.0980392156862745]);
set(plot1(2),'DisplayName','Employed ($z_l$, lhs)','LineStyle','-',...
    'Color',[0.850980392156863 0.325490196078431 0.0980392156862745]);
set(plot1(3),'DisplayName','Unemployed ($z_h$, lhs)','LineStyle','--',...
    'Color',[0 0.447058823529412 0.741176470588235]);
set(plot1(4),'DisplayName','Unemployed ($z_l$, lhs)','LineStyle','-',...
    'Color',[0 0.447058823529412 0.741176470588235]);
ylabel('Percent of Income','Interpreter','latex');
ylim(axes1,[-8 8]);
set(axes1,'YColor',[0.149019607843137 0.149019607843137 0.149019607843137], 'YTick',[-8 -6 -4 -2 0 2 4 6 8]);
yyaxis(axes1,'right');
h = histogram(X_hist, ...
    'Normalization','pdf', ...   
    'FaceAlpha',0.2, ...         
    'EdgeColor','none', ...      
    'FaceColor',[0.5 0.5 0.5], ... 
    'HandleVisibility','off');   
ylabel('Density','Interpreter','latex');
set(axes1,'YColor',[0.149019607843137 0.149019607843137 0.149019607843137], 'YTick',[0 0.1 0.2 0.3 0.4]);
xlabel('Cash-at-hand (''000 \$)','Interpreter','latex');
xlim(axes1,[7.98447909502792 14]);
box(axes1,'on');
hold(axes1,'off');
set(axes1,'FontSize',12,'XTick',[8.0064 9.2 9.9 10.6 11.5 12.5 13.6],'XTickLabel',{'3','10','20','40','100','250','750'});
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.136878635315062 0.741238101323447 0.291421263558524 0.16395236878168],...
    'Interpreter','latex',...
    'FontSize',13.2,...
    'EdgeColor','none');
annotation(figure2,'textbox',...
    [0.683142857142855 0.735714285714288 0.207928571428572 0.0857142857142901],...
    'Color',[0.501960784313725 0.501960784313725 0.501960784313725],...
    'String',{'Cash-at-hand Distribution (rhs)'},...
    'Interpreter','latex',...
    'FontSize',13.2,...
    'FitBoxToText','off',...
    'EdgeColor','none');
annotation(figure2,'textbox',...
    [0.161714285714286 0.133333333333334 0.0793571428571428 0.0571428571428579],...
    'String','$m_{min}$',...
    'Interpreter','latex',...
    'FontSize',13.2,...
    'FitBoxToText','off',...
    'EdgeColor','none');
x99 = 13.6965;  
xL = xlim(axes1);
axpos = axes1.Position; 
x_norm = axpos(1) + axpos(3) * (x99 - xL(1)) / (xL(2) - xL(1));
annotation(figure2,'textbox', ...
    [x_norm-0.02  0.1333  0.08  0.057], ...   
    'String','$m_{99}$', 'Interpreter','latex', ...
    'FontSize',13.2, 'FitBoxToText','off', 'EdgeColor','none');
set(figure2,'Renderer','opengl');  
print(figure2, '_figures/figure_3b.pdf', '-dpdf', '-image');



YMatrix1 = [(dec_emp_inf_boom_meankbar-dec_emp_noinf_boom_meankbar)./scale_emp_boom_meankbar_fi*100;
            (dec_emp_inf_rec_meankbar-dec_emp_noinf_rec_meankbar)./scale_emp_rec_meankbar_fi*100;
            (dec_unemp_inf_boom_meankbar-dec_unemp_noinf_boom_meankbar)./scale_unemp_boom_meankbar_fi*100;
            (dec_unemp_inf_rec_meankbar-dec_unemp_noinf_rec_meankbar)./scale_unemp_rec_meankbar_fi*100]; 
figure3 = figure;

axes1 = axes('Parent',figure3,'Position',[0.13 0.11 0.775 0.815],'YTick',[-4 -3 -2 -1 0 1 2 3 4]);
hold(axes1,'on');
yyaxis(axes1,'left');
plot1 = plot(X1,YMatrix1,'LineWidth',2.5,'Parent',axes1);
set(plot1(1),'DisplayName','Employed ($z_h$, lhs)','LineStyle','--',...
    'Color',[0.850980392156863 0.325490196078431 0.0980392156862745]);
set(plot1(2),'DisplayName','Employed ($z_l$, lhs)','LineStyle','-',...
    'Color',[0.850980392156863 0.325490196078431 0.0980392156862745]);
set(plot1(3),'DisplayName','Unemployed ($z_h$, lhs)','LineStyle','--',...
    'Color',[0 0.447058823529412 0.741176470588235]);
set(plot1(4),'DisplayName','Unemployed ($z_l$, lhs)','LineStyle','-',...
    'Color',[0 0.447058823529412 0.741176470588235]);
ylabel('Percent of Income','Interpreter','latex');
ylim(axes1,[-8 8]);
set(axes1,'YColor',[0.149019607843137 0.149019607843137 0.149019607843137], 'YTick',[-8 -6 -4 -2 0 2 4 6 8]);
yyaxis(axes1,'right');
h = histogram(X_hist, ...
    'Normalization','pdf', ...   
    'FaceAlpha',0.2, ...         
    'EdgeColor','none', ...      
    'FaceColor',[0.5 0.5 0.5], ... 
    'HandleVisibility','off');   
ylabel('Density','Interpreter','latex');
set(axes1,'YColor',[0.149019607843137 0.149019607843137 0.149019607843137], 'YTick',[0 0.1 0.2 0.3 0.4]);
xlabel('Cash-at-hand (''000 \$)','Interpreter','latex');
xlim(axes1,[7.98447909502792 14]);
box(axes1,'on');
hold(axes1,'off');
set(axes1,'FontSize',12,'XTick',[8.0064 9.2 9.9 10.6 11.5 12.5 13.6],'XTickLabel',{'3','10','20','40','100','250','750'});
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.136878635315062 0.741238101323447 0.291421263558524 0.16395236878168],...
    'Interpreter','latex',...
    'FontSize',13.2,...
    'EdgeColor','none',...
    'Color','none');
annotation(figure3,'textbox',...
    [0.683142857142855 0.735714285714288 0.207928571428572 0.0857142857142901],...
    'Color',[0.501960784313725 0.501960784313725 0.501960784313725],...
    'String',{'Cash-at-hand Distribution (rhs)'},...
    'Interpreter','latex',...
    'FontSize',13.2,...
    'FitBoxToText','off',...
    'EdgeColor','none');
annotation(figure3,'textbox',...
    [0.161714285714286 0.133333333333334 0.0793571428571428 0.0571428571428579],...
    'String','$m_{min}$',...
    'Interpreter','latex',...
    'FontSize',13.2,...
    'FitBoxToText','off',...
    'EdgeColor','none');
x99 = 13.6965;  
xL = xlim(axes1);
axpos = axes1.Position; 
x_norm = axpos(1) + axpos(3) * (x99 - xL(1)) / (xL(2) - xL(1));
annotation(figure3,'textbox', ...
    [x_norm-0.02  0.1333  0.08  0.057], ...   
    'String','$m_{99}$', 'Interpreter','latex', ...
    'FontSize',13.2, 'FitBoxToText','off', 'EdgeColor','none');
set(figure3,'Renderer','opengl');  
print(figure3, '_figures/figure_4a.pdf', '-dpdf', '-image');


YMatrix1 = [(dec_emp_inf_boom_meankbarplus-dec_emp_noinf_boom_meankbar)./scale_emp_boom_meankbar_fi*100;
            (dec_emp_inf_rec_meankbarminus-dec_emp_noinf_rec_meankbar)./scale_emp_rec_meankbar_fi*100;
            (dec_unemp_inf_boom_meankbarplus-dec_unemp_noinf_boom_meankbar)./scale_unemp_boom_meankbar_fi*100;
            (dec_unemp_inf_rec_meankbarminus-dec_unemp_noinf_rec_meankbar)./scale_unemp_rec_meankbar_fi*100]; 

figure4 = figure;

axes1 = axes('Parent',figure4,'Position',[0.13 0.11 0.775 0.815],'YTick',[-4 -3 -2 -1 0 1 2 3 4]);
hold(axes1,'on');
yyaxis(axes1,'left');
plot1 = plot(X1,YMatrix1,'LineWidth',2.5,'Parent',axes1);
set(plot1(1),'DisplayName','Employed ($z_h + \sigma(K_t)$, lhs)','LineStyle','--',...
    'Color',[0.850980392156863 0.325490196078431 0.0980392156862745]);
set(plot1(2),'DisplayName','Employed ($z_l - \sigma(K_t)$, lhs)','LineStyle','-',...
    'Color',[0.850980392156863 0.325490196078431 0.0980392156862745]);
set(plot1(3),'DisplayName','Unemployed ($z_h + \sigma(K_t)$, lhs)','LineStyle','--',...
    'Color',[0 0.447058823529412 0.741176470588235]);
set(plot1(4),'DisplayName','Unemployed ($z_l - \sigma(K_t)$, lhs)','LineStyle','-',...
    'Color',[0 0.447058823529412 0.741176470588235]);
ylabel('Percent of Income','Interpreter','latex');
ylim(axes1,[-8 8]);
set(axes1,'YColor',[0.149019607843137 0.149019607843137 0.149019607843137], 'YTick',[-8 -6 -4 -2 0 2 4 6 8]);
yyaxis(axes1,'right');
h = histogram(X_hist, ...
    'Normalization','pdf', ...  
    'FaceAlpha',0.2, ...         
    'EdgeColor','none', ...      
    'FaceColor',[0.5 0.5 0.5], ... 
    'HandleVisibility','off');   
ylabel('Density','Interpreter','latex');
set(axes1,'YColor',[0.149019607843137 0.149019607843137 0.149019607843137], 'YTick',[0 0.1 0.2 0.3 0.4]);
xlabel('Cash-at-hand (''000 \$)','Interpreter','latex');
xlim(axes1,[7.98447909502792 14]);
box(axes1,'on');
hold(axes1,'off');
set(axes1,'FontSize',12,'XTick',[8.0064 9.2 9.9 10.6 11.5 12.5 13.6],'XTickLabel',{'3','10','20','40','100','250','750'});
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.136878635315062 0.741238101323447 0.291421263558524 0.16395236878168],...
    'Interpreter','latex',...
    'FontSize',13.2,...
    'EdgeColor','none',...
    'Color','none');
annotation(figure4,'textbox',...
    [0.683142857142855 0.735714285714288 0.207928571428572 0.0857142857142901],...
    'Color',[0.501960784313725 0.501960784313725 0.501960784313725],...
    'String',{'Cash-at-hand Distribution (rhs)'},...
    'Interpreter','latex',...
    'FontSize',13.2,...
    'FitBoxToText','off',...
    'EdgeColor','none');
annotation(figure4,'textbox',...
    [0.161714285714286 0.133333333333334 0.0793571428571428 0.0571428571428579],...
    'String','$m_{min}$',...
    'Interpreter','latex',...
    'FontSize',13.2,...
    'FitBoxToText','off',...
    'EdgeColor','none');
x99 = 13.6965;  % or prctile(X_hist,99);
xL = xlim(axes1);
axpos = axes1.Position; 
x_norm = axpos(1) + axpos(3) * (x99 - xL(1)) / (xL(2) - xL(1));
annotation(figure4,'textbox', ...
    [x_norm-0.02  0.1333  0.08  0.057], ...   
    'String','$m_{99}$', 'Interpreter','latex', ...
    'FontSize',13.2, 'FitBoxToText','off', 'EdgeColor','none');
set(figure4,'Renderer','opengl');  
print(figure4, '_figures/figure_4b.pdf', '-dpdf', '-image');
