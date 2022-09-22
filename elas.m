function f=elas(Price,Share,Nestshare,Nest)
%This function calculates the own-product price elasticities.
global alpha rho
np=length(Price);
lambda=zeros(np,np);
for j=1:np
    for k=1:np
        if j==k
            lambda(j,k)=alpha/(1-rho)*Share(j)*(1-(1-rho)*Share(j)-rho*Nestshare(j));
        elseif Nest(j)==Nest(k)
            lambda(j,k)=-alpha/(1-rho)*Share(k)*((1-rho)*Share(j)+rho*Nestshare(j));
        else
            lambda(j,k)=-alpha*Share(j)*Share(k);
        end
    end
end
elas=zeros(np,np);
for j=1:np
    for k=1:np
        elas(j,k)=lambda(j,k)*Price(k)/Share(j);
    end
end
ownelas=diag(elas);
f={ownelas};