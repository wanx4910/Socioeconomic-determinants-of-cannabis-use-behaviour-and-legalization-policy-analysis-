*
* Date:		February 27, 2019
* Author:	Logan McLeod & David Wan
*
* Data File:	NSDUH_Analysis.dta (n=169,314)

* Variables:	

* Directory:	/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/
*
* Purpose: 
******************************************************************************************************************************

* Open log file
log using "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/log_files/Summary_Statistics.log", replace

clear
use "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_Analysis.dta", clear

* 1. Sample Restrictions
******************************************************************************************************************************************************
drop if ED_12_17==1
* 41,457 observerations dropped 
drop if empl_skip==1
* 806 observerations dropped
drop if marjmth==.
* 804 observerations dropped

* 2. Summary Statistics
******************************************************************************************************************************************************

* Y
sum marjmthpart marjmth
sum marjmth if marjmth>0
tab marjmth

table wave, contents(mean marjmthpart) row col format(%5.3g)
table wave if marjmth>0, contents(mean marjmth) row col format(%5.3g)

histogram marjmth if marjmth>0, xtitle("# Days used Marijuana/Hashish in the past 30 Days")
graph save "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/log_files/hist_cannabis_use.gph", replace
graph export "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/log_files/hist_cannabis_use.pdf", replace

kdensity marjmth if marjmth>0, xtitle("# Days used Marijuana/Hashish in the past 30 Days")
graph save "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/log_files/kdensity_cannabis_use.gph", replace
graph export "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/log_files/kdensity_cannabis_use.pdf", replace


* X
sum med_cannabis_law female  age_12 age_13 age_14 age_15 age_16 age_17 age_18 age_19 age_20 age_21 age_22_23 age_24_25 age_26_29 age_30_34 age_35_49 age_50_64 age_65_plus
sum LTHS HS somecol college white black nativeam nativehi asian multirace hispanic fulltimewrk parttimewrk volunteerwrk unemployed disabled housekeeper student retiree nojobother empl_skip

* Marijuana Law regime
table med_cannabis_law wave, contents(mean marjmthpart) row col format(%5.3g)
table med_cannabis_law wave if marjmth>0, contents(mean marjmth) row col format(%5.3g)

* Sex
table female wave, contents(mean marjmthpart) row col format(%5.3g)
table female wave if marjmth>0, contents(mean marjmth) row col format(%5.3g)

* Age
table AGE2 wave, contents(mean marjmthpart) row col format(%5.3g)
table AGE2 wave if marjmth>0, contents(mean marjmth) row col format(%5.3g)

* Income
table IRFAMIN3 wave, contents(mean marjmthpart) row col format(%5.3g)
table IRFAMIN3 wave if marjmth>0, contents(mean marjmth) row col format(%5.3g)

* Education
table EDUCCAT2 wave, contents(mean marjmthpart) row col format(%5.3g)
table EDUCCAT2 wave if marjmth>0, contents(mean marjmth) row col format(%5.3g)

* Race
table NEWRACE2 wave, contents(mean marjmthpart) row col format(%5.3g)
table NEWRACE2 wave if marjmth>0, contents(mean marjmth) row col format(%5.3g)

* Employment
table JBSTATR2 wave, contents(mean marjmthpart) row col format(%5.3g)
table JBSTATR2 wave if marjmth>0, contents(mean marjmth) row col format(%5.3g)

log close


* 3. Regerssion Analysis
******************************************************************************************************************************************************

global X1 "med_cannabis_law female inc_10K_less inc_10K_20K inc_20K_30K inc_30K_40K inc_40K_50K inc_50K_75K LTHS somecol college age_21 age_22_23 age_24_25 age_26_29 age_30_34 age_35_49 age_50_64 age_65_plus"
global X2 "parttimewrk volunteerwrk unemployed disabled housekeeper student retiree nojobother"
global X3 "black nativeam nativehi asian multirace hispanic"

* 3.1 Probability models for marijuana participation
reg marjmthpart $X1
reg marjmthpart $X1 $X2
reg marjmthpart $X1 $X2 $X3

logit marjmthpart $X1 $X2 $X3
mfx

probit marjmthpart $X1 $X2 $X3

* 3.2 FMM models for marijuana consumption
fmm marjmth $X1 $X2 $X3 if marjmthpart>0, components(2) mixtureof(poisson)
estat ic

fmm marjmth $X1 $X2 $X3 if marjmthpart>0, components(2) mixtureof(normal) technique(dfp 6 nr 5 dfp 10) difficult
estat ic

fmm marjmth $X1 $X2 $X3 if marjmthpart>0, components(3) mixtureof(normal) technique(dfp 6 nr 5 dfp 10) difficult
estat ic

fmm marjmth $X1 $X2 $X3 if marjmthpart>0, components(2) mixtureof(negbin2) technique(dfp 6 nr 5 dfp 10) difficult
estat ic

fmm marjmth $X1 $X2 $X3 if marjmthpart>0, components(3) mixtureof(negbin2) technique(dfp 6 nr 5 dfp 10) difficult
estat ic
