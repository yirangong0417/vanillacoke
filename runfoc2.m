function f=runfoc2(price0,x0,mc0,nest0,Firms)
%This function calculates the equilibruim prices with the choice set where
%the new product is removed.
options = optimoptions('fsolve','Algorithm','levenberg-marquardt','FunctionTolerance',1e-8,'OptimalityTolerance',1e-8,'MaxFunctionEvaluations',500000,'MaxIterations',100000);
initialp=price0(1:end-1);
price2=fsolve(@(price) foc2(price,x0,mc0,nest0,Firms),initialp,options);
price2p=[price2;0];
f={price2p};
