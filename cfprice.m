function f=cfprice(targetPi,delta0,a,b)
%This function calculates the required change in rival prices.
global mc firm_ids prices X nesting_ids Gmarket mktsize Gfirm sumPiB
error=1e-5;
c=a;
delta=delta0;
while abs(delta)>error
if delta<0
    a=c;
else
    b=c;
end
c=(a+b)/2;
ff=zeros(length(firm_ids),1);
for i=1:length(firm_ids)
    if firm_ids(i)~=firm_ids(end)
        ff(i,1)=c;
    else
        ff(i,1)=1;
    end
end
pricetemp=prices.*ff;
%cf: higher prices for rival brands
pricenewt=splitapply(@runfocp,pricetemp,X,mc,nesting_ids,firm_ids,Gmarket);
pricenew=cell2mat(pricenewt);
sharenewt=splitapply(@sharecompute,pricenew,X,nesting_ids,Gmarket);
sharenew=cell2mat(sharenewt);
profitAnew=(pricenew-mc).*sharenew;
PiAnew=profitAnew.*mktsize;
sumPiAnew=splitapply(@sum,PiAnew,Gfirm);
sumfdPi2new=sumPiAnew-sumPiB;
Firm5Pi=sumfdPi2new(end);
delta=Firm5Pi-targetPi;
fprintf('%.4f %.8f\n',[delta c]);
end
f=c;
end