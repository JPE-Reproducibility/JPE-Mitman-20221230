function [dec,cpol,t1] = solve_EGM(c0,info_choice,params)


Agrid = params.Agrid;
tol = params.tol;
maxIter = params.maxIter;
delta = params.delta;
wtax  = params.wtax;
Kgrid = params.Kgrid;

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
probdeath=params.probdeath;
rebate = params.rebate;
nu = params.nu;
npz     = params.npz;
npzp    = params.npzp;
npk     = params.npk;
nsigK   = params.nsigK;
ns      = params.ns;
nz      = params.nz;
nA      = params.nA;
nk      = params.nk;
% Get the persistences of the good and bad states
rho_g = params.piz(2,2);
rho_b = params.piz(1,1);


% What we need to do is forecast what your posteriors are going to be
% tomorrow, given your posterior today

% Timing:
% We start in the consumption savings choice today, we have state variables
% m,y,pz,pk
% What we need to know, is which consumption policy functions we'll be
% using tomorrow in order to be able to implement the EGM
% pk' is independent of choices given pz and pk from the aggregate LOM
% y' is independent of choices given pz and depends on the markov process
% What do we need to forecast? y' and pk' 
% We've fixed a grid over k'. So the first thing that we need to do is
% recover y' from the choice k'. Given a choice k' and pk' then we have a
% forecast for what m' will be, where m' given from the prior tomorrow. So
% given a posterior pz today, my prior tomorrow is
% prior_z' = rho_g*pz+(1-pz)*(1-rho_b)
% Then, w/prob prior_z' m'=(1+r(z_g,pk')-delta)*k'+w(z_g,pk')*y
% and w/prob (1-prior_z') m'=(1+r(z_b,pk')-delta)*k'+w(z_b,pk')*y
% So how do we recover the posterior over z tomorrow, pz'
% If you acquire information, then pz'=1 w/prob pz, and pz'=0 w/prob (1-pz)
% If you don't acquire information then pz'=prior_z' (nothing changes)
% So, given your posterior today you can end up at 3 possible posteriors
% tomorrow, that's all that we need.



% Get the grid over the prior and posterior for z
zprior = params.zprior;
zpost = params.zpost;


% Contruct the transition matrix between posterior and prior
zpost_to_prior=zeros(npzp,npz);
% z_prior_to_prepost=zeros(npz,npzp);


% Set up the transition to cover the rolling from today's posterior to
% tomorrow's prior

for zc=1:npzp
    prior = rho_g*zpost(zc)+(1-rho_b)*(1-zpost(zc));
    [vals,inds] = basefun(zprior,npz,prior);
    zpost_to_prior(zc,inds(1))=vals(1);
    zpost_to_prior(zc,inds(2))=vals(2);
end

% For the EGM we'll need the mapping from tomorrow's prior to today's
% posterior, so we need essentially the inverse of the rolling
% for zc=1:npz
%     prepost = (zprior(zc)+rho_b-1)/(rho_g+rho_b-1);
%     [vals,inds] = basefun(zpost,npzp,prepost);
%     z_prior_to_prepost(zc,inds(1))=vals(1);
%     z_prior_to_prepost(zc,inds(2))=vals(2);
% end


% indz_prob = zeros(npz,nz*nz);
% for pzc=1:npz            
% %     indz_prob(pzc,zcc,zc)=            
% %     indz_prob(pzc,1,1)=(1-zprior(pzc))*rho_b;
% %     indz_prob(pzc,2,1)=(1-zprior(pzc))*(1-rho_b);
% %     indz_prob(pzc,1,2)=zprior(pzc)*(1-rho_g);
% %     indz_prob(pzc,2,2)=zprior(pzc)*rho_g;    
%     indz_prob(pzc,1)=(1-zprior(pzc))*rho_b;
%     indz_prob(pzc,2)=(1-zprior(pzc))*(1-rho_b);
%     indz_prob(pzc,3)=zprior(pzc)*(1-rho_g);
%     indz_prob(pzc,4)=zprior(pzc)*rho_g;    
% end

% Probability of (z,z') from subperiod 2, where you already are at your
% posterior. So the prob(z=z_g) = zpost. 
% Prob(z=z_g & z'=z_g)=zpost*rho_g+(1-zpost)*(1-rho_b)
% 1=rec,rec
% 2=rec,boom
% 3=boom,rec
% 4=boom,boom


% indz_prob = zeros(npzp,nz*nz);
% for pzc=1:npzp            
%     indz_prob(pzc,1)=(1-zpost(pzc));
%     indz_prob(pzc,2)=(1-zpost(pzc));
%     indz_prob(pzc,3)=zpost(pzc);
%     indz_prob(pzc,4)=zpost(pzc);    
% end

probzc = zeros(npzp,nz);
for pzc=1:npzp            
    probzc(pzc,1)=(1-zpost(pzc));
    probzc(pzc,2)=zpost(pzc);    
end

probkp = params.probkp;
ksigkprob = params.ksigkprob;

exotos=zeros(npk*ns*nsigK,1);
exotok=exotos;
exotosigK=exotok;

% pi_exo_b = zeros(npk*ns,npk*ns);
% pi_exo_g = zeros(npk*ns,npk*ns);

% pi_exo also should depend on my prior today. Why?
% pK′ = E[H(z,pK)|Ω ]
% H(z,pK) is params.pk_trans
% We don't know which z is true today, but we have our prior
% Thus E[H(z,pK)|Ω ] = pz*H(z_g,pK)+(1-pz)*H(z_b,pK)
% Now we are also introducing uncertainty about K, we are being simple and
% assuming that K is roughly a random variable


pi_exo      = zeros(npk*ns*nsigK,npk*ns*nsigK,npzp,nz*nz);
% pi_exo_full = zeros(npk*ns,npk*ns,nz*nz);
% exotos_full=zeros(npk*ns,1);
% exotok_full=exotos;
% sksigtoexo = zeros(ns,npk,nsigK);


% for zc=1:nz
%     for zcc=1:nz
%         for pzc=1:npzp
%             indz=zcc+(zc-1)*nz;
%             j=0;
%             for sigKc=1:nsigK
%                 for pkc=1:npk
%                     for sc=1:ns
%                         j=j+1;
%                         exotos(j)=sc;
%                         exotok(j)=pkc;
%                         exotosigK(j)=sigKc;
%                         % sksigtoexo(sc,pkc,sigKc) = j;
%                         for sigKcp=1:nsigK
%                             for pkcp=1:npk
%                                 pi_exo(j,1+ns*(pkcp-1+npk*(sigKcp-1)):ns*(pkcp+npk*(sigKcp-1)),pzc,indz)=...
%                                     params.piagg{indz}(sc,:)*(ksigkprob(pkc+npk*(sigKc-1+nsigK*(pzc-1)),pkcp+npk*(sigKcp-1)));
%                             end
%                         end
%                     end
%                 end
%             end
%         end
%     end
% end

for zc = 1:nz
    for zcc = 1:nz
        indz = zcc + (zc-1)*nz;
        j = 0;
        for sigKc = 1:nsigK
            for pkc = 1:npk
                for sc = 1:ns
                    j = j + 1;
                    exotos(j)   = sc;
                    exotok(j)   = pkc;
                    exotosigK(j) = sigKc;
                    for pzc=1:npzp
                        for scp=1:ns
                            for sigKcp = 1:nsigK
                                for pkcp = 1:npk
                                      % column block must include sigKcp
                                      col0 = scp + ns*((pkcp-1) + npk*(sigKcp-1));
                                      kc_row = pkc  + npk*(sigKc-1);
                                      kp_col = pkcp + npk*(sigKcp-1);
                        
                                      pi_exo(j,col0,pzc,indz)=...
                                        params.piagg{indz}(sc,scp)*(ksigkprob(kc_row, kp_col,pzc));
    
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

for indz = 1:nz*nz
    for j = 1:ns*npk*nsigK
        for pzc=1:npzp
            % s = sum(pi_exo(j,:,pzc,indz));
            % assert(abs(s-1) < 1e-12, 'Row does not sum to 1');
            assert(all(pi_exo(j,:,pzc,indz) >= -1e-14), 'Negative probability');
        end
    end
end


exotok_nosigK = zeros(ns*npk,1);
exotos_nosigK = zeros(ns*npk,1);
kstoexo       = zeros(ns,npk);
j=0;
for pkc=1:npk
    for sc=1:ns
        j=j+1;
        exotos_nosigK(j)=sc;
        exotok_nosigK(j)=pkc;
        kstoexo(sc,pkc)=j;
    end
end

% Preinitilize cah' tomorrow as a function of prior of z and prior of k
% cahp = zeros(nA,nz*nz,npk*ns);
% r_exp = zeros(nA,nz,npk*ns);

% Add the fact that the capital forecast for tomorrow can be two values,
% because from the LOM k' depends on k and z, and we don't know z. 

% for j=1:ns*npk
%     for zc=1:nz
%         for zcc = 1:nz
%             indz=zcc+(zc-1)*nz;
% 
%             cahp(:,indz,j)    = sav_grid*(1+r_mat(zcc,j)-delta) + ix(exotos(j))*w_mat(zcc,j);
% 
%         end
%     end
% end


% Preinitilize cah' tomorrow as a function of prior of z and prior of k
cahp = zeros(nk,nz,npk*ns);


%   Now going to try to write this as a function only of zcc, we don't think that we actually need indz (or do we?)

% Do we need this as a function of zcc and kp? Or we kind of already know
% what the potential values of kp can be (since we're looping over npk, so
% what we really need to work on is the mapping between cahp(:,zcc,j) and
% what the policy function state variables will be in the subsequent
% period?

for j=1:ns*npk
    for zcc = 1:nz
        cahp(:,zcc,j)    = rebate*Kgrid(exotok_nosigK(j))*wtax+sav_grid*(1+r_mat(zcc,j)-delta-wtax)/(1-probdeath) ...
                            + ix(exotos_nosigK(j))*w_mat(zcc,j) * ( iu(exotos_nosigK(j))*(1-taxu_mat(zcc,j)) + (1-iu(exotos_nosigK(j)))*(1-taxe_mat(zcc,j)) );
    end
end


cahp = (cahp<=Agrid(nA)).*cahp+Agrid(nA)*(cahp>Agrid(nA));

% infop = zeros(nA,npz,npk*ns,nz*nz);

% Need to interpolate the info choice
% need to know infop(m,pzc,j). but infop is really a function of
% m',pzc*post_to_prior,j', in order to have it as a function of m, I need
% to know mapping from m to m', which needs to know zp

% Now that we've defined information choice as a function of capital
% instead of cash at hand, we no longer need to interpolate the ipol
% function

% infop = zeros(nk,npz,npk*ns,nz);
% 
% for zcc=1:nz
%     for pzc=1:npz
%         for j=1:ns*npk
%             infop(:,pzc,j,zcc) = interp1(params.Agrid,info_choice(:,pzc,j),cahp(:,zcc,j),'pchip');
% 
%         end
%     end
% end



for m=1:maxIter
    t1start = tic;
    cp = zeros(nk,npzp,ns*npk*nsigK,nz*npk);
    c_new = zeros(nA,npzp,ns*npk*nsigK);
    cp_info = zeros(nk,ns*npk*nsigK,nz*npk);
    


% Note that cp is defined over cash-at-hand, posterior for z, posteriod for
% k and the individual productivity/employment state. 
% To figure out cp we interpolate the guess for the consumption policy
% function over cah tomorrow, taking into accound the fact that cah is a
% function of pk, zcc and the individual state. I guess right now we aren't
% fully internalizing the uncertainty over capital tomorrow?
    
        % indz=zcc+(zc-1)*nz;

    % tstart2=tic;
    if nsigK > 1
        for j=1:ns*npk*nsigK
            for zcc=1:nz
                for kp = 1:npk
    
                    % The idea, tomorrow my prior over k will be given by the
                    % state j, but I take into account that because there's
                    % uncertainty over the aggregate capital stock, then I may
                    % end up at potentially different cash at hands because of
                    % that
                  
                    sc      = exotos(j);
                    jp      = kstoexo(sc,kp);
                % For now doing this with pchip, can think if we can speed up a lot by
                % doing things linearly with the c code
                    for pzc=1:npzp
        
        
                        cp(:,pzc,j,(zcc-1)*npk+kp)  = interp1(Agrid,c0(:,pzc,j),cahp(:,zcc,jp),'pchip','extrap');
        
                    end     
        
                    cp_info(:,j,(zcc-1)*npk+kp)     = interp1(Agrid,c0(:,1+(zcc-1)*(npzp-1),j),cahp(:,zcc,jp)-nu,'pchip','extrap');    
        
                end
            end
        end
    else
        for j=1:ns*npk
            for zcc=1:nz
    
            % For now doing this with pchip, can think if we can speed up a lot by
            % doing things linearly with the c code
                for pzc=1:npzp
    
    
                    cp(:,pzc,j,zcc)  = interp1(Agrid,c0(:,pzc,j),cahp(:,zcc,j),'linear','extrap');
    
                end     
    
                cp_info(:,j,zcc)     = interp1(Agrid,c0(:,1+(zcc-1)*(npzp-1),j),cahp(:,zcc,j)-nu,'linear','extrap');
    
    
            end
        end

    end

    % toc(tstart2)

        
        %     cp defined over m',pz',y',pk'
    mup_info    = cp_info.^(-params.sigma);
    mup_no      = cp.^(-params.sigma);
    
    

    % Note that mup is defined right now over *tomorrows* posterior, so
    % what we need to do is we need a mapping from todays posterior to
    % tomorrows posterior. zpost->zprior' mechanically from the
    % persistence, since there are no decisions. Then, from zprior' ->
    % zpost', zpost'=zprior' if you don't buy info, otherwise you know for
    % sure what z is tomorrow

    % Grids are constructed such that today's posterior 1 to npz maps to
    % the posterior tomorrow of 2 to npzp-1 if you don't buy info. If you
    % do buy info, the posterior is either 1 or npzp depending on zcc.
    if nsigK>1
        % Marginal utility tomorrow as a function of *todays* posterior.
        Emupzz = zeros(nk,npzp,ns*npk*nsigK,nz*npk);

        for j=1:ns*npk*nsigK
            for zcc=1:nz
                for kp = 1:npk
                    sc      = exotos(j);
                    jp      = kstoexo(sc,kp);
    
                    Emupzz(:,:,j,(zcc-1)*npk+kp) = ((1+r_mat(zcc,jp)-delta-wtax)/(1-probdeath)...
                        *(((1-info_choice(:,:,j)).*mup_no(:,2:npzp-1,j,(zcc-1)*npk+kp))...    %dont buy func of tom prior
                        +info_choice(:,:,j).*repmat(mup_info(:,j,(zcc-1)*npk+kp),[1 npz])))... %buy func of tom prior
                        *zpost_to_prior'; %now put in terms of today's posterior
                
                end                            
            end
        end

    else
        % Marginal utility tomorrow as a function of *todays* posterior.
        Emupzz = zeros(nk,npzp,ns*npk*nsigK,nz);

        for j=1:ns*npk
            for zcc=1:nz
        
                Emupzz(:,:,j,zcc) = ((1+r_mat(zcc,j)-delta-wtax)/(1-probdeath)...
                    *(((1-info_choice(:,:,j)).*mup_no(:,2:npzp-1,j,zcc))...    %dont buy func of tom prior
                    +info_choice(:,:,j).*repmat(mup_info(:,j,zcc),[1 npz])))... %buy func of tom prior
                    *zpost_to_prior'; %now put in terms of today's posterior
                
                                
            end
        end
    end
    % end
    Emup        = zeros(nk,npzp,ns*npk*nsigK);

    % tstart3=tic;
    if nsigK>1
        parfor j=1:ns*npk*nsigK
            sigKc   = exotosigK(j);
            kc      = exotok(j);    
            for zc=1:nz
                for zcc=1:nz
                    indz=zcc+(zc-1)*nz;
                    for kp=1:npk
                        for pzc=1:npzp    
                            Emup(:,pzc,j) = Emup(:,pzc,j)+probzc(pzc,zc)*probkp(kp,kc+npk*(sigKc-1+nsigK*(pzc-1)))*squeeze(Emupzz(:,pzc,:,(zcc-1)*npk+kp))*(squeeze(pi_exo(j,:,pzc,indz))');
                        end
                    end
                end
            end
        end
    else
        parfor j=1:ns*npk
            for zc=1:nz
                for zcc=1:nz
                    indz=zcc+(zc-1)*nz;
                    for pzc=1:npzp    
                        Emup(:,pzc,j) = Emup(:,pzc,j)+probzc(pzc,zc)*squeeze(Emupzz(:,pzc,:,zcc))*(squeeze(pi_exo(j,:,pzc,indz))');
                    end
                end
            end
        end
    end
    % There all have nk for the size of the first dimension
    Emup = beta*(1-probdeath)*Emup;
    

    c_s = Emup.^(-1/params.sigma);


%     keyboard
    cah_today = c_s+sav_grid;

    % tstart4=tic;

    % Now interpolate back onto the cah grid, with dimension nA
    for j=1:ns*npk*nsigK
        for zc=1:npzp
                        if sum(cah_today(:,zc,j)<0)>0
                            disp('negative cah_today')
                keyboard
                        end
                                        if sum(isnan(cah_today(:,zc,j)))>0
                            disp('nan cah_today')
                keyboard
                                        end
                       if sum(~isreal(cah_today(:,zc,j)))>0
                            disp('complex cah_today')
                keyboard
            end
            c_new(:,zc,j) = (Agrid>cah_today(1,zc,j)).*interp1([bmin; cah_today(:,zc,j)],[0; c_s(:,zc,j)],Agrid,'linear','extrap')...
                ...%+(Agrid<=cah_today(1,zc,j)).*interp1([bmin; cah_today(:,zc,j)],[0; c_s(:,zc,j)],Agrid,'pchip','extrap');
                +(Agrid<=cah_today(1,zc,j)).*(Agrid-bmin);
            % if sum(isnan(c_new(:,zc,j)))>0
            %     keyboard
            % end
        end
    end
    % toc(tstart4)


    t1 = t1 + toc(t1start);
    maxDiff_info = max(max(max(abs(c_new-c0))));

    maxDiff=maxDiff_info;
    if(maxDiff < 1e-4)
        updateval = 0.75;
    else
        updateval = 1;
    end
    if(params.display==0)
        if (maxDiff < tol)
    %         keyboard
            fprintf('consumption policy function converged after %d iterations \n',m);
            break
        end
        if (m==maxIter)
            fprintf('consumption policy function did NOT converge after %d iterations \n',maxIter);
        end
    end
    c0      = c_new*updateval+(1-updateval)*c0;


end

dec  = Agrid-c0;
cpol = c0;

if(params.display==0)
    fprintf('time spent on finding cons pol: %f \n',t1)
end
end