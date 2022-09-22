function f=foc(price,x1,mc1,nest0,Firms)
%This function calculates firms' FOCs with the observed choice set.
global beta alpha rho
np=length(mc1);
delta=zeros(np,1);
for j=1:np
    delta(j,1)=x1(j,:)*beta+alpha*price(j);
end
nnest=length(unique(nest0));
D=zeros(nnest,1);
for oo=1:nnest
    for pp=1:np
        if nest0(pp)==oo
            D(oo,1)=D(oo,1)+exp(delta(pp)/(1-rho));
        end
    end
end
totalD=1;
for oo=1:nnest
    totalD=totalD+D(oo,1)^(1-rho);
end
share=zeros(np,1);
for pp=1:np
    share(pp,1)=exp(delta(pp)/(1-rho))/(D(nest0(pp),1)^rho*totalD);
end
nsharet=zeros(nnest,1);
for oo=1:nnest
    for pp=1:np
        if nest0(pp)==oo
            nsharet(oo,1)=nsharet(oo,1)+share(pp);
        end
    end
end
nestshare=zeros(np,1);
for oo=1:nnest
    for pp=1:np
        if nest0(pp)==oo
            nestshare(pp,1)=share(pp)/nsharet(oo,1);
        end
    end
end
lambda=zeros(np,np);
for j=1:np
    for k=1:np
        if j==k
            lambda(j,k)=alpha/(1-rho)*share(j)*(1-(1-rho)*share(j)-rho*nestshare(j));
        elseif nest0(j)==nest0(k)
            lambda(j,k)=-alpha/(1-rho)*share(k)*((1-rho)*share(j)+rho*nestshare(j));
        else
            lambda(j,k)=-alpha*share(j)*share(k);
        end
    end
end
omegaf=zeros(np,np);
for j=1:np
    for k=1:np
        if Firms(j)==Firms(k)
            omegaf(j,k)=1;
        else
            omegaf(j,k)=0;
        end
    end
end
f=norm(share+omegaf.*lambda*(price-mc1));