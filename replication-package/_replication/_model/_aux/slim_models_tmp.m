%% ========================================================================
%
%  SLIM_MODELS_TMP -- shrink _aux/_models_tmp from ~82 GB to ~0.29 GB
%
%  WHAT IT DOES
%    (A) For every .mat file whose name corresponds to a model identifier in
%        _baseline/modelsMasterExcel.xlsx or _kvar/modelsMasterExcel.xlsx,
%        it keeps EVERY variable except the four "panel" objects:
%              cah_panel, kdist_panel, pKdist_panel
%              forecast_moments.fcerror_ur_up_4q_panel   (a struct FIELD)
%        Those four account for ~96 GB of the ~129 GB uncompressed footprint
%        and are never read back by BKKS_main.m as an initial guess.
%    (B) After every slim step has succeeded, it deletes the regenerable
%        .mat files (shock panels, LOMendo re-runs, 7009 counterfactuals,
%        fig_7).
%
%  WHY "KEEP EVERYTHING EXCEPT THE PANELS" RATHER THAN "KEEP ONLY THE 8
%  INITIAL-GUESS VARIABLES": the solver only needs
%  params/a0/a1/cpol/dec/X/ipol/moments, but the output scripts in
%  /_model/ read this same directory and additionally need
%  moments, forecast_moments (scalar fields), kdist0, pdist0, pKdist0,
%  Kvec, Kvec_e, Kvec_u, ishocksT, diff_a and (kvar) sigKdist0.
%  Those total ~12 MB per file -- dropping them saves nothing and breaks
%  table_iii, figure_5, figure_7, figure_b1 and every table_*.m.
%
%  SAFETY PROPERTIES
%    * Idempotent: a file already free of panels is detected and skipped.
%    * Atomic: each file is rewritten to <name>.slimtmp in the SAME
%      directory, verified by reopening it, and only then renamed over the
%      original. An interrupted run never leaves a truncated .mat.
%    * All-or-nothing deletes: NOTHING is deleted unless every single slim
%      step reported success.
%    * DRY_RUN is TRUE by default. Review the printed plan, then set it to
%      false and re-run to execute.
%
%  BEFORE YOU RUN
%    This directory lives inside Dropbox. Pause Dropbox syncing first, or
%    the rewrites and deletes will generate ~82 GB of sync churn (and the
%    deleted files will sit in Dropbox's version history, so the space is
%    not reclaimed remotely until you purge them there).
%
% =========================================================================

clear; clc;

DRY_RUN = true;    % <-- set to false to actually modify the directory
                   %     (this has already been run once, on the distributed
                   %      package; it is idempotent and safe to re-run)

datapath = fullfile(fileparts(mfilename('fullpath')), '_models_tmp');
if ~isfolder(datapath)
    error('slim_models_tmp: directory not found: %s', datapath);
end

% ---- the four panel objects to drop -------------------------------------
PANEL_VARS  = {'cah_panel', 'kdist_panel', 'pKdist_panel'};
PANEL_FIELD = 'fcerror_ur_up_4q_panel';   % inside forecast_moments
FAT_FM_BYTES = 100e6;   % forecast_moments above this size still holds the panel

% ---- (A) KEEP-AND-SLIM: files matching a workbook model identifier ------
KEEP_FILES = { ...
    'model_1001.mat',   'model_1007.mat',   'model_1018.mat',   ...
    'model_1023.mat',   'model_1025.mat',   'model_1026.mat',   ...
    'model_1028.mat',   'model_1030.mat',   'model_1033.mat',   ...
    'model_1036.mat',   'model_1047.mat',   'model_1050.mat',   ...
    'model_1066.mat',   'model_1074.mat',   'model_105902.mat', ...
    'model_106002.mat', 'model_7009.mat',                       ...
    'model_2044.mat',   'model_2051.mat',   'model_2052.mat',   ...
    'initialguess1047.mat', 'initialguess1066.mat',             ...
    'initialguess2044.mat', 'initialguess2051.mat',             ...
    'initialguess2052.mat', 'initialguess7009.mat',             ...
    ... % the entrepreneur counterfactuals are derived rather than workbook
    ... % models, but they are already panel-free (41 MB for all seven) and
    ... % table_cx.m and table_di.m read them, so keeping them lets Tables
    ... % C.10 and D.1 be rebuilt without re-running the warm-start chains.
    'model_7009_exoki.mat',  'model_7009_exo.mat',              ...
    'model_7009_exo_ui.mat', 'model_7009_fiki.mat',             ...
    'model_7009_fi.mat',     'model_7009_fi_ui.mat',            ...
    'model_7009_ui.mat'                                         ...
};

% ---- (B) DELETE: every other .mat file, all regenerable -----------------
DELETE_FILES = { ...
    'NewShocks.mat',            ... % make_shocks.m, rng(140324) -> bit-identical
    'NE3Shocks3.mat',           ... % make_shocks.m, rng(140324) -> bit-identical
    ... % The LOMendo re-runs are 13.1 GB and their only value to the output
    ... % scripts is kdist_panel (figure_c1.m, table_ciii.m), which slimming
    ... % would strip anyway -- so slimming them would gain nothing. They are
    ... % rebuilt by BKKS_start_runs.m section 4.
    'model_1023_LOMendo.mat',   ... % BKKS_start_runs.m section 4
    'model_1026_LOMendo.mat',   ... % BKKS_start_runs.m section 4
    'fig_7.mat'                 ... % output of figure_7.m, rewritten on each run
};

fprintf('=======================================================\n');
fprintf(' slim_models_tmp   %s\n', datestr(now, 'yyyy-mm-dd HH:MM:SS'));
fprintf(' target : %s\n', datapath);
fprintf(' mode   : %s\n', ternary(DRY_RUN, 'DRY RUN (nothing written)', 'EXECUTE'));
fprintf('=======================================================\n\n');

startBytes = dirBytes(datapath);
fprintf('Directory size before: %8.2f GB\n\n', startBytes/1e9);

%% ---------------------------------------------------------------- PHASE 1
fprintf('--- PHASE 1: slim %d keep-files --------------------------\n\n', numel(KEEP_FILES));

% clear any temp files left behind by an interrupted earlier run
stale = dir(fullfile(datapath, '*.slimtmp.mat'));
for s = 1:numel(stale)
    fprintf('  [CLEAN]   removing stale temp %s\n', stale(s).name);
    if ~DRY_RUN
        delete(fullfile(datapath, stale(s).name));
    end
end
if ~isempty(stale); fprintf('\n'); end

allOK    = true;
nSlimmed = 0; nSkipped = 0; nMissing = 0;
savedBytes = 0;

for i = 1:numel(KEEP_FILES)

    name = KEEP_FILES{i};
    f    = fullfile(datapath, name);

    if ~isfile(f)
        fprintf('  [MISSING] %-24s  -- not present, cannot slim\n', name);
        nMissing = nMissing + 1;
        allOK    = false;          % a missing keep-file blocks the deletes
        continue
    end

    d0 = dir(f); before = d0.bytes;

    % ---- inspect without loading anything ------------------------------
    try
        w = whos('-file', f);
    catch ME
        fprintf('  [ERROR]   %-24s  -- unreadable: %s\n', name, ME.message);
        allOK = false; continue
    end
    names = {w.name};

    hasPanelVar = any(ismember(names, PANEL_VARS));
    fmIdx       = find(strcmp(names, 'forecast_moments'), 1);
    hasFatFM    = ~isempty(fmIdx) && w(fmIdx).bytes > FAT_FM_BYTES;

    % ---- idempotency: already slim? ------------------------------------
    if ~hasPanelVar && ~hasFatFM
        fprintf('  [SKIP]    %-24s  %7.1f MB  already slim\n', name, before/1e6);
        nSkipped = nSkipped + 1;
        continue
    end

    keepVars = setdiff(names, PANEL_VARS, 'stable');
    if isempty(keepVars)
        fprintf('  [ERROR]   %-24s  -- nothing would remain\n', name);
        allOK = false; continue
    end

    fprintf('  [SLIM]    %-24s  %7.1f MB -> ', name, before/1e6);

    if DRY_RUN
        dropped = intersect(names, PANEL_VARS, 'stable');
        fprintf('(dry run)  drop: %s%s\n', strjoin(dropped, ', '), ...
                ternary(hasFatFM, ' + forecast_moments.fcerror_ur_up_4q_panel', ''));
        nSlimmed = nSlimmed + 1;
        continue
    end

    % NOTE: the temp name MUST still end in ".mat" -- MATLAB's load() refuses
    % to open a file with any other extension, which would break verification.
    tmp = [f(1:end-4) '.slimtmp.mat'];
    if isfile(tmp); delete(tmp); end

    try
        % load ONLY the keepers -- the panels are never read off disk
        S = load(f, keepVars{:});

        % strip the hidden panel field out of forecast_moments
        if isfield(S, 'forecast_moments') && ...
           isstruct(S.forecast_moments)  && ...
           isfield(S.forecast_moments, PANEL_FIELD)
            S.forecast_moments = rmfield(S.forecast_moments, PANEL_FIELD);
        end

        save(tmp, '-struct', 'S', '-v7.3');

        % ---- verify the temp file before touching the original ---------
        v     = whos('-file', tmp);
        vname = {v.name};

        missingV = setdiff(keepVars, vname);
        if ~isempty(missingV)
            error('verification failed: missing %s', strjoin(missingV, ', '));
        end
        strayV = intersect(vname, PANEL_VARS);
        if ~isempty(strayV)
            error('verification failed: panel survived (%s)', strjoin(strayV, ', '));
        end
        fmI = find(strcmp(vname, 'forecast_moments'), 1);
        if ~isempty(fmI) && v(fmI).bytes > FAT_FM_BYTES
            error('verification failed: forecast_moments still fat (%.0f MB)', ...
                  v(fmI).bytes/1e6);
        end
        T = load(tmp, keepVars{1});   %#ok<NASGU>  final readability probe

        clear S T

        % ---- atomic replace --------------------------------------------
        [ok, msg] = movefile(tmp, f, 'f');
        if ~ok
            error('atomic replace failed: %s', msg);
        end

        d1 = dir(f); after = d1.bytes;
        savedBytes = savedBytes + (before - after);
        nSlimmed   = nSlimmed + 1;
        fprintf('%7.1f MB  (saved %6.2f GB)\n', after/1e6, (before-after)/1e9);

    catch ME
        fprintf('FAILED\n            %s\n', ME.message);
        if isfile(tmp); delete(tmp); end     % original left untouched
        allOK = false;
        clear S T
    end
end

fprintf('\n  slimmed %d | skipped %d | missing %d\n\n', nSlimmed, nSkipped, nMissing);

%% ---------------------------------------------------------------- PHASE 2
fprintf('--- PHASE 2: delete %d regenerable files -----------------\n\n', numel(DELETE_FILES));

if ~allOK
    fprintf('  *** ABORTED: at least one slim step failed. ***\n');
    fprintf('  Nothing has been deleted. Fix the errors above and re-run;\n');
    fprintf('  already-slimmed files will be skipped automatically.\n\n');
else
    delBytes = 0;
    for i = 1:numel(DELETE_FILES)
        name = DELETE_FILES{i};
        f    = fullfile(datapath, name);
        if ~isfile(f)
            fprintf('  [GONE]    %-24s  already absent\n', name);
            continue
        end
        d = dir(f);
        if DRY_RUN
            fprintf('  [DELETE]  %-24s  %7.2f GB  (dry run)\n', name, d.bytes/1e9);
        else
            delete(f);
            if isfile(f)
                fprintf('  [ERROR]   %-24s  delete failed\n', name);
            else
                fprintf('  [DELETE]  %-24s  %7.2f GB  removed\n', name, d.bytes/1e9);
            end
        end
        delBytes = delBytes + d.bytes;
    end
    fprintf('\n  reclaimed by deletion: %.2f GB\n\n', delBytes/1e9);
end

%% ---------------------------------------------------------------- SUMMARY
endBytes = dirBytes(datapath);
fprintf('=======================================================\n');
if DRY_RUN
    fprintf(' DRY RUN complete -- nothing was modified.\n');
    fprintf(' Set DRY_RUN = false at the top of this file to execute.\n');
else
    fprintf(' Directory size before : %8.2f GB\n', startBytes/1e9);
    fprintf(' Directory size after  : %8.2f GB\n', endBytes/1e9);
    fprintf(' Reclaimed             : %8.2f GB\n', (startBytes-endBytes)/1e9);
end
fprintf('=======================================================\n');
fprintf([' REMINDER: the figures that consume panel data\n' ...
         ' (figure_3_and_4, figure_6, figure_8, figure_b1, figure_b2,\n' ...
         '  figure_c1..c4, figure_d1, table_ciii, table_cx, table_di,\n' ...
         '  table_iii) now require section [1] of model_master.m to be\n' ...
         ' re-run first, which repopulates the panels and the shock files.\n']);

%% ---------------------------------------------------------------- HELPERS
function b = dirBytes(p)
    d = dir(fullfile(p, '*'));
    d = d(~[d.isdir]);
    b = sum([d.bytes]);
end

function out = ternary(cond, a, b)
    if cond, out = a; else, out = b; end
end
