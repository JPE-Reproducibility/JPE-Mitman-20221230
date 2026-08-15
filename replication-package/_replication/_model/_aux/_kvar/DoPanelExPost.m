% Do panel stuff
clear
load("/Users/kmitm/Dropbox/BKKS_Shadow/_modelresults/kvar-prior/model_2044.mat")
load("/Users/kmitm/GitHub/BKKS/NewShocks.mat")
shocks.xshocks=xshocks;
shocks.ishocks=ishocks;
shocks.kapshocks=kapshocks;
shocks.kinfoshocks=kinfoshocks;
shocks.death=death;
%%
dists.kdist=kdist0;     
dists.pdist=pdist0;
dists.pKdist=pKdist0;
dists.sigKdist=sigKdist0;
dists.meanKbar=mean(Kvec);

[Kvec,dists_out,panel,stats,Kvec_u,Kvec_e]=simKS(dec,ipol,dists,zvec,shocks,params);
[moments,TS] = calculate_moments_stoch(Kvec',panel,ishocks,zvec,params);
forecast_moments = calculate_fcerrors_stoch(Kvec',panel,zvec,params,a0,a1);
kdist_panel = panel.kdistT(:,params.drop+1:end);
save('/Users/kmitm/Dropbox/BKKS_Shadow/_modelresults/kvar-prior/fullpanel_model_2044.mat', 'a0', 'a1', 'cpol', 'dec', 'X','ipol', 'kdist0', 'pdist0', 'pKdist0', 'ishocksT','forecast_moments','moments','diff_a','params','Kvec','Kvec_u','Kvec_e','kdist_panel','-v7.3')
