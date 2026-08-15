clear
load('model_7009.mat')
dists.kdist=kdist0;
dists.pdist=pdist0;
dists.pKdist=pKdist0;

load('NE3Shocks3.mat')
shocks.xshocks=xshocks;
shocks.ishocks=ishocks;
shocks.kapshocks=kapshocks;
shocks.kinfoshocks=kinfoshocks;
shocks.death=death;

%%
[Kvec,dists_out,panel,stats,Kvec_u,Kvec_e]=simKS(dec,ipol,dists,zvec,shocks,params);

[moments,TS] = calculate_moments_stoch(Kvec',panel,ishocks,zvec,params);

forecast_moments = calculate_fcerrors_stoch(Kvec',panel,zvec,params,a0,a1);

kdist_panel = panel.kdistT(:,params.drop+1:end);
% save(parIn.saveResultsFile, 'a0', 'a1', 'cpol', 'dec', 'X','ipol', 'kdist0', 'pdist0', 'pKdist0', 'ishocksT','forecast_moments','moments','diff_a','params','Kvec','Kvec_u','Kvec_e','kdist_panel','-v7.3')
save('model_7009_panel', 'a0', 'a1', 'cpol', 'dec', 'X','ipol', 'kdist0', 'pdist0', 'pKdist0', 'ishocksT','forecast_moments','moments','diff_a','params','Kvec','Kvec_u','Kvec_e','panel','-v7.3')

% %%
% 
% dists.kdist=dists_out.kdist;
% dists.pdist=dists_out.pdist;
% dists.pKdist=dists_out.pKdist;
% 
% [Kvec,dists_out,panel,stats,Kvec_u,Kvec_e]=simKS(dec,ipol,dists,zvec,shocks,params);
% 
% [moments4,TS] = calculate_moments_stoch(Kvec',panel,ishocks,zvec,params);
% 
% forecast_moments3 = calculate_fcerrors_stoch_optimized(Kvec',panel,zvec,params,a0,a1);
% 
% kdist_panel = panel.kdistT(:,params.drop+1:end);
