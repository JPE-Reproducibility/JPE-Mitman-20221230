


%% 1 - BKKS_start_runs.m
clear
% clc
current_models=[1001 1007 1018 1023 1025 1026 1028 1030 1033 1036 1047 1050 1066 1074 7009];

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





%% 2 - additional models for entrepreneur extension
clear
% clc
current_models=[7009];

for i=1:3
    model_to_run = current_models(1);
    excellocation = '';
    guesslocation = '../_models_tmp/';
     savelocation  = guesslocation;
    parIn = BKKS_load_parameters(model_to_run,excellocation);
    load(['../_models_tmp/model_' int2str(model_to_run) '.mat'],'moments');
    parIn.save_panel=0;
    if(i==1)
        parIn.exinfo=moments.info;
        parIn.aggKinfo=moments.info;
        clear moments
        parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_exoki.mat'];
        parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '.mat']
        parIn.readShocksFile = [guesslocation parIn.readShocksFile];
    elseif(i==2)
        parIn.exinfo=moments.info;
        parIn.aggKinfo=0;
        clear moments
        parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_exo.mat'];
        parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '_exoki.mat']
        parIn.readShocksFile = [guesslocation parIn.readShocksFile];
    else
        parIn.exinfo=moments.info;
        parIn.aggKinfo=0;
        parIn.b=parIn.b+0.1;
        clear moments
        parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_exo_ui.mat'];
        parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '_exo.mat']
        parIn.readShocksFile = [guesslocation parIn.readShocksFile];
    end
    
    
    BKKS_main(parIn)
end




%BKKS_start_runs.m
clear
% clc
current_models=[7009];

for i=1:3
    model_to_run = current_models(1);
    excellocation = '';
    guesslocation = '../_models_tmp/';
    savelocation  = guesslocation;
    parIn = BKKS_load_parameters(model_to_run,excellocation);
    parIn.save_panel=0;

    if(i==1)
        parIn.exinfo=1;
        parIn.aggKinfo=1;
        parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_fiki.mat'];
        parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '.mat']
        parIn.readShocksFile = [guesslocation parIn.readShocksFile];
    elseif(i==2)
        parIn.exinfo=1;
        parIn.aggKinfo=0;
        parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_fi.mat'];
        parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '_fiki.mat']
        parIn.readShocksFile = [guesslocation parIn.readShocksFile];
    else
        parIn.exinfo=1;
        parIn.aggKinfo=0;
        parIn.b=parIn.b+0.1;
        parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_fi_ui.mat'];
        parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '_fi.mat']
        parIn.readShocksFile = [guesslocation parIn.readShocksFile];
    end
    
    
    BKKS_main(parIn)
end


clear
% clc
current_models=[7009];

for i=1:1
    model_to_run = current_models(1);


    excellocation = '';
    guesslocation = '../_models_tmp/';
    savelocation  = guesslocation;
    parIn = BKKS_load_parameters(model_to_run,excellocation);
    parIn.save_panel=0;

    parIn.b=parIn.b+0.1;
    parIn.readInitialGuessFile = [guesslocation 'model_' int2str(model_to_run) '.mat'];
    parIn.saveResultsFile = [savelocation 'model_' int2str(parIn.model_nb) '_ui.mat'];
    parIn.readShocksFile = [guesslocation parIn.readShocksFile];
    BKKS_main(parIn)
end


%% 3 - exogenous information about aggregate capital
clear
% clc
current_models=[105902 106002];

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

%% 4 - LOM from baseline endogenous info model
clear
% clc
current_models=[1023 1026];

for i=1:length(current_models)
    model_to_run = current_models(i);
    excellocation = '';
    guesslocation = '../_models_tmp/';
    savelocation  = guesslocation;

    parIn = BKKS_load_parameters(model_to_run,excellocation);
    parIn.readInitialGuessFile = [savelocation 'model_1001.mat'];
    parIn.maxIterLOM = 1;
    parIn.saveResultsFile = [savelocation 'model_' int2str(model_to_run) '_LOMendo.mat'];
    parIn.readShocksFile = [guesslocation parIn.readShocksFile];
    BKKS_main(parIn)
end

% InfoDecomposition is invoked from model_master.m rather than here: it needs
% NE3Shocks3.mat, which make_shocks.m creates, and the solved model_7009.mat.
