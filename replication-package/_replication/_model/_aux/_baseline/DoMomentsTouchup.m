dists.kdist=kdist0;
dists.pdist=pdist0;
dists.pKdist=pKdist0;



[Kvec,dists_out,panel,stats,Kvec_u,Kvec_e]=simKS(dec,ipol,dists,zvec,shocks,params);

[moments,TS] = calculate_moments_stoch(Kvec',panel,ishocks,zvec,params);

save(['model_' int2str(model_to_run) model_variant{i}], 'a0', 'a1', 'cpol', 'dec', 'X','ipol', 'kdist0', 'pdist0', 'pKdist0', 'ishocksT','moments','diff_a','params','Kvec','Kvec_u','Kvec_e','-v7.3')
