## Code Quality

### R

[ADVISORY] `merge()` called without explicit `all=`, `all.x=`, or `all.y=` argument — defaults to inner join, which may silently drop rows. (table_a10.R, line 67)
  → data_spf_infl     = merge(data_spf,data_realz,by='qdate')

[ADVISORY] `merge()` called without explicit `all=`, `all.x=`, or `all.y=` argument — defaults to inner join, which may silently drop rows. (bvar_data.R, line 75)
  → data_main         = merge(data_all, data, by = c("qdate"))

[ADVISORY] `merge()` called without explicit `all=`, `all.x=`, or `all.y=` argument — defaults to inner join, which may silently drop rows. (bvar_data.R, line 102)
  → data_other       = merge(data_all, data, by = c("qdate"))

[ADVISORY] `merge()` called without explicit `all=`, `all.x=`, or `all.y=` argument — defaults to inner join, which may silently drop rows. (bvar_data.R, line 105)
  → data_save        = merge(data_main, data_other, by = c("qdate"))

[ADVISORY] `merge()` called without explicit `all=`, `all.x=`, or `all.y=` argument — defaults to inner join, which may silently drop rows. (sce_data.R, line 180)
  → data_sce         = merge(data_sce, data, by = c("qdate"))

[ADVISORY] `merge()` called without explicit `all=`, `all.x=`, or `all.y=` argument — defaults to inner join, which may silently drop rows. (sce_data.R, line 190)
  → data_sce         = merge(data_sce, data, by = c("qdate"))

[ADVISORY] `merge()` called without explicit `all=`, `all.x=`, or `all.y=` argument — defaults to inner join, which may silently drop rows. (sce_data.R, line 228)
  → data_sce_new     = merge(data_sce, data, by  =c("id"))

### Unknown

[CRITICAL] Hardcoded absolute path detected — the package will not run on another machine. (getDirs.m, line 12)
  → SaveDir='/Users/tobiasbroer/Dropbox/Research/Current_Projects/';

[CRITICAL] Hardcoded absolute path detected — the package will not run on another machine. (getDirs.m, line 13)
  → CodeDir='/Users/tobiasbroer/GutHub/BKKS/';

[CRITICAL] Hardcoded absolute path detected — the package will not run on another machine. (DoPanelExPost.m, line 3)
  → load("/Users/kmitm/Dropbox/BKKS_Shadow/_modelresults/kvar-prior/model_2044.mat")

[CRITICAL] Hardcoded absolute path detected — the package will not run on another machine. (DoPanelExPost.m, line 4)
  → load("/Users/kmitm/GitHub/BKKS/NewShocks.mat")

[CRITICAL] Hardcoded absolute path detected — the package will not run on another machine. (DoPanelExPost.m, line 21)
  → save('/Users/kmitm/Dropbox/BKKS_Shadow/_modelresults/kvar-prior/fullpanel_model_2044.mat', 'a0', 'a1', 'cpol', 'dec', 'X','ipol', 'kdist0', 'pdist0', 'pKdist0', 'ishocksT','forecast_moments','moments','diff_a','params','Kvec','Kvec_u','Kvec_e','kdist_panel','-v7.3')

