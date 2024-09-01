

clear
use filiou_desfiliou_tratada

capture drop  d_dir_esq d_dir_ctr d_esq_ctr d_fil_direita d_fil_centro d_fil_esquerda disp_de_d_fil disp_de_e_fil disp_ec_e_fil disp_ec_c_fil disp_dc_d_fil disp_dc_c_fil disp_de_d_desfil disp_de_e_desfil disp_ec_e_desfil disp_ec_c_desfil disp_dc_d_desfil disp_dc_c_desfil
* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################
* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################
* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################
* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################
* ################################################################################################################################ PSDB AS A CENTER PARTY ####################################

capture log close
log using TablesA6toA8.log, replace

capture erase TablePSDBDesfil.xml

* DE efeito na esquerda - Table A.6 - Top
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.095) b (0.194)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.142) b (0.244)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.130) b (0.235)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.197) b (0.291)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.228) b (0.347) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.198) b (0.319) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.142) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.197) b (0.10)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.142) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_e_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.197) b (0.40)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  

* DC efeito no centro - Table A.6 - Bottom
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.087) b (0.160)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.115) b (0.215)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.091) b (0.157)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) 	p (1) all h (0.150) b (0.225)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.179) b (0.305) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.253) b (0.379) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.115) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.150) b (0.10)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.115) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_c_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.150) b (0.40)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB") 

* DE efeito na direita - Table A.7 - Top
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.102) b (0.153)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.196) b (0.410)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.133) b (0.236)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.180) b (0.347)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.188) b (0.290) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.233) b (0.334) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.196) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.180) b (0.10)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.196) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_de_d_desfil_ROB margem_vit if 	d_dir_esq_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.180) b (0.40)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB") 

* EC efeito no centro - Table A.7 - Bottom
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.136) b (0.203)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.173) b (0.292)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.181) b (0.333)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) p (1) all h (0.163) b (0.296)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.205) b (0.281) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.214) b (0.335) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.173) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.163) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.173) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_c_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.163) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  

* DC efeito na direita - Table A.8 - Top
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.122) b (0.202)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.122) b (0.227)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.141) b (0.249)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) 	p (1) all h (0.161) b (0.286)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.184) b (0.294) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.284) b (0.477) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.122) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.161) b (0.10)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.122) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_dc_d_desfil_ROB margem_vit if 	d_dir_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.161) b (0.40)   
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB") 

* EC efeito na esquerda - Table A.8 - Bottom
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (antes_eleicoes==1) , vce(cluster codigo_ibge) 	p (1) all h (0.130) b (0.174)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.127) b (0.218)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (doisanos_eleicoes==1) , vce(cluster codigo_ibge) p (1) all h (0.122) b (0.207)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge) p (1) all h (0.179) b (0.272)
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (2) all h (0.191) b (0.284) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (2) all h (0.308) b (0.470) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.127) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.179) b (0.10) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1) , vce(cluster codigo_ibge)	p (1) all h (0.127) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  
rdrobust disp_ec_e_desfil_ROB margem_vit if 	d_esq_ctr_ROB==1 & (todas_eleicoes==1)  & reeleito == 1, vce(cluster codigo_ibge)	p (1) all h (0.179) b (0.40) 
outreg2 using TablePSDBDesfil, excel label append nonotes title("Table PSDB")  

capture log close



