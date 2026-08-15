function [Xp,Vp,ipol,t1] = solve_experience(X0_in,cpol_in,kpol,info_choice_in,params)
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

interp_type='linear';
nA = params.nA;
nk = params.nk;
ns = params.ns; 
Agrid = params.Agrid;
tol = params.tol;
maxIter = params.maxIter;
delta = params.delta;
Kgrid = params.Kgrid;

wtax  = params.wtax;
t1 = 0;
sav_grid = params.sav_grid;
bmin = params.bmin;
ix = params.ix;
iu = params.iu;
r_mat = params.r_mat;
w_mat = params.w_mat;
taxe_mat = params.taxe_mat;
taxu_mat = params.taxu_mat;
beta = params.beta;
euler   = params.euler;
probdeath=params.probdeath;
rebate = params.rebate;
kappa = params.kappa;
nu = params.nu;

npz     = params.npz;
npzp    = params.npzp;
npk     = params.npk;
ns      = params.ns;
nz      = params.nz;

% Get the persistences of the good and bad states
rho_g = params.piz(2,2);
rho_b = params.piz(1,1);

zprior = params.zprior;
zpost = params.zpost;

zprior_stack = repmat(zprior,[nk 1 ns*npk]);


% Contruct the transition matrix between posterior and prior
zpost_to_prior=zeros(npzp,npz);
z_prior_to_prepost=zeros(npz,npzp);
vals_post_prior=zeros(npzp,2);
inds_post_prior=zeros(npzp,2);

z_prior_to_post=zeros(npz,npzp);

% Definitely need this to roll today's posterior into tomorrow's prior
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
pi_exo_full_sliced = zeros(nz*nz,npk*ns,npk*ns);

exotos_full=zeros(npk*ns,1);
exotok_full=exotos;



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
                    pi_exo_full_sliced(indz,1+(pkcp-1)*ns:pkcp*ns,j)=...
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

% cpol is a function of m,pz,pk/s, so we need to replicated it across the z
% dimension because you'll make the same choices regardless of the true
% state (since you odn't know it!). This is also true for the info choice,
% except that info choice depends on the prior (as opposed to the
% posterior) so just need to be careful of the different dimensions


cpol        = repmat(reshape(cpol_in,[nA 1 npzp npk*ns]),[1 nz 1 1]);
info_choice = info_choice_in; %repmat(reshape(info_choice_in,[nk 1 npz npk*ns]),[1 nz 1 1]);

% This is the Chi from the document, defined over CAH, z, posterior, and
% exo stuff
if(size(X0_in,2)==nz)
    X0             = X0_in;
else
    X0          = repmat(reshape(X0_in,[nA 1 npzp npk*ns]),[1 nz 1 1]);
end

% Preinitilize cah' tomorrow as a function of prior of z and prior of k
cahp = zeros(nA,nz,npk*ns,npzp,npk*ns);


cah_today = zeros(nk,nz,npk*ns);
% Add the fact that the capital forecast for tomorrow can be two values,
% because from the LOM k' depends on k and z. Here now we're using the
% exotos full info, because in the experience utility thought experiment we
% need to use the real probabilities of transferring between states.
% cash at hand tomorrow is a function of my posterior today, and my individual
% states, but tomorrow's depends on zcc.

% for j=1:ns*npk
%     for pzc=1:npzp
%         for jp  = 1:ns*npk
%             for zcc = 1:nz
%                 cahp(:,zcc,jp,pzc,j)    = kpol(:,pzc,j)*(1+r_mat(zcc,jp)-delta)/(1-probdeath) + ix(exotos_full(jp))*w_mat(zcc,jp);
%             end
%         end
%     end
% end
% cahp = (cahp<=Agrid(nA)).*cahp+Agrid(nA)*(cahp>Agrid(nA));


% cahp_full = (cahp_full<=Agrid(nA)).*cahp_full+Agrid(nA)*(cahp_full>Agrid(nA));
is_saver = (sav_grid >= 0);

for j=1:ns*npk
    for zc = 1:nz
        % Return depends on whether saving or borrowing
        % Savers (b >= 0): wealth tax applies
        % Borrowers (b < 0): no wealth tax
        R_saver = (1+r_mat(zc,j)-delta-wtax)/(1-probdeath);
        R_borrower = (1+r_mat(zc,j)-delta)/(1-probdeath);
        R_effective = is_saver * R_saver + (1 - is_saver) * R_borrower;
        
        cah_today(:,zc,j) = rebate*Kgrid(exotok_full(j))*wtax + sav_grid .* R_effective ...
                            + ix(exotos_full(j))*w_mat(zc,j) * ( iu(exotos_full(j))*(1-taxu_mat(zc,j)) + (1-iu(exotos_full(j)))*(1-taxe_mat(zc,j)) );
    end
end

% for j=1:ns*npk
%     for zc = 1:nz
%         cah_today(:,zc,j)    = rebate*Kgrid(exotok_full(j))*wtax+sav_grid*(1+r_mat(zc,j)-delta-wtax)/(1-probdeath) ...
%                                 + ix(exotos_full(j))*w_mat(zc,j) * ( iu(exotos_full(j))*(1-taxu_mat(zc,j)) + (1-iu(exotos_full(j)))*(1-taxe_mat(zc,j)) );
%     end
% end


iter=0;
max_diff=1;


% Ok, we now have the initial guess for X:

% X0 as a function of cah, z, Kpost, eps, Zpost
% The tricky thing is figuring out when we have priors and when we have
% posteriors to get things right


while(iter<50 && max_diff>1e-8)

    t1start = tic;

    % To calculate the X recursion from the note, we need:
    % X = u(c) + beta*E[X']
    % Note X is defined over today's posteriors
    % What we need is to express E[X'] also as function of today's
    % posteriors, even though X' itself is defined over *tomorrow's*
    % posteriors.


    % Note here that kpol is defined over today's posterior, but X0 is
    % defined over tomorrow's prior. So we need to roll

    Wpost=zeros(nk,nz,npzp,ns*npk);
    % Let's compute W from the document
    iter=iter+1;
    for pzc=2:npzp-1
        for jp  = 1:ns*npk
            for zcc = 1:nz
                Wpost(:,zcc,pzc,jp) = interp1(Agrid,X0(:,zcc,pzc,jp),cah_today(:,zcc,jp),interp_type,'extrap');
            end
        end
    end
    % if(any(isinf(Wpost),'all'))
    %     keyboard
    % end

    for jp  = 1:ns*npk
        for zcc = 1:nz
            Wpost(:,zcc,1,jp) = interp1(Agrid,X0(:,zcc,1,jp),cah_today(:,zcc,jp)-nu,interp_type,'extrap');
            Wpost(:,zcc,npzp,jp) = interp1(Agrid,X0(:,zcc,npzp,jp),cah_today(:,zcc,jp)-nu,interp_type,'extrap');
        end
    end

    % if(any(isnan(Wpost),'all'))
    %     keyboard
    % end
    % if(any(isinf(Wpost),'all'))
    %     keyboard
    % end

    % Now we need to get this in terms of the t variables
    % Evalute W at kpol, which means we need a mapping from yesterday's posterior to 
    % today's things

    Wpre=zeros(nk,nz,npz,ns*npk);

    % If you don't buy info choice, today's posterios = today's prior
    % info_choice defined nk,prior,exo stuff 
    parfor jp=1:ns*npk
    % for jp=1:ns*npk
     
        for zcc = 1:nz
            for pzc=1:npz
                Wpre(:,zcc,pzc,jp) = info_choice(:,pzc,jp).*(Wpost(:,zcc,1+(npzp-1).*(zcc==2),jp)-kappa)...
                    +(1-info_choice(:,pzc,jp)).*Wpost(:,zcc,pzc+1,jp);
            end
        end
    end
    % if(any(isnan(Wpre),'all'))
    %     keyboard
    % end
    % if(any(isinf(Wpre),'all'))
    %     keyboard
    % end


    Wpostpre=zeros(nk,nz,npzp,ns*npk);
  
    % Interpolate Wpre in terms of yesterday's posterior
    for pzc=1:npzp
        Wpostpre(:,:,pzc,:)=Wpre(:,:,inds_post_prior(pzc,1),:)*vals_post_prior(pzc,1)...
            +Wpre(:,:,inds_post_prior(pzc,2),:)*vals_post_prior(pzc,2);
    end
    % if(any(isnan(Wpostpre),'all'))
    %     keyboard
    % end
    % if(any(isinf(Wpostpre),'all'))
    %     keyboard
    % end

    EXp=zeros(nA,nz,npzp,ns*npk);

    % Now we have Wpre in terms of k',z',prior',exo stuff'
    % Now, we want EW in terms of m,posterior,exo stuff
    parfor j=1:ns*npk
    % for j=1:ns*npk
        for zc=1:nz
            for pzc=1:npzp
                for jp=1:ns*npk
                    for zcc=1:nz
                        indz=zcc+(zc-1)*nz;
                        EXp(:,zc,pzc,j)=EXp(:,zc,pzc,j)...
                            +interp1(sav_grid,Wpostpre(:,zcc,pzc,jp),kpol(:,pzc,j),interp_type,'extrap')...
                            *pi_exo_full_sliced(indz,jp,j);
                    end
                end
            end
        end
    end

    % if(any(isnan(EXp),'all'))
    %     keyboard
    % end
    % if(any(isinf(EXp),'all'))
    %     keyboard
    % end
% 
    



    % W from eq 4.2 is just a function of the posterior
    if(params.sigma==1)
        Xp =  log(cpol)+beta*(1-probdeath)*EXp;
    else
        Xp =  cpol.^(1-params.sigma)/(1-params.sigma)+beta*(1-probdeath)*EXp;
    end
    % if(any(isnan(Xp),'all'))
    %     keyboard
    % end
    % if(any(isinf(Xp),'all'))
    %     keyboard
    % end

    % What is the expected value from purchasing and not purchasing
    % information today? These objects should be defined over the *prior*
    % today, and they are defined over the capital stock today, so we have
    % to interpolate the mapping from k to cah, which depends importantly
    % on what z is today

   
    t1 = t1 + toc(t1start);

    X_diff=max(abs(Xp-X0),[],'all');
    % W_diff=max(abs(Wp-W0),[],'all');


    X0=Xp;
    
    max_diff=max(X_diff);
    if(params.display==0)
        if (max_diff < 1e-8)
    %         keyboard
            fprintf('value function converged after %d iterations \n',iter);
            break
        end
        if (iter==250)
            fprintf('value policy function did NOT converge after %d iterations \n',250);
        end
    
    end

end
% fprintf('time spent on finding value func: %f \n',t1)







% Now that we've computed the experience value function, let's compute the
% optimal information choice that we can then feed back into the EGM


Xp_no      = zeros(nk,nz,npz,ns*npk);
Xp_info    = zeros(nk,nz,npz,ns*npk);

for j=1:ns*npk
    for zc=1:nz
        Xp_info(:,zc,:,j)=repmat(interp1(Agrid,Xp(:,zc,1+(zc-1)*(npzp-1),j),cah_today(:,zc,j)-params.nu,interp_type,'extrap'),[1 1 npz]);
        for pzc=1:npz
            Xp_no(:,zc,pzc,j)     =   interp1(Agrid,Xp(:,zc,pzc+1,j),cah_today(:,zc,j),interp_type,'extrap');
        end
    end 
end

EXp_info = zprior_stack.*squeeze(Xp_info(:,nz,:,:))+(1-zprior_stack).*squeeze(Xp_info(:,1,:,:))-params.kappa;
EXp_no = zprior_stack.*squeeze(Xp_no(:,nz,:,:))+(1-zprior_stack).*squeeze(Xp_no(:,1,:,:));

info_buy = EXp_info-EXp_no;
i_less_no = info_buy<0;
no_less_i = ~i_less_no;

if params.scale_ev==0
    Vp(i_less_no)   =  euler/params.ev_shock + EXp_no(i_less_no) + ...
        1/params.ev_shock*log(1+exp(params.ev_shock*info_buy(i_less_no)));
    
    Vp(no_less_i)   =  euler/params.ev_shock + EXp_info(no_less_i) + ...
        1/params.ev_shock*log(1+exp(-params.ev_shock*info_buy(no_less_i)));

    ipol(i_less_no)= 1 - 1./(1+exp(params.ev_shock*info_buy(i_less_no)));
    ipol(no_less_i)= 1./(1+exp(-params.ev_shock*info_buy(no_less_i)));

else
    ctemp=zeros(nk,npz,ns*npk);
    for j=1:ns*npk
        for pzc=1:npz
            ctemp(:,pzc,j) = interp1(Agrid,cpol(:,1,pzc,j),cah_today(:,1,j),'pchip','extrap')*params.zinv(1)...
                +interp1(Agrid,cpol(:,1,pzc,j),cah_today(:,nz,j),'pchip','extrap')*params.zinv(2);
        end
    end
    % Ascale_stack = repmat((cah_today(:,1,:)*params.zinv(1)+cah_today(:,nz,:)*params.zinv(nz)).^(-2),[1 npz 1]);
    Ascale_stack = max(ctemp.^(-params.sigma),1e-2);
    Vp(i_less_no)   =  Ascale_stack(i_less_no).*euler/params.ev_shock + EXp_no(i_less_no) + ...
        Ascale_stack(i_less_no)./params.ev_shock.*log(1+exp(params.ev_shock*info_buy(i_less_no)./Ascale_stack(i_less_no)));

    Vp(no_less_i)   =  Ascale_stack(no_less_i).*euler/params.ev_shock + EXp_info(no_less_i) + ...
        Ascale_stack(no_less_i)./params.ev_shock.*log(1+exp(-params.ev_shock*info_buy(no_less_i)./Ascale_stack(no_less_i)));

    ipol(i_less_no)= 1 - 1./(1+exp(params.ev_shock*info_buy(i_less_no)./Ascale_stack(i_less_no)));
    ipol(no_less_i)= 1./(1+exp(-params.ev_shock*info_buy(no_less_i)./Ascale_stack(no_less_i)));


end


ipol = reshape(ipol,[nk npz ns*npk]);
Vp   = reshape(Vp,[nk npz ns*npk]);

