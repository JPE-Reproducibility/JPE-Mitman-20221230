function [mNext,vNext] = mv_update(m,v,p,a,b)
% m is mean of K
% v is variance of K
% LOM parameters a = [a0 a1];  b = [b0 b1];

L = a(1)/(1-b(1));
U = a(2)/(1-b(2));

mu0 = a(1) + b(1).*m;
mu1 = a(2) + b(2).*m;
s20 = b(1).^2 .* v;
s21 = b(2).^2 .* v;
Delta = mu1 - mu0;

mu  = (1-p).*mu0 + p.*mu1;
s2  = (1-p).*s20 + p.*s21 + p.*(1-p).*Delta.^2;
s   = sqrt(s2);

mu = max(mu,L);
mu = min(mu,U);

alphaval = (L - mu)./s;
betaval  = (U - mu)./s;
kappaval = normcdf(betaval) - normcdf(alphaval);

phi_a = normpdf(alphaval);
phi_b = normpdf(betaval);

kappaval(s<1e-12)=1;
alphaval(s<1e-12)=1;
betaval(s<1e-12)=1;
phi_b(s<1e-12)=0;
phi_a(s<1e-12)=0;

mNext = mu + s .* (phi_a - phi_b) ./ kappaval;
vNext = s2 .* ( 1 ...
         + (alphaval.*phi_a - betaval.*phi_b)./kappaval ...
         - ((phi_a - phi_b)./kappaval).^2 );

if(any(isnan(mNext)))
    keyboard;
end
if(any(isnan(vNext)))
    keyboard;
end

end
