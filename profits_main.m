%import nlestimates.csv as column vectors
global alpha beta rho
Gmarket = findgroups(market_ids);
alpha=alpha1(1);
beta=[1];
rho=rho(1);
X=[xi];
%Elasticity
oelastemp=splitapply(@elas,prices,shares,nestshare,nesting_ids,Gmarket);
oelas=cell2mat(oelastemp);
mdown=splitapply(@median,oelas,product_ids);
%Marginal costs
mctemp=splitapply(@mcnl,firm_ids,shares,nestshare,nesting_ids,prices,Gmarket);
mc=cell2mat(mctemp);
PCM=100*(1-mc./prices);
mdmc=splitapply(@median,mc,product_ids);%median mc
mdPCM=splitapply(@median,PCM,product_ids);%median markup
mdprice=splitapply(@median,prices,product_ids);%median price

%Test program
pricetemp=splitapply(@runfoc,prices,X,mc,nesting_ids,firm_ids,Gmarket);
pricetest=cell2mat(pricetemp);

%Counterfactual: remove the last product
price2temp=splitapply(@runfoc2,prices,X,mc,nesting_ids,firm_ids,Gmarket);
price2=cell2mat(price2temp);
Gproduct=findgroups(product_ids);
mdprice2=splitapply(@median,price2,Gproduct);%median simulated price
PCM2=100*(1-mc./price2);
mdPCM2=splitapply(@median,PCM2,Gproduct);%median simulated markup

%Producer profits
share2temp=splitapply(@sharenvc,price2,X,nesting_ids,Gmarket);%simulated shares
share2=cell2mat(share2temp);
profitB=(price2-mc).*share2;
profitA=(prices-mc).*shares;
PiB=profitB.*mktsize;
PiA=profitA.*mktsize;
Gfirm=findgroups(firm_ids);
sumPiB=splitapply(@sum,PiB,Gfirm);
sumPiA=splitapply(@sum,PiA,Gfirm);
sumfdPi2=sumPiA-sumPiB;%Firms' profit changes
sumPP2=sum(sumfdPi2);%total profit changes
%cannibalization
sumPiB_firm5=sumPiB(5);%firm 5's profit before the intro
sumPiA_firm5=sumPiA(5);%firm 5's profit after the intro
sumPiA_Product=splitapply(@sum,PiA,Gproduct);
sumPiA_newproduct=sumPiA_Product(end);%direct profit from the new product
sumPiA_Other=sumPiA_firm5-sumPiA_newproduct;
sumdPi_Other=sumPiA_Other-sumPiB_firm5;%cannibalization of other products from firm 5
save profits_results.mat