
clear
use bases_balanceamento_short

* ################################################################################################################ MUNICIPAL CHARACTERISTICS

capture log close
log using municipal_candidate_characteristics.log, replace

* MUNICIPAIS - DIR ESQ
rdrobust pop_dec_tot 		margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.103) b (0.162)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_rural 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.166) b (0.335)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_mul_rural 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.153) b (0.304)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_mul 		margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) 	p (1) all h (0.160) b (0.271)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust pib_per_capita	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) 	p (1) all h (0.155) b (0.278)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust homic_1529_pcmh 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.139) b (0.249)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust homic_tot_pcmh 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.146) b (0.248)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust bolsa_fam_anual 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.099) b (0.158)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust gini_dec 		margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) 	p (1) all h (0.147) b (0.253)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_agua 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) 	p (1) all h (0.193) b (0.337)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_pobreza margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) 	p (1) all h (0.167) b (0.278)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust mort_inf_pcmh  	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.112) b (0.238)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_analf 		margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.152) b (0.268)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_idosos		margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.153) b (0.261)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 

* MUNICIPAIS - ESQ CTR
rdrobust pop_dec_tot 		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.093) b (0.143) 
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_rural 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.139) b (0.259)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_mul_rural 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.136) b (0.253)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_mul 		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.178) b (0.298)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust pib_per_capita	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.103) b (0.201)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust homic_1529_pcmh 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.188) b (0.341)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust homic_tot_pcmh 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.164) b (0.284)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust bolsa_fam_anual 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.097) b (0.167)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust gini_dec 		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.161) b (0.260)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_agua 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.180) b (0.303)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_pobreza margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.116) b (0.232)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust mort_inf_pcmh  	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.191) b (0.325)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_analf 		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.147) b (0.250)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_idosos		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.186) b (0.331)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 

* MUNICIPAIS - DIR CTR
rdrobust pop_dec_tot 		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.093) b (0.185)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_rural 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.136) b (0.259)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_mul_rural 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.132) b (0.244)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_mul 		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.121) b (0.199)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust pib_per_capita	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.127) b (0.236)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust homic_1529_pcmh 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.187) b (0.336)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust homic_tot_pcmh 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.200) b (0.386)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust bolsa_fam_anual 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.112) b (0.214)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust gini_dec 		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.165) b (0.281)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_agua 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.140) b (0.237)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_pop_pobreza margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	p (1) all h (0.164) b (0.287)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust mort_inf_pcmh  	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.142) b (0.273)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_analf 		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.137) b (0.241)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 
rdrobust perc_idosos		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.128) b (0.211)
outreg2 using TableBalanceMunicipal, excel label append nonotes title("Table Municipal Balance: Balance test for municipal characteristics") 

capture log close

* ################################################################################################################ CANDIDATE CHARACTERISTICS

capture log close
log using candidate_characteristics.log, replace
* CANDIDATOS - DIR ESQ
rdrobust idade_pref 			margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.177) b (0.303)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_pref_coligacao 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) 	 p (1) all h (0.153) b (0.249)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_masculino 			margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.124) b (0.235)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_full_degree_pref 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.191) b (0.336)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_full_school_pref 	margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.160) b (0.276)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_fund_pref 			margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.142) b (0.244)
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
rdrobust d_cor_branca			margem_vit if d_dir_esq==1, vce (cluster codigo_ibge) p (1) all h (0.191) b (0.336)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 

* CANDIDATOS - ESQ CTR
rdrobust idade_pref 			margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.169) b (0.295)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_pref_coligacao 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	 p (1) all h (0.156) b (0.268)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_masculino 			margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.190) b (0.338)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_full_degree_pref 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.159) b (0.262)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_full_school_pref 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.146) b (0.239)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_fund_pref 			margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.183) b (0.315)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_casamento_pref 	margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) 	 p (1) all h (0.142) b (0.234)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_preta 			margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.195) b (0.323)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_parda 			margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.161) b (0.286)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_amarela 		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge)  	 p (1) all h (0.104) b (0.235)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_indigena 		margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.000) b (1.000)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_branca			margem_vit if d_esq_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.190) b (0.340)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 

* CANDIDATOS - DIR CTR
rdrobust idade_pref 			margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.164) b (0.286)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_pref_coligacao 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	 p (1) all h (0.127) b (0.238)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_masculino 			margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.168) b (0.333)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_full_degree_pref 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.155) b (0.300)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_full_school_pref 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.128) b (0.241)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_fund_pref 			margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.171) b (0.304)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_casamento_pref 	margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) 	 p (1) all h (0.147) b (0.260)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_preta 			margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.151) b (0.268)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_parda 			margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.100) b (0.206)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_amarela 		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge)  	 p (1) all h (0.037) b (0.109)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_indigena 		margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (1.000) b (1.000)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 
rdrobust d_cor_branca			margem_vit if d_dir_ctr==1, vce (cluster codigo_ibge) p (1) all h (0.146) b (0.269)
outreg2 using TableBalanceCandidate, excel label append nonotes title("Table Candidate Balance: Balance test for candidate characteristics") 

capture log close