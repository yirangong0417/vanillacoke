clear
cd
import delimited product
merge m:1 market_ids using mktsize // merge with market size data
drop _merge
egen subtshare=sum(shares), by(market_ids) //total inside shares for each market
gen share0=1-subtshare //shares for the outside option
gen logshare = log(shares)-log(share0)
egen ntotal=sum(shares), by(nesting_ids market_ids) //total shares per nest
gen nestshare=shares/ntotal //within-nest shares
gen lnshare=log(nestshare)

ivreghdfe logshare (prices lnshare = demand_instruments1 demand_instruments2), absorb(market_ids) gmm2s cluster(market_ids)
boottest prices, cluster(market_ids)
boottest lnshare, cluster(market_ids)
predict yhat,xb
gen xi=logshare-yhat
gen alpha=_b[prices]
gen rho=_b[lnshare]
sort market_ids product_ids
keep market_ids product_ids firm_ids nesting_ids prices shares nestshare xi alpha rho mktsize
export delimited nlestimates, replace