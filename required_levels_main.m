clear
clear global
clc
load profits_results.mat
global beta alpha rho mc firm_ids prices X nesting_ids Gmarket mktsize Gfirm sumPiB
targetPi=200;%target profit change
obPi=sumfdPi2(end);%baseline profit change
delta0=obPi-targetPi;
a=1;
b=1.01;
dratio=cfprice(targetPi,delta0,a,b);%required change in rival prices
c=dratio;        
ff=zeros(length(firm_ids),1);
for i=1:length(firm_ids)
    if firm_ids(i)~=firm_ids(end)
        ff(i,1)=c;
    else
        ff(i,1)=1;
    end
end
pricetemp=prices.*ff;
%counterfactual: higher prices for rival brands
pricenewt=splitapply(@runfocp,pricetemp,X,mc,nesting_ids,firm_ids,Gmarket);
pricenew=cell2mat(pricenewt);%new prices after the change
sharenewt=splitapply(@sharecompute,pricenew,X,nesting_ids,Gmarket);
sharenew=cell2mat(sharenewt);%new shares after the change
profitAnew=(pricenew-mc).*sharenew;
PiAnew=profitAnew.*mktsize;
sumPiAnew=splitapply(@sum,PiAnew,Gfirm);
sumfdPi2new=sumPiAnew-sumPiB;%firms' profit changes under the new counterfactual
sumPiA_Productnew=splitapply(@sum,PiAnew,Gproduct);
sumPiA_newproductnew=sumPiA_Productnew(end);%direct profit from the new product under the new counterfactual
sumPiA_firm5new=sumPiAnew(end);
sumPiA_Othernew=sumPiA_firm5new-sumPiA_newproductnew;
sumdPi_Othernew=sumPiA_Othernew-sumPiB_firm5;%cannibalization of other products from firm 5 under the new counterfactual
save required_levels_results.mat