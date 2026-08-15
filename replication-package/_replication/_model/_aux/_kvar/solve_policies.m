function [cpol,dec,ipol,Xp] = solve_policies(cpol0,ipol0,X0,params)


iter    =   0;
cdiff   =   1;
idiff   =   1;
                                                                    
while(iter<25 && idiff>1e-8)
    iter = iter+1;
    
    [dec,cpol] = solve_EGM(cpol0,ipol0,params);
    if(params.exinfo==0)
        [Xp,Vp,ipol,t1] = solve_experience(X0,cpol,dec,ipol0,params);
    else
        ipol = params.exinfo*ones(size(ipol0));
        Xp = X0;
        t1=0;
    end
    cdiff=max(abs(cpol-cpol0),[],'all');
    idiff=max(abs(ipol-ipol0),[],'all');
    % xdiff=max(abs(Xp-X0),[],'all');



    cpol0   =   cpol;
    if(idiff>1e-3)
        ipol0   =   0.5*ipol+0.5*ipol0;
    else
        ipol0   =   0.9*ipol+0.1*ipol0;
    end
    X0      =   Xp;
end
fprintf('Iter %d\t cdiff= %e\t idiff= %e\t Vfun t= %e\n',iter,cdiff,idiff,t1)



