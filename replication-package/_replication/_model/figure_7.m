% Figure 7
%------------------------------------------------------------------------

clc
clear
close all



scriptDir = fileparts(mfilename('fullpath'));
datapath = [scriptDir '/_aux/_models_tmp/']; 
shockpath = [scriptDir '/_aux/_models_tmp/'];
printlocation = [scriptDir '/_figures/'];%'D:\Dropbox (Personal)\BKKS Kathrin local\testfigures_replication\';

Nwindow = 32;
oldpath = path;
addpath([scriptDir '/_aux/_baseline']);

models_to_run = [1001 1026 1023];


%% compute impulse responses

% NewShocks.mat is not distributed (~7.8 GB); make_shocks.m regenerates it.
% Set to 1 to force a redraw here instead.
generate_new_shocks = ~exist([shockpath 'NewShocks.mat'],'file');
if generate_new_shocks==1
    %draw shocks
    fprintf('generating shocks... ')
    load([datapath 'model_1001'],'params')
    [ishocks,xshocks,kapshocks,kinfoshocks,zvec,death] = genShocks(params);
    save([shockpath 'NewShocks.mat'],'ishocks', 'xshocks', 'kapshocks', 'kinfoshocks', 'zvec','death','-v7.3')
end
shockfile = [shockpath 'NewShocks.mat'];

for im=1:length(models_to_run)

    fprintf('model %d... ' ,im)
    %load the results:
    loadResultsFile = ['model_' int2str(models_to_run(im))];
    load([datapath loadResultsFile])  

    %simulate the full model
    fprintf('simulating the full model... ')
    load(shockfile)
    if(params.nx==1)
        xshocks=ones(size(xshocks));
    end
    mainshocks.xshocks=xshocks;
    mainshocks.ishocks=ishocks;
    mainshocks.kapshocks=kapshocks;
    mainshocks.kinfoshocks=kinfoshocks;
    mainshocks.death = death;
    dists.kdist=kdist0;     
    dists.pdist=pdist0;
    dists.pKdist=pKdist0;
    [Kvec,dists_out2,panel,stats,Kvec_u,Kvec_e]=simKS(dec,ipol,dists,zvec,mainshocks,params);
    clear xshocks ishocks kapshocks kinfoshocks death Kvec dists_out2 stats Kvec_u Kvec_e
    mainshocks.xshocks=mainshocks.xshocks(:,params.drop+1:end);
    mainshocks.ishocks=mainshocks.ishocks(:,params.drop+1:end);
    mainshocks.kapshocks=mainshocks.kapshocks(:,params.drop+1:end);
    mainshocks.kinfoshocks=mainshocks.kinfoshocks(:,params.drop+1:end);
    mainshocks.death = mainshocks.death(:,params.drop+1:end);
    mainshocks.zvec = zvec(params.drop+1:end);
    panel.kdistT = panel.kdistT(:,params.drop+1:end);
    panel.pKdistT = panel.pKdistT(:,params.drop+1:end);
    panel.pdistT = panel.pdistT(:,params.drop+1:end);

    %flag transitions from boom->bust and vice versa
    ind_shock_neg = [0;(mainshocks.zvec(2:end-Nwindow-1)==1 & mainshocks.zvec(1:end-1-Nwindow-1)==2)];
    ind_shock_pos = [0;(mainshocks.zvec(2:end-Nwindow-1)==2 & mainshocks.zvec(1:end-1-Nwindow-1)==1)];
    
    t_shock_neg = find(ind_shock_neg==1);
    t_shock_pos = find(ind_shock_pos==1);

    cutoff = 5000;
    if length(t_shock_neg)>cutoff
        t_shock_neg = t_shock_neg(1:cutoff);
    end
    if length(t_shock_pos)>cutoff
        t_shock_pos = t_shock_pos(1:cutoff);
    end

    %compute counterfactual shock series and resimulate
    fprintf('simulating the counterfactuals... ')
    zvec_trans_neg = NaN(length(t_shock_neg),Nwindow+1,2);
    Kvec_trans_neg = NaN(length(t_shock_neg),Nwindow+1,2);
    c_trans_neg = NaN(length(t_shock_neg),Nwindow,2);
    pK_trans_neg = NaN(length(t_shock_neg),Nwindow+1,2);
    pK_w_trans_neg = NaN(length(t_shock_neg),Nwindow+1,2);
    info_trans_neg = NaN(length(t_shock_neg),Nwindow+1,2);

    rng(140324,'twister');
    for i_shock = 1:length(t_shock_neg)
        if t_shock_neg(i_shock)+Nwindow>length(mainshocks.zvec)
            break
        end

        %Use Quasi-random numbers to get distributions right
        deepshocks.urandv  = rand(params.N,Nwindow+1);
        deepshocks.xrand = rand(params.N,Nwindow+1);
        deepshocks.kapshocks = rand(params.N,Nwindow+1); 
        deepshocks.kinfoshocks = rand(params.N,Nwindow+1); 
        deepshocks.zshocks = rand(1,Nwindow+1);
        deepshocks.deathshocks = rand(params.N,Nwindow+1);

        distinit.ishocks = mainshocks.ishocks(:,t_shock_neg(i_shock)-1);
        distinit.xshocks = mainshocks.xshocks(:,t_shock_neg(i_shock)-1);
        dists.kdist=panel.kdistT(:,t_shock_neg(i_shock)-1);     
        dists.pdist=panel.pdistT(:,t_shock_neg(i_shock)-1);
        dists.pKdist=panel.pKdistT(:,t_shock_neg(i_shock)-1);
        param_local = params;
        param_local.T = Nwindow+1;

        %with shock
        zinit = [mainshocks.zvec(t_shock_neg(i_shock)-1),1];

        [ishocks,xshocks,kapshocks,kinfoshocks,zvec,death]  = genShocks_GIRFs(params,zinit,deepshocks,distinit,Nwindow);
        shocks.xshocks=xshocks;
        shocks.ishocks=ishocks;
        shocks.kapshocks=kapshocks;
        shocks.kinfoshocks=kinfoshocks;
        shocks.death = death; 
        [Kvec_tmp,~,panel_tmp,stats_tmp] =simKS(dec,ipol,dists,zvec,shocks,param_local);
        Kvec_trans_neg(i_shock,:,1) = Kvec_tmp;
        zvec_trans_neg(i_shock,:,1) = zvec';
        ccross = panel_tmp.cahT(:,1:end-1)-panel_tmp.kdistT(:,2:end)-params.nu*panel_tmp.info_acT(:,1:end-1); 
        c_trans_neg(i_shock,:,1) = mean(ccross);
        pK_trans_neg(i_shock,:,1) = mean(panel_tmp.pKdistT);
        pK_w_trans_neg(i_shock,:,1) = mean(panel_tmp.pKdistT.*panel_tmp.cahT.*repmat(sum(panel_tmp.cahT).^(-1),size(panel_tmp.cahT,1),1));
        info_trans_neg(i_shock,:,1) = mean(panel_tmp.info_acT);

        %without shock
        zinit = [mainshocks.zvec(t_shock_neg(i_shock)-1),2];

        [ishocks,xshocks,kapshocks,kinfoshocks,zvec,death]  = genShocks_GIRFs(params,zinit,deepshocks,distinit,Nwindow);
        shocks.xshocks=xshocks;
        shocks.ishocks=ishocks;
        shocks.kapshocks=kapshocks;
        shocks.kinfoshocks=kinfoshocks;
        shocks.death = death; 
        [Kvec_tmp,~,panel_tmp,stats_tmp] =simKS(dec,ipol,dists,zvec,shocks,param_local);
        Kvec_trans_neg(i_shock,:,2) = Kvec_tmp;
        zvec_trans_neg(i_shock,:,2) = zvec';
        ccross = panel_tmp.cahT(:,1:end-1)-panel_tmp.kdistT(:,2:end)-params.nu*panel_tmp.info_acT(:,1:end-1); 
        c_trans_neg(i_shock,:,2) = mean(ccross);        
        pK_trans_neg(i_shock,:,2) = mean(panel_tmp.pKdistT);
        pK_w_trans_neg(i_shock,:,2) = mean(panel_tmp.pKdistT.*panel_tmp.cahT.*repmat(sum(panel_tmp.cahT).^(-1),size(panel_tmp.cahT,1),1));
        info_trans_neg(i_shock,:,2) = mean(panel_tmp.info_acT);

    end

    %calculate output, investment, and consumption
    a         = params.z;
    ur_b      = params.u(1);
    ur_g      = params.u(2);
    alpha     = params.alpha;
    delta     = params.delta;

    invest_trans_neg = Kvec_trans_neg(:,2:end,:)-(1-delta)*Kvec_trans_neg(:,1:end-1,:);

    prod_ag_neg = (zvec_trans_neg==1)*a(1) + (zvec_trans_neg==2)*a(2);
    labor_ag_neg = (zvec_trans_neg==1)*(1-ur_b) + (zvec_trans_neg==2)*(1-ur_g);
    y_trans_neg=prod_ag_neg.*Kvec_trans_neg.^alpha.*labor_ag_neg.^(1-alpha);
    
   
    %express as percentage deviations from state when shock hits
    invest_trans_neg_IRF = (invest_trans_neg(:,:,1)./invest_trans_neg(:,:,2) -1)*100; 
    y_trans_neg_IRF = (y_trans_neg(:,:,1)./y_trans_neg(:,:,2) -1)*100; 
    Kvec_trans_neg_IRF = (Kvec_trans_neg(:,:,1)./Kvec_trans_neg(:,:,2) -1)*100; 
    c_trans_neg_IRF = (c_trans_neg(:,:,1)./c_trans_neg(:,:,2) -1)*100; 
    pK_trans_neg_IRF = (pK_trans_neg(:,:,1)./pK_trans_neg(:,:,2) -1)*100; 
    pK_w_trans_neg_IRF = (pK_w_trans_neg(:,:,1)./pK_w_trans_neg(:,:,2) -1)*100; 
    info_trans_neg_IRF = (info_trans_neg(:,:,1)./info_trans_neg(:,:,2) -1)*100; 
      

    %save
    fprintf('saving... ')
    save([datapath loadResultsFile '_GIRF'],'params', ...
        'Kvec_trans_neg', 'zvec_trans_neg', 'y_trans_neg', 'invest_trans_neg', 'c_trans_neg', ...
        'pK_trans_neg', 'pK_w_trans_neg', 'info_trans_neg', ...
        'Kvec_trans_neg_IRF', 'y_trans_neg_IRF', 'invest_trans_neg_IRF','c_trans_neg_IRF', ...
        'pK_trans_neg_IRF', 'pK_w_trans_neg_IRF', 'info_trans_neg_IRF', ...
        '-v7.3')  
    fprintf('done \n ')
    clearvars -except models_to_run path shockpath datapath im Nwindow shockfile printlocation
end




%% make plots

variables = {'Kvec','y','invest','prod'};%
shocklabels = {'neg'};%

plotuntilquarter = 30;
print_figures = 1;

set(0,'DefaultFigureWindowStyle','docked') %'normal' 'docked'
set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'DefaultAxesTickLabelInterpreter', 'latex');
set(groot, 'DefaultLegendInterpreter', 'latex');


for im=1:length(models_to_run)

    %load the results:
    loadResultsFile = ['model_' int2str(models_to_run(im))];
    load([datapath loadResultsFile '_GIRF'])   

    for is = 1:length(shocklabels)
        eval(['T_' shocklabels{is} ' = size(Kvec_trans_' shocklabels{is} ',1);']);
    end

    %get productivity & unemployment
    a         = params.z;
    ur_b      = params.u(1);
    ur_g      = params.u(2);
    markdown  = params.markdown;
    alpha     = params.alpha;
    for is = 1:length(shocklabels)
        eval(['prod_trans_' shocklabels{is} ' = (zvec_trans_' shocklabels{is} '==1)*a(1) + (zvec_trans_' shocklabels{is} '==2)*a(2);']);
        eval(['l_trans_' shocklabels{is} ' = (zvec_trans_' shocklabels{is} '==1)*(1-ur_b) + (zvec_trans_' shocklabels{is} '==2)*(1-ur_g);']);
        eval(['r_trans_' shocklabels{is} ' = markdown * alpha * prod_trans_' shocklabels{is} '.* ( l_trans_' shocklabels{is} './ Kvec_trans_' shocklabels{is} ').^(1-alpha);']);
        eval(['prod_trans_' shocklabels{is} '_IRF = ((prod_trans_' shocklabels{is} '(:,:,1)./prod_trans_' shocklabels{is} '(:,:,2)) -1)*100;']);
        eval(['l_trans_' shocklabels{is} '_IRF = ((l_trans_' shocklabels{is} '(:,:,1)./l_trans_' shocklabels{is} '(:,:,2)) -1)*100;']);
        eval(['r_trans_' shocklabels{is} '_IRF = ((r_trans_' shocklabels{is} '(:,:,1)./r_trans_' shocklabels{is} '(:,:,2)) -1)*100;']);
    end
    
    for ivar = 1:length(variables)
        for is = 1:length(shocklabels)

            eval([variables{ivar} '_trans_mean_' shocklabels{is} '(:,' int2str(im) ') = mean(' variables{ivar} '_trans_' shocklabels{is} '_IRF);']);

        end
    end

end

IRFwindow = (0:1:Nwindow-1);


h = figure(1);
plot(IRFwindow(1:end)',prod_trans_mean_neg(2:end,1),'LineWidth',2)
xlim([0 plotuntilquarter])
xlabel('quarters','FontSize',14)
ylabel('\% change in productivity','FontSize',14)
if print_figures==1
    exportgraphics(h, [printlocation 'figure_7a.pdf'], 'ContentType', 'vector');
end

h = figure(2); 
plot(IRFwindow',Kvec_trans_mean_neg(2:end,1),'LineWidth',3, 'DisplayName','Benchmark')
hold on
plot(IRFwindow',Kvec_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName','Exogenous Information')
plot(IRFwindow',Kvec_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
hold off
legend('Location','northeast','FontSize',12,'Box','off')
axis([0 plotuntilquarter -1.8 0])
xlabel('quarters','FontSize',14)
ylabel('\% change in capital','FontSize',14)
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on')
if print_figures==1
    exportgraphics(h, [printlocation 'figure_7b.pdf'], 'ContentType', 'vector');
end

h = figure(3); 
plot(IRFwindow',y_trans_mean_neg(2:end,1),'LineWidth',3,'DisplayName','Benchmark')
hold on
plot(IRFwindow',y_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName','Exogenous Information')
plot(IRFwindow',y_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
hold off
legend('Location','southeast','FontSize',12,'Box','off')
set(gca, 'YScale', 'log');
set(gca, 'YMinorTick', 'off')
yticks([-5 -2 -1 -0.5 0])
axis([0 plotuntilquarter -6 -0.35])
xlabel('quarters','FontSize',14)
ylabel('\% change in output','FontSize',14)
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on')
if print_figures==1
    exportgraphics(h, [printlocation 'figure_7c.pdf'], 'ContentType', 'vector');
end

h = figure(4);
plot(IRFwindow(1:end-1)',invest_trans_mean_neg(2:end,1),'LineWidth',3,'DisplayName','Benchmark')
hold on
plot(IRFwindow(1:end-1)',invest_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName','Exogenous Information')
plot(IRFwindow(1:end-1)',invest_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
hold off
legend('Location','southeast','FontSize',12,'Box','off')
set(gca, 'YScale', 'log');
set(gca, 'YMinorTick', 'off')
yticks([-25 -5 -1 -0.2])
axis([0 plotuntilquarter -26 -.4])
xlabel('quarters','FontSize',14)
ylabel('\% change in investment','FontSize',14)
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on')
if print_figures==1
    exportgraphics(h, [printlocation 'figure_7d.pdf'], 'ContentType', 'vector');
end


