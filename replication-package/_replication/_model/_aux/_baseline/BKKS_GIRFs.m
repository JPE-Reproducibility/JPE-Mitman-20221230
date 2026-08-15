clc
clear
close all

flag_0_1_bench_entrepreneur = 1;

Nwindow = 92;
compute_positive = 0;



switch flag_0_1_bench_entrepreneur

    case 0   %benchmark
        models_to_run = [1001 1026 1023];
        path = 'D:\Dropbox (Personal)\BKKS_Shadow\_modelresults\';
        shockpath = 'C:\Users\ksc.fi\Documents\GitHub\BKKS\';
        
        generate_new_shocks = 0;
        if generate_new_shocks==1
            %draw shocks
            fprintf('generating shocks... ')
            load([path 'model_1001'],'params') 
            [ishocks,xshocks,kapshocks,kinfoshocks,zvec,death] = genShocks(params);
            save([shockpath 'NewShocks.mat'],'ishocks', 'xshocks', 'kapshocks', 'kinfoshocks', 'zvec','death','-v7.3')   
        end
        shockfile = [shockpath 'NewShocks.mat'];



    case 1   %entrepreneur
        models_to_run = {'7009' '7009_exo' '7009_FI'};% [194 2201 198];
        path = 'D:\Dropbox (Personal)\BKKS_Shadow\_modelresults\entrepreneur\';
        shockpath = 'D:\Dropbox (Personal)\BKKS_Shadow\_modelresults\entrepreneur\';
        
        shockfile = [shockpath 'NE3Shocks3.mat'];

end



for im=1:length(models_to_run)


    fprintf('model %d... ' ,im)
    %load the results:
    if isnumeric(models_to_run)
        loadResultsFile = ['model_' int2str(models_to_run(im))];
    else
        loadResultsFile = ['model_' models_to_run{im}];
    end
    load([path loadResultsFile])  

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
    switch flag_0_1_bench_entrepreneur
        case 0
            ind_shock_neg = [0;(mainshocks.zvec(2:end-Nwindow-1)==1 & mainshocks.zvec(1:end-1-Nwindow-1)==2)];
            ind_shock_pos = [0;(mainshocks.zvec(2:end-Nwindow-1)==2 & mainshocks.zvec(1:end-1-Nwindow-1)==1)];
        case 1 %if entrepreneur: since shorter T, use all t with good states as possible neg transitions (and vice versa for pos transitions)
            ind_shock_neg = [0;(mainshocks.zvec(1:end-1-Nwindow-1)==2)];
            ind_shock_pos = [0;(mainshocks.zvec(1:end-1-Nwindow-1)==1)];
    end
    
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
    fprintf('negative shock ... ')
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
    

    if compute_positive==1
        fprintf('positive shock ... ')
        zvec_trans_pos = NaN(length(t_shock_pos),Nwindow+1,2);
        Kvec_trans_pos = NaN(length(t_shock_pos),Nwindow+1,2);
        c_trans_pos = NaN(length(t_shock_pos),Nwindow,2);
        pK_trans_pos = NaN(length(t_shock_neg),Nwindow+1,2);
        pK_w_trans_pos = NaN(length(t_shock_neg),Nwindow+1,2);
        info_trans_pos = NaN(length(t_shock_neg),Nwindow+1,2);

    
        rng(140324,'twister');
        for i_shock = 1:length(t_shock_pos)
            if t_shock_pos(i_shock)+Nwindow>length(mainshocks.zvec)
                break
            end
    
            %Use Quasi-random numbers to get distributions right
            deepshocks.urandv  = rand(params.N,Nwindow+1);
            deepshocks.xrand = rand(params.N,Nwindow+1);
            deepshocks.kapshocks = rand(params.N,Nwindow+1); 
            deepshocks.kinfoshocks = rand(params.N,Nwindow+1); 
            deepshocks.zshocks = rand(1,Nwindow+1);
            deepshocks.deathshocks = rand(params.N,Nwindow+1);
    
            distinit.ishocks = mainshocks.ishocks(:,t_shock_pos(i_shock)-1);
            distinit.xshocks = mainshocks.xshocks(:,t_shock_pos(i_shock)-1);
            dists.kdist=panel.kdistT(:,t_shock_pos(i_shock)-1);     
            dists.pdist=panel.pdistT(:,t_shock_pos(i_shock)-1);
            dists.pKdist=panel.pKdistT(:,t_shock_pos(i_shock)-1);
            param_local = params;
            param_local.T = Nwindow+1;
    
            %with shock
            zinit = [mainshocks.zvec(t_shock_pos(i_shock)-1),2];
    
            [ishocks,xshocks,kapshocks,kinfoshocks,zvec,death]  = genShocks_GIRFs(params,zinit,deepshocks,distinit,Nwindow);
            shocks.xshocks=xshocks;
            shocks.ishocks=ishocks;
            shocks.kapshocks=kapshocks;
            shocks.kinfoshocks=kinfoshocks;
            shocks.death = death; 
            [Kvec_tmp,~,panel_tmp,stats_tmp] =simKS(dec,ipol,dists,zvec,shocks,param_local);
            Kvec_trans_pos(i_shock,:,1) = Kvec_tmp;
            zvec_trans_pos(i_shock,:,1) = zvec';
            ccross = panel_tmp.cahT(:,1:end-1)-panel_tmp.kdistT(:,2:end)-params.nu*panel_tmp.info_acT(:,1:end-1); 
            c_trans_pos(i_shock,:,1) = mean(ccross);
            pK_trans_pos(i_shock,:,1) = mean(panel_tmp.pKdistT);
            pK_w_trans_pos(i_shock,:,1) = mean(panel_tmp.pKdistT.*panel_tmp.cahT.*repmat(sum(panel_tmp.cahT).^(-1),size(panel_tmp.cahT,1),1));
            info_trans_pos(i_shock,:,1) = mean(panel_tmp.info_acT);
    
            %without shock
            zinit = [mainshocks.zvec(t_shock_pos(i_shock)-1),1];
    
            [ishocks,xshocks,kapshocks,kinfoshocks,zvec,death]  = genShocks_GIRFs(params,zinit,deepshocks,distinit,Nwindow);
            shocks.xshocks=xshocks;
            shocks.ishocks=ishocks;
            shocks.kapshocks=kapshocks;
            shocks.kinfoshocks=kinfoshocks;
            shocks.death = death; 
            [Kvec_tmp,~,panel_tmp,stats_tmp] =simKS(dec,ipol,dists,zvec,shocks,param_local);
            Kvec_trans_pos(i_shock,:,2) = Kvec_tmp;
            zvec_trans_pos(i_shock,:,2) = zvec';
            ccross = panel_tmp.cahT(:,1:end-1)-panel_tmp.kdistT(:,2:end)-params.nu*panel_tmp.info_acT(:,1:end-1); 
            c_trans_pos(i_shock,:,2) = mean(ccross);
            pK_trans_pos(i_shock,:,2) = mean(panel_tmp.pKdistT);
            pK_w_trans_pos(i_shock,:,2) = mean(panel_tmp.pKdistT.*panel_tmp.cahT.*repmat(sum(panel_tmp.cahT).^(-1),size(panel_tmp.cahT,1),1));
            info_trans_pos(i_shock,:,2) = mean(panel_tmp.info_acT);
    
        end

        %calculate output, investment, and consumption
        a         = params.z;
        ur_b      = params.u(1);
        ur_g      = params.u(2);
        alpha     = params.alpha;
        delta     = params.delta;
    
        invest_trans_pos = Kvec_trans_pos(:,2:end,:)-(1-delta)*Kvec_trans_pos(:,1:end-1,:);
    
        prod_ag_pos = (zvec_trans_pos==1)*a(1) + (zvec_trans_pos==2)*a(2);
        labor_ag_pos = (zvec_trans_pos==1)*(1-ur_b) + (zvec_trans_pos==2)*(1-ur_g);
        y_trans_pos=prod_ag_pos.*Kvec_trans_pos.^alpha.*labor_ag_pos.^(1-alpha);
        
        %express as percentage deviations from state when shock hits
        invest_trans_pos_IRF = (invest_trans_pos(:,:,1)./invest_trans_pos(:,:,2) -1)*100; 
        y_trans_pos_IRF = (y_trans_pos(:,:,1)./y_trans_pos(:,:,2) -1)*100; 
        Kvec_trans_pos_IRF = (Kvec_trans_pos(:,:,1)./Kvec_trans_pos(:,:,2) -1)*100; 
        c_trans_pos_IRF = (c_trans_pos(:,:,1)./c_trans_pos(:,:,2) -1)*100; 
        pK_trans_pos_IRF = (pK_trans_pos(:,:,1)./pK_trans_pos(:,:,2) -1)*100; 
        pK_w_trans_pos_IRF = (pK_w_trans_pos(:,:,1)./pK_w_trans_pos(:,:,2) -1)*100; 
        info_trans_pos_IRF = (info_trans_pos(:,:,1)./info_trans_pos(:,:,2) -1)*100; 

    end
        

    %save
    fprintf('saving... ')
    if compute_positive==1
    save([path loadResultsFile '_GIRF'],'params', ...
        'Kvec_trans_neg', 'zvec_trans_neg', 'y_trans_neg', 'invest_trans_neg', 'c_trans_neg', ...
        'pK_trans_neg', 'pK_w_trans_neg', 'info_trans_neg', ...
        'Kvec_trans_neg_IRF', 'y_trans_neg_IRF', 'invest_trans_neg_IRF','c_trans_neg_IRF', ...
        'pK_trans_neg_IRF', 'pK_w_trans_neg_IRF', 'info_trans_neg_IRF', ...
        'Kvec_trans_pos', 'zvec_trans_pos', 'y_trans_pos', 'invest_trans_pos', 'c_trans_pos', ...
        'pK_trans_pos', 'pK_w_trans_pos', 'info_trans_pos', ...
        'Kvec_trans_pos_IRF', 'y_trans_pos_IRF', 'invest_trans_pos_IRF','c_trans_pos_IRF', ...
        'pK_trans_pos_IRF', 'pK_w_trans_pos_IRF', 'info_trans_pos_IRF', ...
        '-v7.3')  
    else
    save([path loadResultsFile '_GIRF'],'params', ...
        'Kvec_trans_neg', 'zvec_trans_neg', 'y_trans_neg', 'invest_trans_neg', 'c_trans_neg', ...
        'pK_trans_neg', 'pK_w_trans_neg', 'info_trans_neg', ...
        'Kvec_trans_neg_IRF', 'y_trans_neg_IRF', 'invest_trans_neg_IRF','c_trans_neg_IRF', ...
        'pK_trans_neg_IRF', 'pK_w_trans_neg_IRF', 'info_trans_neg_IRF', ...
        '-v7.3')  
    end
    fprintf('done \n ')
    clearvars -except models_to_run path shockpath im Nwindow compute_positive shockfile flag_0_1_bench_entrepreneur
end




%% make plots
clear
clc
close all


variables = {'Kvec','y','invest','prod','l','c','pK','pK_w','info','r'};%
shocklabels = {'neg'};%, 'pos'};
percentilelist = [5 10 25 75 90 95];

plotuntilquarter = 30;
print_figures = 0;
plot_cumulative = 0;
Nwindow = 92;

flag_0_1_bench_entrepreneur = 1;

switch flag_0_1_bench_entrepreneur

    case 0   %benchmark
        models_to_run = [1001 1026 1023];
        path = 'D:\Dropbox (Personal)\BKKS_Shadow\_modelresults\';
        printlocation = 'D:\Dropbox (Personal)\BKKS_Shadow\_revision2\_input\';

    case 1   %entrepreneur
        models_to_run = {'7009' '7009_exo' '7009_FI'};% [194 2201 198];
        path = 'D:\Dropbox (Personal)\BKKS_Shadow\_modelresults\entrepreneur\';
        printlocation = 'D:\Dropbox (Personal)\BKKS_Shadow\_revision2\_input\entrepreneur_';
end




set(0,'DefaultFigureWindowStyle','docked') %'normal' 'docked'
set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'DefaultAxesTickLabelInterpreter', 'latex');
set(groot, 'DefaultLegendInterpreter', 'latex');

colors = get(groot, 'defaultAxesColorOrder');

for im=1:length(models_to_run)

    %load the results:
    if isnumeric(models_to_run)
        loadResultsFile = ['model_' int2str(models_to_run(im))];
    else
        loadResultsFile = ['model_' models_to_run{im}];
    end
    load([path loadResultsFile '_GIRF'])   

    for is = 1:length(shocklabels)
        eval(['T_' shocklabels{is} ' = size(Kvec_trans_' shocklabels{is} ',1);']);
    end

    % Kvec_trans_neg_IRF = Kvec_trans_neg_IRF(1:end-1,:);
    % y_trans_neg_IRF = y_trans_neg_IRF(1:end-1,:);
    % invest_trans_neg_IRF = invest_trans_neg_IRF(1:end-1,:);
    % zvec_trans_neg = zvec_trans_neg(1:end-1,:,:);
    % y_trans_neg = y_trans_neg(1:end-1,:,:);
    % invest_trans_neg = invest_trans_neg(1:end-1,:,:);
    % Kvec_trans_neg = Kvec_trans_neg(1:end-1,:,:);

    for p=percentilelist
        for is = 1:length(shocklabels)
            eval(['t_p' int2str(p) '_' shocklabels{is} ' = round(T_' shocklabels{is} '/100*' int2str(p) ');']);
        end
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
    
    %cumulative responses
    for ivar = 1:length(variables)
        for is = 1:length(shocklabels)
            % y_trans_neg_cum = cumsum(y_trans_neg,2);
            % y_trans_neg_cum_IRF = (y_trans_neg_cum(:,:,1)./y_trans_neg_cum(:,:,2) -1)*100;
            eval([variables{ivar} '_trans_' shocklabels{is} '_cum = cumsum(' variables{ivar} '_trans_' shocklabels{is} ',2);']);
            eval([variables{ivar} '_trans_' shocklabels{is} '_cum_IRF = ((' variables{ivar} '_trans_' shocklabels{is} '_cum(:,:,1)./' variables{ivar} '_trans_' shocklabels{is} '_cum(:,:,2)) -1)*100;']);
        end
    end

    for ivar = 1:length(variables)
        for is = 1:length(shocklabels)

            eval([variables{ivar} '_trans_mean_' shocklabels{is} '(:,' int2str(im) ') = mean(' variables{ivar} '_trans_' shocklabels{is} '_IRF);']);
            eval([variables{ivar} '_trans_mean_cum_' shocklabels{is} '(:,' int2str(im) ') = mean(' variables{ivar} '_trans_' shocklabels{is} '_cum_IRF);']);
    
            % eval([variables{ivar} '_trans_' shocklabels{is} '_sorted = sort(' variables{ivar} '_trans_' shocklabels{is} '_IRF);']);
            % 
            % for p=percentilelist
            %     eval([variables{ivar} '_trans_p' int2str(p) '_' shocklabels{is} '(:,' int2str(im) ') = ' variables{ivar} '_trans_' shocklabels{is} '_sorted(t_p' int2str(p) '_' shocklabels{is} ',: );']);
            % end
        end
    end

end

IRFwindow = (0:1:Nwindow-1);

h = figure(1); 
plot(IRFwindow',Kvec_trans_mean_neg(2:end,1),'LineWidth',3, 'Color',colors(1,:), 'DisplayName','Benchmark')
hold on
plot(IRFwindow',Kvec_trans_mean_neg(2:end,2),'LineWidth',2, 'Color',colors(2,:),'LineStyle','--','DisplayName','Exogenous Information')
plot(IRFwindow',Kvec_trans_mean_neg(2:end,3),'LineWidth',2, 'Color',colors(2,:),'DisplayName','Full Information')
% plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
hold off
% xlim([0 1])
% grid on
legend('Location','northeast','FontSize',12,'Box','off')
axis([0 plotuntilquarter -1.8 0])
xlabel('quarters','FontSize',14)
ylabel('\% change in capital','FontSize',14)
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on')
if print_figures==1
    savefig([printlocation 'figure_IRF_k_Q' int2str(plotuntilquarter) '.fig'])
    exportgraphics(h, [printlocation 'figure_IRF_k_Q' int2str(plotuntilquarter) '.pdf'], 'ContentType', 'vector');
end

h = figure(2); 
plot(IRFwindow',y_trans_mean_neg(2:end,1),'LineWidth',3, 'Color',colors(1,:),'DisplayName','Benchmark')
hold on
plot(IRFwindow',y_trans_mean_neg(2:end,2),'LineWidth',2, 'Color',colors(2,:),'LineStyle','--','DisplayName','Exogenous Information')
plot(IRFwindow',y_trans_mean_neg(2:end,3),'LineWidth',2, 'Color',colors(2,:),'DisplayName','Full Information')
% plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
hold off
% xlim([0 1])
% grid on
legend('Location','southeast','FontSize',12,'Box','off')
set(gca, 'YScale', 'log');
set(gca, 'YMinorTick', 'off')
yticks([-5 -2 -1 -0.5 0])
axis([0 plotuntilquarter -6 -0.35])
xlabel('quarters','FontSize',14)
ylabel('\% change in output','FontSize',14)
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on')
if print_figures==1
    savefig([printlocation 'figure_IRF_y_Q' int2str(plotuntilquarter) '.fig'])
    exportgraphics(h, [printlocation 'figure_IRF_y_Q' int2str(plotuntilquarter) '.pdf'], 'ContentType', 'vector');
end

h = figure(3);
plot(IRFwindow(1:end-1)',invest_trans_mean_neg(2:end,1),'LineWidth',3, 'Color',colors(1,:),'DisplayName','Benchmark')
hold on
plot(IRFwindow(1:end-1)',invest_trans_mean_neg(2:end,2),'LineWidth',2, 'Color',colors(2,:),'LineStyle','--','DisplayName','Exogenous Information')
plot(IRFwindow(1:end-1)',invest_trans_mean_neg(2:end,3),'LineWidth',2, 'Color',colors(2,:),'DisplayName','Full Information')
hold off
% xlim([0 1])
% grid on
legend('Location','southeast','FontSize',12,'Box','off')
set(gca, 'YScale', 'log');
set(gca, 'YMinorTick', 'off')
yticks([-25 -5 -1 -0.2])
axis([0 plotuntilquarter -26 -.4])
xlabel('quarters','FontSize',14)
ylabel('\% change in investment','FontSize',14)
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on')
if print_figures==1
    savefig([printlocation 'figure_IRF_inv_Q' int2str(plotuntilquarter) '.fig'])
    exportgraphics(h, [printlocation 'figure_IRF_inv_Q' int2str(plotuntilquarter) '.pdf'], 'ContentType', 'vector');
end

% h = figure(4);
% plot(IRFwindow(1:end-1)',c_trans_mean_neg(2:end,1),'LineWidth',3,'DisplayName','Benchmark')
% hold on
% plot(IRFwindow(1:end-1)',c_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName','Exogenous Information')
% plot(IRFwindow(1:end-1)',c_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
% hold off
% % xlim([0 1])
% % grid on
% legend('Location','southeast','FontSize',12,'Box','off')
% % set(gca, 'YScale', 'log');
% % set(gca, 'YMinorTick', 'off')
% % yticks([-25 -5 -1 -0.2])
% axis([0 plotuntilquarter -1 0])
% xlabel('quarters','FontSize',14)
% ylabel('\% change in consumption','FontSize',14)
% if print_figures==1
%     savefig([printlocation 'figure_IRF_c_Q' int2str(plotuntilquarter) '.fig'])
%     exportgraphics(h, [printlocation 'figure_IRF_c_Q' int2str(plotuntilquarter) '.pdf'], 'ContentType', 'vector');
% end

h = figure(5);
plot(IRFwindow(1:end)',prod_trans_mean_neg(2:end,1),'LineWidth',2)
% hold on
% plot(IRFwindow(1:end)',prod_trans_mean_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Information')
% plot(IRFwindow(1:end)',prod_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
% hold off
% xlim([0 1])
% grid on
% legend('Location','southeast','FontSize',12)
% set(gca, 'YScale', 'log');
% set(gca, 'YMinorTick', 'off')
% yticks([-25 -5 -1 -0.2])
% axis([0 plotuntilquarter -26 0])
xlim([0 plotuntilquarter])
xlabel('quarters','FontSize',14)
ylabel('\% change in productivity','FontSize',14)
if print_figures==1
    savefig([printlocation 'figure_IRF_prod_Q' int2str(plotuntilquarter) '.fig'])
    exportgraphics(h, [printlocation 'figure_IRF_prod_Q' int2str(plotuntilquarter) '.pdf'], 'ContentType', 'vector');
end

% h = figure(6);
% plot(IRFwindow(1:end)',r_trans_mean_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
% hold on
% plot(IRFwindow(1:end)',r_trans_mean_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Information')
% plot(IRFwindow(1:end)',r_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
% plot(IRFwindow(1:end)',zeros(length(IRFwindow(1:end)'),1),'-k','LineWidth',0.5,'HandleVisibility','off')
% hold off
% axis([0 plotuntilquarter -5.5 1.5])
% % set(gca, 'YScale', 'log');
% % set(gca, 'YMinorTick', 'off')
% % yticks([-1 -0.2])
% % grid on
% legend('Location','southeast','FontSize',12,'Box','off')
% xlabel('quarters','FontSize',14)
% ylabel('\% change in interest rate','FontSize',14)
% if print_figures==1
%     savefig([printlocation 'figure_IRF_r_Q' int2str(plotuntilquarter) '.fig'])
%     exportgraphics(h, [printlocation 'figure_IRF_r_Q' int2str(plotuntilquarter) '.pdf'], 'ContentType', 'vector');
% end

% h = figure(7); 
% plot(IRFwindow',pK_trans_mean_neg(2:end,1),'LineWidth',3,'DisplayName','Benchmark')
% hold on
% plot(IRFwindow',pK_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName','Exogenous Information')
% plot(IRFwindow',pK_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
% % plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
% hold off
% % xlim([0 1])
% % grid on
% legend('Location','southeast','FontSize',12)
% xlim([0 plotuntilquarter])
% xlabel('quarters','FontSize',14)
% ylabel('\% change in capital priors','FontSize',14)
% if print_figures==1
%     savefig([printlocation 'figure_IRF_pK_Q' int2str(plotuntilquarter) '.fig'])
%     exportgraphics(h, [printlocation 'figure_IRF_pK_Q' int2str(plotuntilquarter) '.pdf'], 'ContentType', 'vector');
% end

% h = figure(8); 
% plot(IRFwindow',pK_w_trans_mean_neg(2:end,1),'LineWidth',3,'DisplayName','Benchmark')
% hold on
% plot(IRFwindow',pK_w_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName','Exogenous Information')
% plot(IRFwindow',pK_w_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
% % plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
% hold off
% % xlim([0 1])
% % grid on
% legend('Location','east','FontSize',12)
% xlim([0 plotuntilquarter])
% xlabel('quarters','FontSize',14)
% ylabel('\% change in capital priors (asset weighted)','FontSize',14)
% if print_figures==1
%     savefig([printlocation 'figure_IRF_pK_w_Q' int2str(plotuntilquarter) '.fig'])
%     exportgraphics(h, [printlocation 'figure_IRF_pK_w_Q' int2str(plotuntilquarter) '.pdf'], 'ContentType', 'vector');
% end

% h = figure(9); 
% plot(IRFwindow',info_trans_mean_neg(2:end,1),'LineWidth',3,'DisplayName','Benchmark')
% hold on
% plot(IRFwindow',info_trans_mean_neg(2:end,2),'LineWidth',2,'LineStyle','--','DisplayName','Exogenous Information')
% plot(IRFwindow',info_trans_mean_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
% % plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
% hold off
% % xlim([0 1])
% % grid on
% legend('Location','east','FontSize',12)
% xlim([0 plotuntilquarter])
% xlabel('quarters','FontSize',14)
% ylabel('\% change in info acquisition','FontSize',14)
% if print_figures==1
%     savefig([printlocation 'figure_IRF_info_Q' int2str(plotuntilquarter) '.fig'])
%     exportgraphics(h, [printlocation 'figure_IRF_info_Q' int2str(plotuntilquarter) '.pdf'], 'ContentType', 'vector');
% end

% ----------- cumulative responses ------------- %
if plot_cumulative==1
    h = figure(11); 
    plot(IRFwindow',Kvec_trans_mean_cum_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
    hold on
    plot(IRFwindow',Kvec_trans_mean_cum_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Information')
    plot(IRFwindow',Kvec_trans_mean_cum_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
    % plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
    hold off
    % xlim([0 1])
    % grid on
    legend('Location','northeast','FontSize',12)
    axis([0 plotuntilquarter -1.5 0])
    xlabel('quarters','FontSize',14)
    ylabel('\% change in capital (cum)','FontSize',14)
    savefig([printlocation 'figure_IRF_kcum.fig'])
    % exportgraphics(h, [printlocation 'figure_IRF_kcum.pdf'], 'ContentType', 'vector');
    
    h = figure(12); 
    plot(IRFwindow',y_trans_mean_cum_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
    hold on
    plot(IRFwindow',y_trans_mean_cum_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Information')
    plot(IRFwindow',y_trans_mean_cum_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
    % plot(MPC_quantile,MPC_sorted,'-b','LineWidth',2,'DisplayName','implied distribution of MPCs')
    hold off
    % xlim([0 1])
    % grid on
    legend('Location','southeast','FontSize',12)
    set(gca, 'YScale', 'log');
    set(gca, 'YMinorTick', 'off')
    yticks([-3 -2 -1 ])
    axis([0 plotuntilquarter -3.2 0])
    xlabel('quarters','FontSize',14)
    ylabel('\% change in output (cum)','FontSize',14)
    savefig([printlocation 'figure_IRF_ycum.fig'])
    % exportgraphics(h, [printlocation 'figure_IRF_ycum.pdf'], 'ContentType', 'vector');
    
    h = figure(13);
    plot(IRFwindow(1:end-1)',invest_trans_mean_cum_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
    hold on
    plot(IRFwindow(1:end-1)',invest_trans_mean_cum_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Information')
    plot(IRFwindow(1:end-1)',invest_trans_mean_cum_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
    hold off
    % xlim([0 1])
    % grid on
    legend('Location','southeast','FontSize',12)
    % set(gca, 'YScale', 'log');
    % set(gca, 'YMinorTick', 'off')
    % yticks([-10 -5 -1 -0.2])
    axis([0 plotuntilquarter -12 0])
    xlabel('quarters','FontSize',14)
    ylabel('\% change in investment (cum)','FontSize',14)
    savefig([printlocation 'figure_IRF_invcum.fig'])
    % exportgraphics(h, [printlocation 'figure_IRF_invcum.pdf'], 'ContentType', 'vector');
    
    h = figure(14);
    plot(IRFwindow(1:end-1)',c_trans_mean_cum_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
    hold on
    plot(IRFwindow(1:end-1)',c_trans_mean_cum_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Information')
    plot(IRFwindow(1:end-1)',c_trans_mean_cum_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
    hold off
    % xlim([0 1])
    % grid on
    legend('Location','northeast','FontSize',12)
    % set(gca, 'YScale', 'log');
    % set(gca, 'YMinorTick', 'off')
    % yticks([-25 -5 -1 -0.2])
    axis([0 plotuntilquarter -0.65 0])
    xlabel('quarters','FontSize',14)
    ylabel('\% change in consumption (cumulative)','FontSize',14)
    savefig([printlocation 'figure_IRF_ccum.fig'])
    % exportgraphics(h, [printlocation 'figure_IRF_ccum.pdf'], 'ContentType', 'vector');
    
    h = figure(15);
    plot(IRFwindow(1:end)',prod_trans_mean_cum_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
    hold on
    plot(IRFwindow(1:end)',prod_trans_mean_cum_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Information')
    plot(IRFwindow(1:end)',prod_trans_mean_cum_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
    hold off
    % xlim([0 1])
    % grid on
    % legend('Location','southeast','FontSize',12)
    % set(gca, 'YScale', 'log');
    % set(gca, 'YMinorTick', 'off')
    % yticks([-25 -5 -1 -0.2])
    % axis([0 plotuntilquarter -26 0])
    xlabel('quarters','FontSize',14)
    ylabel('\% change in productivity (cum)','FontSize',14)
    savefig([printlocation 'figure_IRF_prodcum.fig'])
    % exportgraphics(h, [printlocation 'figure_IRF_prodcum.pdf'], 'ContentType', 'vector');
    
    h = figure(16);
    plot(IRFwindow(1:end)',u_trans_mean_cum_neg(2:end,1),'LineWidth',2,'DisplayName','Benchmark')
    hold on
    plot(IRFwindow(1:end)',u_trans_mean_cum_neg(2:end,2),'LineWidth',2,'DisplayName','Exogenous Information')
    plot(IRFwindow(1:end)',u_trans_mean_cum_neg(2:end,3),'LineWidth',2,'DisplayName','Full Information')
    hold off
    % xlim([0 1])
    % grid on
    % legend('Location','southeast','FontSize',12)
    % set(gca, 'YScale', 'log');
    % set(gca, 'YMinorTick', 'off')
    % yticks([-25 -5 -1 -0.2])
    % axis([0 plotuntilquarter -26 0])
    xlabel('quarters','FontSize',14)
    ylabel('\% change in unemployment (cum)','FontSize',14)
    savefig([printlocation 'figure_IRF_ucum.fig'])
    % exportgraphics(h, [printlocation 'figure_IRF_ucum.pdf'], 'ContentType', 'vector');

end