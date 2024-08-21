* ##################### Paper Information
* Journal: Submission to The Leadership Quarterly (2024)
* Title: Is the mobility of followers explained by dissimilarity/similarity of ideology in leader-follower dyads? 
* Authors: Henrique Minetto Brabo; Paulo Roberto Arvate 
* Corresponding Author: Paulo Roberto Arvate: paulo.arvate@fgv.br 

* ##################### Technical Information
* Github Repository: https://github.com/brbhm/Mobility-of-Followers-Brabo-Arvate
* Stata Version: Stata 17 BE
* RAM Memory used to perform calculations: 32GB
* This version's date: 2024 Aug 23rd 

* ##################### Disclaimer About the Dataset
* The dataset mainly consists in data from political party affiliations and electoral candidate characteristcs from Brazil. This dataset used to be publicly available but was removed from public access due to the LGPD ("Lei Geral de Proteção de Dados"), the data protection law (similar to the GDPR). This is the reason that the researchers are not allowed to share the original versions (identified or identifiable) of those datasets.
* If you have access to the original dataset (tables with the least of individuals filiated to each political party, by year and state), we are glad to check if the sample is similar to ours, and we would clearly help replicating the construction of the consolidated databases.

* ##################### Disclaimer About the Method/Do-files
* The RD method requires the bandwidths (rdbwselect) to be calculated before the performing of the RD (rdrobust) and than manually inserted in each of the rdrobust regressions. We are not showing here all the rdbwselect calculations but, as an example, if you want to reperform all the rdbwselects, using the following logic (example):
* rdbwselect d_desfiliou margem_vit if 	d_dir_esq==1 & (antes_eleicoes==1) & ((d_fil_direita ==1 & margem_vit > 0) | (d_fil_esquerda ==1 & margem_vit < 0)), vce(cluster codigo_ibge)	p (1)
* The outcomes are h(0.10) b(0.173). With this information, insert it into the rdrobust and perform the calculation:
* rdrobust d_desfiliou margem_vit if 	d_dir_esq==1 & (antes_eleicoes==1) & ((d_fil_direita ==1 & margem_vit > 0) | (d_fil_esquerda ==1 & margem_vit < 0)), vce(cluster codigo_ibge)	p (1) all h (0.10) b (0.173) 
* All the Rdrobust values shown in the Results' do-files are already showing the Optimal Bandwidths calculated for each of them, with the exception of the robustness tests with specific bandwidths
* The numbers of observations may be retrieved from the .log files.

* ##################### Installing Packages
net install rdrobust, 	replace // 'RDROBUST': module to provide robust data-driven inference in the regression-discontinuity design
net install outreg2, 	replace // 'OUTREG2': module to arrange regression outputs into an illustrative table
net install rd, 		replace // 'RD': module for regression discontinuity estimation
net install rddensity,	replace // RD Density
net install lpdensity,	replace // LP Density
net install DCdensity,	replace // DC Density
net install grc1leg,  	replace // Combine graphs into one graph with a common legend.

* ##################### Codes
* Each of this do-files are related to one or more tables, figures or graphs in the original text or appendix.
* The output of tables are not straight-forward as presented in the text and must be 
clear all
set more off, permanently
cd ... // Insert your directory

	* Do-file Packages
		 run 1.Table3_DescriptiveStatistics.do
		 run 2.Tables4_to_6_MainResults_Afil.do
		 run 3.Tables7_to_9_MainResults_Disaf.do
		 run 4.TableA1_A2_Municipal_Candidate_Characteristics.do
		 run 5.TablesA3_to_A5_PSDB_Afil.do
		 run 6.TablesA6_to_A8_PSDB_Disaf.do
		 run 7.AllFiguresAndGraphs.do

capture erase bases_balanceamento_short.dta
capture erase filiou_desfiliou_tratada.dta