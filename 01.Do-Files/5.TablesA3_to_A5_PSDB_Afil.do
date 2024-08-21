clear
use consolidada_econometria

* #################################################################################################################### SHORTENING THE BASE #############################
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

clear
use filiou_desfiliou_tratada

* ################################################################################################################################ MAIN RESULTS WITH ROBUSTNESS TESTS ########################
* ################################################################################################################################ MAIN RESULTS WITH ROBUSTNESS TESTS ########################
* ################################################################################################################################ MAIN RESULTS WITH ROBUSTNESS TESTS ########################
* ################################################################################################################################ MAIN RESULTS WITH ROBUSTNESS TESTS ########################
* ################################################################################################################################ MAIN RESULTS WITH ROBUSTNESS TESTS ########################

capture log close
log using Tables4to6.log, replace
capture erase TableResultsAfil.xml

* DE efeito na direita
rdrobust disp_de_d_fil margem_vit if 	d_dir_esq==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.122) b (0.215)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.19) b (0.352)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_fil margem_vit if 	d_dir_esq==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.163) b (0.299)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.251) b (0.417)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.26) b (0.411) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")
rdrobust disp_de_d_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.222) b (0.317) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.19) b (0.10) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.251) b (0.10)  
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.19) b (0.40) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.251) b (0.40)  
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  

* DE efeito na esquerda
rdrobust disp_de_e_fil margem_vit if 	d_dir_esq==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.123) b (0.214)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.143) b (0.28)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_fil margem_vit if 	d_dir_esq==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.16) b (0.304)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.21) b (0.398)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.222) b (0.370) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.245) b (0.442) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.143) b (0.10) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.21) b (0.10)  
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.143) b (0.40) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_fil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.21) b (0.40)  
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  

* EC efeito na esquerda
rdrobust disp_ec_e_fil margem_vit if 	d_esq_ctr==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.111) b (0.215)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.122) b (0.237)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_fil margem_vit if 	d_esq_ctr==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.131) b (0.231)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) p (1) all h (0.120) b (0.227)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.172) b (0.301) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.189) b (0.302) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.122) b (0.10) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.120) b (0.10)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.122) b (0.40) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.120) b (0.40)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  

* EC efeito no centro
rdrobust disp_ec_c_fil margem_vit if 	d_esq_ctr==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.1) b (0.185)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.120) b (0.218)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_fil margem_vit if 	d_esq_ctr==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.158) b (0.276)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) p (1) all h (0.154) b (0.254)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.172) b (0.277) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.185) b (0.282) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.12) b (0.10) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.154) b (0.10)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.12) b (0.40) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_fil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.154) b (0.40)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  

* DC efeito na direita
rdrobust disp_dc_d_fil margem_vit if 	d_dir_ctr==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.129) b (0.233)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.129) b (0.222)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_fil margem_vit if 	d_dir_ctr==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.147) b (0.243)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) 	p (1) all h (0.137) b (0.234)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.191) b (0.308) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.264) b (0.407) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.129) b (0.10) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.137) b (0.10)  
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.129) b (0.40) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.137) b (0.40)  
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results") 

* DC efeito no centro
rdrobust disp_dc_c_fil margem_vit if 	d_dir_ctr==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.132) b (0.218)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.151) b (0.257)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_fil margem_vit if 	d_dir_ctr==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.185) b (0.302)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) 	p (1) all h (0.138) b (0.242)
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.204) b (0.329) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.241) b (0.366) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.151) b (0.10) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.138) b (0.10)  
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.151) b (0.40) 
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_fil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.138) b (0.40)  
outreg2 using TableResultsAfil, excel label append nonotes title("Table Results") 

 capture log close

* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################
* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################
* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################
* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################
* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################

capture log close
log using TablesA3toA5.log, replace
capture erase TablePSDBAfil.xml

* DE efeito na direita - Table A.3 - Top
rdrobust disp_de_d_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.115) b (0.199)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.167) b (0.295)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.156) b (0.308)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.228) b (0.384)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.307) b (0.507) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")
rdrobust disp_de_d_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.228) b (0.327) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.167) b (0.10) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.228) b (0.10)  
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.167) b (0.40) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.228) b (0.40)  
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  

* DC efeito na direita - Table A.3 - Bottom
rdrobust disp_dc_d_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.117) b (0.205)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.125) b (0.224)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.165) b (0.260)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) 	p (1) all h (0.146) b (0.239)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.197) b (0.302) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.262) b (0.403) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.125) b (0.10) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.146) b (0.10)  
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.125) b (0.40) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.146) b (0.40)  
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB") 

* DE efeito na esquerda - Table A.4 - Top
rdrobust disp_de_e_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.138) b (0.226)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.147) b (0.302)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.170) b (0.331)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.242) b (0.432)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.210) b (0.356) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.244) b (0.454) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.147) b (0.10) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.242) b (0.10)  
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.147) b (0.40) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_fil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.242) b (0.40)  
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  

* EC efeito na esquerda - Table A.4 - Bottom
rdrobust disp_ec_e_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.123) b (0.218)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.148) b (0.241)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.130) b (0.227)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) p (1) all h (0.184) b (0.283)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.194) b (0.279) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.259) b (0.364) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.148) b (0.10) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.184) b (0.10)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.148) b (0.40) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.184) b (0.40)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  

* DC efeito no centro - A.5 - Top
rdrobust disp_dc_c_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.117) b (0.219)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.173) b (0.292)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.180) b (0.286)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) 	p (1) all h (0.172) b (0.272)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.250) b (0.375) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.301) b (0.450) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.173) b (0.10) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.172) b (0.10)  
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.173) b (0.40) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_fil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.172) b (0.40)  
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB") 

* EC efeito no centro - Table A.5 - Bottom
rdrobust disp_ec_c_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.132) b (0.214)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.178) b (0.307)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.155) b (0.242)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) p (1) all h (0.215) b (0.338)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.212) b (0.303) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.213) b (0.300) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.178) b (0.10) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.215) b (0.10)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.178) b (0.40) 
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_fil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.215) b (0.40)
outreg2 using TablePSDBAfil, excel label append nonotes title("Table PSDB")  

capture log close
