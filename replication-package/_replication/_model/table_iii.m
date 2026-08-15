%% Model columns of Table 3

scriptDir = fileparts(mfilename('fullpath'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));
addpath(fullfile(scriptDir, '_aux/_baseline/'));
addpath(fullfile(scriptDir, '_aux'));

Entrepreneur    =  fullfile(scriptDir, '_aux/_models_tmp/model_7009.mat');
EntShocks       =  fullfile(scriptDir, '_aux/_models_tmp/NE3Shocks3.mat');
Baseline        =  fullfile(scriptDir, '_aux/_models_tmp/model_1001.mat');
BaseShocks      =  fullfile(scriptDir, '_aux/_models_tmp/NewShocks.mat');

Basefile=fullfile(scriptDir, '_table/table_iii_model_base.tex');
Entfile=fullfile(scriptDir, '_table/table_iii_model_ent.tex');


produce_wealthdistribution(Baseline,BaseShocks,Basefile)
produce_wealthdistribution(Entrepreneur,EntShocks,Entfile)




function produce_wealthdistribution(model_file,shock_file,outfile)


    load(model_file);
    load(shock_file);
    if(params.nx==1)
        xshocks=ones(size(xshocks));
    end
    shocks.xshocks=xshocks;
    shocks.ishocks=ishocks;
    shocks.kapshocks=kapshocks;
    shocks.kinfoshocks=kinfoshocks;
    shocks.death=death;
    
    dists.kdist=kdist0;
    dists.pdist=pdist0;
    dists.pKdist=pKdist0;
    dists.meanKbar=moments.kbar_mean;
    params.newborn_noinf_pZ=1;
    [Kvec,dists_out,panel,stats,Kvec_u,Kvec_e]=simKS(dec,ipol,dists,zvec,shocks,params);
    
    %% [3] Figure out distributions
    
    
    TT=length(Kvec)-params.drop;
    
    N=length(panel.kdistT(:,1));
    Wshare=nan(6,TT);
    Cshare=nan(6,TT);
    for i=1+params.drop:TT+params.drop
        
        [W, I]=sort(panel.kdistT(:,i));
    
        cumW = cumsum(W);
        C=panel.consT(I,i);
        cumC = cumsum(C);
        cumval = cumW;
        Wshare(:,i-params.drop) = 100*[cumval(end)-cumval(0.8*N+1) cumval(0.8*N)-cumval(0.6*N+1) cumval(0.6*N)-cumval(0.4*N+1) cumval(0.4*N)-cumval(0.2*N+1) cumval(0.2*N)-cumval(0.1*N+1) cumval(0.1*N)]/cumval(end);  
        cumval = cumC;
        Cshare(:,i-params.drop) = 100*[cumval(end)-cumval(0.8*N+1) cumval(0.8*N)-cumval(0.6*N+1) cumval(0.6*N)-cumval(0.4*N+1) cumval(0.4*N)-cumval(0.2*N+1) cumval(0.2*N)-cumval(0.1*N+1) cumval(0.1*N)]/cumval(end);  
        
    end
    
    
    meanWs=mean(Wshare(6:-1:1,:),2);
    meanCs=mean(Cshare(6:-1:1,:),2);

    names=['D1','D2','Q2','Q3','Q4','Q5'];

    fid = fopen(outfile, 'w');

    fprintf(fid, '\\begin{tabular}{lcc}\n');
    fprintf(fid, '\\toprule\n');
    fprintf(fid, '\\toprule\n');
    
    fprintf(fid, 'NW & Wealth &  Expenditure \\\\\n');
    fprintf(fid, '\\midrule\n');
    
    %Baseline
    for is=1:length(meanCs)
        fprintf(fid,names(is));
        fprintf(fid, ' & %.1f & %.1f',[meanWs(is) meanCs(is)]);
        fprintf(fid, '\\\\ \n');
    end
    
    
    fprintf(fid, '\\bottomrule\n');
    fprintf(fid, '\\bottomrule\n');
    fprintf(fid, '\\end{tabular}\n');
    
    % Close the file
    fclose(fid);
end