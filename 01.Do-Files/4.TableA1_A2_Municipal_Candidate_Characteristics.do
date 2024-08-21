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

* ################################################################################################################ MUNICIPAL CHARACTERISTICS

capture log close
log using municipal_candidate_characteristics.log, replace

* MUNICIPAIS - DIR ESQ
rdrobust pop_dec_tot 		margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.101) b (0.162)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_rural 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.203) b (0.394)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_mul_rural 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.191) b (0.375)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_mul 		margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) 	p (1) all h (0.159) b (0.271)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust pib_per_capita	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) 	p (1) all h (0.161) b (0.287)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust homic_1529_pcmh 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.141) b (0.255)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust homic_tot_pcmh 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.148) b (0.251)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust bolsa_fam_anual 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.099) b (0.160)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust gini_dec 		margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) 	p (1) all h (0.145) b (0.253)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_agua 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) 	p (1) all h (0.192) b (0.337)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_pobreza margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) 	p (1) all h (0.169) b (0.284)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust mort_inf_pcmh  	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.111) b (0.240)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_analf 		margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.153) b (0.269)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_idosos		margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.155) b (0.265)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 

* MUNICIPAIS - ESQ CTR
rdrobust pop_dec_tot 		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.093) b (0.143) 
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_rural 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.141) b (0.260)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_mul_rural 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.137) b (0.255)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_mul 		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.177) b (0.301)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust pib_per_capita	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.104) b (0.202)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust homic_1529_pcmh 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.189) b (0.345)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust homic_tot_pcmh 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.166) b (0.288)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust bolsa_fam_anual 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.097) b (0.168)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust gini_dec 		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.163) b (0.267)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_agua 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.151) b (0.260)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_pobreza margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.117) b (0.233)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust mort_inf_pcmh  	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.220) b (0.397)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_analf 		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.148) b (0.252)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_idosos		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.184) b (0.326)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 

* MUNICIPAIS - DIR CTR
rdrobust pop_dec_tot 		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.089) b (0.177)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_rural 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.136) b (0.254)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_mul_rural 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.144) b (0.289)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_mul 		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.119) b (0.197)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust pib_per_capita	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.126) b (0.240)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust homic_1529_pcmh 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.165) b (0.288)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust homic_tot_pcmh 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.185) b (0.348)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust bolsa_fam_anual 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.110) b (0.211)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust gini_dec 		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.157) b (0.269)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_agua 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.140) b (0.237)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_pobreza margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.164) b (0.293)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust mort_inf_pcmh  	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.142) b (0.262)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_analf 		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.141) b (0.249)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_idosos		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.128) b (0.210)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 

capture log close

* ################################################################################################################ CANDIDATE CHARACTERISTICS

* CANDIDATOS - DIR ESQ
rdrobust idade_pref 			margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.177) b (0.303)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_pref_coligacao 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) 	 p (1) all h (0.153) b (0.249)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_masculino 			margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.123) b (0.234)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_full_degree_pref 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.189) b (0.330)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_full_school_pref 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.160) b (0.275)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_fund_pref 			margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.143) b (0.243)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_casamento_pref 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) 	 p (1) all h (0.173) b (0.299)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_preta 			margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.211) b (0.403)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_parda 			margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.141) b (0.235)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_amarela 		margem_vit if d_dir_esq==1, vce (cluster codigo_ibge)  	 p (1) all h (0.064) b (0.178)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_indigena 		margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.000) b (1.000)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_branca			margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.193) b (0.338)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 

* CANDIDATOS - ESQ CTR
rdrobust idade_pref 			margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.169) b (0.295)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_pref_coligacao 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	 p (1) all h (0.156) b (0.268)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_masculino 			margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.190) b (0.339)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_full_degree_pref 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.159) b (0.263)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_full_school_pref 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.146) b (0.240)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_fund_pref 			margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.180) b (0.309)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_casamento_pref 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	 p (1) all h (0.141) b (0.233)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_preta 			margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.195) b (0.323)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_parda 			margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.161) b (0.286)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_amarela 		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge)  	 p (1) all h (0.104) b (0.235)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_indigena 		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.000) b (1.000)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_branca			margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.195) b (0.355)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 

* CANDIDATOS - DIR CTR
rdrobust idade_pref 			margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.164) b (0.232)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_pref_coligacao 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	 p (1) all h (0.128) b (0.238)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_masculino 			margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.155) b (0.286)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_full_degree_pref 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.151) b (0.291)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_full_school_pref 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.128) b (0.242)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_fund_pref 			margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.171) b (0.305)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_casamento_pref 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	 p (1) all h (0.143) b (0.253)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_preta 			margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.150) b (0.267)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_parda 			margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.100) b (0.205)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_amarela 		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge)  	 p (1) all h (0.037) b (0.109)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_indigena 		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (1.000) b (1.000)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_branca			margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.146) b (0.268)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 

capture log close