% Table C.3
% ----------------------------------------------------------------
clear all; clc; close all;

scriptDir = fileparts(mfilename('fullpath'));
addpath(fullfile(scriptDir, '_aux/_models'));
addpath(fullfile(scriptDir, '_aux/_models_tmp'));

opts = optimset('Display','off');

TT          = 7000;
T_smpl      = 1000; 

rng(11);

adj_factor = 1/(38.1/10.26)*65300/4;

nn          = 4;

%% [1] Derive Distributional Moments
%load('model_1001_wPanel.mat','kdist_panel');         %baseline
load('model_1001.mat','kdist_panel');         %baseline
kdist_ii = kdist_panel(:,1:TT)'; 
clearvars -except kdist_ii TT T_smpl rng(11) adj_factor x_values nn x_lim_start x_lim_end 
disp('...done with baseline...')

%load('model_1023_wPanel.mat','kdist_panel');         %full information 
load('model_1023.mat','kdist_panel');         %full information 
kdist_fi = kdist_panel(:,1:TT)'; 
clearvars -except kdist_ii kdist_fi TT T_smpl rng(11) adj_factor x_values nn x_lim_start x_lim_end
disp('...done with full information...')

load('model_1023_LOMendo.mat','kdist_panel'); %full information w/ baseline lom
kdist_fi_lom  = kdist_panel(:,1:TT)'; 
clearvars -except kdist_ii kdist_fi kdist_fi_lom TT T_smpl rng(11) adj_factor x_values nn x_lim_start x_lim_end
disp('...done with full information with lom...')

load('model_1026_LOMendo.mat','kdist_panel'); %exogenous information w/ baseline lom
kdist_ei_lom  = kdist_panel(:,1:TT)'; 
clearvars -except kdist_ii kdist_fi  kdist_fi_lom  kdist_ei_lom TT T_smpl rng(11) adj_factor x_values nn x_lim_start x_lim_end
disp('...done with exogenous information with lom...')

k = randperm(TT, T_smpl);
k = sort(k');

kdist_ii_tmp      = kdist_ii(k,:);
kdist_fi_tmp      = kdist_fi(k,:);
kdist_fi_lom_tmp  = kdist_fi_lom(k,:);
kdist_ei_lom_tmp  = kdist_ei_lom(k,:);


% -- estimate distributions
gini_save          = zeros(T_smpl,nn);
mean_save          = zeros(T_smpl,nn);
moments_save       = zeros(T_smpl,4, nn); %1 10 90 99

for jj=1:nn
    
    if jj==1
        kdist_tmp = kdist_ii_tmp;
    elseif jj==2
        kdist_tmp = kdist_fi_tmp;
    elseif jj==3
        kdist_tmp = kdist_fi_lom_tmp;
    elseif jj==4
        kdist_tmp = kdist_ei_lom_tmp;
    end


    for tt=1:T_smpl
        k_cross = kdist_tmp(tt,:)';

        mean_save(tt,jj) = mean(k_cross);

        [W, I] = sort(k_cross);
        NN_tmp = length(W);
        gini_save(tt,jj) = 1-2*sum(cumsum(W)/sum(W))/NN_tmp;

        PP = prctile(k_cross,[1 10 90 99]);

        moments_save(tt,:,jj) = PP';

    end

    disp('done with model'); disp(jj);
end

% -- Panel (a): average moments of the capital distribution
mean_gini            = zeros(1,nn);
mean_nineten         = zeros(1,nn);
mean_ninenineone     = zeros(1,nn);


for jj = 1:nn
    
    x_tmp         = squeeze(gini_save(:,jj));
    mean_gini(jj) = mean(x_tmp);


    x_tmp                 = squeeze(moments_save(:,3,jj))./squeeze(moments_save(:,2,jj));
    mean_nineten(jj)      =  mean(x_tmp);

    x_tmp                 = squeeze(moments_save(:,4,jj))./squeeze(moments_save(:,1,jj));
    mean_ninenineone(jj)  =  mean(x_tmp);

end


benchmark_full_info = 100.*[mean_gini(1)/mean_gini(2)-1; mean_nineten(1)/mean_nineten(2)-1; mean_ninenineone(1)/mean_ninenineone(2)-1];

ge                  = 100.*[mean_gini(3)/mean_gini(2)-1; mean_nineten(3)/mean_nineten(2)-1; mean_ninenineone(3)/mean_ninenineone(1)-1];

info                = 100.*[mean_gini(4)/mean_gini(3)-1; mean_nineten(4)/mean_nineten(3)-1; mean_ninenineone(4)/mean_ninenineone(3)-1];

het                 = 100.*[mean_gini(1)/mean_gini(4)-1; mean_nineten(1)/mean_nineten(4)-1; mean_ninenineone(1)/mean_ninenineone(4)-1];


LastName        = ["Gini"; "90/10"; "99/1"];
Overall         = round(benchmark_full_info, 2);
General_eq      = round(ge, 2);
Incomplete_info = round(info, 2);
Het_info        = round(het, 2);
Interaction     = round(benchmark_full_info - ge - info - het, 2);

Decomposition = table(LastName, Overall, General_eq, Incomplete_info, Het_info, Interaction);

scriptDir = fileparts(mfilename('fullpath'));
if isempty(scriptDir)
    scriptDir = pwd;   % fallback when not running from a saved .m file
end

outDir = fullfile(scriptDir, '_table');
if ~exist(outDir, 'dir')
    mkdir(outDir);
end

writetable(Decomposition, fullfile(outDir, 'table_ciii.txt'), 'Delimiter', '\t');