* ################################################################################################################################ PREPARING DATABASES ##########################
* ################################################################################################################################ PREPARING DATABASES ##########################
* ################################################################################################################################ PREPARING DATABASES ##########################
* ################################################################################################################################ PREPARING DATABASES ##########################
* ################################################################################################################################ PREPARING DATABASES ##########################
clear
use consolidada_econometria

keep if inlist(ano_base, 2004, 2008, 2012, 2016)

compress

keep ano_base codigo_ibge margem_vit pop_dec_tot perc_pop_rural perc_mul_rural perc_mul pop_est_anual pib_per_capita homic_1529_pcmh homic_tot_pcmh bolsa_fam_anual gini_dec perc_pop_agua perc_pop_pobreza mort_inf_pcmh perc_analf perc_idosos  d_pref_coligacao reeleito idade_pref ocupacao_pref d_masculino d_full_degree_pref d_full_school_pref d_fund_pref d_casamento_pref d_cor_preta d_cor_parda d_cor_amarela d_cor_indigena d_cor_branca d_dir_esq d_dir_ctr d_esq_ctr

drop if d_dir_esq == 0 & d_dir_ctr == 0 & d_esq_ctr == 0  // removing robustness-only tests

compress

*save bases_balanceamento, replace

collapse  (max) pop_dec_tot perc_pop_rural perc_mul_rural perc_mul pop_est_anual pib_per_capita homic_1529_pcmh homic_tot_pcmh bolsa_fam_anual gini_dec perc_pop_agua perc_pop_pobreza mort_inf_pcmh perc_analf perc_idosos  d_pref_coligacao reeleito idade_pref ocupacao_pref d_masculino d_full_degree_pref d_full_school_pref d_fund_pref d_casamento_pref d_cor_preta d_cor_parda d_cor_amarela d_cor_indigena d_cor_branca d_dir_esq d_dir_ctr d_esq_ctr , by (ano_base codigo_ibge margem_vit)

compress

capture drop venc_dir venc_esq venc_ctr
gen byte venc_dir = 0
gen byte venc_esq = 0
gen byte venc_ctr = 0

replace venc_dir = 1 if (d_dir_esq == 1 & margem_vit > 0) | (d_dir_ctr == 1 & margem_vit > 0) // right wing leader
replace venc_esq = 1 if (d_dir_esq == 1 & margem_vit < 0) | (d_esq_ctr == 1 & margem_vit > 0) // left wing leader
replace venc_ctr = 1 if (d_dir_ctr == 1 & margem_vit < 0) | (d_esq_ctr == 1 & margem_vit < 0) // center wing leader

save bases_balanceamento_short, replace
*capture erase bases_balanceamento.dta

* ################################################################################################################ CHECKING FOR ELECTORAL MANIPULATION #######################################

capture log close
log using Manipulacao.log, replace

qui rddensity margem_vit, all plot graph_opt(ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)) )
graph save manipulation.gph, replace
capture graph close
graph combine manipulation.gph, graphregion(color(white)) plotregion(color(white)) title("Figure B1 - Election Manipulation - All Elections and Wings", size(medium))  rows(1)
graph save manipulation.gph, replace
capture graph close

qui rddensity margem_vit if d_dir_esq == 1, all plot graph_opt(title("Right vs Left-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save a1.gph, replace
capture graph close
qui rddensity margem_vit if d_esq_ctr == 1, all plot graph_opt(title("Left vs Center-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save b1.gph, replace
capture graph close
qui rddensity margem_vit if d_dir_ctr == 1, all plot graph_opt(title("Right vs Center-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save c1.gph, replace
capture graph close
graph combine a1.gph b1.gph c1.gph, graphregion(color(white)) plotregion(color(white)) title("Figure B2 - Election Manipulation - All Elections", size(medium))  rows(3)
graph save allelections.gph, replace
capture graph close
capture erase a1.gph
capture erase b1.gph
capture erase c1.gph

qui rddensity margem_vit if d_dir_esq == 1 & ano_base == 2004, all plot graph_opt(title("Right vs Left-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save a2.gph, replace
capture graph close
qui rddensity margem_vit if d_esq_ctr == 1 & ano_base == 2004, all plot graph_opt(title("Left vs Center-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save b2.gph, replace
capture graph close
qui rddensity margem_vit if d_dir_ctr == 1 & ano_base == 2004, all plot graph_opt(title("Right vs Center-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save c2.gph, replace
capture graph close
graph combine a2.gph b2.gph c2.gph, graphregion(color(white)) plotregion(color(white)) title("Figure B3 - Election Manipulation - 2004 Election", size(medium))  rows(1)
graph save 2004.gph, replace
capture graph close
capture erase a2.gph
capture erase b2.gph
capture erase c2.gph

qui rddensity margem_vit if d_dir_esq == 1 & ano_base == 2008, all plot graph_opt(title("Right vs Left-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save a3.gph, replace
capture graph close
qui rddensity margem_vit if d_esq_ctr == 1 & ano_base == 2008, all plot graph_opt(title("Left vs Center-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save b3.gph, replace
capture graph close
qui rddensity margem_vit if d_dir_ctr == 1 & ano_base == 2008, all plot graph_opt(title("Right vs Center-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save c3.gph, replace
capture graph close
graph combine a3.gph b3.gph c3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure B4 - Election Manipulation - 2008 Election", size(medium))  rows(1)
graph save 2008.gph, replace
capture graph close
capture erase a3.gph
capture erase b3.gph
capture erase c3.gph

qui rddensity margem_vit if d_dir_esq == 1 & ano_base == 2012, all plot graph_opt(title("Right vs Left-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save a4.gph, replace
capture graph close
qui rddensity margem_vit if d_esq_ctr == 1 & ano_base == 2012, all plot graph_opt(title("Left vs Center-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save b4.gph, replace
capture graph close
qui rddensity margem_vit if d_dir_ctr == 1 & ano_base == 2012, all plot graph_opt(title("Right vs Center-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save c4.gph, replace
capture graph close
graph combine a4.gph b4.gph c4.gph, graphregion(color(white)) plotregion(color(white)) title("Figure B5 - Election Manipulation - 2012 Election", size(medium))  rows(1)
graph save 2012.gph, replace
capture graph close
capture erase a4.gph
capture erase b4.gph
capture erase c4.gph

qui rddensity margem_vit if d_dir_esq == 1 & ano_base == 2016, all plot graph_opt(title("Right vs Left-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save a5.gph, replace
capture graph close
qui rddensity margem_vit if d_esq_ctr == 1 & ano_base == 2016, all plot graph_opt(title("Left vs Center-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save b5.gph, replace
capture graph close
qui rddensity margem_vit if d_dir_ctr == 1 & ano_base == 2016, all plot graph_opt(title("Right vs Center-Wing Dispute") ytitle(Frequency, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white)))
graph save c5.gph, replace
capture graph close
graph combine a5.gph b5.gph c5.gph, graphregion(color(white)) plotregion(color(white)) title("Figure B6 - Election Manipulation - 2016 Election", size(medium))  rows(1)
graph save 2016.gph, replace
capture graph close
capture erase a5.gph
capture erase b5.gph
capture erase c5.gph

capture log close

* ################################################################################################################ MCCRARY TEST ##########################################################
* ################################################################################################################ MCCRARY TEST ##########################################################
* ################################################################################################################ MCCRARY TEST ##########################################################
* ################################################################################################################ MCCRARY TEST ##########################################################

clear
use bases_balanceamento_short

qui twoway (hist margem_vit, frequency width(0.02) legend(lab(1 "bin=2%")) fcolor(olive) xlabel(-0.6(0.1)0.6) fcolor(olive))(hist margem_vit, frequency width(0.01) legend(lab(2 "bin=1%")) fcolor(olive_teal) xlabel(-0.6(0.1)0.6) xline(0) lcolor(olive_teal) fcolor(olive_teal)) (hist margem_vit, frequency width(0.005) lcolor(navy) legend(lab(3 "bin=0.5%")) fcolor(navy) xlabel(-0.6(0.1)0.6) fcolor(navy) xtitle("Margin of Victory in Percentage", size (small)) graphregion(color(white)) ytitle("Frequency") plotregion(ilcolor(white)))  
graph save mct1.gph, replace
qui DCdensity margem_vit, breakpoint(0) generate (X2 Y2 ro fhat se_fhat)
graph save mct2.gph, replace
graph combine mct1.gph mct2.gph, graphregion(color(white)) plotregion(color(white)) title("Figure A1: McCrary Test - All Elections", size(medium))  rows(1)
graph save mccrary1.gph, replace
capture drop X2 Y2 ro fhat se_fhat
capture erase mct1.gph 
capture erase mct2.gph

qui twoway (hist margem_vit if ano_base == 2004, frequency width(0.02) legend(lab(1 "bin=2%")) fcolor(olive) xlabel(-0.6(0.1)0.6) fcolor(olive))(hist margem_vit, frequency width(0.01) legend(lab(2 "bin=1%")) fcolor(olive_teal) xlabel(-0.6(0.1)0.6) xline(0) lcolor(olive_teal) fcolor(olive_teal)) (hist margem_vit if ano_base == 2004, frequency width(0.005) lcolor(navy) legend(lab(3 "bin=0.5%")) fcolor(navy) xlabel(-0.6(0.1)0.6) fcolor(navy) xtitle("Margin of Victory in Percentage", size (small)) graphregion(color(white)) ytitle("Frequency") plotregion(ilcolor(white)))  
graph save mct3.gph, replace
qui DCdensity margem_vit if ano_base == 2004, breakpoint(0) generate (X2 Y2 ro fhat se_fhat)
graph save mct4.gph, replace
graph combine mct3.gph mct4.gph, graphregion(color(white)) plotregion(color(white)) title("Figure A2: McCrary Test - 2004 Election", size(medium))  rows(1) 
graph save mc2004.gph, replace
capture drop X2 Y2 ro fhat se_fhat
capture erase mct3.gph 
capture erase mct4.gph

qui twoway (hist margem_vit if ano_base == 2008, frequency width(0.02) legend(lab(1 "bin=2%")) fcolor(olive) xlabel(-0.6(0.1)0.6) fcolor(olive))(hist margem_vit, frequency width(0.01) legend(lab(2 "bin=1%")) fcolor(olive_teal) xlabel(-0.6(0.1)0.6) xline(0) lcolor(olive_teal) fcolor(olive_teal)) (hist margem_vit if ano_base == 2008, frequency width(0.005) lcolor(navy) legend(lab(3 "bin=0.5%")) fcolor(navy) xlabel(-0.6(0.1)0.6) fcolor(navy) xtitle("Margin of Victory in Percentage", size (small)) graphregion(color(white)) ytitle("Frequency") plotregion(ilcolor(white)))  
graph save mct5.gph, replace
qui DCdensity margem_vit if ano_base == 2008, breakpoint(0) generate (X2 Y2 ro fhat se_fhat)
graph save mct6.gph, replace
graph combine mct5.gph mct6.gph, graphregion(color(white)) plotregion(color(white)) title("Figure A3: McCrary Test - 2008 Election", size(medium))  rows(1) 
graph save mc2008.gph, replace
capture drop X2 Y2 ro fhat se_fhat
capture erase mct5.gph 
capture erase mct6.gph

qui twoway (hist margem_vit if ano_base == 2012, frequency width(0.02) legend(lab(1 "bin=2%")) fcolor(olive) xlabel(-0.6(0.1)0.6) fcolor(olive))(hist margem_vit, frequency width(0.01) legend(lab(2 "bin=1%")) fcolor(olive_teal) xlabel(-0.6(0.1)0.6) xline(0) lcolor(olive_teal) fcolor(olive_teal)) (hist margem_vit if ano_base == 2012, frequency width(0.005) lcolor(navy) legend(lab(3 "bin=0.5%")) fcolor(navy) xlabel(-0.6(0.1)0.6) fcolor(navy) xtitle("Margin of Victory in Percentage", size (small)) graphregion(color(white)) ytitle("Frequency") plotregion(ilcolor(white)))  
graph save mct7.gph, replace
qui DCdensity margem_vit if ano_base == 2012, breakpoint(0) generate (X2 Y2 ro fhat se_fhat)
graph save mct8.gph, replace
graph combine mct7.gph mct8.gph, graphregion(color(white)) plotregion(color(white)) title("Figure A4: McCrary Test - 2012 Election", size(medium))  rows(1)
graph save mc2012.gph, replace
capture drop X2 Y2 ro fhat se_fhat
capture erase mct7.gph 
capture erase mct8.gph

qui twoway (hist margem_vit if ano_base == 2016, frequency width(0.02) legend(lab(1 "bin=2%")) fcolor(olive) xlabel(-0.6(0.1)0.6) fcolor(olive))(hist margem_vit, frequency width(0.01) legend(lab(2 "bin=1%")) fcolor(olive_teal) xlabel(-0.6(0.1)0.6) xline(0) lcolor(olive_teal) fcolor(olive_teal)) (hist margem_vit if ano_base == 2016, frequency width(0.005) lcolor(navy) legend(lab(3 "bin=0.5%")) fcolor(navy) xlabel(-0.6(0.1)0.6) fcolor(navy) xtitle("Margin of Victory in Percentage", size (small)) graphregion(color(white))  ytitle("Frequency") plotregion(ilcolor(white)))  
graph save mct9.gph, replace
qui DCdensity margem_vit if ano_base == 2016, breakpoint(0) generate (X2 Y2 ro fhat se_fhat)
graph save mct10.gph, replace
graph combine mct9.gph mct10.gph, graphregion(color(white)) plotregion(color(white)) title("Figure A5: McCrary Test - 2016 Election", size(medium))  rows(1)
graph save mc2016.gph, replace
capture drop X2 Y2 ro fhat se_fhat
capture erase mct9.gph 
capture erase mct10.gph


* ################################################################################################################################ OTHER GRAPHS ##################################################
* ################################################################################################################################ OTHER GRAPHS ##################################################
* ################################################################################################################################ OTHER GRAPHS ##################################################
* ################################################################################################################################ OTHER GRAPHS ##################################################
* ################################################################################################################################ OTHER GRAPHS ##################################################


* Figure 1 - Main Effect Found

clear
use filiou_desfiliou_tratada

capture graph close		
qui rdplot disp_de_d_fil margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1 & doisanos_eleicoes==1,  all ci(90) p(4) graph_options(title("Right-Wing versus Left-Wing Disputes (Regardless the Winner) - Two First Years") ytitle(Percentage of Right-Wing Affiliations, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save f1.gph, replace 

capture graph close	
graph combine f1.gph, graphregion(color(white)) plotregion(color(white)) title("Figure 1 - Effect of Right-wing (mayor) leader on right-wing affiliation", size(medium))  rows(1)
graph save figure1.gph, replace
capture graph close		


* Other Appendix Figures

clear
use bases_balanceamento_short

qui rdplot d_pref_coligacao margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot d_pref_coligacao margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot d_pref_coligacao margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C1 - Election Manipulation - Coligation", size(medium))  rows(3)
graph save d_pref_coligacao.gph, replace
capture graph close		

qui rdplot idade_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot idade_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot idade_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C2 - Election Manipulation - Candidate Age", size(medium))  rows(3)
graph save idade_pref.gph, replace
capture graph close

qui rdplot ocupacao_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot ocupacao_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot ocupacao_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C3 - Election Manipulation - Candidate Occupation Code", size(medium))  rows(3)
graph save ocupacao_pref.gph, replace
capture graph close

qui rdplot d_masculino margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot d_masculino margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot d_masculino margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C4 - Election Manipulation - Male Candidate", size(medium))  rows(3)
graph save d_masculino.gph, replace
capture graph close

qui rdplot d_full_degree_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot d_full_degree_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot d_full_degree_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C5 - Election Manipulation - Candidate Education - College", size(medium))  rows(3)
graph save d_full_degree_pref.gph, replace
capture graph close

qui rdplot d_full_school_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot d_full_school_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot d_full_school_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C6 - Election Manipulation - Candidate Education - High School", size(medium))  rows(3)
graph save d_full_school_pref.gph, replace
capture graph close

qui rdplot d_fund_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot d_fund_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot d_fund_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C7 - Election Manipulation - Candidate Education - Elementary School", size(medium))  rows(3)
graph save d_fund_pref.gph, replace
capture graph close

qui rdplot d_casamento_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot d_casamento_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot d_casamento_pref margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C8 - Election Manipulation - Married Candidate", size(medium))  rows(3)
graph save d_casamento_pref.gph, replace
capture graph close

qui rdplot d_cor_preta margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot d_cor_preta margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot d_cor_preta margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C9 - Election Manipulation - Black Candidate (2016 election only)", size(medium))  rows(3)
graph save d_cor_preta.gph, replace
capture graph close

qui rdplot d_cor_parda margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot d_cor_parda margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot d_cor_parda margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C10 - Election Manipulation - Brown Candidate (2016 election only)", size(medium))  rows(3)
graph save d_cor_parda.gph, replace
capture graph close	

qui rdplot d_cor_amarela margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot d_cor_amarela margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot d_cor_amarela margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C11 - Election Manipulation - Yellow Candidate (2016 election only)", size(medium))  rows(3)
graph save d_cor_amarela.gph, replace
capture graph close		

qui rdplot d_cor_indigena margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot d_cor_indigena margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot d_cor_indigena margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C12 - Election Manipulation - Indigenous Candidate (2016 election only)", size(medium))  rows(3)
graph save d_cor_indigena.gph, replace
capture graph close		

qui rdplot d_cor_branca margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot d_cor_branca margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot d_cor_branca margem_vit if ano_base == 2016 & margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C13 - Election Manipulation - White Candidate (2016 election only)", size(medium))  rows(3)
graph save d_cor_branca.gph, replace
capture graph close

qui rdplot perc_pop_rural margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot perc_pop_rural margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot perc_pop_rural margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C14 - Election Manipulation - Percentage of People in Rural Areas", size(medium))  rows(3)
graph save perc_pop_rural.gph, replace
capture graph close

qui rdplot perc_mul margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot perc_mul margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot perc_mul margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C15 - Election Manipulation - Percentage of Women", size(medium))  rows(3)
graph save perc_mul.gph, replace
capture graph close

qui rdplot perc_mul_rural margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot perc_mul_rural margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot perc_mul_rural margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C16 - Election Manipulation - Percentage of Women in Rural Areas", size(medium))  rows(3)
graph save perc_mul_rural.gph, replace
capture graph close

qui rdplot pib_per_capita margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot pib_per_capita margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot pib_per_capita margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C17 - Election Manipulation - GDP per capita", size(medium))  rows(3)
graph save pib_per_capita.gph, replace
capture graph close			

qui rdplot gini_dec margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Rate, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot gini_dec margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Rate, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot gini_dec margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Rate, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C18 - Election Manipulation - Gini Index", size(medium))  rows(3)
graph save gini_dec.gph, replace
capture graph close	

qui rdplot bolsa_fam_anual margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot bolsa_fam_anual margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot bolsa_fam_anual margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Value, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C19 - Election Manipulation - Bolsa Familia Beneficiaries", size(medium))  rows(3)
graph save bolsa_fam_anual.gph, replace
capture graph close	

qui rdplot perc_pop_agua margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot perc_pop_agua margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot perc_pop_agua margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C20 - Election Manipulation - Percentage of People with Access to Water", size(medium))  rows(3)
graph save perc_pop_agua.gph, replace
capture graph close

qui rdplot homic_1529_pcmh margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Rate per 100k inhabitants, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot homic_1529_pcmh margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Rate per 100k inhabitants, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot homic_1529_pcmh margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Rate per 100k inhabitants, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C21 - Election Manipulation - Murders of People from 15 to 29 years old", size(medium))  rows(3)
graph save homic_1529_pcmh.gph, replace
capture graph close

qui rdplot homic_tot_pcmh margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Rate per 100k inhabitants, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot homic_tot_pcmh margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Rate per 100k inhabitants, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot homic_tot_pcmh margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Rate per 100k inhabitants, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C22 - Election Manipulation - Murders", size(medium))  rows(3)
graph save homic_tot_pcmh.gph, replace
capture graph close

qui rdplot perc_pop_pobreza margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot perc_pop_pobreza margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot perc_pop_pobreza margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C23 - Election Manipulation - Percentage of People in Poverty", size(medium))  rows(3)
graph save perc_pop_pobreza.gph, replace
capture graph close

qui rdplot mort_inf_pcmh margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Rate per 100k inhabitants, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot mort_inf_pcmh margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Rate per 100k inhabitants, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot mort_inf_pcmh margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Rate per 100k inhabitants, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C24 - Election Manipulation - Child Mortality", size(medium))  rows(3)
graph save mort_inf_pcmh.gph, replace
capture graph close

qui rdplot perc_analf margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot perc_analf margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot perc_analf margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C25 - Election Manipulation - Percentage of Illiterates", size(medium))  rows(3)
graph save perc_analf.gph, replace
capture graph close

qui rdplot perc_idosos margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_esq==1,  all ci(90) p(4) graph_options(title("Right vs Left-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa1.gph, replace 
qui rdplot perc_idosos margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_esq_ctr==1,  all ci(90) p(4) graph_options(title("Left vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa2.gph, replace 
qui rdplot perc_idosos margem_vit if margem_vit>-0.1 & margem_vit<0.1 & d_dir_ctr==1,  all ci(90) p(4) graph_options(title("Right vs Center-Wing Dispute") ytitle(Percentage, size (vsmall)) xtitle(Margin of victory, size (vsmall)) legend(off) graphregion(color(white))) graphregion(color(white))
graph save aa3.gph, replace 
graph combine aa1.gph aa2.gph aa3.gph, graphregion(color(white)) plotregion(color(white)) title("Figure C26 - Election Manipulation - Percentage of Elderly", size(medium))  rows(3)
graph save perc_idosos.gph, replace
capture graph close

capture drop aa1.gph
capture drop aa2.gph
capture drop aa3.gph 
