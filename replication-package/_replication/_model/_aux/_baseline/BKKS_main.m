%% Code re-write for Expectations and Wealth Heterogeneity in the Macroeconomy 
%   Broer, Kohlhas, Mitman and Schlafmann (202X)

%clear;
% close all
function BKKS_main(parIn)

if parIn.loadPrevResults ==1
            try 
        load(parIn.readInitialGuessFile,'params')
        sav_grid_old=params.sav_grid; clear params
        disp('loaded sav_grid')
            end
end
% save panel or not
params.save_panel=parIn.save_panel;

% Discount factor
params.beta = parIn.beta;

% Risk aversion
params.sigma = parIn.sigma;

% UI Benefit
params.b = parIn.b;     
% Productivity value in a recession
zval=parIn.zval;

% Capital share
params.alpha=parIn.alpha;       

% Capital depreciation
params.delta=parIn.delta;    

% wealth tax 
params.wtax=parIn.wtax;

% rebate wealth tax?
params.rebate = parIn.rebate;

% Info cost utils
params.kappa=parIn.kappa;

% Info cost money
params.nu=parIn.nu;

% Shape parameter
params.ev_shock = parIn.ev_shock;

% Scale shape parameter?
params.scale_ev = parIn.scale_ev;

% death probability
params.probdeath = parIn.probdeath;

% newborns uninformed about kbar or z?
params.newborn_noinf_pK = parIn.newborn_noinf_pK;
params.newborn_noinf_pZ = parIn.newborn_noinf_pZ;

% if params.probdeath==1/160
% params.beta=params.beta*1.0065;
% elseif params.probdeath==1/200
% params.beta=params.beta*1.005;
% end
params.beta = params.beta/(1-params.probdeath);

params.euler=double(eulergamma);

params.exinfo       = parIn.exinfo;
params.aggKinfo     = parIn.aggKinfo; %0.01; %0.00; 0.05;


Urec=parIn.Urec; %0.0839;
Uboom=parIn.Uboom; %0.0533;

params.gross_benefits = parIn.gross_benefits;
params.acyclical_tax  = parIn.acyclical_tax;

% To pin down the transition matrices we read in 8 numbers

params.u(1)=Urec;
params.u(2)=Uboom;

params.piz = [parIn.prob_1_1+parIn.prob_1_2, 1-(parIn.prob_1_1+parIn.prob_1_2)
    1-(parIn.prob_3_3+parIn.prob_3_4), parIn.prob_3_3+parIn.prob_3_4];

ee_rr = (1+(parIn.prob_1_1/params.piz(1,1)-2)*Urec)/(1-Urec);

ee_rb = (1-Uboom)/(1-Urec)-((1-(parIn.prob_1_3/params.piz(1,2)))*Urec)/(1-Urec);

ee_br = (1-Urec)/(1-Uboom) - (1-(parIn.prob_3_1/params.piz(2,1)))*Uboom/(1-Uboom);

ee_bb = (1+(parIn.prob_3_3/params.piz(2,2)-2)*Uboom)/(1-Uboom);


prob=[  parIn.prob_1_1    parIn.prob_1_2    parIn.prob_1_3    1-(parIn.prob_1_1+parIn.prob_1_2+parIn.prob_1_3)
        (1-ee_rr)*params.piz(1,1) ee_rr*params.piz(1,1)    (1-ee_rb)*params.piz(1,2) ee_rb*params.piz(1,2)
        parIn.prob_3_1    params.piz(2,1)-parIn.prob_3_1    parIn.prob_3_3    1-(parIn.prob_3_1+params.piz(2,1)-parIn.prob_3_1+parIn.prob_3_3)
        (1-ee_br)*params.piz(2,1) ee_br*params.piz(2,1)    (1-ee_bb)*params.piz(2,2) ee_bb*params.piz(2,2)];


% Old way of doing it pre-Feb 24, 2025
% params.u(1)=Urec;
% params.u(2)=Uboom;
% 
% prob=[  parIn.prob_1_1    parIn.prob_1_2    parIn.prob_1_3    parIn.prob_1_4
%         parIn.prob_2_1    parIn.prob_2_2    parIn.prob_2_3    parIn.prob_2_4
%         parIn.prob_3_1    parIn.prob_3_2    parIn.prob_3_3    parIn.prob_3_4
%         parIn.prob_4_1    parIn.prob_4_2    parIn.prob_4_3    parIn.prob_4_4];
% 
% params.piz=[   sum(prob(1,1:2)),sum(prob(1,3:4))
%             sum(prob(3,1:2)),sum(prob(3,3:4))];

temp = params.piz^10000;
params.zinv = temp(1,:);

params.z(2)=parIn.zH;
params.z(1)=parIn.zL;

% Simulation length
params.T=parIn.T;     

% Number of people
params.N = parIn.N;

% Periods to drop
params.drop=parIn.drop;

% Aggregate states
params.nz=parIn.nz;            
nz = params.nz;

options=optimset('Display','iter');


params.pie{1}=zeros(2,2);

%Idiosyncratic income states
params.nx=parIn.nx;
nx=params.nx;

% Persistence component of income
params.rho=parIn.rho; 
rho=params.rho;

sigy=sqrt(parIn.sigyPartial/(1+sqrt(rho)+rho+rho^(3/2)));

params.upsilon=ones(nx,1);

%Transitory component
siget=parIn.siget; 
params.siget=siget;

if(nx > 1)
    [params.ex,params.piex] =rouwenhorst(params.nx,0,rho,sigy);
    temp=params.piex^1000000;
    params.exinv=temp(1,:);
    params.ex=exp(params.ex);
    ydist=params.exinv;
    params.ex = params.ex/(ydist*params.ex);
else
    params.ex=1;
    params.piex=1;
    params.exinv=1;
    ydist=1;
end

% cyclical probabilities of falling for entrepreneur to worker
prob_e_w=[parIn.e_to_w_rr;parIn.e_to_w_rb;parIn.e_to_w_br;parIn.e_to_w_bb];

if(parIn.ent_model==1)
    ent_share=parIn.ent_share;
    params.ent_share = ent_share;
    for zc=1:3:4
        prob_w_e = fsolve(@(x) solve_ent_transition(x,prob_e_w(zc),ent_share),0.1); 
        params.pient{zc}=[1-prob_w_e prob_w_e; prob_e_w(zc) 1-prob_e_w(zc)];
    end
    % ent_inv=[1-ent_share ent_share];
    for zc=2:3
        prob_w_e=ent_share*prob_e_w(zc)/(1-ent_share);
        params.pient{zc}=[1-prob_w_e prob_w_e; prob_e_w(zc) 1-prob_e_w(zc)];
    end
    params.markdown = parIn.markdown;
    markdown = params.markdown;
else
    markdown = 1;
    params.markdown = markdown;
    ent_share=parIn.ent_share;
    params.ent_share = ent_share;
    params.pient={};
end


params.lbar=1/((1-Urec)*(1-ent_share));      % L=1 in low aggregate state

params.L=(1-params.u)/(1-params.u(2));
params.L(1)=(1-params.u(1))*params.lbar;
params.L(2)=(1-params.u(2))*params.lbar;

if params.gross_benefits==1 %if benefits are net (not taxed), then do not hh do not supply lbar in unemployment
    params.e(1)=params.b*params.lbar;
else
    params.e(1)=params.b;
end
params.e(2)=1*params.lbar;

params.pie{1}=prob(1:2,1:2)/params.piz(1,1);
params.pie{4}=prob(3:4,3:4)/params.piz(2,2);
params.pie{2}=prob(1:2,3:4)/params.piz(1,2);
params.pie{3}=prob(3:4,1:2)/params.piz(2,1);

params.ne=parIn.ne;
ne = params.ne;
ns = nx*ne;
params.ns = ns;

if(ne>2)
    for zc=1:4
        if(zc==1 || zc==3)
            uval=params.u(1);
        else
            uval=params.u(2);
        end

        params.pie_new{zc}=zeros(ne,ne);
        params.pie_new{zc}(1:2,1:2) = params.pient{zc}(1,1)*params.pie{zc};
        params.pie_new{zc}(1:2,3)   = params.pient{zc}(1,2);
        params.pie_new{zc}(3,3)     = params.pient{zc}(2,2);
        params.pie_new{zc}(3,1)     = params.pient{zc}(2,1)*uval;
        params.pie_new{zc}(3,2)     = params.pient{zc}(2,1)*(1-uval);
    end
    params.pie=params.pie_new;
    params.e(3) = 1/ent_share;
    params.ix=[params.ex*params.e(1);params.ex*params.e(2);params.ex*params.e(3)];
    params.iu=[ones(size(params.ex));zeros(size(params.ex));zeros(size(params.ex))];    %indicator whether this is a unemployed state or not
else
    params.ix=[params.ex*params.e(1);params.ex*params.e(2)];
    params.iu=[ones(size(params.ex));zeros(size(params.ex))];    %indicator whether this is a unemployed state or not

end


for zc=1:nz
    for ic=1:ne
        for ix=1:nx
            for zcc=1:nz
                for icc=1:ne
                    for ixx=1:nx
                        index=(zc-1)*nz+zcc;
                        params.pi(ix+(ic-1)*nx+(zc-1)*ns,ixx+(icc-1)*nx+(zcc-1)*ns)=params.piz(zc,zcc)*...
                            params.pie{index}(ic,icc)*params.piex(ix,ixx);
                    end
                end
            end    
        end
    end
end
for ic=1:ne
    for ix=1:nx
        for icc=1:ne
            for ixx=1:nx
                params.piagg{1}(ix+(ic-1)*nx,ixx+(icc-1)*nx)=params.piz(1,1)*...
                    params.pie{1}(ic,icc)*params.piex(ix,ixx);
                params.piagg{2}(ix+(ic-1)*nx,ixx+(icc-1)*nx)=params.piz(1,2)*...
                    params.pie{2}(ic,icc)*params.piex(ix,ixx);
                params.piagg{3}(ix+(ic-1)*nx,ixx+(icc-1)*nx)=params.piz(2,1)*...
                    params.pie{3}(ic,icc)*params.piex(ix,ixx);
                params.piagg{4}(ix+(ic-1)*nx,ixx+(icc-1)*nx)=params.piz(2,2)*...
                    params.pie{4}(ic,icc)*params.piex(ix,ixx);
            end
        end
    end    
end

%generate new shocks or load existing ones
if parIn.generate_new_shocks==1
    tic
    [ishocks,xshocks,kapshocks,kinfoshocks,zvec,death] = genShocks(params);
    toc
    save(parIn.writeShocksFile,'ishocks', 'xshocks', 'kapshocks', 'kinfoshocks', 'zvec','death','-v7.3')
else
        load(parIn.readShocksFile,'ishocks', 'xshocks', 'kapshocks', 'kinfoshocks', 'zvec','death')
end

% Number of points for the priors
params.npz  = parIn.npz;
npz = params.npz;

params.zprior = linspace(1-params.piz(1,1),params.piz(2,2),npz);

% Get the persistences of the good and bad states
rho_g = params.piz(2,2);
rho_b = params.piz(1,1);

% number of grid points for posterior
params.npzp=parIn.npzp;
npzp = params.npzp;


% params.zpost  = [0 rho_g*params.zprior+(1-rho_b)*(1-params.zprior) 1];
params.zpost  = [0 params.zprior 1];

params.npk = parIn.npk;
npk = params.npk;
params.aggKmin=parIn.aggKmin;
aggKmin=params.aggKmin;
params.aggKmax=parIn.aggKmax;
aggKmax=params.aggKmax;

% Aggregate capital points
params.Kgrid = linspace(aggKmin,aggKmax,npk);
params.Kgrid=params.Kgrid';


% Low wage
wmin = markdown*params.z(1).*(1-params.alpha).*(params.Kgrid(1)./params.L(1)).^(params.alpha);
 wmax = markdown*params.z(2)*(1-params.alpha)*(params.Kgrid(end)/params.L(2)).^(params.alpha);
 rmax= markdown*params.z(2)*(params.alpha)*(params.Kgrid(1)/params.L(2)).^(params.alpha-1);

% Individual cah grid points

params.bmin=parIn.bmin;
if params.gross_benefits==1
    params.Amin=params.ex(1)*params.b*min(wmin,[],'all')+params.bmin+params.rebate*params.wtax*aggKmin;
else
    params.Amin=params.ex(1)*params.b*min(wmin,[],'all')+params.bmin - params.nu+params.rebate*params.wtax*aggKmin;
end
params.Amax=parIn.Amax;

params.nA = parIn.nA; % # asset grid points (we do allow for off-grid decisions)
% put more points at lower end of asset grid. Note that optimal savings
% decisions become linear in the limit (i.e. as assets go to infinity).
params.curv=parIn.curv;
curv=params.curv;
params.curv_fine=parIn.curv_fine;
curv_fine = params.curv_fine;
nA = params.nA;
nA_fine = 5*(params.nA-1)+1;
Agrid=zeros(nA,1);
Agrid_fine=zeros(nA_fine,1);


if(parIn.ent_model==1 && params.bmin<0)
    params.nk=parIn.nk;
    params.curv_sav_grid=parIn.curv_sav_grid
    nk = params.nk;

    sav_grid1 = (linspace(params.bmin,0,ceil(0.4*params.nk)))';
    sav_grid2 = (linspace(0.05,1,floor(0.1*params.nk)))';
    nk3 = params.nk-length(sav_grid2)-length(sav_grid1);
    sav_grid3 = 1.1+(params.Amax-1.1)*(linspace(0,1,nk3).^params.curv_sav_grid)';
    params.sav_grid=[sav_grid1;sav_grid2;sav_grid3];
    params.nk=length(params.sav_grid);
    nk=params.nk;
elseif(parIn.ent_model==1 && params.bmin==0)
    params.nk=parIn.nk;
    params.curv_sav_grid=parIn.curv_sav_grid
    
    sav_grid1 = (linspace(0,5,ceil(0.5*params.nk)))';
    nk3 = params.nk-length(sav_grid1);
    sav_grid3 = 5.1+(params.Amax-5.1)*(linspace(0,1,nk3).^params.curv_sav_grid)';
    params.sav_grid=[sav_grid1;sav_grid3];
    params.nk=length(params.sav_grid);
    nk=params.nk;

else
    params.nk=parIn.nk;
    params.curv_sav_grid=parIn.curv_sav_grid
    nk = params.nk;
    params.sav_grid1 = (params.bmin+(params.Amax-params.bmin)*(linspace(0,1,floor(params.nk*3)).^params.curv_sav_grid))';
    params.sav_grid1=params.sav_grid1(params.sav_grid1<4);
    
    params.sav_grid2 =params.bmin+(params.Amax-params.bmin)*(linspace(0,1,params.nk/2).^params.curv_sav_grid)';
    params.sav_grid2=params.sav_grid2(params.sav_grid2>=4);
    params.sav_grid=[params.sav_grid1;params.sav_grid2];
    params.nk=length(params.sav_grid);
    nk=params.nk;
    % replacing sav_grid with more points where infopol has non-lineariry
end
% for i=1:ns

Agrid = params.Amin+(params.Amax*(1+rmax-params.delta-params.wtax)/(1-params.probdeath)+wmax*params.ix(end)-params.Amin)*(linspace(0,1,params.nA).^curv);
Agrid_fine = params.Amin+(params.Amax-params.Amin)*(linspace(0,1,nA_fine).^curv_fine);
% end

params.Agrid=Agrid'; %repmat(Agrid, [1 1 1 npz npk]);
params.Agrid_fine=Agrid'; %repmat(Agrid_fine, [1 1 1 npz npk]);
sav_grid=params.sav_grid;


params.nA_fine = nA_fine;


% Transition matrices

% transition matrix for income we know from the Markov
% transition matrix for p^z and p^k?
% Given, cah, y, p^z, p^k, do we know the transition matrix for p^z and
% p^k?

% Policy function guesses

cpol = 0.1*repmat(Agrid',[1 npzp npk*ns]);
if(params.exinfo>0)
    ipol = params.exinfo*ones(nk,npz,npk*ns);
else
    ipol = 0.16*ones(nk,npz,npk*ns);
end
X=log(repmat(reshape(cpol,[nA 1 npzp npk*ns]),[1 nz 1 1]));

a0 = [parIn.a0_1; parIn.a0_2];
a1 = [parIn.a1_1; parIn.a1_2];


params.pk_trans = zeros(npk,npk,nz);

params.maxIter=parIn.maxIter;
params.tol=parIn.tol;
params.display=parIn.display;

% load CurrentOutput.mat
% Get policy functions
diff_a = 1;
iter=0;
lambda0=parIn.lambda0;
lambda1=parIn.lambda1;
tol=parIn.tolLOM;
kdist0=parIn.kdist0all*ones(params.N,1);
pdist0=rand(params.N,1);
pKdist0=parIn.pkdist0all*ones(params.N,1);
meanKbar=parIn.pkdist0all;

if parIn.loadPrevResults ==1
    try 
disp('a0old')
disp(a0)
        load(parIn.readInitialGuessFile,'a0') 
disp('new')
disp(a0)
    end
    try 
        load(parIn.readInitialGuessFile,'a1') 
    end
    try 
        load(parIn.readInitialGuessFile,'cpol') 
    end
    try 
        load(parIn.readInitialGuessFile,'dec') 
    end
    try 
        %load(parIn.readInitialGuessFile,'kdist0') 
    end
    try 
        % load(parIn.readInitialGuessFile,'pdist0') 
    end
    try 
        % load(parIn.readInitialGuessFile,'pKdist0') 
    end
    try 
        load(parIn.readInitialGuessFile,'X') 
    end
    try 
        load(parIn.readInitialGuessFile,'ipol') 
    end
    try 
        load(parIn.readInitialGuessFile,'moments') 
        meanKbar = moments.kbar_mean;
        clear moments
    end
end


% cpol = 0.1*repmat(Agrid',[1 npzp npk*ns]);
% ipol = params.exinfo*ones(nk,npz,npk*ns);
npzp = params.npzp;
params.npk = parIn.npk;
npk = params.npk;
params.aggKmin=parIn.aggKmin;
aggKmin=params.aggKmin;
params.aggKmax=parIn.aggKmax;
aggKmax=params.aggKmax;

% Aggregate capital points
params.Kgrid = linspace(aggKmin,aggKmax,npk);
params.Kgrid=params.Kgrid';

cNa=size(cpol,1);
cNpz=size(cpol,2);
cNaggK=size(cpol,3);
% cpol_new=zeros(nA,npzp,npk*ns);
% update_cpol=0;
% if(cNa~=nA)
%     update_cpol=1;
%     AgridOld = params.Amin+(params.Amax-params.Amin)*(linspace(0,1,cNa).^curv);
%     for ii=1:size(cpol,2)
%         for jj=1:size(cpol,3)
%             cpol_new(:,ii,jj) = interp1(AgridOld,cpol(:,ii,jj),Agrid,'pchip','extrap');
%         end
%     end
% end
if(cNa~=nA || cNpz~=npzp || cNaggK~=npk*ns)
    cpol = 0.1*repmat(Agrid',[1 npzp npk*ns]);
end
cNa=size(ipol,1);
cNpz=size(ipol,2);
cNaggK=size(ipol,3);

if(cNa~=nk || cNpz~=npz || cNaggK~=npk*ns)
    if(params.exinfo>0)
        ipol = params.exinfo*ones(nk,npz,npk*ns);
    elseif cNpz==npz && cNaggK==npk*ns
        ipolnew=ones(nk,npz,npk*ns);
	    for jj=1:npz
   		     for ii=1:npk*ns
	            ipolnew(:,jj,ii)=interp1(sav_grid_old,ipol(:,jj,ii),sav_grid,'linear','extrap');
   		     end
	    end
        disp('interpolated info pol on new grid')
        ipol=ipolnew; clear ipolnew
    else
        ipol = 0.16*ones(nk,npz,npk*ns);
    end
else
    disp('using previous ipol')
end

if(params.exinfo>0)
    X=0;


else
    if(size(X,2)==nz)
        cNa=size(X,1);
        cNpz=size(X,3);
        cNaggK=size(X,4);
        if(cNa~=nA || cNpz~=npzp || cNaggK~=npk*ns)
            X=log(repmat(reshape(cpol,[nA 1 npzp npk*ns]),[1 nz 1 1]));
        end
    else
        cNa=size(X,1);
        cNpz=size(X,2);
        cNaggK=size(X,3);
        if(cNa~=nA || cNpz~=npzp || cNaggK~=npk*ns)
            X=log(repmat(reshape(cpol,[nA 1 npzp npk*ns]),[1 nz 1 1]));
        end
    end
end

% ipol = params.exinfo*ones(nk,npz,npk*ns);







% load InitialGuessBroerU04.mat
% load('~/Dropbox/BKKS_Shadow/new_code_results/MMEndoInfoK05Results','ipol')
% load('~/Dropbox/BKKS_Shadow/new_code_results/MMEndoInfoK05Results','cpol')
% load('~/Dropbox/BKKS_Shadow/new_code_results/MMEndoInfoK05Results','X')

% cpol = 0.1*repmat(Agrid',[1 npzp npk*ns]);
% X = log(cpol);

dists.kdist=kdist0;     
dists.pdist=pdist0;
dists.pKdist=pKdist0;
dists.meanKbar=meanKbar;

    

if(nx==1)
    xshocks=ones(size(xshocks));
end
shocks.xshocks=xshocks;
shocks.ishocks=ishocks;
shocks.kapshocks=kapshocks;
shocks.kinfoshocks=kinfoshocks;
shocks.death=death;
% load FirstConverge.mat
while(diff_a > tol && iter<parIn.maxIterLOM)
    params.a0=a0;
    params.a1=a1;
    for zc=1:nz
        for kc=1:npk
            kp = exp(a0(zc)+a1(zc)*log(params.Kgrid(kc)));
            [vals,inds] = basefun(params.Kgrid,npk,kp);
            params.pk_trans(kc,inds,zc)=vals;     
        end
    end
    
    r_mat = zeros(2,npk*ns);
    w_mat = zeros(2,npk*ns);
    taxe_mat = zeros(2,npk*ns); %taxes applied to employed wages
    taxu_mat = zeros(2,npk*ns); %taxes applied to unemployment benefits
    
    for sc=1:ns
        for kc=1:npk
            for zc=1:2
                if params.gross_benefits==1 %unemployment benefits are also taxed
                    tax=params.u(zc)*params.b/((1-params.u(zc))+params.b*params.u(zc));
                    taxe_mat(zc,sc+(kc-1)*ns) = tax;
                    taxu_mat(zc,sc+(kc-1)*ns) = tax;
                else %unemployment benefits are not taxed
                    tax=params.u(zc)*params.b/((1-params.u(zc))*params.lbar);
                    taxe_mat(zc,sc+(kc-1)*ns) = tax;
                    taxu_mat(zc,sc+(kc-1)*ns) = 0;
                end
                r_mat(zc,sc+(kc-1)*ns)=markdown*params.z(zc)*params.alpha*(params.Kgrid(kc)/params.L(zc)).^(params.alpha-1);
                w_mat(zc,sc+(kc-1)*ns)=markdown*params.z(zc)*(1-params.alpha)*(params.Kgrid(kc)/params.L(zc)).^(params.alpha);
                if(sc==3 && ne==3) %note that right now we CANNOT have ne>2 and nx>1
                    taxe_mat(zc,sc+(kc-1)*ns)   = 0;
                    w_mat(zc,sc+(kc-1)*ns)      = (1-markdown)*params.z(zc)*params.Kgrid(kc)^(params.alpha)*params.L(zc)^(1-params.alpha); %profits
                end
            end
        end
    end

    % Note, this option only makes sense if gross_benefits=1
    if(params.acyclical_tax==1) 
        params.taxz=(params.u*params.b./((1-params.u)+params.b*params.u))';
        tax_bar = params.zinv*params.taxz;
        taxe_mat(zc,sc+(kc-1)*ns) = tax_bar;
        taxu_mat(zc,sc+(kc-1)*ns) = tax_bar;
        params.tax_bar = tax_bar;
    end

    params.r_mat = r_mat;
    params.w_mat = w_mat;
    params.taxe_mat = taxe_mat;
    params.taxu_mat = taxu_mat;

    [cpol,dec,ipol,X] = solve_policies(cpol,ipol,X,params);
    save CurrentOutput cpol dec ipol X
    % load CurrentOutput.mat
    
    
    % Next step - do the simulation
    tic
    [Kvec,dists_out,panel,stats]=simKS(dec,ipol,dists,zvec,shocks,params);
    toc
    count1=1;
    count2=1;
    K1=zeros(sum(zvec(params.drop+1:params.T-1)==1),1);
    Kp1=K1;
    K2=zeros(sum(zvec(params.drop+1:params.T-1)==2),1);
    Kp2=K1;
    
    for t=params.drop+1:params.T-1
        if zvec(t)==1
            K1(count1)=Kvec(t);
            Kp1(count1)=Kvec(t+1);
            count1=count1+1;
        else
            K2(count2)=Kvec(t);
            Kp2(count2)=Kvec(t+1);
            count2=count2+1;
        end
    end
    X1=[ones(count1-1,1),log(K1)];
    X2=[ones(count2-1,1),log(K2)];
    [b1,BINT1,R,RINT,s1]=regress(log(Kp1),X1);
    [b2,BINT2,R,RINT,s2]=regress(log(Kp2),X2);
    a0p=[b1(1);b2(1)];
    a1p=[b1(2);b2(2)];
    diff_a=norm([a0; a1]-[a0p;a1p]);
    if(diff_a>2*tol)
        dists.kdist=dists_out.kdist;
        dists.pdist=dists_out.pdist;
        dists.pKdist=dists_out.pKdist;
        dists.meanKbar=(1-lambda0)*dists.meanKbar + lambda0*dists_out.meanKbar;
    end  
    if(diff_a < 10*tol)
        params.maxIter=10*parIn.maxIter;
    end
    if iter==parIn.lambdaChangeIter
        lambda0=parIn.lambda0_lateIter;
        lambda1=parIn.lambda1_lateIter;
    end
    if sum(Kvec==params.aggKmax)/length(Kvec)>0.5
        disp('upper bound')
        a0=a0*1.02
    elseif sum(Kvec==params.aggKmin)/length(Kvec)>0.5
        disp('lower bound')
        a0=a0/1.02
    else
        if(diff_a > tol)
            a0=(1-lambda0)*a0+lambda0*a0p
            a1=(1-lambda1)*a1+lambda1*a1p
        end
        if(diff_a>2*tol || iter<10)
            dists.kdist=dists_out.kdist;
            dists.pdist=dists_out.pdist;
            dists.pKdist=dists_out.pKdist;
        end
        iter=iter+1;
        fprintf('iter=%d eps=%f R2=%f R2=%f\n',iter,diff_a,s1(1),s2(1))

    end


end
Klomvec=zeros(params.T,1);
Klomvec(1)=Kvec(1);
for t=2:params.T
    if(zvec(t-1)==1)
        Klomvec(t) = exp(a0(1)+a1(1)*log(Klomvec(t-1)));
    else
        Klomvec(t) = exp(a0(2)+a1(2)*log(Klomvec(t-1)));
    end
end
kdist0=dists_out.kdist;
pdist0=dists_out.pdist;
pKdist0=dists_out.pKdist;
ishocksT=shocks.ishocks(:,end);

save(parIn.saveResultsFile, 'a0', 'a1', 'cpol', 'dec', 'X','ipol', 'kdist0', 'pdist0', 'pKdist0', 'ishocksT','diff_a','params','Kvec') 

[Kvec,dists_out,panel,stats,Kvec_u,Kvec_e]=simKS(dec,ipol,dists,zvec,shocks,params);

[moments,TS] = calculate_moments_stoch(Kvec',panel,ishocks,zvec,params);

forecast_moments = calculate_fcerrors_stoch_optimized(Kvec',panel,zvec,params,a0,a1);

kdist_panel = panel.kdistT(:,params.drop+1:end);
pKdist_panel = panel.pKdistT(:,params.drop+1:end);
if params.save_panel==1
    cah_panel = panel.cahT(:,params.drop+1:end);
    save(parIn.saveResultsFile, 'a0', 'a1', 'cpol', 'dec', 'X','ipol', 'kdist0', 'pdist0', 'pKdist0', 'ishocksT','forecast_moments','moments','diff_a','params','Kvec','Kvec_u','Kvec_e','kdist_panel','cah_panel','pKdist_panel','-v7.3')
else
    save(parIn.saveResultsFile, 'a0', 'a1', 'cpol', 'dec', 'X','ipol', 'kdist0', 'pdist0', 'pKdist0', 'ishocksT','forecast_moments','moments','diff_a','params','Kvec','Kvec_u','Kvec_e','-v7.3')
end

end

% Compute the value functions

% tic
% % [Vp,Wp,Wp_info]     = solve_value(V0,W0,cpol,dec,cpol_full,dec_full,ipol,params);
% [Xp,Wp_info,Wp_full,ipol] = solve_experience(V0,cpol,dec,cpol_full,dec_full,ipol,params);
% toc

% Solve the discrete choice
% tic
% [ipolp]     = solve_info(V0,W0,params);
% toc






