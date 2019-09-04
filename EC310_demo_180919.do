*
* Date: September 19, 2019
* Author: Logan McLeod
*
* Data File:	cchs-82M0013-E-2014-Annual-component_F1.dta
*				n=63,522

* Variables:	GEOGPRV, DHH_SEX, INCGHH, EDUDR04, GEN_01, WTS_M

* Directory: /Users/Logan/Desktop/CCHS2014
*
* Purpose: Open raw data (CCHS 2014), clean the data/recode variables, run our analysis
*
*

* open log file
log using "/Users/Logan/Desktop/CCHS2014/EC310_demo.log", replace

* 1. Open Raw Data
clear
use "/Users/Logan/Desktop/CCHS2014/cchs-82M0013-E-2014-Annual-component_F1.dta"

keep GEOGPRV DHH_SEX INCGHH EDUDR04 GEN_01 WTS_M

* 2. Clean / Recode the variables

* GEOGPRV

* DHH_SEX
gen female=0
replace female=1 if DHH_SEX==2

**** gen female=(DHH_SEX==2)

* INCGHH
gen inc_0_20K=0
replace inc_0_20K=1 if INCGHH==1
 
gen inc_20_40K=0
replace inc_20_40K=1 if INCGHH==2

gen inc_40_60K=0
replace inc_40_60K=1 if INCGHH==3

gen inc_60_80K=0
replace inc_60_80K=1 if INCGHH==4
gen inc_60K_plus=0
replace inc_60K_plus=1 if INCGHH==5

gen inc_NR=0
replace inc_NR=1 if INCGHH==.d

* EDUDR04
gen LTHS_Edu=0
replace LTHS_Edu=1 if EDUDR04==1

gen HS_edu=0
replace HS_edu=1 if EDUDR04==2

gen Some_PostSec_Edu=0
replace Some_PostSec_Edu=1 if EDUDR04==3

gen PostSec_Edu=0
replace PostSec_Edu=1 if EDUDR04==4

gen NR_Edu=0
replace NR_Edu=1 if EDUDR04==.d

* GEN_01
gen ex_sph=0
replace ex_sph=1 if GEN_01==1

gen vg_sph=0
replace vg_sph=1 if GEN_01==2

gen gd_sph=0
replace gd_sph=1 if GEN_01==3

gen fr_sph=0
replace fr_sph=1 if GEN_01==4

gen pr_sph=0
replace pr_sph=1 if GEN_01==5

gen NR_sph=0
replace NR_sph=1 if GEN_01==.b
replace NR_sph=1 if GEN_01==.c

gen ex_vg_sph=0
replace ex_vg_sph=1 if ex_sph==1 | vg_sph==1

* 3. Analysis

* Summary statistics, showing the difference between using survey weights and not using survey weights
* unweighted summary statistics tell you about the sample
sum female
* unweighted summary statistics tell you about the population the sample represents
sum female [aw= WTS_M]

* Table
table EDUDR04 GEN_01

* Table (with mean of Excellent/Very Good Health by level of Education)
table EDUDR04 [aw=WTS_M], contents(mean ex_vg_sph) format(%9.3f)

* Table with means

* Linear Regression (OLS / Linear Probability Model)
reg ex_vg_sph LTHS_Edu Some_PostSec_Edu PostSec_Edu NR_Edu inc_0_20K inc_20_40K inc_40_60K inc_60_80K inc_NR female [aw= WTS_M]

* close your log file
log close
