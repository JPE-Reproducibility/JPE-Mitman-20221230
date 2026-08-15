function [ishocks,xshocks,kapshocks,kinfoshocks,zvec,death]  = genShocks(params)

T=params.T;
N=params.N;
ishocks=zeros(N,T);
xshocks=ones(N,T);
zvec=zeros(T,1);
piz=params.piz;
pie=params.pie;
piex=params.piex;
pient=params.pient;
ent_share=params.ent_share;
nz=params.nz;
ne=params.ne;
nx=params.nx;
zvec(1)=2;
exinv=params.exinv;
cumexinv=cumsum(exinv);
cumpiex=zeros(nx,nx);
for j=1:nx
    cumpiex(j,:) = cumsum(piex(j,:));
end

probdeath=params.probdeath;

%Use Quasi-random numbers to get distributions right
rng(140324,'twister');
% uv = haltonset(T,'Skip',89234);
% urandv = net(uv,N);
urandv  = rand(N,T);
% ev = haltonset(T,'Skip',25021982);
% erandv = net(ev,N);
xrand = rand(N,T);
% kv = haltonset(T,'Skip',11031975);
kapshocks = rand(N,T); %net(kv,N);
kinfoshocks = rand(N,T); %net(kv,N);

death=rand(N,T)>(1-probdeath);
for t=1:T
    order=randperm(N);
    iflip=1;
    if(sum(death(:,t))<round(probdeath*N))
        while(sum(death(:,t))<probdeath*N)
            if(death(order(iflip),t)==0)
                death(order(iflip),t)=1;
            end
            iflip=iflip+1;
        end
    
    elseif(sum(death(:,t))>round(probdeath*N))
        while(sum(death(:,t))>probdeath*N)
            if(death(order(iflip),t)==1)
                death(order(iflip),t)=0;
            end
            iflip=iflip+1;
        end        
    end
end

for t=1:T
    kapshocks(:,t)=kapshocks(:,t)/mean(kapshocks(:,t));
    kinfoshocks(:,t)=kinfoshocks(:,t)/mean(kinfoshocks(:,t));
end

for t=2:T
    temp=rand;
    if(temp<=piz(zvec(t-1),1))
        zvec(t)=1;
    else
        zvec(t)=2;
    end
end

for i=1:N
    % Employment states
    if(urandv(i,1)<=params.u(2)*(1-ent_share))
        ishocks(i,1)=1;
    elseif(urandv(i,1)<=1-ent_share)
        ishocks(i,1)=2;
    else
        ishocks(i,1)=3;
    end
    if(nx>1)
        j=1;
        while(xrand(i,1)>cumexinv(j))
           j=j+1; 
        end
        xshocks(i,1)=j;
    end        
end
t=1;
order=randperm(N);
iflip=1;
for j=1:ne-1
    if(j==1)
        val=round(params.u(zvec(t))*N*(1-ent_share));
    else
        val=round((1-params.u(zvec(t)))*N*(1-ent_share));    
    end
    if(sum(ishocks(:,t)==j)<val)
        while(sum(ishocks(:,t)==j)<val)
            if(ishocks(order(iflip),t)>j)
                ishocks(order(iflip),t)=j;
            end
           iflip=iflip+1;
        end
    
    else
        while(sum(ishocks(:,t)==j)>val)
            if(ishocks(order(iflip),t)==j)
                ishocks(order(iflip),t)=j+1;
            end
            iflip=iflip+1;
        end        
    end
end

order=randperm(N);
iflip=1;
for j=1:nx-1
    if(sum(xshocks(:,t)==j)<round(exinv(j)*N))
        while(sum(xshocks(:,t)==j)<exinv(j)*N)
            if(xshocks(order(iflip),t)>j)
                xshocks(order(iflip),t)=j;
            end
            iflip=iflip+1;
        end
    
    elseif(sum(xshocks(:,t)==j)>round(exinv(j)*N))
        while(sum(xshocks(:,t)==j)>exinv(j)*N)
            if(xshocks(order(iflip),t)==j)
                xshocks(order(iflip),t)=j+1;
            end
            iflip=iflip+1;
        end        
    end
end


for t=2:T
    % disp(t)
    index=(zvec(t-1)-1)*nz+zvec(t);
    for i=1:N
        temp=urandv(i,t);
        if(temp<=pie{index}(ishocks(i,t-1),1))
            ishocks(i,t)=1;
        elseif(temp<=pie{index}(ishocks(i,t-1),2)+pie{index}(ishocks(i,t-1),1))
            ishocks(i,t)=2;
        else
            ishocks(i,t)=ne;
        end

        if(nx>1)
            j=1;
            while(xrand(i,t)>cumpiex(xshocks(i,t-1),j))
            % while(rand>cumpiex(xshocks(i,t-1),j))
               j=j+1; 
            end
            xshocks(i,t)=j;
        end 

    end
    order=randperm(N);
    iflip=1;
    for j=1:ne-1
        if(j==1)
            val=round(params.u(zvec(t))*N*(1-ent_share));
        else
            val=round((1-params.u(zvec(t)))*N*(1-ent_share));    
        end
        if(sum(ishocks(:,t)==j)<val)
            while(sum(ishocks(:,t)==j)<val)
                if(ishocks(order(iflip),t)>j)
                    ishocks(order(iflip),t)=j;
                end
               iflip=iflip+1;
            end
        
        else
            while(sum(ishocks(:,t)==j)>val)
                if(ishocks(order(iflip),t)==j)
                    ishocks(order(iflip),t)=j+1;
                end
                iflip=iflip+1;
            end        
        end
    end


    order=randperm(N);
    iflip=1;
    for j=1:nx-1
        if(sum(xshocks(:,t)==j)<round(exinv(j)*N))
            while(sum(xshocks(:,t)==j)<exinv(j)*N)
                if(xshocks(order(iflip),t)>j)
                    xshocks(order(iflip),t)=j;
                end
                iflip=iflip+1;
                if(iflip>N)
                    keyboard
                end
            end
        
        elseif(sum(xshocks(:,t)==j)>round(exinv(j)*N))
            while(sum(xshocks(:,t)==j)>exinv(j)*N)
                if(xshocks(order(iflip),t)==j)
                    xshocks(order(iflip),t)=j+1;
                end
                iflip=iflip+1;
            end        
        end
    end
    
end




