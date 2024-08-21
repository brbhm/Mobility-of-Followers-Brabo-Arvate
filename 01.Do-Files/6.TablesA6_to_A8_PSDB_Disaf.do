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

* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################
* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################
* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################
* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################
* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################

capture log close
log using TablesA6toA8.log, replace

capture erase TablePSDBDesfil.xml

* DE efeito na esquerda - Table A.6 - Top
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.095) b (0.197)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.141) b (0.244)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.127) b (0.235)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.198) b (0.291)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.229) b (0.350) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.195) b (0.313) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.141) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.198) b (0.10)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.141) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.198) b (0.40)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  

* DC efeito no centro - Table A.6 - Bottom
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.084) b (0.163)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.117) b (0.218)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.091) b (0.157)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) 	p (1) all h (0.151) b (0.226)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.180) b (0.307) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.254) b (0.379) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.117) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.151) b (0.10)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.117) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.151) b (0.40)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB") 

* DE efeito na direita - Table A.7 - Top
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.102) b (0.153)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.180) b (0.354)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.130) b (0.234)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.197) b (0.371)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.182) b (0.293) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.238) b (0.343) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.180) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.197) b (0.10)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.180) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.197) b (0.40)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB") 

* EC efeito no centro - Table A.7 - Bottom
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.138) b (0.204)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.174) b (0.294)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.189) b (0.346)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) p (1) all h (0.163) b (0.297)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.205) b (0.282) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.214) b (0.335) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.174) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.163) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.174) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.163) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  

* DC efeito na direita - Table A.8 - Top
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.133) b (0.227)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.144) b (0.255)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.145) b (0.254)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) 	p (1) all h (0.165) b (0.295)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.193) b (0.302) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.245) b (0.393) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.144) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.165) b (0.10)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.144) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.165) b (0.40)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB") 

* EC efeito na esquerda - Table A.8 - Bottom
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.130) b (0.174)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.127) b (0.217)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.121) b (0.206)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) p (1) all h (0.178) b (0.272)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.190) b (0.283) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.280) b (0.437) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.127) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.178) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.127) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.178) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  

capture log close



