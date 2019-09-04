*
* Date:		February 27, 2019
* Author:	Logan McLeod & David Wan
*
* Data File:	NSDUH_2014.dta (n=55,271)
*				NSDUH_2015.dta (n=57,146)
*				NSDUH_2016.dta (n=56,897)

* Variables:	

* Directory:	/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/
*
* Purpose: Open raw data sets (NSDUH 2014, 2015, 2016), clean the data/recode variables, append all years into one file
******************************************************************************************************************************

* Open log file
log using "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/log_files/Clean_Data.log", replace

* 1. NSDUH 2014
******************************************************************************************************************************************************
clear
use "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_2014.dta", clear

* Variables: IRFAMIN3-Family income, MEDMJST2-State's marijuana legal regime, 
* mrjmdays-self reported marijuana use in the last 30 days (intensity of use)
* mjyrtot-TOTAL # OF DAYS USED MARIJUANA IN PAST 12 MOS
* mjrec-TIME SINCE LAST USED MARIJUANA/HASHISH
* mrdaypyr-# DAYS USED MARIJUANA/HASHISH PAST 12 MONTHS
* mrdaypmo-# DAYS PER MO USED MARIJUANA/HASHISH PAST 12 MOS
* mrdaypwk-# DAYS PER WEEK USED MARIJUANA/HASHISH PAST 12 MOS
* MJDAY30A-# DAYS USED MARIJUANA/HASHISH PAST 30 DAYS
* MR30EST-BEST EST. # DAYS USED MARIJUANA PAST 30 DAYS
* snfamjev-HOW YOU FEEL: ADLTS TRYING MJ/HASH
* AGE2-RECODE - FINAL EDITED AGE
* irsex-IMPUTATION REVISED GENDER
* irmarit-IMPUTATION REVISED MARITAL STATUS
* EDUCCAT2-EDUCATION RECODE
* JBSTATR2-WORK SITUATION IN PAST WEEK - RECODE
* NEWRACE2-RACE/HISPANICITY RECODE
* mrjmdays-# OF DAYS USED MARIJUANA IN PAST MONTH
* IRFAMIN3-RECODE - IMP.REVISED - TOT FAM INCOME

keep mjyrtot MEDMJST2 mjrec mrdaypyr mrdaypmo mrdaypwk MJDAY30A MR30EST snfamjev AGE2 irsex irmarit NEWRACE2 mrjmdays IRFAMIN3 EDUCCAT2 JBSTATR2

* Survey Cohort Indicator
gen wave = 2014

* Cannabis Use - Past 30 Days

* Drops observations that did not answer 98 (258/330/247 respondents in 14/15/16)  
* Bad Data 85 (67/78/77 in 14/15/16), Refused 97 (32/32/48 in 14/15/16)
* and Don't Know (53/35/39 in 14/15/16)
*drop if MJDAY30A == 85 
*drop if MJDAY30A == 94
*drop if MJDAY30A == 97
*drop if MJDAY30A == 98

gen marjmth=.
replace marjmth = 0 if (MJDAY30A== 91) | (MJDAY30A== 93)
replace marjmth = MJDAY30A if (MJDAY30A<=30)

* Marijuana Use participation in last month
gen marjmthpart=.
replace marjmthpart=0 if marjmth == 0
replace marjmthpart=1 if marjmth > 0

* Marijuana laws indicator
gen med_cannabis_law =(MEDMJST2==1)

* Sex (Female)
gen female=(irsex==2)

* Education level (Omitted group is High School graduates)
gen LTHS=(EDUCCAT2==1)
gen HS=(EDUCCAT2==2)
gen somecol=(EDUCCAT2==3)
gen college=(EDUCCAT2==4)
gen ED_12_17=(EDUCCAT2==5)

* Age 
gen age_12=(AGE2==1)
gen age_13=(AGE2==2)
gen age_14=(AGE2 == 3)
gen age_15=(AGE2 == 4)
gen age_16=(AGE2 == 5)
gen age_17=(AGE2 == 6)
gen age_18=(AGE2 == 7)
gen age_19=(AGE2 == 8)
gen age_20=(AGE2 == 9)
gen age_21=(AGE2 == 10)
gen age_22_23=(AGE2 == 11)
gen age_24_25=(AGE2 == 12)
gen age_26_29=(AGE2 == 13)
gen age_30_34=(AGE2 == 14)
gen age_35_49=(AGE2 == 15)
gen age_50_64=(AGE2 == 16)
gen age_65_plus=(AGE2 == 17)

* Race dummies
gen white=(NEWRACE2==1)
gen black=(NEWRACE2==2)
gen nativeam=(NEWRACE2==3)
gen nativehi=(NEWRACE2==4)
gen asian=(NEWRACE2==5)
gen multirace=(NEWRACE2==6)
gen hispanic=(NEWRACE2==7)

* Employment Status (Omitted Group is full time workers)
gen fulltimewrk=(JBSTATR2==1)
gen parttimewrk=(JBSTATR2==2)
gen volunteerwrk=(JBSTATR2==3)
gen unemployed=(JBSTATR2==4)
gen disabled=(JBSTATR2==5)
gen housekeeper=(JBSTATR2==6)
gen student=(JBSTATR2==7)
gen retiree=(JBSTATR2==8)
gen nojobother=(JBSTATR2==9)
gen empl_skip=(JBSTATR2==98 | JBSTATR2==99)

* Income (Omitted group is people making 75k and over)
gen inc_10K_less=(IRFAMIN3==1)
gen inc_10K_20K=(IRFAMIN3==2)
gen inc_20K_30K=(IRFAMIN3==3)
gen inc_30K_40K=(IRFAMIN3==4)
gen inc_40K_50K=(IRFAMIN3==5)
gen inc_50K_75K=(IRFAMIN3==6)
gen inc_75K_plus=(IRFAMIN3==7)

save "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_2014_temp.dta", replace

* 2. NSDUH 2015
******************************************************************************************************************************************************
clear
use "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_2015.dta", clear

* Variables: IRFAMIN3-Family income, MEDMJST2-State's marijuana legal regime, 
* mrjmdays-self reported marijuana use in the last 30 days (intensity of use)
* mjyrtot-TOTAL # OF DAYS USED MARIJUANA IN PAST 12 MOS
* mjrec-TIME SINCE LAST USED MARIJUANA/HASHISH
* mrdaypyr-# DAYS USED MARIJUANA/HASHISH PAST 12 MONTHS
* mrdaypmo-# DAYS PER MO USED MARIJUANA/HASHISH PAST 12 MOS
* mrdaypwk-# DAYS PER WEEK USED MARIJUANA/HASHISH PAST 12 MOS
* MJDAY30A-# DAYS USED MARIJUANA/HASHISH PAST 30 DAYS
* MR30EST-BEST EST. # DAYS USED MARIJUANA PAST 30 DAYS
* snfamjev-HOW YOU FEEL: ADLTS TRYING MJ/HASH
* AGE2-RECODE - FINAL EDITED AGE
* irsex-IMPUTATION REVISED GENDER
* irmarit-IMPUTATION REVISED MARITAL STATUS
* EDUCCAT2-EDUCATION RECODE
* JBSTATR2-WORK SITUATION IN PAST WEEK - RECODE
* NEWRACE2-RACE/HISPANICITY RECODE
* mrjmdays-# OF DAYS USED MARIJUANA IN PAST MONTH
* IRFAMIN3-RECODE - IMP.REVISED - TOT FAM INCOME

keep mjyrtot MEDMJST2 mjrec mrdaypyr mrdaypmo mrdaypwk MJDAY30A MR30EST snfamjev AGE2 irsex irmarit NEWRACE2 mrjmdays IRFAMIN3 eduhighcat WRKSTATWK2
rename eduhighcat EDUCCAT2
rename  WRKSTATWK2 JBSTATR2

* Survey Cohort Indicator
gen wave = 2015

* Cannabis Use - Past 30 Days

* Drops observations that did not answer 98 (258/330/247 respondents in 14/15/16)  
* Bad Data 85 (67/78/77 in 14/15/16), Refused 97 (32/32/48 in 14/15/16)
* and Don't Know (53/35/39 in 14/15/16)
*drop if MJDAY30A == 85 
*drop if MJDAY30A == 94
*drop if MJDAY30A == 97
*drop if MJDAY30A == 98

gen marjmth=.
replace marjmth = 0 if (MJDAY30A== 91) | (MJDAY30A== 93)
replace marjmth = MJDAY30A if (MJDAY30A<=30)

* Marijuana Use participation in last month
gen marjmthpart=.
replace marjmthpart=0 if marjmth == 0
replace marjmthpart=1 if marjmth > 0

* Marijuana laws indicator
gen med_cannabis_law =(MEDMJST2==1)

* Sex (Female)
gen female=(irsex==2)

* Education level (Omitted group is High School graduates)
gen LTHS=(EDUCCAT2==1)
gen HS=(EDUCCAT2==2)
gen somecol=(EDUCCAT2==3)
gen college=(EDUCCAT2==4)
gen ED_12_17=(EDUCCAT2==5)

* Age 
gen age_12=(AGE2==1)
gen age_13=(AGE2==2)
gen age_14=(AGE2 == 3)
gen age_15=(AGE2 == 4)
gen age_16=(AGE2 == 5)
gen age_17=(AGE2 == 6)
gen age_18=(AGE2 == 7)
gen age_19=(AGE2 == 8)
gen age_20=(AGE2 == 9)
gen age_21=(AGE2 == 10)
gen age_22_23=(AGE2 == 11)
gen age_24_25=(AGE2 == 12)
gen age_26_29=(AGE2 == 13)
gen age_30_34=(AGE2 == 14)
gen age_35_49=(AGE2 == 15)
gen age_50_64=(AGE2 == 16)
gen age_65_plus=(AGE2 == 17)

* Race dummies
gen white=(NEWRACE2==1)
gen black=(NEWRACE2==2)
gen nativeam=(NEWRACE2==3)
gen nativehi=(NEWRACE2==4)
gen asian=(NEWRACE2==5)
gen multirace=(NEWRACE2==6)
gen hispanic=(NEWRACE2==7)

* Employment Status (Omitted Group is full time workers)
gen fulltimewrk=(JBSTATR2==1)
gen parttimewrk=(JBSTATR2==2)
gen volunteerwrk=(JBSTATR2==3)
gen unemployed=(JBSTATR2==4)
gen disabled=(JBSTATR2==5)
gen housekeeper=(JBSTATR2==6)
gen student=(JBSTATR2==7)
gen retiree=(JBSTATR2==8)
gen nojobother=(JBSTATR2==9)
gen empl_skip=(JBSTATR2==98 | JBSTATR2==99)

* Income (Omitted group is people making 75k and over)
gen inc_10K_less=(IRFAMIN3==1)
gen inc_10K_20K=(IRFAMIN3==2)
gen inc_20K_30K=(IRFAMIN3==3)
gen inc_30K_40K=(IRFAMIN3==4)
gen inc_40K_50K=(IRFAMIN3==5)
gen inc_50K_75K=(IRFAMIN3==6)
gen inc_75K_plus=(IRFAMIN3==7)

save "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_2015_temp.dta", replace

* 3. NSDUH 2016
******************************************************************************************************************************************************
clear
use "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_2016.dta", clear

* Variables: IRFAMIN3-Family income, MEDMJST2-State's marijuana legal regime, 
* mrjmdays-self reported marijuana use in the last 30 days (intensity of use)
* mjyrtot-TOTAL # OF DAYS USED MARIJUANA IN PAST 12 MOS
* mjrec-TIME SINCE LAST USED MARIJUANA/HASHISH
* mrdaypyr-# DAYS USED MARIJUANA/HASHISH PAST 12 MONTHS
* mrdaypmo-# DAYS PER MO USED MARIJUANA/HASHISH PAST 12 MOS
* mrdaypwk-# DAYS PER WEEK USED MARIJUANA/HASHISH PAST 12 MOS
* MJDAY30A-# DAYS USED MARIJUANA/HASHISH PAST 30 DAYS
* MR30EST-BEST EST. # DAYS USED MARIJUANA PAST 30 DAYS
* snfamjev-HOW YOU FEEL: ADLTS TRYING MJ/HASH
* AGE2-RECODE - FINAL EDITED AGE
* irsex-IMPUTATION REVISED GENDER
* irmarit-IMPUTATION REVISED MARITAL STATUS
* EDUCCAT2-EDUCATION RECODE
* JBSTATR2-WORK SITUATION IN PAST WEEK - RECODE
* NEWRACE2-RACE/HISPANICITY RECODE
* mrjmdays-# OF DAYS USED MARIJUANA IN PAST MONTH
* IRFAMIN3-RECODE - IMP.REVISED - TOT FAM INCOME

keep mjyrtot MEDMJST2 mjrec mrdaypyr mrdaypmo mrdaypwk MJDAY30A MR30EST snfamjev AGE2 irsex irmarit NEWRACE2 mrjmdays IRFAMIN3 eduhighcat WRKSTATWK2
rename eduhighcat EDUCCAT2
rename  WRKSTATWK2 JBSTATR2

* Survey Cohort Indicator
gen wave = 2016

* Cannabis Use - Past 30 Days

* Drops observations that did not answer 98 (258/330/247 respondents in 14/15/16)  
* Bad Data 85 (67/78/77 in 14/15/16), Refused 97 (32/32/48 in 14/15/16)
* and Don't Know (53/35/39 in 14/15/16)
*drop if MJDAY30A == 85 
*drop if MJDAY30A == 94
*drop if MJDAY30A == 97
*drop if MJDAY30A == 98

gen marjmth=.
replace marjmth = 0 if (MJDAY30A== 91) | (MJDAY30A== 93)
replace marjmth = MJDAY30A if (MJDAY30A<=30)

* Marijuana Use participation in last month
gen marjmthpart=.
replace marjmthpart=0 if marjmth == 0
replace marjmthpart=1 if marjmth > 0

* Marijuana laws indicator
gen med_cannabis_law =(MEDMJST2==1)

* Sex (Female)
gen female=(irsex==2)

* Education level (Omitted group is High School graduates)
gen LTHS=(EDUCCAT2==1)
gen HS=(EDUCCAT2==2)
gen somecol=(EDUCCAT2==3)
gen college=(EDUCCAT2==4)
gen ED_12_17=(EDUCCAT2==5)

* Age 
gen age_12=(AGE2==1)
gen age_13=(AGE2==2)
gen age_14=(AGE2 == 3)
gen age_15=(AGE2 == 4)
gen age_16=(AGE2 == 5)
gen age_17=(AGE2 == 6)
gen age_18=(AGE2 == 7)
gen age_19=(AGE2 == 8)
gen age_20=(AGE2 == 9)
gen age_21=(AGE2 == 10)
gen age_22_23=(AGE2 == 11)
gen age_24_25=(AGE2 == 12)
gen age_26_29=(AGE2 == 13)
gen age_30_34=(AGE2 == 14)
gen age_35_49=(AGE2 == 15)
gen age_50_64=(AGE2 == 16)
gen age_65_plus=(AGE2 == 17)

* Race dummies
gen white=(NEWRACE2==1)
gen black=(NEWRACE2==2)
gen nativeam=(NEWRACE2==3)
gen nativehi=(NEWRACE2==4)
gen asian=(NEWRACE2==5)
gen multirace=(NEWRACE2==6)
gen hispanic=(NEWRACE2==7)

* Employment Status (Omitted Group is full time workers)
gen fulltimewrk=(JBSTATR2==1)
gen parttimewrk=(JBSTATR2==2)
gen volunteerwrk=(JBSTATR2==3)
gen unemployed=(JBSTATR2==4)
gen disabled=(JBSTATR2==5)
gen housekeeper=(JBSTATR2==6)
gen student=(JBSTATR2==7)
gen retiree=(JBSTATR2==8)
gen nojobother=(JBSTATR2==9)
gen empl_skip=(JBSTATR2==98 | JBSTATR2==99)

* Income (Omitted group is people making 75k and over)
gen inc_10K_less=(IRFAMIN3==1)
gen inc_10K_20K=(IRFAMIN3==2)
gen inc_20K_30K=(IRFAMIN3==3)
gen inc_30K_40K=(IRFAMIN3==4)
gen inc_40K_50K=(IRFAMIN3==5)
gen inc_50K_75K=(IRFAMIN3==6)
gen inc_75K_plus=(IRFAMIN3==7)

save "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_2016_temp.dta", replace

* 3. Append all Files into Analysis File: NSDUH 2014 + NSDUH 2015 + NSDUH 2016
******************************************************************************************************************************************************
clear
use "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_2014_temp.dta", clear
append using "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_2015_temp.dta" "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_2016_temp.dta"

save "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_Analysis.dta", replace

erase "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_2014_temp.dta"
erase "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_2015_temp.dta"
erase "/Users/Logan/Documents/Academic/Research/Work_in_Progress/Project_6_Cannabis/Data/NSDUH_2016_temp.dta"

log close
