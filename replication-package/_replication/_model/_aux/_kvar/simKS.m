function [Kvec,dists_out,panel_out,stats,Kvec_u,Kvec_e]=simKS(kpol_in,ipol_in,dists,zvec,shocks,params)

kdist = dists.kdist; 
pdist = dists.pdist; 
pKdist = dists.pKdist; 
sigKdist = dists.sigKdist;
a0  =   params.a0;
a1  =   params.a1;
ishocks=shocks.ishocks;
xshocks=shocks.xshocks;
kapshocks=shocks.kapshocks/2;
kinfoshocks=shocks.kinfoshocks/2;
death=shocks.death;
markdown=params.markdown;
N = params.N;
T=params.T;
Kvec=zeros(T,1);         
sum_bequest_t=zeros(T,1);         
Kvec_u=zeros(T,1);         
Kvec_e=zeros(T,1);         
stats.cvar=zeros(T,1);
stats.ct=zeros(T,1);
stats.it=zeros(T,1);
stats.yt=zeros(T,1);
stats.rt=zeros(T,1);
stats.wt=zeros(T,1);
stats.info=zeros(T,1);
stats.prior=zeros(T,1);
stats.post=zeros(T,1);
rho_g = params.piz(2,2);
rho_b = params.piz(1,1);

probdeath=params.probdeath;
rebate = params.rebate;

lbar=params.lbar;
alpha=params.alpha;
z=params.z;
b=params.b;
delta=params.delta;
wtax=params.wtax;
aggKmin=params.aggKmin;
aggKmax=params.aggKmax;
k=params.sav_grid;
aggK=params.Kgrid;
sigKgrid=params.sigKgrid;
sigKmax=params.sigKmax;
sigKmin=params.sigKmin;
mgrid = params.Agrid;
nx=params.nx;
ns=params.ns;
nz=params.nz;
nA=params.nA;
nk=params.nk;
npk=params.npk;
nsigK=params.nsigK;
npz=params.npz;
npzp=params.npzp;
kmin=params.bmin;
kmax=params.Amax;
zprior = params.zprior;
zpost = params.zpost;
istates = 1:ns;
kpol = reshape(kpol_in,[nA npzp ns npk nsigK]);
ipol = reshape(ipol_in,[nk npz ns npk nsigK]);

%interpolant objects:
interp_type='linear';
extrap_type='linear';

if nsigK > 1
    [k_ndgrid,zprior_ndgrid,istates_ndgrid,aggK_ndgrid,sigK_ndgrid] = ndgrid(k,zprior,istates,aggK,sigKgrid);
    F_info=griddedInterpolant(k_ndgrid,zprior_ndgrid,istates_ndgrid,aggK_ndgrid,sigK_ndgrid,ipol,interp_type,extrap_type);
    clear k_ndgrid zprior_ndgrid istates_ndgrid aggK_ndgrid sigK_ndgrid
    
    [mgrid_ndgrid,zpost_ndgrid,istates_ndgrid,aggK_ndgrid,sigK_ndgrid] = ndgrid(mgrid,zpost,istates,aggK,sigKgrid);
    F_k=griddedInterpolant(mgrid_ndgrid,zpost_ndgrid,istates_ndgrid,aggK_ndgrid,sigK_ndgrid,kpol,interp_type,extrap_type);
    clear mgrid_ndgrid zpost_ndgrid istates_ndgrid aggK_ndgrid sigK_ndgrid
else
    [k_ndgrid,zprior_ndgrid,istates_ndgrid,aggK_ndgrid] = ndgrid(k,zprior,istates,aggK);
    F_info=griddedInterpolant(k_ndgrid,zprior_ndgrid,istates_ndgrid,aggK_ndgrid,ipol,interp_type,extrap_type);
    clear k_ndgrid zprior_ndgrid istates_ndgrid aggK_ndgrid 
    
    [mgrid_ndgrid,zpost_ndgrid,istates_ndgrid,aggK_ndgrid] = ndgrid(mgrid,zpost,istates,aggK);
    F_k=griddedInterpolant(mgrid_ndgrid,zpost_ndgrid,istates_ndgrid,aggK_ndgrid,kpol,interp_type,extrap_type);
    clear mgrid_ndgrid zpost_ndgrid istates_ndgrid aggK_ndgrid 

end

kdistT=nan(N,T);
cahT=nan(N,T);
info_acT=nan(N,T);
pKdistT=nan(N,T);
sigKdistT=nan(N,T);
pdistT=nan(N,T);

for t=1:T
    incshocks=xshocks(:,t)+(ishocks(:,t)-1)*nx;
   
    inddeath=find(death(:,t)==1);
    indsurv=find(death(:,t)==0);
    bequest=sum(kdist(inddeath))/sum(kdist(indsurv))*kdist(indsurv);    
     
     sum_bequest_t(t)=sum(kdist(inddeath));
     kdist(inddeath)=0;
     kdist(indsurv)=kdist(indsurv)+bequest;
     
    if params.newborn_noinf_pK==1
        pKdist(inddeath)=dists.meanKbar; %newborns have LR mean as capital prior
        sigKdist(inddeath)=dists.sigKbar; %newborns have LR variance of capital prior
    end
    if params.newborn_noinf_pZ==1
        pdist(inddeath)=params.zinv(2); % newborns have uninformative prior
    end

    Kt=mean(kdist); 
    zc=zvec(t);
    Kt=Kt*(Kt>=aggKmin)*(Kt<=aggKmax)+aggKmin*(Kt<aggKmin)+aggKmax*(Kt>aggKmax); 
    Kvec(t)=Kt;
    Kvec_u(t) = mean(kdist(ishocks(:,t)==1));
    Kvec_e(t) = mean(kdist(ishocks(:,t)==2));
    % [t Kt]
    Lt=params.L(zvec(t));
    yt=z(zvec(t))*Kt^alpha*Lt^(1-alpha);
    rt=markdown*alpha*z(zvec(t))*(Lt/Kt)^(1-alpha);
    wt=markdown*(1-alpha)*z(zvec(t))*(Kt/Lt)^(alpha);
    profitt=(1-markdown)*yt;
    if params.gross_benefits==1
        tax=params.u(zc)*params.b/((1-params.u(zc))+params.b*params.u(zc));
        taxe=tax;
        taxu=tax;
    else
        tax=params.u(zc)*params.b/((1-params.u(zc))*params.lbar);
        taxe=tax;
        taxu=0;
    end
    % Note, this option only makes sense if gross_benefits=1
    if(params.acyclical_tax==1)
        tax     = params.tax_bar;
        taxe    = tax;
        taxu    = tax;
    end
    if(params.ne>2)
        earn=[wt;wt;profitt].*params.ix .* ( params.iu*(1-taxu) + (1-params.iu).*(1-[taxe;taxe;0]) );
    else
        earn=wt*params.ix .* ( params.iu*(1-taxu) + (1-params.iu)*(1-taxe) );
    end
    % Stack this to be in ns*npk as the policy functions
    % earn=repmat(earn,[params.npk]);

    if(params.aggKinfo==1)
        pKdist=Kt*ones(N,1);
    elseif(params.aggKinfo>0)
        kinfo_prob  = params.aggKinfo*ones(size(pKdist));
        info_kc     = kinfoshocks(:,t)<=kinfo_prob;
        pKdist      = info_kc*Kt+(1-info_kc).*pKdist;
        sigKdist    = (1-info_kc).*sigKdist;
    end


    % First thing, for each person, we have to figure out their info choice
    if(params.exinfo==0)
        % info_prob=interpn(k,zprior,istates,aggK,ipol,kdist,pdist,incshocks,pKdist,'spline');
        if nsigK>1
            info_prob=F_info(kdist,pdist,incshocks,pKdist,sigKdist);
        else
            info_prob=F_info(kdist,pdist,incshocks,pKdist);
        end
    elseif(params.exinfo<1)
        info_prob = params.exinfo*ones(size(pdist));
    else
        info_prob = 10*ones(size(pdist));        
    end
    info_ac = kapshocks(:,t)<=info_prob;
    postdist = info_ac.*(zc-1)+(1-info_ac).*pdist;
    
    cah=kdist*(1-delta-wtax+rt)+earn(incshocks)-params.nu*info_ac+rebate*wtax*Kt;

    % keyboard;
    % kdistp=interpn(mgrid,zpost,istates,aggK,kpol,cah,postdist,incshocks,pKdist,'spline');
    if nsigK>1
        kdistp=F_k(cah,postdist,incshocks,pKdist,sigKdist);
    else
        kdistp=F_k(cah,postdist,incshocks,pKdist);
    end


    kdistp=kdistp.*(kdistp>=kmin).*(kdistp<=kmax)+kmin*(kdistp<kmin)+kmax*(kdistp>kmax); 
 
    % pKdistp = postdist.*exp(a0(2)+a1(2)*log(pKdist))...
    %         + (1-postdist).*exp(a0(1)+a1(1)*log(pKdist));

    [logpKdistp,sigKdistp] = mv_update(log(pKdist),sigKdist,postdist,a0,a1);
    if nsigK == 1
        sigKdistp = zeros(N,1);
    end
    pKdistp = exp(logpKdistp);

    ct=cah-kdistp;
   
    it=kdistp-(1-delta)*kdist;
    pdist=rho_g*postdist+(1-rho_b)*(1-postdist);
    stats.info(t)=mean(info_ac);
    stats.prior(t)=mean(pdist);
    stats.post(t)=mean(postdist);
    stats.pK(t)=mean(pKdist);
    stats.cvar(t)=var(log(ct));
    stats.ct(t)=mean(ct);
    stats.it(t)=mean(it);
    stats.rt(t)=rt;
    stats.yt(t)=yt;
    stats.tax(t)=tax;
    stats.limt(t)=mean(kdistp==0);
    stats.limt1(t)=mean(kdistp<0.01*wt);
    stats.limt2(t)=mean(kdistp<0.1*wt);
    stats.limt3(t)=mean(kdistp<0.25*wt);
    stats.ct2=ct;
    stats.wt(t)=wt;
    stats.sum_bequest(t) = sum_bequest_t(t);
    kdistT(:,t)=kdist;
    cahT(:,t)=cah;
    info_acT(:,t)   =   info_ac;
    pKdistT(:,t)    =   pKdist;
    pdistT(:,t)     =   pdist;
    sigKdistT(:,t)  =   sigKdist;

    pKdist          =   pKdistp;
    kdist           =   kdistp;
    sigKdist        =   sigKdistp;                              
   
   
end
dists_out.kdist=kdist;
dists_out.pdist=pdist;
dists_out.pKdist=pKdist;
dists_out.sigKdist=sigKdist;
dists_out.cah = cah;
panel_out.cahT = cahT;
panel_out.kdistT = kdistT;
panel_out.info_acT = info_acT;
panel_out.pKdistT = pKdistT;
panel_out.pdistT = pdistT;
dists_out.meanKbar=mean(Kvec(params.drop+1:end));
