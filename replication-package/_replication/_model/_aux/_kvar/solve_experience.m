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
nsigK   = params.nsigK;

% Get the persistences of the good and bad states
rho_g = params.piz(2,2);
rho_b = params.piz(1,1);

zprior = params.zprior;
zpost = params.zpost;

zprior_stack = repmat(reshape(zprior,[1 1 5]),[nk npk 1 ns*npk*nsigK]);


% Contruct the transition matrix between posterior and prior
zpost_to_prior=zeros(npzp,npz);
z_prior_to_prepost=zeros(npz,npzp);
vals_post_prior=zeros(npzp,2);
inds_post_prior=zeros(npzp,2);

z_prior_to_post=zeros(npz,npzp);

% probkp_today = params.probkp_today;
wKp_grid = params.wKp_grid;

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

pi_exo_full_sliced = zeros(nz*nz,npk*ns,npk*ns);

exotos_full=zeros(npk*ns*nsigK,1);
exotok_full=exotos;
exotosig_full=exotos;

% for zc = 1:nz
%     for zcc = 1:nz
%         indz = zcc + (zc-1)*nz;
%         j = 0;
%         for sigKc = 1:nsigK
%             for pkc = 1:npk
%                 for sc = 1:ns
%                     j = j + 1;
%                     exotos_full(j)   = sc;
%                     exotok_full(j)   = pkc;
%                     exotosig_full(j) = sigKc;
%                     for pzc=1:npzp
%                         for sigKcp = 1:nsigK
%                             for pkcp = 1:npk
%                                   % column block must include sigKcp
%                                   col0 = 1 + ns*((pkcp-1) + npk*(sigKcp-1));
%                                   kc_row = pkc  + npk*(sigKc-1);
%                                   kp_col = pkcp + npk*(sigKcp-1);
% 
%                                   % if the (K, σK) law depends on z (recommended), use a per-z kernel (see B)
%                                   pi_exo_full_sliced(indz, col0:(col0+ns-1),pzc, j) = ...
%                                       params.piagg{indz}(sc,:) * params.ksigkprob(kc_row, kp_col,pzc);
%                             end
%                         end
%                     end
%                 end
%             end
%         end
%     end
% end
j=0;
for sigKc = 1:nsigK
    for pkc = 1:npk
        for sc = 1:ns
            j = j + 1;
            exotos_full(j)   = sc;
            exotok_full(j)   = pkc;
            exotosig_full(j) = sigKc;
        end
    end
end

exotok_nosigK = zeros(ns*npk,1);
exotos_nosigK = zeros(ns*npk,1);
kstoexo       = zeros(ns,npk);

for zc=1:nz
    for zcc=1:nz
        indz=zcc+(zc-1)*nz;
        j=0;
        for pkc=1:npk
            for sc=1:ns
                j=j+1;
                exotos_nosigK(j)=sc;
                exotok_nosigK(j)=pkc;
                kstoexo(sc,pkc)=j;                
                for pkcp=1:npk
                    % pi_exo_full(j,1+(pkcp-1)*ns:pkcp*ns,indz)=...
                    %     params.piagg{indz}(sc,:)*(...
                    %     params.pk_trans(pkc,pkcp,zc));
                    pi_exo_full_sliced(indz,1+(pkcp-1)*ns:pkcp*ns,j)=...
                        params.piagg{indz}(sc,:)*(...
                        params.pk_trans(pkc,pkcp,zc));
                    
                end
            end
        end
    end
end

% for indz = 1:nz*nz
%     for j = 1:ns*npk*nsigK
%             % s = sum(pi_exo_full_sliced(indz,:,pzc,j));
%             % assert(abs(s-1) < 1e-12, 'Row does not sum to 1');
%             assert(all(pi_exo_full_sliced(indz,:,j) >= -1e-14), 'Negative probability');
%         end
%     end
% end


% These are for the cah calculations, which only depend on s,K, and z, they
% don't directly depend on your uncertainty about the capital stock. so
% doing this to reduce the dimensionality


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


cpol        = repmat(reshape(cpol_in,[nA 1 1 npzp npk*ns*nsigK]),[1 nz npk 1 1]);
info_choice = info_choice_in; %repmat(reshape(info_choice_in,[nk 1 npz npk*ns]),[1 nz 1 1]);

% This is the Chi from the document, defined over CAH, z, posterior, and
% exo stuff
if(size(X0_in,2)~=nz)
    X0_in          = repmat(reshape(X0_in,[nA 1 npzp nsigK*npk*ns]),[1 nz 1 1]);
end
if(size(X0_in,3)~=npk)
    X0_in         = repmat(reshape(X0_in,[nA nz 1 npzp nsigK*npk*ns]),[1 1 npk 1 1]);
end
X0             = X0_in;

% Preinitilize cah' tomorrow as a function of prior of z and prior of k
% cahp = zeros(nA,nz,npk*ns,npzp,npk*ns);


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

for j=1:ns*npk
    for zcc = 1:nz
        cah_today(:,zcc,j)        = rebate*Kgrid(exotok_nosigK(j))*wtax+sav_grid*(1+r_mat(zcc,j)-delta-wtax)/(1-probdeath) ...
                                + ix(exotos_nosigK(j))*w_mat(zcc,j) * ( iu(exotos_nosigK(j))*(1-taxu_mat(zcc,j)) + (1-iu(exotos_nosigK(j)))*(1-taxe_mat(zcc,j)) );
    end
end


iter=0;
max_diff=1;


% Ok, we now have the initial guess for X:

% X0 as a function of cah, z, Kpost, eps, Zpost
% The tricky thing is figuring out when we have priors and when we have
% posteriors to get things right

    t1start = tic;

while(iter<30 && max_diff>1e-8)


    % To calculate the X recursion from the note, we need:
    % X = u(c) + beta*E[X']
    % Note X is defined over today's posteriors
    % What we need is to express E[X'] also as function of today's
    % posteriors, even though X' itself is defined over *tomorrow's*
    % posteriors.


    % Note here that kpol is defined over today's posterior, but X0 is
    % defined over tomorrow's prior. So we need to roll

    % Wpost has to depend on your beliefs, as well as the true k and z
    Wpost=zeros(nk,nz,npk,npzp,ns*npk*nsigK);
    % Let's compute W from the document
    iter=iter+1;
    % tstart2=tic;

    % Value function today given state j and cah determined by j_cah
    for jp  = 1:ns*npk*nsigK
        sp      = exotos_full(jp);
        for ktrue = 1:npk 
            j_cah   = kstoexo(sp,ktrue);
            for pzc=2:npzp-1
                    for zcc = 1:nz
                        Wpost(:,zcc,ktrue,pzc,jp) = interp1(Agrid,X0(:,zcc,pzc,jp),cah_today(:,zcc,j_cah),interp_type,'extrap');
                    end
            end
            for zcc = 1:nz
                Wpost(:,zcc,ktrue,1,jp) = interp1(Agrid,X0(:,zcc,1,jp),cah_today(:,zcc,j_cah)-nu,interp_type,'extrap');
                Wpost(:,zcc,ktrue,npzp,jp) = interp1(Agrid,X0(:,zcc,npzp,jp),cah_today(:,zcc,j_cah)-nu,interp_type,'extrap');
            end
        end
    end
    % toc(tstart2);


    % Now we need to get this in terms of the t variables
    % Evalute W at kpol, which means we need a mapping from yesterday's posterior to 
    % today's things

    Wpre=zeros(nk,nz,npk,npz,ns*npk*nsigK);

    % If you don't buy info choice, today's posterios = today's prior
    % info_choice defined nk,prior,exo stuff 
    % tstart4=tic;
    parfor j_today=1:ns*npk*nsigK
    % for jp=1:ns*npk
        for ktrue = 1:npk
            for zcc = 1:nz
                for pzc=1:npz
                    Wpre(:,zcc,ktrue, pzc,j_today) = info_choice(:,pzc,j_today).*(Wpost(:,zcc,ktrue,1+(npzp-1).*(zcc==2),j_today)-kappa)...
                        +(1-info_choice(:,pzc,j_today)).*Wpost(:,zcc,ktrue,pzc+1,j_today);
                end
            end
        end
    end
    % if(any(isnan(Wpre),'all'))
    %     keyboard
    % end
    % if(any(isinf(Wpre),'all'))
    %     keyboard
    % end
    % toc(tstart4);

    Wpostpre=zeros(nk,nz,npk,npzp,ns*npk*nsigK);
  
    % Interpolate Wpre in terms of yesterday's posterior
    for pzc=1:npzp
        Wpostpre(:,:,:,pzc,:)=Wpre(:,:,:,inds_post_prior(pzc,1),:)*vals_post_prior(pzc,1)...
            +Wpre(:,:,:,inds_post_prior(pzc,2),:)*vals_post_prior(pzc,2);
    end
    % if(any(isnan(Wpostpre),'all'))
    %     keyboard
    % end
    % if(any(isinf(Wpostpre),'all'))
    %     keyboard
    % end

    EXp=zeros(nA,nz,npk,npzp,ns*npk*nsigK);

    % Now we have Wpre in terms of k',z',prior',exo stuff'
    % Now, we want EW in terms of m,posterior,exo stuff
    % tstart5=tic;
    % parfor j=1:ns*npk*nsigK
    %     s     = exotos_full(j);
    %     for ktrue = 1:npk
    %         j_pi  = kstoexo(s,ktrue);
    %         for zc=1:nz
    %             for pzc=1:npzp
    %                 for jp=1:ns*npk*nsigK
    %                     for ktruep = 1:npk
    %                         sp      = exotos_full(jp);
    %                         jp_pi   = kstoexo(sp,ktruep);
    %                         for zcc=1:nz
    %                             indz=zcc+(zc-1)*nz;
    %                             EXp(:,zc,ktrue,pzc,j)=EXp(:,zc,ktrue,pzc,j)...
    %                                 +interp1(sav_grid,Wpostpre(:,zcc,ktruep,pzc,jp),kpol(:,pzc,j),interp_type,'extrap')...
    %                                 *pi_exo_full_sliced(indz,jp_pi,j_pi);
    %                         end
    %                     end
    %                 end
    %             end
    %         end
    %     end
    % end


    % toc(tstart5);
    % tstart6=tic;



    % parfor j=1:ns*npk*nsigK
    %     sc      = exotos_full(j);
    %     sigKc   = exotosig_full(j); 
    %     kc      = exotok_full(j);
    %     kc_row  = kc  + npk*(sigKc-1);
    %     for pzc=1:npzp
    %         for jp=1:ns*npk*nsigK
    %             scp      = exotos_full(jp);
    %             sigKcp   = exotosig_full(jp);
    %             kcp      = exotok_full(jp);
    %             kp_col   = kcp + npk*(sigKcp-1);
    %             ksigval=params.ksigkprob(kc_row, kp_col,pzc);
    %             for ktruep = 1:npk
    %                 jp_pi   = kstoexo(scp,ktruep);
    %                 for zcc=1:nz
    %                     Wval = interp1(sav_grid,Wpostpre(:,zcc,ktruep,pzc,jp),kpol(:,pzc,j),interp_type,'extrap')*ksigval;
    %                     for ktrue = 1:npk
    %                         j_pi  = kstoexo(sc,ktrue);
    %                         for zc=1:nz
    %                             indz=zcc+(zc-1)*nz;
    %                             EXp(:,zc,ktrue,pzc,j)=EXp(:,zc,ktrue,pzc,j)...
    %                                 +Wval*pi_exo_full_sliced(indz,jp_pi,j_pi);
    %                         end
    %                     end
    %                 end
    %             end
    %         end
    %     end
    % end



    J = ns*npk*nsigK;                  % # of (s,k_bel,sigK) states
    s_of   = exotos_full(:);           % length J
    j_pi_map  = zeros(J,npk); % j  × ktrue  -> j_pi
    for j=1:J
        sj = s_of(j);
        for ktrue=1:npk,  j_pi_map(j,ktrue)  = kstoexo(sj, ktrue);  end
    end


    % linear interp on sav_grid for all (pzc,j)
    % iL = zeros(nA,npzp,J); iU = iL; wU = zeros(nA,npzp,J);
    % for j=1:J
    %   for pzc=1:npzp
    %     xq = kpol(:,pzc,j);           % query points
    %     % find bins on sav_grid (assumes sav_grid increasing)
    %     iu = discretize(xq, [-inf; 0.5*(sav_grid(1:end-1)+sav_grid(2:end)); +inf]);
    %     il = max(iu-1,1); iu = min(iu, numel(sav_grid));
    %     wl = (sav_grid(iu) - xq) ./ max(sav_grid(iu) - sav_grid(il), eps);
    %     iL(:,pzc,j) = il;
    %     iU(:,pzc,j) = iu;
    %     wU(:,pzc,j) = 1 - wl;         % weight on upper index
    %   end
    % end

       % linear interp on sav_grid for all (pzc,j)
    iL = zeros(nA,npzp,J); iU = iL; wU = zeros(nA,npzp,J);
    for j=1:J
        for pzc=1:npzp

            % Precompute once per (pzc, j):
            x  = sav_grid(:);                 % strictly increasing, length = nk
            nX = numel(x);
            
            % Segment edges at sample points (not midpoints):
            edges = [-inf; x(2:end-1); inf];  % creates nX-1 bins
            
            xq = kpol(:, pzc, j);             % length nk (or whatever)
        
            % Bin -> lower segment index il in 1..nX-1 (always valid; no NaNs)
            il = discretize(xq, edges);       % double, integral values
            iu = il + 1;
            
            % Linear weights (NO clamping; allow extrapolation on [1,2] and [nX-1,nX])
            dx = x(iu) - x(il);               % > 0 if x strictly increasing
            wu = (xq - x(il)) ./ dx;          % upper weight
            wl = 1 - wU;                      % lower weight
        
            % Optional: exact snaps at the knots to match interp1 bit-for-bit:
            maskL = abs(xq - x(il)) < 1e-15;  wu(maskL) = 0;  % at lower node
            maskU = abs(xq - x(iu)) < 1e-15;  wu(maskU) = 1;  % at upper node
            wl = 1 - wu;
        
            iL(:,pzc,j) = il;
            iU(:,pzc,j) = iu;
            wU(:,pzc,j) = 1 - wl;         % weight on upper index

        end
    end



    R = ns*npk;               % # of (s',k') states
    rows = (1:(J*npk)).';     % each pair (jp,ktruep)
    cols = reshape(j_pi_map.', [], 1);    % length J*npk, values in 1..R
    S = sparse(rows, cols, 1, J*npk, R);   % gathers by jp_pi

    kp_col_of_jp = exotok_full(:) + npk*(exotosig_full(:)-1);   % length J, 1..(npk*nsigK)

% v3

    J   = ns*npk*nsigK;           % 108
    % R   = ns*npk;                 % 36
    NT  = J*npzp;                 % 756  (number of parfor tasks)
    EXp_flat = zeros(nA, nz, npk, NT, 'like', Wpostpre);   % sliced in dim 4

    parfor tj = 1:NT
        % --- recover (j, pzc) from tj ---
        j   = ceil(tj/npzp);
        pzc = tj - (j-1)*npzp;    % 1..npzp

        % --- local accumulator for this (j,pzc) ---
        EXloc = zeros(nA, nz, npk, 'like', Wpostpre);

        % --- precomputed things for this (j,pzc) ---
        sigKc  = exotosig_full(j);
        kc     = exotok_full(j);
        kc_row = kc + npk*(sigKc-1);
        j_cols = j_pi_map(j,:);         % 1×npk

        il = iL(:,pzc,j);  iu = iU(:,pzc,j);  wu = wU(:,pzc,j);  wl = 1 - wu;

        % weights over jp blocks (size 1×J), expand to columns (1×(J*npk))
        kprob     = params.ksigkprob(kc_row, kp_col_of_jp, pzc);
        col_scale = kron(kprob, ones(1,npk));

        % --- loop over z' ---
        for zcc = 1:nz
            % 1) build Wmat: nA × (J*npk), with ksigkprob scaling per jp-block
            Wmat = zeros(nA, J*npk, 'like', Wpostpre);
            c0 = 0;
            for jp = 1:J
                for ktruep = 1:npk
                    c0 = c0 + 1;
                    col = Wpostpre(:, zcc, ktruep, pzc, jp);              % nA×1
                    Wmat(:,c0) = (wl .* col(il) + wu .* col(iu)) * col_scale(c0);
                end
            end

            % 2) aggregate by (s',k'): nA × R
            G = Wmat * S;    % S: (J*npk)×R sparse gather (built once outside)

            % 3) push through π for each z (objective, no pzc)
            for zc = 1:nz
                indz   = zcc + (zc-1)*nz;
                Pcols  = squeeze(pi_exo_full_sliced(indz, :, j_cols));   % R×npk
                add    = G * Pcols;                              % nA×npk
                EXloc(:,zc,:) = EXloc(:,zc,:) + reshape(add,[nA,1,npk]);
            end
        end

        % --- single sliced write for this iteration ---
        EXp_flat(:,:,:,tj) = EXloc;
    end

    % reshape back to (nA × nz × npk × npzp × J)
    EXp = reshape(EXp_flat, [nA, nz, npk, npzp, J]);







% % Pick a few indices
% j   = 7;                      % any 1..J
% pzc = 3;                      % 1..npzp
% zcc = 2;                      % 1..nz
% 
% % ----- (A) Wval stage: our precomputed-weight interp vs interp1 -----
% % Build one column Wval for some (jp,ktruep); repeat for several pairs
% jp = 11; ktruep = 5;
% 
% xq = kpol(:,pzc,j);
% col = Wpostpre(:, zcc, ktruep, pzc, jp);
% 
% % interp1 reference
% W_ref = interp1(sav_grid, col, xq, 'linear', 'extrap');
% 
% % our weight-based version (exactly as in your vectorized path)
% il = double(iL(:,pzc,j)); iu = double(iU(:,pzc,j)); wu = wU(:,pzc,j); wl = 1 - wu;
% W_new = wl .* col(il) + wu .* col(iu);
% 
% fprintf('max|W_new - W_ref| = %.3g\n', max(abs(W_new - W_ref)));
% 
% % If this is > 1e-12 consistently, the bin/weight logic is the source.
% % (Edge cases: xq near endpoints or exact midpoints)







    % parfor j=1:ns*npk*nsigK
    %     sc      = exotos_full(j);
    %     sigKc   = exotosig_full(j); 
    %     kc      = exotok_full(j);
    %     kc_row  = kc  + npk*(sigKc-1);
    %     for pzc=1:npzp
    %         for jp=1:ns*npk*nsigK
    %             scp      = exotos_full(jp);
    %             sigKcp   = exotosig_full(jp);
    %             kcp      = exotok_full(jp);
    %             kp_col   = kcp + npk*(sigKcp-1);
    %             for ktruep = 1:npk
    %                 jp_pi   = kstoexo(scp,ktruep);
    %                 for zcc=1:nz
    %                     il = iL(:,pzc,j); iu = iU(:,pzc,j); wu = wU(:,pzc,j); wl = 1 - wu;
    %                     col = Wpostpre(:,zcc,ktruep,pzc,jp);
    %                     Wval = wl .* col(il) + wu .* col(iu);  % no interp1 call
    %                     for ktrue = 1:npk
    %                         j_pi  = kstoexo(sc,ktrue);
    %                         for zc=1:nz
    %                             indz=zcc+(zc-1)*nz;
    %                             EXp(:,zc,ktrue,pzc,j)=EXp(:,zc,ktrue,pzc,j)...
    %                                 +Wval*pi_exo_full_sliced(indz,jp_pi,j_pi)...
    %                                 *params.ksigkprob(kc_row, kp_col,pzc);
    %                         end
    %                     end
    %                 end
    %             end
    %         end
    %     end
    % end


    % toc(tstart6);
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

   
    % t1 = t1 + toc(t1start);

    X_diff=max(abs(Xp-X0),[],'all');
    % W_diff=max(abs(Wp-W0),[],'all');
    % fprintf('%f\n',X_diff)

    X0=Xp;
    
    max_diff=max(X_diff);
    if(params.display==0)
        if (max_diff < 1e-8)
    %         keyboard
            fprintf('value function converged after %d iterations \n',iter);
            break
        end
        if (iter==30)
            fprintf('value policy function did NOT converge after %d iterations \n',30);
        end
    
    end

end
% fprintf('time spent on finding value func: %f \n',t1)







% Now that we've computed the experience value function, let's compute the
% optimal information choice that we can then feed back into the EGM


Xp_no      = zeros(nk,nz,npk,npz,ns*npk*nsigK);
Xp_info    = zeros(nk,nz,npk,npz,ns*npk*nsigK);
% tic
parfor j=1:ns*npk*nsigK
    sc = exotos_full(j);
    for ktrue = 1:npk
        j_cah = kstoexo(sc,ktrue);
        for zc=1:nz
            cIdx_info = 1+(zc-1)*(npzp-1);
            Xp_info(:,zc,ktrue,:,j)=repmat(interp1(Agrid,Xp(:,zc,ktrue,cIdx_info,j),cah_today(:,zc,j_cah)-params.nu,interp_type,'extrap'),[1 1 npz]);
            for pzc=1:npz
                Xp_no(:,zc,ktrue,pzc,j)     =   interp1(Agrid,Xp(:,zc,ktrue,pzc+1,j),cah_today(:,zc,j_cah),interp_type,'extrap');
            end
        end 
    end
end
% toc
    

EzXp_info = zprior_stack.*squeeze(Xp_info(:,nz,:,:,:))+(1-zprior_stack).*squeeze(Xp_info(:,1,:,:,:))-params.kappa;
EzXp_no = zprior_stack.*squeeze(Xp_no(:,nz,:,:,:))+(1-zprior_stack).*squeeze(Xp_no(:,1,:,:,:));

EXp_info = zeros(nk,npz,ns*npk*nsigK);
EXp_no   = zeros(nk,npz,ns*npk*nsigK);

for j=1:ns*npk*nsigK
    sigKc = exotosig_full(j);
    kc    = exotosig_full(j);
    wKp = wKp_grid(:,kc,sigKc);
    for ktrue=1:npk
        EXp_info(:,:,j) = EXp_info(:,:,j)+wKp(ktrue)*squeeze(EzXp_info(:,ktrue,:,j));
        EXp_no(:,:,j) = EXp_no(:,:,j)+wKp(ktrue)*squeeze(EzXp_no(:,ktrue,:,j));

    end
end


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
    ctemp=zeros(nk,npz,ns*npk*nsigK);
    for j=1:ns*npk*nsigK
        sc=exotos_full(j);
        kc=exotok_full(j);
        j_cah   = kstoexo(sc,kc);  
        for pzc=1:npz
            ctemp(:,pzc,j) = interp1(Agrid,cpol(:,1,pzc,j),cah_today(:,1,j_cah),'pchip','extrap')*params.zinv(1)...
                +interp1(Agrid,cpol(:,1,pzc,j),cah_today(:,nz,j_cah),'pchip','extrap')*params.zinv(2);
        end
    end
    % Ascale_stack = repmat((cah_today(:,1,:)*params.zinv(1)+cah_today(:,nz,:)*params.zinv(nz)).^(-2),[1 npz 1]);
    Ascale_stack = max(ctemp.^(-params.sigma),1e-2);
    % Ascale_stack = repmat((cah_today(:,1,:)*params.zinv(1)+cah_today(:,nz,:)*params.zinv(nz)).^(-1),[1 npz 1]);
    Vp(i_less_no)   =  Ascale_stack(i_less_no).*euler/params.ev_shock + EXp_no(i_less_no) + ...
        Ascale_stack(i_less_no)./params.ev_shock.*log(1+exp(params.ev_shock*info_buy(i_less_no)./Ascale_stack(i_less_no)));

    Vp(no_less_i)   =  Ascale_stack(no_less_i).*euler/params.ev_shock + EXp_info(no_less_i) + ...
        Ascale_stack(no_less_i)./params.ev_shock.*log(1+exp(-params.ev_shock*info_buy(no_less_i)./Ascale_stack(no_less_i)));

    ipol(i_less_no)= 1 - 1./(1+exp(params.ev_shock*info_buy(i_less_no)./Ascale_stack(i_less_no)));
    ipol(no_less_i)= 1./(1+exp(-params.ev_shock*info_buy(no_less_i)./Ascale_stack(no_less_i)));


end


ipol = reshape(ipol,[nk npz ns*npk*nsigK]);
Vp   = reshape(Vp,[nk npz ns*npk*nsigK]);
t1 = toc(t1start);

if(params.display==0)
    fprintf('time spent on finding value pol: %f \n',t1)
end


