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
log using Tables7to8.log, replace
capture erase TableResultsDesfil.xml

* DE efeito na esquerda - Table 7 - Top
rdrobust disp_de_e_desfil margem_vit if 	d_dir_esq==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.122) b (0.199)
outreg2 using TableResults, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.130) b (0.236)
outreg2 using TableResults, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_desfil margem_vit if 	d_dir_esq==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.130) b (0.242)
outreg2 using TableResults, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.183) b (0.284)
outreg2 using TableResults, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.220) b (0.340) 
outreg2 using TableResults, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.190) b (0.292) 
outreg2 using TableResults, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.130) b (0.10) 
outreg2 using TableResults, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.183) b (0.10)   
outreg2 using TableResults, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.130) b (0.40) 
outreg2 using TableResults, excel label append nonotes title("Table Results")  
rdrobust disp_de_e_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.183) b (0.40)   
outreg2 using TableResults, excel label append nonotes title("Table Results")  

* DC efeito no centro - Table 7 - Bottom
rdrobust disp_dc_c_desfil margem_vit if 	d_dir_ctr==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.086) b (0.206)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.155) b (0.259)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_desfil margem_vit if 	d_dir_ctr==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.105) b (0.196)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) 	p (1) all h (0.241) b (0.366)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.213) b (0.352) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.284) b (0.409) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.155) b (0.10) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.241) b (0.10)   
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.155) b (0.40) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_c_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.241) b (0.40)   
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results") 

* DE efeito na direita - Table 8 - Top
rdrobust disp_de_d_desfil margem_vit if 	d_dir_esq==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.113) b (0.173)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.121) b (0.246)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_desfil margem_vit if 	d_dir_esq==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.125) b (0.225)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.197) b (0.405)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.181) b (0.287) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")
rdrobust disp_de_d_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.243) b (0.352) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.121) b (0.10) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.197) b (0.10)   
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.121) b (0.40) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_de_d_desfil margem_vit if 	d_dir_esq==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.197) b (0.40)   
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  

* EC efeito no centro - Table 8 - Bottom
rdrobust disp_ec_c_desfil margem_vit if 	d_esq_ctr==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.112) b (0.209)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.144) b (0.229)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_desfil margem_vit if 	d_esq_ctr==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.090) b (0.192)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) p (1) all h (0.223) b (0.341)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.217) b (0.293) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.329) b (0.471) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.144) b (0.10) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.223) b (0.10) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.144) b (0.40) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_c_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.223) b (0.40) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  

* DC efeito na direita - Table 9 - Top
rdrobust disp_dc_d_desfil margem_vit if 	d_dir_ctr==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.113) b (0.207)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.165) b (0.305)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_desfil margem_vit if 	d_dir_ctr==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.141) b (0.248)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) 	p (1) all h (0.162) b (0.292)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.182) b (0.285) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.205) b (0.341) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.165) b (0.10) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.162) b (0.10)   
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.165) b (0.40) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_dc_d_desfil margem_vit if 	d_dir_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.162) b (0.40)   
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results") 

* EC efeito na esquerda - Table 9 - Bottom
rdrobust disp_ec_e_desfil margem_vit if 	d_esq_ctr==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.144) b (0.272)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.118) b (0.201)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_desfil margem_vit if 	d_esq_ctr==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.123) b (0.217)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) p (1) all h (0.136) b (0.225)
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.167) b (0.261) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.220) b (0.318) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.118) b (0.10) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.136) b (0.10) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.118) b (0.40) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  
rdrobust disp_ec_e_desfil margem_vit if 	d_esq_ctr==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.136) b (0.40) 
outreg2 using TableResultsDesfil, excel label append nonotes title("Table Results")  

capture log close