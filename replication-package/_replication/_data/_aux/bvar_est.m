%% ======================================================================
% BAYESIAN VAR ESTIMATION
% -- FIVE VARIABLE FORECASTING VAR
% =======================================================================
clear all; clc; close all;
currentFile = mfilename( 'fullpath' );
[pathstr,~,~] = fileparts( currentFile );

opts = optimset('Display','off');

rng(1);

n = 5;
p = 2;

smpl = 2500;


opts = delimitedTextImportOptions("NumVariables", 15);

opts.DataLines = [2, Inf];
opts.Delimiter = ",";

opts.VariableNames = ["VarName1", "qdate", "P", "infl", "Y", "y", "yqoq", "u", "Group1x", "irate", "hours", "Group1y", "empl", "pop", "n"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

databvar = readtable("data_bvar.csv", opts);
clear opts


T = size(databvar,1); 
Y  = databvar;
Y  = [Y(:,4) Y(:,6) Y(:,8) Y(:,10) Y(:,15)]; % var = {infl,y,u,irate,n}
Y  = Y{:,:};

 
PriorMdl = bayesvarm(n,p, ModelType="conjugate");

[PosteriorMdl, Summary] = estimate(PriorMdl,Y);

[Coeff,Vol] = simulate(PosteriorMdl,'NumDraws',smpl);

y   = Y';
fy4 = zeros(n,T,smpl);
for jj=1:smpl

    beta_mean   = reshape(Coeff(:,jj), [n*p+1,n]);
    cons_hat    = beta_mean(end,:)';
    phi1_hat    = [beta_mean(1:n,1)'; beta_mean(1:n,2)'; beta_mean(1:n,3)'; beta_mean(1:n,4)'; beta_mean(1:n,5)'];
    phi2_hat    = [beta_mean(n+1:end-1,1)'; beta_mean(n+1:end-1,2)'; beta_mean(n+1:end-1,3)'; beta_mean(n+1:end-1,4)'; beta_mean(n+1:end-1,5)'];

    for tt=p:T
        fy1          = cons_hat + phi1_hat*y(:,tt)  + phi2_hat*y(:,tt-1);
        fy2          = cons_hat + phi1_hat*fy1+ phi2_hat*y(:,tt);
        fy3          = cons_hat + phi1_hat*fy2+ phi2_hat*fy1;
        fy4(:,tt,jj) = cons_hat + phi1_hat*fy3+ phi2_hat*fy2;
    end
end

prob_up =zeros(1,T);
for tt=p:T   
    u_realz = y(3,tt).*ones(smpl,1);
    u_fcast = squeeze(fy4(3,tt,:));

    up       = u_fcast-u_realz;

    count = length(nonzeros(up(up>0)));

    prob_up(tt) = count/smpl;
end


qdate = databvar(:,2); 
qdate = qdate{:,:};

data_save = [qdate(p+1:end) prob_up(p+1:end)'];

mdate          = [qdate(p+1):1/12:qdate(end)]';
prob_up_interp = interp1(data_save(:,1),data_save(:,2),mdate);

data_save_interp = [mdate prob_up_interp];

writematrix(data_save_interp,'prob_up_bvar.csv') 
