function f=mcnl(Firms,Share,Nestshare,Nest,Price)
%This function calculates the marginal costs.
global alpha rho
n=length(Firms);
%Omega matrix
omegaf=zeros(n,n);
for j=1:n
    for k=1:n
        if Firms(j)==Firms(k)
            omegaf(j,k)=1;
        else
            omegaf(j,k)=0;
        end
    end
end
%Lambda matrix
lambda=zeros(n,n);
for j=1:n
    for k=1:n
        if j==k
            lambda(j,k)=alpha/(1-rho)*Share(j)*(1-(1-rho)*Share(j)-rho*Nestshare(j));
        elseif Nest(j)==Nest(k)
            lambda(j,k)=-alpha/(1-rho)*Share(k)*((1-rho)*Share(j)+rho*Nestshare(j));
        else
            lambda(j,k)=-alpha*Share(j)*Share(k);
        end
    end
end
%MC
f={(Price+(omegaf.*lambda)\Share)};