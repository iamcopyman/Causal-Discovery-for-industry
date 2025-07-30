cd C:\Users\20201\Desktop\RA\因果推断\Causal_Inference\4-CNIndustry\2-revise\
clear

import delimited "C:\Users\20201\Desktop\RA\因果推断\Causal_Inference\4-CNIndustry\2-revise\final_panel_data_with_factors_and_phase.csv"

*设置面板数据



encode pairid,gen(pair)
encode time_period, gen(time)

xtset pair time

encode phase, gen(phases)
encode source, gen(sources)
encode target, gen(targets)


gen log_pe_diff  = log(pe_diff)
gen log_dy_diff = log(dy_diff)
gen log_mv_diff = log(mv_diff)


save panel_data ,replace
use panel_data, clear


sum

*m1-1
logit connection i.phases i.sources i.targets density average_clustering, or
outreg2 using fundamental_business, replace tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m1-2
logit connection i.phases i.sources i.targets density average_clustering pe_diff, or
outreg2 using fundamental_business, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m1-3
logit connection i.phases i.sources i.targets density average_clustering pe_diff dy_diff, or
outreg2 using fundamental_business, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m1-4
logit connection i.phases i.sources i.targets density average_clustering pe_diff dy_diff mv_diff, or
outreg2 using fundamental_business, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m1-5
logit connection i.phases i.sources i.targets density average_clustering pe_diff dy_diff mv_diff alpha_diff, or
outreg2 using fundamental_business, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m1-6
logit connection i.phases i.sources i.targets density average_clustering pe_diff dy_diff mv_diff alpha_diff beta_diff, or
outreg2 using fundamental_business, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex


*m2-1
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff density average_clustering, or
outreg2 using fundamental_business, replace tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex
 
*m2-2
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff density average_clustering pe_diff, or
outreg2 using fundamental_business, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m2-3
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff density average_clustering pe_diff dy_diff, or
outreg2 using fundamental_business, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m2-4
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff density average_clustering pe_diff dy_diff mv_diff, or
outreg2 using fundamental_business, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m2-5
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff density average_clustering pe_diff dy_diff mv_diff alpha_diff, or
outreg2 using fundamental_business, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m2-6
logit connection i.phases out_degree_diff in_degree_diff i.phases##c.out_degree_diff i.phases##c.in_degree_diff density average_clustering pe_diff dy_diff mv_diff alpha_diff, or
outreg2 using fundamental_business, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex

*m2-7: with interaction
logit connection density average_clustering i.phases##c.out_degree_diff i.phases##c.in_degree_diff pe_diff dy_diff mv_diff alpha_diff beta_diff , or
outreg2 using fundamental_business, append tstat bdec(3) tdec(2) addstat("Pseudo R-squared", `e(r2_p)',"Log-Likelihood", e(ll),"LR $\chi^2$", e(chi2), "Prob < $\chi^2$", e(p)) eform cti(odds ratio) tex



