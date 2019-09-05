* Datafile used: NSDUH_2015.dta
* Author: David Wan
* Date: November 2, 2018
* Sample Size: n=55271
* Data source: NSDHU 2015 cycle
capture log close
cd "/Users/davidwan/Downloads/MRP Project"
log using datafile.log, replace text
*Create log file

clear
use "/Users/davidwan/Downloads/MRP Project/NSDUH_2015.dta"
*Opens raw data file

keep mjyrtot MEDMJST2 mjrec mrdaypyr mrdaypmo mrdaypwk MJDAY30A MR30EST snfamjev AGE2 irsex irmarit eduhighcat WRKSTATWK2 NEWRACE2 mrjmdays IRFAMIN3

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

* Survey Cohort Indicator
gen wave = 2015

* Marijuana laws indicator
gen MEDMJLAW=1
replace MEDMJLAW=0 if MEDMJST2==2

* Gender indicator
gen male=1
replace male=0 if irsex==2

* Race dummies
gen black=0
replace black=1 if NEWRACE2==2

gen nativeam=0
replace nativeam=1 if NEWRACE2==3

gen nativehi=0
replace nativehi=1 if NEWRACE2==4

gen asian=0
replace asian=1 if NEWRACE2==5

gen hispanic=0
replace hispanic=1 if NEWRACE2==7

gen multirace=0
replace multirace=1 if NEWRACE2==6

gen EDUCCAT2=0
replace EDUCCAT2=1 if eduhighcat==1
replace EDUCCAT2=2 if eduhighcat==2
replace EDUCCAT2=3 if eduhighcat==3
replace EDUCCAT2=4 if eduhighcat==4
replace EDUCCAT2=5 if eduhighcat==5

gen JBSTATR2=0
replace JBSTATR2=1 if WRKSTATWK2==1
replace JBSTATR2=2 if WRKSTATWK2==2
replace JBSTATR2=3 if WRKSTATWK2==3
replace JBSTATR2=4 if WRKSTATWK2==4
replace JBSTATR2=5 if WRKSTATWK2==5
replace JBSTATR2=6 if WRKSTATWK2==6
replace JBSTATR2=7 if WRKSTATWK2==7
replace JBSTATR2=8 if WRKSTATWK2==8
replace JBSTATR2=9 if WRKSTATWK2==9
replace JBSTATR2=98 if WRKSTATWK2==98
replace JBSTATR2=99 if WRKSTATWK2==99

save "/Users/davidwan/Downloads/MRP Project/NSDUHclean2015.dta"



