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


for j=1:ns*npk
    for zc = 1:nz
        cah_today(:,zc,j)    = rebate*Kgrid(exotok_full(j))*wtax+sav_grid*(1+r_mat(zc,j)-delta-wtax)/(1-probdeath) ...
                                + ix(exotos_full(j))*w_mat(zc,j) * ( iu(exotos_full(j))*(1-taxu_mat(zc,j)) + (1-iu(exotos_full(j)))*(1-taxe_mat(zc,j)) );
    end
end