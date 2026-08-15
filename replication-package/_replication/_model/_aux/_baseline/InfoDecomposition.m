%% ========================================================================
%
%  INFODECOMPOSITION -- decomposes the entrepreneur model's wealth
%  distribution into the full-information and exogenous-information
%  counterfactuals, holding the law of motion at model_7009's own.
%
%  Writes _aux/_models_tmp/model_7009_decomp.mat, the input to
%  /_model/table_cxi.m (Table C.11).
%
%  Requires model_7009.mat and NE3Shocks3.mat to exist in _models_tmp, i.e.
%  make_shocks.m and the model solves must have run first. Called from
%  model_master.m, not from BKKS_start_runs.m.
%
% =========================================================================
clear

thisDir = fileparts(mfilename('fullpath'));
dataDir = fullfile(thisDir, '..', '_models_tmp');
addpath(thisDir);

load(fullfile(dataDir,'model_7009.mat'))
dists.kdist=kdist0;
dists.pdist=pdist0;
dists.pKdist=pKdist0;

load(fullfile(dataDir,'NE3Shocks3.mat'))
shocks.xshocks=xshocks;
shocks.ishocks=ishocks;
shocks.kapshocks=kapshocks;
shocks.kinfoshocks=kinfoshocks;
shocks.death=death;

%%

params.exinfo=1;
[~,dec_fi,ipol_fi,~] = solve_policies(cpol,ipol,X,params);

dists.pKdist=ones(size(pKdist0))*mean(kdist0);
[Kvec_fi1,~,panel_fi1,~,~,~]=simKS(dec_fi,ipol_fi,dists,zvec,shocks,params);

[moments_fi1,~] = calculate_moments_stoch(Kvec_fi1',panel_fi1,ishocks,zvec,params);

dists.pKdist=pKdist0;
[Kvec_fi2,~,panel_fi2,~,~,~]=simKS(dec_fi,ipol_fi,dists,zvec,shocks,params);

[moments_fi2,~] = calculate_moments_stoch(Kvec_fi2',panel_fi2,ishocks,zvec,params);


params.exinfo=moments.info;
[~,dec_exo,ipol_exo,~] = solve_policies(cpol,ipol,X,params);

dists.pKdist=pKdist0;
[Kvec_exo,~,panel_exo,~,~,~]=simKS(dec_exo,ipol_exo,dists,zvec,shocks,params);

[moments_exo,~] = calculate_moments_stoch(Kvec_exo',panel_exo,ishocks,zvec,params);



save(fullfile(dataDir,'model_7009_decomp.mat'), 'a0', 'a1', 'cpol', 'dec', 'X','ipol', 'kdist0', 'pdist0', 'pKdist0', 'ishocksT','moments_fi1','moments_fi2','moments_exo','moments','diff_a','params','Kvec','Kvec_fi1','Kvec_fi2','Kvec_exo','-v7.3')

