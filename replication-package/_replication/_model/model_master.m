%% ========================================================================
%
% MASTER MODEL
%
% =========================================================================
clear all; clc; close all;

% Always operate relative to this file, not to whatever the caller's cwd is.
cd(fileparts(mfilename('fullpath')))

% NOTE: BKKS_start_runs.m and InfoDecomposition.m are scripts that begin with
% `clear`, so they wipe the shared base workspace. Navigation below therefore
% uses relative paths rather than a saved variable, which would not survive.

%% [1] REGENERATE THE SIMULATION SHOCK PANELS
%
% NewShocks.mat and NE3Shocks3.mat are ~7.8 GB each and are not distributed.
% Every model solve loads one of them, so this must run FIRST. It needs only
% the `params` struct from the distributed model_1001.mat and model_7009.mat,
% which the slimmed files retain. genShocks is seeded with
% rng(140324,'twister'), so the panels are reproduced exactly.

make_shocks;


%% [2] RUN ALL MODELS

% ---- Run baseline and most extensions -----
cd(fullfile('_aux','_baseline'))
BKKS_start_runs;
cd(fullfile('..','..'))

% ---- Run kvar extension -----
cd(fullfile('_aux','_kvar'))
BKKS_start_runs;
cd(fullfile('..','..'))

% ---- Information decomposition for Table C.11 -----
% Needs the re-solved model_7009.mat and NE3Shocks3.mat, so it runs after
% both of the above.
cd(fullfile('_aux','_baseline'))
InfoDecomposition;
cd(fullfile('..','..'))


%% [3] RUN ALL OUTPUT


% ---- Run tables -----

table_bii;
table_ci;
table_cii;
table_ciii;
table_civ;
table_cix;
table_cv;
table_cvi;
table_cvii;
table_cviii;
table_cx;
table_cxi;
table_cxii;
table_di; 
table_i_and_ii;
table_iv;
table_vi;
table_iii;


% ---- Run figures -----
figure_3_and_4;
figure_5;
figure_6;
figure_7;
figure_8;
figure_b1;
figure_b2;
figure_c1;
figure_c2;
figure_c3;
figure_c4;
figure_d1; 

