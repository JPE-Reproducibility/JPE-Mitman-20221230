 function table_moments = get_moments_table(modelname)

    
    load(modelname,'*moments')
    table_moments.bc=100*[moments.kbar_log_stdev moments.y_log_stdev moments.inv_log_stdev moments.c_log_stdev moments.c_corr_y_log];
    table_moments.bc(end)=table_moments.bc(end)/100;
    table_moments.ineq=[moments.gini moments.ninetyten moments.ninetynineone moments.k_corr_y_log moments.gini_corr_y_log];
   % table_moments.forecast=forecast_moments.coeffs_ur_up_4q_mix;
    table_moments.info = moments.info;
    table_moments.info_emp = moments.info_emp;
    table_moments.info_unemp = moments.info_unemp;
    table_moments.comp=[moments.kbar_mean moments.y_log_stdev moments.gini moments.ninetyten moments.ninetynineone moments.info_unemp moments.info_emp];
    table_moments.add = moments.inv_corr_y_log;
    
