


%BKKS_start_runs.m
clear
% clc
current_models=[2044 2051 2052];

for i=1:length(current_models)
    model_to_run = current_models(i);


    excellocation = '';
    guesslocation = '../_models_tmp/'; 
    savelocation  = guesslocation;
    parIn = BKKS_load_parameters(model_to_run,excellocation);
    parIn.readInitialGuessFile = [guesslocation parIn.readInitialGuessFile];
    parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '.mat'];
    parIn.readShocksFile = [guesslocation parIn.readShocksFile];
    BKKS_main(parIn)
end