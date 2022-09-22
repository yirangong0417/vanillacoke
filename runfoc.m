function f=runfoc(price0,x0,mc0,nesting_ids0,Firms)
%This function calculates the equilibruim prices with the observed choice
%set.
options = optimoptions('fsolve','Algorithm','levenberg-marquardt','FunctionTolerance',1e-8,'OptimalityTolerance',1e-8,'MaxFunctionEvaluations',500000,'MaxIterations',100000);
pricet=fsolve(@(price) foc(price,x0,mc0,nesting_ids0,Firms),price0,options);
f={pricet};
