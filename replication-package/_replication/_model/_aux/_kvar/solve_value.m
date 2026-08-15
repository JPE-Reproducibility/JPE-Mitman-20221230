function [Vp,Wp,Wp_info,ipol] = solve_value(V0,W0,cpol,kpol,cpol_full,kpol_full,info_choice,params)
% Function to compute the value function given the policy functions for
% consumption and savings and the information choice
% Inputs
% V0: initial guess for V
% cpol: consumption pol function
% kpol: savings pol function
% info_choise: information policy function
% Outputs
% V: ex-ante value function
% W: ex-post value function


nA = params.nA;
ns = params.ns; 
Agrid = params.Agrid;
tol = params.tol;
maxIter = params.maxIter;
delta = params.delta;
wtax = params.wtax;
t1 = 0;
sav_grid = params.sav_grid;
bmin = params.bmin;
ix = params.ix;
r_mat = params.r_mat;
w_mat = params.w_mat;
beta = params.beta;
euler   = params.euler;
probdeath=params.probdeath;

npz     = params.npz;
npzp    = params.npzp;
npk     = params.npk;
ns      = params.ns;
nz      = params.nz;

% Get the persistences of the good and bad states
rho_g = params.piz(2,2);
rho_b = params.piz(1,1);

Vp=V0;
zprior = params.zprior;
zpost = params.zpost;

% zprior_stack = repmat(zprior,[nA 1]);



% Contruct the transition matrix between posterior and prior
zpost_to_prior=zeros(npzp,npz);
z_prior_to_prepost=zeros(npz,npzp);
vals_post_prior=zeros(npzp,2);
inds_post_prior=zeros(npzp,2);

z_prior_to_post=zeros(npz,npzp);

for zc=1:npzp
    prior = rho_g*zpost(zc)+(1-rho_b)*(1-zpost(zc));
    [vals,inds] = basefun(zprior,npz,prior);
    zpost_to_prior(zc,inds(1))=vals(1);
    zpost_to_prior(zc,inds(2))=vals(2);
    vals_post_prior(zc,:)=vals;
    inds_post_prior(zc,:)=inds;
end

for zc=1:npz
    post = rho_g*zprior(zc)+(1-rho_b)*(1-zprior(zc));
    [vals,inds] = basefun(zpost,npzp,post);
    z_prior_to_post(zc,inds(1))=vals(1);
    z_prior_to_post(zc,inds(2))=vals(2);
end


for zc=1:npz
    prepost = (zpost(zc)+rho_b-1)/(rho_g+rho_b-1);
    [vals,inds] = basefun(zpost,npzp,prepost);
    z_prior_to_prepost(zc,inds(1))=vals(1);
    z_prior_to_prepost(zc,inds(2))=vals(2);
end


% indz_prob = zeros(npzp,nz*nz);
% for pzc=1:npzp            
%     indz_prob(pzc,1)=(1-zpost(pzc))*rho_b;
%     indz_prob(pzc,2)=(1-zpost(pzc))*(1-rho_b);
%     indz_prob(pzc,3)=zpost(pzc)*(1-rho_g);
%     indz_prob(pzc,4)=zpost(pzc)*rho_g;    
% end
indz_prob = zeros(npzp,nz*nz);
for pzc=1:npzp            
    indz_prob(pzc,1)=(1-zpost(pzc));
    indz_prob(pzc,2)=(1-zpost(pzc));
    indz_prob(pzc,3)=zpost(pzc);
    indz_prob(pzc,4)=zpost(pzc);    
end

% cpol(cah,prior,exo states)
exotos=zeros(npk*ns,1);
exotok=exotos;

pi_exo = zeros(npk*ns,npk*ns,npzp,nz*nz);
pi_exo_full = zeros(npk*ns,npk*ns,nz*nz);
exotos_full=zeros(npk*ns,1);
exotok_full=exotos;

for zc=1:nz
    for zcc=1:nz
        for pzc=1:npzp
            indz=zcc+(zc-1)*nz;
            j=0;
            for pkc=1:npk
                for sc=1:ns
                    j=j+1;
                    exotos(j)=sc;
                    exotok(j)=pkc;
                    for pkcp=1:npk
                        pi_exo(j,1+(pkcp-1)*ns:pkcp*ns,pzc,indz)=...
                            params.piagg{indz}(sc,:)*(...
                            zpost(pzc)*params.pk_trans(pkc,pkcp,2)+...
                            (1-zpost(pzc))*params.pk_trans(pkc,pkcp,1));
                    end
                end
            end
        end
    end
end

for zc=1:nz
    for zcc=1:nz
        indz=zcc+(zc-1)*nz;
        j=0;
        for pkc=1:npk
            for sc=1:ns
                j=j+1;
                exotos_full(j)=sc;
                exotok_full(j)=pkc;
                for pkcp=1:npk
                    pi_exo_full(j,1+(pkcp-1)*ns:pkcp*ns,indz)=...
                        params.piagg{indz}(sc,:)*(...
                        params.pk_trans(pkc,pkcp,zc));
                end
            end
        end
    end
end

% W = u(cpol)+beta E_{z',individual stuff},
% Need to take expectations over e',pK',m'

% Things that are functions of the posterior
% kpol
% cpol
% W0/Wp

% Things that are functions of the prior
% V0/Vp
% info


V0_full = cpol_full.^(1-params.sigma)/((1-params.beta*(1-probdeath))*(1-params.sigma));
W0_full = cpol_full.^(1-params.sigma)/((1-params.beta*(1-probdeath))*(1-params.sigma));


% Preinitilize cah' tomorrow as a function of prior of z and prior of k
cahp = zeros(nA,nz,npk*ns,npzp,npk*ns);
Vint = zeros(nA,nz,npk*ns,npzp,npk*ns);

cahp_full = zeros(nA,nz,npk*ns,nz,npk*ns);
Vint_full = zeros(nA,nz,npk*ns,nz,npk*ns);

% Add the fact that the capital forecast for tomorrow can be two values,
% because from the LOM k' depends on k and z, and we don't know z. 
% V0 and W0 to start
for j=1:ns*npk
    for pzc=1:npzp
        for jp  = 1:ns*npk
            for zcc = 1:nz
                cahp(:,zcc,jp,pzc,j)    = kpol(:,pzc,j)*(1+r_mat(zcc,jp)-delta-wtax)/(1-probdeath) + ix(exotos(jp))*w_mat(zcc,jp);
                % Vint(:,zcc,jp,pzc,j)      = interp1(Agrid,V0(:,pzc,jp),cahp(:,zcc,jp,pzc,j),'pchip');
            end
        end
    end
end

for j = 1:ns*npk
    for zc = 1:nz
        for jp = 1:ns*npk
            for zcc = 1:nz
                cahp_full(:,zcc,jp,zc,j) = kpol_full(:,zc,j)*(1+r_mat(zcc,jp)-delta-wtax)/(1-probdeath) + ix(exotos_full(jp))*w_mat(zcc,jp);
            end
        end
    end
end



iter=0;
max_diff=1;
while(iter<100 && max_diff>1e-8)


    % Note here that cahp is defined over today's posterior, but V0 is
    % defined over tomorrow's prior. So we need to roll
    iter=iter+1;
    for j=1:ns*npk
        for pzc=1:npzp
            for jp  = 1:ns*npk
                for zcc = 1:nz
                    % Vint(:,zcc,jp,pzc,j)      = vals_post_prior(pzc,1)*interp1(Agrid,V0(:,inds_post_prior(pzc,1),jp),cahp(:,zcc,jp,pzc,j),'pchip')...
                    %     +vals_post_prior(pzc,2)*interp1(Agrid,V0(:,inds_post_prior(pzc,2),jp),cahp(:,zcc,jp,pzc,j),'pchip');
                    Vint(:,zcc,jp,pzc,j)      = interp1(Agrid,W0(:,1+(zcc-1)*(npzp-1),jp),cahp(:,zcc,jp,pzc,j),'pchip');

                end
            end
        end
    end
    % Vint is defined over today's posterior, today's pk and s, as well as
    % z' and pk' and s'. So we need to integrate out over z' and pk',s'
    % based on today's posterior, because we want EVp=EVint defined only
    % form the point of view of what's known today
    
    for j=1:ns*npk
        for zc=1:nz
            for jp  = 1:ns*npk
                for zcc = 1:nz
                    Vint_full(:,zcc,jp,zc,j)      = interp1(Agrid,V0_full(:,zcc,jp),cahp_full(:,zcc,jp,zc,j),'pchip');
                end
            end
        end
    end
    



    EVp         = zeros(nA,npzp,ns*npk);
    EVp_full    = zeros(nA,nz,ns*npk);

    % Looping over z and z', because we need to know (z,z') in order to
    % figure out the transition probabilities for unemployment between
    % today and tomorrow. indz_prob says, based on your prior pzc today,
    % what is the probability of the four possible (z,z') outcomes
    % tomorrow. Then, we also need to integrate over the individual risk
    % and the evolution of the capital prior, which are baked into pi_exo.
    % And Vint is the interpolated value function at V(m'(z')) which is
    % conditional on k'(m,s) (m' = cahp above). Vint is defined over m',
    % z', pk',pz,s
    for j=1:ns*npk
        for zc=1:nz
            for zcc=1:nz
                indz=zcc+(zc-1)*nz;
                for pzc=1:npzp
                    EVp(:,pzc,j) = EVp(:,pzc,j) +indz_prob(pzc,indz)*squeeze(Vint(:,zcc,:,pzc,j))*pi_exo(j,:,pzc,indz)';
                    % EVp(:,pzc,j) = EVp(:,pzc,j) +squeeze(Vint(:,zcc,:,pzc,j))*pi_exo(j,:,pzc,indz)';
                end
                EVp_full(:,zc,j) = EVp_full(:,zc,j)+squeeze(Vint_full(:,zcc,:,zc,j))*pi_exo_full(j,:,indz)';
            end
        end
    end

    % test=zeros(ns*npk,npzp);
    % for j=1:ns*npk
    %     for zc=1:nz
    %         for zcc=1:nz
    %             indz=zcc+(zc-1)*nz;
    %             for pzc=1:npzp
    %                 test(j,pzc) = test(j,pzc) + indz_prob(pzc,indz)*ones(1,npk*ns)*pi_exo(j,:,pzc,indz)';
    %             end
    %         end
    %     end
    % end    

    % W0 should be defined over m',pz,exostates
    % Evalute V(cahp,pzc,jp)
    % W(nA,pzc,j)

    % W from eq 4.2 is just a function of the posterior
    Wp =  cpol.^(1-params.sigma)/(1-params.sigma)+beta*(1-probdeath)*EVp;

    Vp_full = cpol_full.^(1-params.sigma)/(1-params.sigma)+beta*(1-probdeath)*EVp_full;
    % What is the expected value from purchasing and not purchasing
    % information today? These objects should be defined over the *prior*
    % today, even though the Wp is defined over the posterior (because
    % they've the expected value

    EWp_no      = zeros(nA,npz,ns*npk);
    EWp_info    = zeros(nA,npz,ns*npk);

    for j=1:ns*npk
        Wp_rec=interp1(Agrid,Wp(:,1,j),Agrid-params.nu,'pchip');
        Wp_boom=interp1(Agrid,Wp(:,npzp,j),Agrid-params.nu,'pchip');
        for pzc=1:npz
            EWp_info(:,pzc,j)   =   zprior(pzc)*Wp_boom + (1-zprior(pzc))*Wp_rec;
            EWp_no(:,pzc,j)     =   Wp(:,:,j)*z_prior_to_post(pzc,:)';
        end
    end



% Now let's go back to sub-period 1 and update V (there's a question of, do
% we want to keep info choice fixed, or update it here. Let's keep it fixed
% for now.
    % info_buy = Wp_info-Wp_prior;
    % i_less_no = info_buy<0;
    % Vp(i_less_no)   =  euler/params.ev_shock + Wp_prior(i_less_no) + ...
    %     1/params.ev_shock*log(1+exp(params.ev_shock*info_buy(i_less_no)));
    % 
    % no_less_i = ~i_less_no;
    % Vp(no_less_i)   =  euler/params.ev_shock + Wp_info(no_less_i) + ...
    %     1/params.ev_shock*log(1+exp(-params.ev_shock*info_buy(no_less_i)));

    Vp = info_choice.*(EWp_info-params.kappa)+(1-info_choice).*EWp_no;

    V_diff=max(abs(Vp-V0),[],'all');
    W_diff=max(abs(Wp-W0),[],'all');

    V_diff_full=max(abs(Vp_full-V0_full),[],'all');

    fprintf('Iter %d\t Vdiff %e\t Wdiff %e\t Vdiff_full %e\n',iter,V_diff,W_diff,V_diff_full)
    V0=Vp;
    W0=Wp;
    V0_full = Vp_full;
    max_diff=max(max(V_diff,W_diff),V_diff_full);

end

% Preinitialize
ipol = info_choice;


% Indicator for when buying information is preferred
info_buy = EWp_info-EWp_no;
i_less_no = info_buy<0;
no_less_i = ~i_less_no;

ipol(i_less_no)= 1 - 1./(1+exp(params.ev_shock*info_buy(i_less_no)));
ipol(no_less_i)= 1./(1+exp(-params.ev_shock*info_buy(no_less_i)));

keyboard


% In Eq 4.2 in the paper, what are we taking expectations over?
% pz is deterministic (your posterior today = prior tomorrow + roll of
% Markov chain) We need to check at which point is the markov chain rolled
% to make sure we do it once, not 0 or 2
% pk is determinitic give pz & LOM/ pk' = pz*LOM|zg+(1-pz_*LOM|zb
% pz*rho_z*V(m'(zg,pk|g),pk')+...
% Need a mapping from pz,pk->pk'
% Already above have mapping from m'(eps',K',z')




