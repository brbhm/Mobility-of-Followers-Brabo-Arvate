* ################################################################################################################################ CONSOLIDATING DATABASES ##########################
* ################################################################################################################################ CONSOLIDATING DATABASES ##########################
* ################################################################################################################################ CONSOLIDATING DATABASES ##########################
* ################################################################################################################################ CONSOLIDATING DATABASES ##########################
* ################################################################################################################################ CONSOLIDATING DATABASES ##########################
			
			* First part
			clear
			use consolidada // This database consists in the panel data from each of the individuals that, in any given year, affiliated to a given political party

			keep if codigotse <= 54038
			merge m:1 ano_base codigotse using municipal_candidates, nogen keep(match) // This database contains the municipal and candidate characteristics, already filtering for the "eligible disputes", i.e., removing same-wing disputes for instance

			drop if unique_id_com_partido == .

			compress

			save temp1, replace

			* Second part
			clear
			use consolidada
			keep if codigotse > 54038

			merge m:1 ano_base codigotse using municipal_candidates, nogen keep(match)

			drop if unique_id_com_partido == .

			compress

			save temp2, replace


* Append both temporary bases

clear
use temp1

append using temp2, force

* Creating variables of wings

replace sigladopartido = "PcdoB" if sigladopartido == "PCDOB"

capture drop d_fil_direita
capture drop d_fil_centro
capture drop d_fil_esquerda

capture drop d_fil_direita_ROB
capture drop d_fil_centro_ROB
capture drop d_fil_esquerda_ROB

gen byte d_fil_direita = 0
gen byte d_fil_centro = 0
gen byte d_fil_esquerda = 0

gen byte d_fil_direita_ROB = 0
gen byte d_fil_centro_ROB = 0
gen byte d_fil_esquerda_ROB = 0

replace d_fil_direita = 1 if inlist(sigladopartido, "PTB","NOVO","PTC","PSC","PRTB","PSD")
replace d_fil_direita = 1 if inlist(sigladopartido, "SD","DEM","PL","PP","PRP","PSL","PTN","PHS","PEN")

replace d_fil_esquerda = 1 if inlist(sigladopartido, "PSTU", "PSDB", "PCB","PcdoB","PSB","PDT")
replace d_fil_esquerda = 1 if inlist(sigladopartido, "PT","PSOL","PCO","REDE","PROS","PV","PMN","PPS")

replace d_fil_centro = 1 if inlist(sigladopartido, "PMDB")

replace d_fil_direita_ROB = 1 if inlist(sigladopartido, "PTB","NOVO","PTC","PSC","PRTB","PSD")
replace d_fil_direita_ROB = 1 if inlist(sigladopartido, "SD","DEM","PL","PP","PRP","PSL","PTN","PHS","PEN")

replace d_fil_esquerda_ROB = 1 if inlist(sigladopartido, "PSTU", "PCB","PcdoB","PSB","PDT")
replace d_fil_esquerda_ROB = 1 if inlist(sigladopartido, "PT","PSOL","PCO","REDE","PROS","PV","PMN","PPS")

replace d_fil_centro_ROB = 1 if inlist(sigladopartido, "PMDB", "PSDB")

capture drop sigladopartido

capture drop venc_dir venc_esq venc_ctr
gen byte venc_dir = 0
gen byte venc_esq = 0
gen byte venc_ctr = 0

replace venc_dir = 1 if (d_dir_esq == 1 & margem_vit > 0) | (d_dir_ctr == 1 & margem_vit > 0) // right wing leader
replace venc_esq = 1 if (d_dir_esq == 1 & margem_vit < 0) | (d_esq_ctr == 1 & margem_vit > 0) // left wing leader
replace venc_ctr = 1 if (d_dir_ctr == 1 & margem_vit < 0) | (d_esq_ctr == 1 & margem_vit < 0) // center wing leader


save consolidada_econometria, replace

capture erase temp1.dta
capture erase temp2.dta

* ################################################################################################################################ PREPARING DATABASES ##########################
* ################################################################################################################################ PREPARING DATABASES ##########################
* ################################################################################################################################ PREPARING DATABASES ##########################
* ################################################################################################################################ PREPARING DATABASES ##########################
* ################################################################################################################################ PREPARING DATABASES ##########################
clear
use consolidada_econometria

preserve

keep d_dir_esq d_dir_ctr d_esq_ctr margem_vit d_filiou d_desfiliou d_fil_direita d_fil_centro d_fil_esquerda
save base_descriptive_DVs, replace

restore


keep if inlist(ano_base, 2004, 2008, 2012, 2016)

drop if d_dir_esq == 0 & d_dir_ctr == 0 & d_esq_ctr == 0  // removing robustness-only tests

compress

keep ano_base codigo_ibge margem_vit pop_dec_tot perc_pop_rural perc_mul_rural perc_mul pop_est_anual pib_per_capita homic_1529_pcmh homic_tot_pcmh bolsa_fam_anual gini_dec perc_pop_agua perc_pop_pobreza mort_inf_pcmh perc_analf perc_idosos  d_pref_coligacao reeleito idade_pref d_masculino d_full_degree_pref d_full_school_pref d_fund_pref d_casamento_pref d_cor_preta d_cor_parda d_cor_amarela d_cor_indigena d_cor_branca d_dir_esq d_dir_ctr d_esq_ctr

compress

collapse  (max) pop_dec_tot perc_pop_rural perc_mul_rural perc_mul pop_est_anual pib_per_capita homic_1529_pcmh homic_tot_pcmh bolsa_fam_anual gini_dec perc_pop_agua perc_pop_pobreza mort_inf_pcmh perc_analf perc_idosos  d_pref_coligacao reeleito idade_pref d_masculino d_full_degree_pref d_full_school_pref d_fund_pref d_casamento_pref d_cor_preta d_cor_parda d_cor_amarela d_cor_indigena d_cor_branca d_dir_esq d_dir_ctr d_esq_ctr , by (ano_base codigo_ibge margem_vit)

compress

capture drop venc_dir venc_esq venc_ctr
gen byte venc_dir = 0
gen byte venc_esq = 0
gen byte venc_ctr = 0

replace venc_dir = 1 if (d_dir_esq == 1 & margem_vit > 0) | (d_dir_ctr == 1 & margem_vit > 0) // right wing leader
replace venc_esq = 1 if (d_dir_esq == 1 & margem_vit < 0) | (d_esq_ctr == 1 & margem_vit > 0) // left wing leader
replace venc_ctr = 1 if (d_dir_ctr == 1 & margem_vit < 0) | (d_esq_ctr == 1 & margem_vit < 0) // center wing leader

save bases_balanceamento_short, replace

* #################################################################################################################### SHORTENING THE BASE #############################
clear
use consolidada_econometria

keep ano_base codigo_ibge d_filiou d_desfiliou margem_vit d_dir_esq d_dir_esq_ROB d_dir_ctr d_dir_ctr_ROB d_esq_ctr d_esq_ctr_ROB d_fil_direita d_fil_centro d_fil_esquerda d_fil_direita_ROB d_fil_centro_ROB d_fil_esquerda_ROB reeleito

capture drop todas_eleicoes
gen byte todas_eleicoes = 0
replace todas_eleicoes = 1 if ano_base > 2004

capture drop doisanos_eleicoes
gen byte doisanos_eleicoes = 0
replace doisanos_eleicoes = 1 if inlist(ano_base, 2005, 2006, 2009, 2010, 2013, 2014, 2017, 2018)

preserve
keep if ano_base == 2004
drop ano_base d_filiou d_desfiliou
collapse (max)  margem_vit d_dir_esq d_dir_esq_ROB d_dir_ctr d_dir_ctr_ROB d_esq_ctr d_esq_ctr_ROB , by (codigo_ibge)
save temporaria_2004, replace
restore

preserve
keep if ano_base <2004
keep ano_base d_filiou d_desfiliou codigo_ibge d_fil_direita d_fil_centro d_fil_esquerda d_fil_direita_ROB d_fil_centro_ROB d_fil_esquerda_ROB reeleito

merge m:1 codigo_ibge using temporaria_2004.dta, nogen
drop if margem_vit == .

save temporaria_2004_dois, replace
restore

drop if ano_base < 2004
append using temporaria_2004_dois
capture drop antes_eleicoes
gen byte antes_eleicoes = 0
replace antes_eleicoes = 1 if ano_base < 2004
capture drop ano_base

compress

capture erase temporaria_2004.dta
capture erase temporaria_2004_dois.dta

* Aux variables
capture drop disp_de_d_fil
capture drop disp_de_e_fil
capture drop disp_ec_e_fil
capture drop disp_ec_c_fil
capture drop disp_dc_d_fil
capture drop disp_dc_c_fil

gen byte disp_de_d_fil = 0
gen byte disp_de_e_fil = 0
gen byte disp_ec_e_fil = 0
gen byte disp_ec_c_fil = 0
gen byte disp_dc_d_fil = 0
gen byte disp_dc_c_fil = 0

replace disp_de_d_fil = 1 if d_dir_esq == 1 & d_fil_direita == 1 & d_filiou == 1 
replace disp_de_e_fil = 1 if d_dir_esq == 1 & d_fil_esquerda == 1 & d_filiou == 1 
replace disp_ec_e_fil = 1 if d_esq_ctr == 1 & d_fil_esquerda == 1 & d_filiou == 1 
replace disp_ec_c_fil = 1 if d_esq_ctr == 1 & d_fil_centro == 1 & d_filiou == 1 
replace disp_dc_d_fil = 1 if d_dir_ctr == 1 & d_fil_direita == 1 & d_filiou == 1 
replace disp_dc_c_fil = 1 if d_dir_ctr == 1 & d_fil_centro == 1 & d_filiou == 1 

capture drop disp_de_d_fil_ROB
capture drop disp_de_e_fil_ROB
capture drop disp_ec_e_fil_ROB
capture drop disp_ec_c_fil_ROB
capture drop disp_dc_d_fil_ROB
capture drop disp_dc_c_fil_ROB

gen byte disp_de_d_fil_ROB = 0
gen byte disp_de_e_fil_ROB = 0
gen byte disp_ec_e_fil_ROB = 0
gen byte disp_ec_c_fil_ROB = 0
gen byte disp_dc_d_fil_ROB = 0
gen byte disp_dc_c_fil_ROB = 0

replace disp_de_d_fil_ROB = 1 if d_dir_esq_ROB == 1 & d_fil_direita_ROB == 1 & d_filiou == 1 
replace disp_de_e_fil_ROB = 1 if d_dir_esq_ROB == 1 & d_fil_esquerda_ROB == 1 & d_filiou == 1 
replace disp_ec_e_fil_ROB = 1 if d_esq_ctr_ROB == 1 & d_fil_esquerda_ROB == 1 & d_filiou == 1 
replace disp_ec_c_fil_ROB = 1 if d_esq_ctr_ROB == 1 & d_fil_centro_ROB == 1 & d_filiou == 1 
replace disp_dc_d_fil_ROB = 1 if d_dir_ctr_ROB == 1 & d_fil_direita_ROB == 1 & d_filiou == 1 
replace disp_dc_c_fil_ROB = 1 if d_dir_ctr_ROB == 1 & d_fil_centro_ROB == 1 & d_filiou == 1 

capture drop disp_de_d_desfil
capture drop disp_de_e_desfil
capture drop disp_ec_e_desfil
capture drop disp_ec_c_desfil
capture drop disp_dc_d_desfil
capture drop disp_dc_c_desfil

gen byte disp_de_d_desfil = 0
gen byte disp_de_e_desfil = 0
gen byte disp_ec_e_desfil = 0
gen byte disp_ec_c_desfil = 0
gen byte disp_dc_d_desfil = 0
gen byte disp_dc_c_desfil = 0

replace disp_de_d_desfil = 1 if d_dir_esq == 1 & d_fil_direita == 1 & d_desfiliou == 1 
replace disp_de_e_desfil = 1 if d_dir_esq == 1 & d_fil_esquerda == 1 & d_desfiliou == 1 
replace disp_ec_e_desfil = 1 if d_esq_ctr == 1 & d_fil_esquerda == 1 & d_desfiliou == 1 
replace disp_ec_c_desfil = 1 if d_esq_ctr == 1 & d_fil_centro == 1 & d_desfiliou == 1 
replace disp_dc_d_desfil = 1 if d_dir_ctr == 1 & d_fil_direita == 1 & d_desfiliou == 1 
replace disp_dc_c_desfil = 1 if d_dir_ctr == 1 & d_fil_centro == 1 & d_desfiliou == 1 

capture drop disp_de_d_desfil_ROB
capture drop disp_de_e_desfil_ROB
capture drop disp_ec_e_desfil_ROB
capture drop disp_ec_c_desfil_ROB
capture drop disp_dc_d_desfil_ROB
capture drop disp_dc_c_desfil_ROB

gen byte disp_de_d_desfil_ROB = 0
gen byte disp_de_e_desfil_ROB = 0
gen byte disp_ec_e_desfil_ROB = 0
gen byte disp_ec_c_desfil_ROB = 0
gen byte disp_dc_d_desfil_ROB = 0
gen byte disp_dc_c_desfil_ROB = 0

replace disp_de_d_desfil_ROB = 1 if d_dir_esq_ROB == 1 & d_fil_direita_ROB == 1 & d_desfiliou == 1 
replace disp_de_e_desfil_ROB = 1 if d_dir_esq_ROB == 1 & d_fil_esquerda_ROB == 1 & d_desfiliou == 1 
replace disp_ec_e_desfil_ROB = 1 if d_esq_ctr_ROB == 1 & d_fil_esquerda_ROB == 1 & d_desfiliou == 1 
replace disp_ec_c_desfil_ROB = 1 if d_esq_ctr_ROB == 1 & d_fil_centro_ROB == 1 & d_desfiliou == 1 
replace disp_dc_d_desfil_ROB = 1 if d_dir_ctr_ROB == 1 & d_fil_direita_ROB == 1 & d_desfiliou == 1 
replace disp_dc_c_desfil_ROB = 1 if d_dir_ctr_ROB == 1 & d_fil_centro_ROB == 1 & d_desfiliou == 1 

compress

save filiou_desfiliou_tratada, replace
