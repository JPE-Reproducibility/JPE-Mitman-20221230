function [resid] =solve_ent_transition(prob_w_e,prob_e_w,ent_share)

    prob=[1-prob_w_e prob_w_e; prob_e_w 1-prob_e_w];
    inve=prob^10000;
    resid=inve(1,2)-ent_share;


        



