 function table_moments = get_moments_table2(modelname)

    
    load(modelname,'*moments')
    table_moments.bc=100*[moments.kbar_log_stdev moments.y_log_stdev moments.inv_log_stdev moments.c_log_stdev moments.c_corr_y_log];
    table_moments.bc(end)=table_moments.bc(end)/100;
    table_moments.ineq=[moments.gini moments.ninetyten moments.ninetynineone moments.ninetyfifty moments.k_corr_y_log];
    table_moments.ineq_alt=[moments.gini mean(moments.p90_ts)/mean(moments.p10_ts) mean(moments.p99_ts)/mean(moments.p1_ts) mean(moments.p90_ts)/mean(moments.p50_ts) moments.k_corr_y_log];
    %table_moments.forecast=forecast_moments.coeffs_ur_up_4q_mix;
    table_moments.info = moments.info;
    table_moments.info_emp = moments.info_emp;
    table_moments.info_unemp = moments.info_unemp;
    table_moments.comp=[moments.kbar_mean moments.y_log_stdev moments.gini moments.ninetyten moments.ninetynineone moments.ninetyfifty moments.info_unemp moments.info_emp];
    table_moments.comp_alt=[moments.kbar_mean moments.y_log_stdev moments.gini mean(moments.p90_ts)/mean(moments.p10_ts) mean(moments.p99_ts)/mean(moments.p1_ts) mean(moments.p90_ts)/mean(moments.p50_ts) moments.info_unemp moments.info_emp];
    
    cor9010 = corr(moments.p90_ts,moments.p10_ts);
    cor9910 = corr(moments.p99_ts,moments.p10_ts);
    
    
    table_moments.ineqdyn = [moments.gini_stdev moments.ninetyfifty_stdev moments.ninetyninefifty_stdev cor9010 cor9910];
    
    
