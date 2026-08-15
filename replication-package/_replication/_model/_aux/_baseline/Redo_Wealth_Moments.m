


%BKKS_start_runs.m
clear
% clc
current_models=[1001 1007 1017 1023 1025 1026 1028 1029 1030 1033 1036 1018 1047 1050 1066 1074];

load('NewShocks.mat')
shocks.xshocks=xshocks;
shocks.ishocks=ishocks;
shocks.kapshocks=kapshocks;
shocks.kinfoshocks=kinfoshocks;
shocks.death=death;
%%
for i=17:length(current_models)
    model_to_run = current_models(i);
    excellocation = '';
    if(model_to_run~=1066)
        load(['~/Dropbox/BKKS_Shadow/_modelresults/model_' int2str(model_to_run) '.mat']);
    else
        load(['~/Dropbox/BKKS_Shadow/_modelresults/scaled_ev/model_' int2str(model_to_run) '.mat']);
    end
    DoMomentsTouchup
    clear a0 a1 cpol dec X ipol kdist0 pdist0 pKdist0 moments diff_a params Kvec
end