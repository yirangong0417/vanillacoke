function f=runfocp(price0,x0,mc0,nest0,Firms)
%This function calculates the simulated prices under the counterfactural
%that rival firms change their prices to a given level.
options = optimoptions('fsolve','Algorithm','levenberg-marquardt','Display','off','MaxFunctionEvaluations',500000,'MaxIterations',100000);
pricet=fsolve(@(price) focp(price,x0,mc0,nest0,Firms),price0,options);
f={pricet};
