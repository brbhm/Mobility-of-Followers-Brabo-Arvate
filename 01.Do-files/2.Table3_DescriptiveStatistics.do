* ############################################################################################################################################################# DESCRIPTIVE STATISTICS #######
* ############################################################################################################################################################# DESCRIPTIVE STATISTICS #######
* ############################################################################################################################################################# DESCRIPTIVE STATISTICS #######
* ############################################################################################################################################################# DESCRIPTIVE STATISTICS #######
* ############################################################################################################################################################# DESCRIPTIVE STATISTICS #######

capture log close 
log using descriptive_statistics.log, replace

* Summaries
clear
use base_descriptive_DVs

capture drop venc_dir venc_esq venc_ctr
gen byte venc_dir = 0
gen byte venc_esq = 0
gen byte venc_ctr = 0

replace venc_dir = 1 if (d_dir_esq == 1 & margem_vit > 0) | (d_dir_ctr == 1 & margem_vit > 0) // right wing leader
replace venc_esq = 1 if (d_dir_esq == 1 & margem_vit < 0) | (d_esq_ctr == 1 & margem_vit > 0) // left wing leader
replace venc_ctr = 1 if (d_dir_ctr == 1 & margem_vit < 0) | (d_esq_ctr == 1 & margem_vit < 0) // center wing leader

sum d_filiou				if (venc_dir == 1) // right wing leader
sum d_filiou				if (venc_esq == 1) // left wing leader
sum d_filiou				if (venc_ctr == 1) // center wing leader

sum d_filiou				if (d_fil_direita == 1 & venc_dir == 1)
sum d_filiou				if (d_fil_direita == 1 & venc_esq == 1)
sum d_filiou				if (d_fil_direita == 1 & venc_ctr == 1)
sum d_filiou				if (d_fil_esquerda == 1 & venc_dir == 1)
sum d_filiou				if (d_fil_esquerda == 1 & venc_esq == 1)
sum d_filiou				if (d_fil_esquerda == 1 & venc_ctr == 1)
sum d_filiou				if (d_fil_centro == 1 & venc_dir == 1)
sum d_filiou				if (d_fil_centro == 1 & venc_esq == 1)
sum d_filiou				if (d_fil_centro == 1 & venc_ctr == 1)

sum d_desfiliou				if (venc_dir == 1)
sum d_desfiliou				if (venc_esq == 1)
sum d_desfiliou				if (venc_ctr == 1)

sum d_desfiliou				if (d_fil_direita == 1 & venc_dir == 1)
sum d_desfiliou				if (d_fil_direita == 1 & venc_esq == 1)
sum d_desfiliou				if (d_fil_direita == 1 & venc_ctr == 1)
sum d_desfiliou				if (d_fil_esquerda == 1 & venc_dir == 1)
sum d_desfiliou				if (d_fil_esquerda == 1 & venc_esq == 1)
sum d_desfiliou				if (d_fil_esquerda == 1 & venc_ctr == 1)
sum d_desfiliou				if (d_fil_centro == 1 & venc_dir == 1)
sum d_desfiliou				if (d_fil_centro == 1 & venc_esq == 1)
sum d_desfiliou				if (d_fil_centro == 1 & venc_ctr == 1)

**********************************************

clear
use bases_balanceamento_short

sum d_pref_coligacao		if (venc_dir == 1)
sum d_pref_coligacao		if (venc_esq == 1)
sum d_pref_coligacao		if (venc_ctr == 1)
sum reeleito				if (venc_dir == 1)
sum reeleito				if (venc_esq == 1)
sum reeleito				if (venc_ctr == 1)
sum idade_pref				if (venc_dir == 1)
sum idade_pref				if (venc_esq == 1)
sum idade_pref				if (venc_ctr == 1)
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

* Generates the data for the heat map
keep ano_base	codigo_ibge	d_dir_esq	d_esq_ctr	d_dir_ctr
clear



capture log close
