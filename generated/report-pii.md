## Potential Personal Identifiable Information (PII)

⚠️ We found the following instances of potentially personally identifying information. This may be completely legitimate but might be worth checking. *As a reminder, privacy legislation in many countries (e.g. GDPR in EU) prohibits the dissemination of personal identifiable information without prior (and documented) consent of individuals.* If indeed you want to publish such information with your replication package, you should probably have obtained IRB approval for this - please check!

**Summary:**
- Data files with PII indicators: 6
- Variables flagged in data: 35
- Code files with PII references: 94
- PII references in code: 1436

### Summary of Flagged Files

| File Type | File | Variables/References | PII Categories |
|-----------|------|----------------------|----------------|
| Data | `FRBNY-SCE-Public-Microdata-Complete-13-16.csv` | 4 | lat |
| Data | `FRBNY-SCE-Public-Microdata-Complete-17-19.csv` | 4 | lat |
| Data | `FRBNY-SCE-Public-Microdata-latest.csv` | 4 | lat |
| Data | `LICENSE.txt` | 1 | son |
| Data | `psid_2004_2010.csv` | 6 | house, phone, sex, child, wife |
| Data | `psid_2004_2010.dta` | 16 | house, phone, sex, child, wife, school |
| Code | `01_paper.tex` | 628 | lat, lon, name, loc, location, house, sex, gender, second, son, address, degree, city, compound, spouse |
| Code | `BKKS_GIRFs.m` | 125 | son, lat, loc, location, name |
| Code | `BKKS_load_parameters.m` | 6 | loc, location, name |
| Code | `BKKS_load_parameters.m` | 6 | loc, location, name |
| Code | `BKKS_main.m` | 8 | lat, lon |
| Code | `BKKS_main.m` | 11 | lat, lon, second |
| Code | `BKKS_start_runs.m` | 7 | loc, location |
| Code | `BKKS_start_runs.m` | 54 | loc, location |
| Code | `DoMomentsTouchup.m` | 1 | lat |
| Code | `DoPanelExPost.m` | 2 | lat |
| Code | `GaussHermite_2.m` | 1 | degree |
| Code | `InfoDecomposition.m` | 4 | name, lat |
| Code | `PanelForAlex.m` | 4 | lat |
| Code | `Redo_Wealth_Moments.m` | 1 | loc, location |
| Code | `Redo_Wealth_Moments_Ent.m` | 1 | loc, location |
| Code | `bvar_data.R` | 8 | name |
| Code | `bvar_est.m` | 3 | name, lat |
| Code | `calculate_fcerrors_stoch.m` | 2 | lat |
| Code | `calculate_fcerrors_stoch.m` | 2 | lat |
| Code | `calculate_fcerrors_stoch_optimized.m` | 5 | lat |
| Code | `calculate_ineq_moments_stoch.m` | 3 | lat |
| Code | `calculate_ineq_moments_stoch.m` | 3 | lat |
| Code | `calculate_moments_stoch.m` | 3 | lat |
| Code | `calculate_moments_stoch.m` | 6 | lat |
| Code | `data_bib.tex` | 30 | name, url, house, social, census, lat, city, son |
| Code | `data_master.R` | 5 | loc |
| Code | `figure_1_ab_table_a7a9.R` | 2 | lat, name |
| Code | `figure_1_cd.R` | 2 | lat, name |
| Code | `figure_2_a.R` | 2 | name |
| Code | `figure_2_b.R` | 2 | name |
| Code | `figure_3_and_4.m` | 36 | name, lat |
| Code | `figure_5.m` | 19 | name, lat |
| Code | `figure_6.m` | 3 | name, lat |
| Code | `figure_6_data.R` | 2 | name |
| Code | `figure_7.m` | 31 | name, loc, location, son, lat |
| Code | `figure_8.m` | 9 | name, lat |
| Code | `figure_b1.m` | 3 | name, loc, location, lat |
| Code | `figure_b2.m` | 3 | name, lat |
| Code | `figure_c1.m` | 27 | name, lat |
| Code | `figure_c2.m` | 2 | name, loc, location |
| Code | `figure_c3.m` | 2 | name, loc, location |
| Code | `figure_c4.m` | 3 | name |
| Code | `figure_d1.m` | 17 | name, lat |
| Code | `getDirs.m` | 1 | name |
| Code | `get_moments_table.m` | 1 | lname, name |
| Code | `get_moments_table.m` | 1 | lname, name |
| Code | `get_moments_table.m` | 1 | lname, name |
| Code | `get_moments_table2.m` | 1 | lname, name |
| Code | `inequality_moments.m` | 41 | lat, name |
| Code | `make_readme_pdf-checkpoint.py` | 17 | lat, url, lon, zip, loc, name |
| Code | `make_shocks.m` | 3 | lat, minute, name |
| Code | `make_table3_data.do` | 34 | house, lat, loc, name |
| Code | `make_table_bench_compare.m` | 20 | name, lat |
| Code | `make_table_entrepreneur_compare.m` | 23 | name, lat |
| Code | `make_table_entrepreneur_fi.m` | 1 | lat |
| Code | `model_master.m` | 4 | lat, name |
| Code | `packages_rstudio.R` | 2 | lat, name |
| Code | `rouwenhorst.m` | 3 | lon, lat |
| Code | `run_all.sh` | 22 | loc, name, minute |
| Code | `sce_data.R` | 22 | name, lat, sex |
| Code | `simKS.m` | 1 | son |
| Code | `simKS.m` | 1 | son |
| Code | `slim_models_tmp.m` | 31 | name, block, loc, lat |
| Code | `solve_EGM.m` | 4 | lat, lon |
| Code | `solve_EGM.m` | 4 | lat, lon |
| Code | `solve_experience.m` | 1 | lat |
| Code | `solve_experience.m` | 11 | lat, loc, block |
| Code | `spf_data.m` | 4 | name, second, lat |
| Code | `table_a10.R` | 3 | lat, name |
| Code | `table_a10.tex` | 1 | lat |
| Code | `table_a8.R` | 6 | name, lname, city, lat, house |
| Code | `table_a8.tex` | 2 | lat, house |
| Code | `table_b2_a.m` | 5 | name |
| Code | `table_bii.m` | 10 | name, loc, location |
| Code | `table_ci.m` | 7 | name, loc, location |
| Code | `table_cii.m` | 2 | name, lat |
| Code | `table_ciii.m` | 4 | name |
| Code | `table_civ.m` | 2 | name, lat |
| Code | `table_cix.m` | 2 | name, lat |
| Code | `table_cv.m` | 2 | name, lat |
| Code | `table_cvi.m` | 2 | name, lat |
| Code | `table_cvii.m` | 2 | name, lat |
| Code | `table_cviii.m` | 2 | name, lat |
| Code | `table_cx.m` | 2 | name, lat |
| Code | `table_cxi.m` | 4 | name |
| Code | `table_cxii.m` | 2 | name, lat |
| Code | `table_di.m` | 2 | name, lat |
| Code | `table_i.tex` | 1 | lat |
| Code | `table_i_and_ii.m` | 4 | name, lat |
| Code | `table_iii.m` | 3 | name |
| Code | `table_iv.m` | 2 | name, lat |
| Code | `table_vi.m` | 2 | name, lat |
| Code | `wprctile.m` | 7 | lat, lon |
| Code | `wprctile.m` | 7 | lat, lon |

*See [Appendix](report-pii-appendix.md) for detailed listing of all flagged instances.*
