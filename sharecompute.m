function f=sharecompute(Price,X1,Nest)
%This function calculates the new shares under the new prices.
global beta alpha rho
np=length(Price);
delta=zeros(np,1);
for j=1:np
    delta(j,1)=X1(j,:)*beta+alpha*Price(j);
end
nnest=length(unique(Nest));
D=zeros(nnest,1);
for oo=1:nnest
    for pp=1:(np-1)
        if Nest(pp)==oo
            D(oo,1)=D(oo,1)+exp(delta(pp)/(1-rho));
        end
    end
end
totalD=1;
for oo=1:nnest
    totalD=totalD+D(oo,1)^(1-rho);
end
Share=zeros(np,1);
for pp=1:np
    Share(pp,1)=exp(delta(pp)/(1-rho))/(D(Nest(pp),1)^rho*totalD);
end
f={Share};

