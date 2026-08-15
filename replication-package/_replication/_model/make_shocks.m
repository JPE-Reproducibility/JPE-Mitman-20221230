%% ========================================================================
%
% MAKE_SHOCKS -- regenerate the simulation shock panels
%
% NewShocks.mat and NE3Shocks3.mat are each ~7.8 GB and are therefore not
% distributed with the replication package. They are pure functions of the
% corresponding model's parameter struct: genShocks.m seeds the generator
% with rng(140324,'twister') before drawing, so re-running this script
% reproduces the panels used in the paper bit for bit.
%
%   NewShocks.mat    <- genShocks(params) from model_1001.mat (baseline)
%   NE3Shocks3.mat   <- genShocks(params) from model_7009.mat (entrepreneur)
%
% Consumed by: table_iii.m, figure_7.m, figure_b1.m
%
% Takes about 45 minutes for the pair: genShocks walks an interpreted N-by-T
% loop, which is 5e8 iterations at each of the two calibrations. Needs ~20 GB
% of RAM and writes ~14.5 GB to disk.
%
% =========================================================================

scriptDir = fileparts(mfilename('fullpath'));
datapath  = fullfile(scriptDir, '_aux', '_models_tmp');
addpath(fullfile(scriptDir, '_aux', '_baseline'));

targets = { ...
    'model_1001.mat', 'NewShocks.mat'; ...
    'model_7009.mat', 'NE3Shocks3.mat'  ...
};

for i = 1:size(targets, 1)

    modelFile = fullfile(datapath, targets{i,1});
    shockFile = fullfile(datapath, targets{i,2});

    if exist(shockFile, 'file')
        fprintf('make_shocks: %s already exists, skipping.\n', targets{i,2});
        continue
    end

    if ~exist(modelFile, 'file')
        error('make_shocks: %s not found. Run the model solves in [1] of model_master.m first.', modelFile);
    end

    fprintf('make_shocks: generating %s from %s ... ', targets{i,2}, targets{i,1});

    S = load(modelFile, 'params');
    [ishocks, xshocks, kapshocks, kinfoshocks, zvec, death] = genShocks(S.params); %#ok<ASGLU>

    save(shockFile, 'ishocks', 'xshocks', 'kapshocks', 'kinfoshocks', ...
         'zvec', 'death', '-v7.3');

    clear ishocks xshocks kapshocks kinfoshocks zvec death S
    fprintf('done.\n');

end
