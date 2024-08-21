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

* ############################################################################################################################################################# DESCRIPTIVE STATISTICS #######
* ############################################################################################################################################################# DESCRIPTIVE STATISTICS #######
* ############################################################################################################################################################# DESCRIPTIVE STATISTICS #######
* ############################################################################################################################################################# DESCRIPTIVE STATISTICS #######
* ############################################################################################################################################################# DESCRIPTIVE STATISTICS #######

capture log close 
log using descriptive_statistics.log, replace


* Summaries

sum d_filiou				if (venc_dir == 1) // right wing leader
sum d_filiou				if (venc_esq == 1) // left wing leader
sum d_filiou				if (venc_ctr == 1) // center wing leader
sum d_desfiliou				if (venc_dir == 1)
sum d_desfiliou				if (venc_esq == 1)
sum d_desfiliou				if (venc_ctr == 1)
sum d_fil_direita			if (venc_dir == 1)
sum d_fil_direita			if (venc_esq == 1)
sum d_fil_direita			if (venc_ctr == 1)
sum d_fil_centro			if (venc_dir == 1)
sum d_fil_centro			if (venc_esq == 1)
sum d_fil_centro			if (venc_ctr == 1)
sum d_fil_esquerda			if (venc_dir == 1)
sum d_fil_esquerda			if (venc_esq == 1)
sum d_fil_esquerda			if (venc_ctr == 1)

**********************************************

sum d_pref_coligacao		if (venc_dir == 1)
sum d_pref_coligacao		if (venc_esq == 1)
sum d_pref_coligacao		if (venc_ctr == 1)
sum reeleito				if (venc_dir == 1)
sum reeleito				if (venc_esq == 1)
sum reeleito				if (venc_ctr == 1)
sum idade_pref				if (venc_dir == 1)
sum idade_pref				if (venc_esq == 1)
sum idade_pref				if (venc_ctr == 1)
sum ocupacao_pref			if (venc_dir == 1)
sum ocupacao_pref			if (venc_esq == 1)
sum ocupacao_pref			if (venc_ctr == 1)
sum d_masculino				if (venc_dir == 1)
sum d_masculino				if (venc_esq == 1)
sum d_masculino				if (venc_ctr == 1)
sum d_full_degree_pref		if (venc_dir == 1)
sum d_full_degree_pref		if (venc_esq == 1)
sum d_full_degree_pref		if (venc_ctr == 1)
sum d_full_school_pref		if (venc_dir == 1)
sum d_full_school_pref		if (venc_esq == 1)
sum d_full_school_pref		if (venc_ctr == 1)
sum d_fund_pref				if (venc_dir == 1)
sum d_fund_pref				if (venc_esq == 1)
sum d_fund_pref				if (venc_ctr == 1)
sum d_casamento_pref		if (venc_dir == 1)
sum d_casamento_pref		if (venc_esq == 1)
sum d_casamento_pref		if (venc_ctr == 1)
sum d_cor_preta				if (venc_dir == 1)
sum d_cor_preta				if (venc_esq == 1)
sum d_cor_preta				if (venc_ctr == 1)
sum d_cor_parda				if (venc_dir == 1)
sum d_cor_parda				if (venc_esq == 1)
sum d_cor_parda				if (venc_ctr == 1)
sum d_cor_amarela			if (venc_dir == 1)
sum d_cor_amarela			if (venc_esq == 1)
sum d_cor_amarela			if (venc_ctr == 1)
sum d_cor_indigena			if (venc_dir == 1)
sum d_cor_indigena			if (venc_esq == 1)
sum d_cor_indigena			if (venc_ctr == 1)
sum d_cor_branca			if (venc_dir == 1)
sum d_cor_branca			if (venc_esq == 1)
sum d_cor_branca			if (venc_ctr == 1)
sum pop_dec_tot				if (venc_dir == 1)
sum pop_dec_tot				if (venc_esq == 1)
sum pop_dec_tot				if (venc_ctr == 1)
sum perc_pop_rural			if (venc_dir == 1)
sum perc_pop_rural			if (venc_esq == 1)
sum perc_pop_rural			if (venc_ctr == 1)
sum perc_mul				if (venc_dir == 1)
sum perc_mul				if (venc_esq == 1)
sum perc_mul				if (venc_ctr == 1)
sum perc_mul_rural			if (venc_dir == 1)
sum perc_mul_rural			if (venc_esq == 1)
sum perc_mul_rural			if (venc_ctr == 1)
sum pib_per_capita			if (venc_dir == 1)
sum pib_per_capita			if (venc_esq == 1)
sum pib_per_capita			if (venc_ctr == 1)
sum gini_dec				if (venc_dir == 1)
sum gini_dec				if (venc_esq == 1)
sum gini_dec				if (venc_ctr == 1)
sum bolsa_fam_anual			if (venc_dir == 1)
sum bolsa_fam_anual			if (venc_esq == 1)
sum bolsa_fam_anual			if (venc_ctr == 1)
sum perc_pop_agua			if (venc_dir == 1)
sum perc_pop_agua			if (venc_esq == 1)
sum perc_pop_agua			if (venc_ctr == 1)
sum homic_1529_pcmh			if (venc_dir == 1)
sum homic_1529_pcmh			if (venc_esq == 1)
sum homic_1529_pcmh			if (venc_ctr == 1)
sum homic_tot_pcmh			if (venc_dir == 1)
sum homic_tot_pcmh			if (venc_esq == 1)
sum homic_tot_pcmh			if (venc_ctr == 1)
sum perc_pop_pobreza		if (venc_dir == 1)
sum perc_pop_pobreza		if (venc_esq == 1)
sum perc_pop_pobreza		if (venc_ctr == 1)
sum mort_inf_pcmh			if (venc_dir == 1)
sum mort_inf_pcmh			if (venc_esq == 1)
sum mort_inf_pcmh			if (venc_ctr == 1)
sum perc_analf				if (venc_dir == 1)	
sum perc_analf				if (venc_esq == 1)	
sum perc_analf				if (venc_ctr == 1)	
sum perc_idosos				if (venc_dir == 1)	
sum perc_idosos				if (venc_esq == 1)	
sum perc_idosos				if (venc_ctr == 1)

capture log close
