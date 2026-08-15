


%BKKS_start_runs.m
clear
% clc
current_models=[7009];

load('NE3Shocks3.mat')
shocks.xshocks=xshocks;
shocks.ishocks=ishocks;
shocks.kapshocks=kapshocks;
shocks.kinfoshocks=kinfoshocks;
shocks.death=death;

model_variant{1}='';
model_variant{2}='_exo';
model_variant{3}='_fi';
model_variant{4}='_ui';
model_variant{5}='_exo_ui';
model_variant{6}='_fi_ui';

%%
for i=1:length(model_variant)
    model_to_run = current_models(1);
    excellocation = '';
    load(['~/Dropbox/BKKS_Shadow/_modelresults/entrepreneur/model_' int2str(model_to_run) model_variant{i} '.mat']);
    DoMomentsTouchup
    clear a0 a1 cpol dec X ipol kdist0 pdist0 pKdist0 moments diff_a params Kvec
end