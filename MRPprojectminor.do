* Datafile used: NSDUHclean.dta
* Author: David Wan
* Date: November 6, 2018
* Sample Size: n=169314
* Data source: NSDHU 2014-2016 cycles
capture log close
cd "/Users/davidwan/Downloads/MRP Project"
log using minordatafile.log, replace text
* Create log file

clear
use "/Users/davidwan/Downloads/MRP Project/NSDUHclean.dta"
* Use combined NSDUH dataset

* Education level (Omitted group is High School graduates)
gen lessthanhs = 0
replace lessthanhs = 1 if EDUCCAT2 == 1
* Generates a dummy variable for less than HS group
* Omitted group is High School Graduate

gen somecol = 0
replace somecol = 1 if EDUCCAT2 == 3
* Generates a dummy variable for people with some college education

gen colgrad = 0
replace colgrad = 1 if EDUCCAT2 == 4
* Generates a dummy variable for people who are college graduates

gen minor = 0 
replace minor = 1 if EDUCCAT2 == 5
* Generates a dummy vairable for people who are minors that are still in hs

* Age 
gen age = 0
replace age = 12 if AGE2 == 1
replace age = 13 if AGE2 == 2
replace age = 14 if AGE2 == 3
replace age = 15 if AGE2 == 4
replace age = 16 if AGE2 == 5
replace age = 17 if AGE2 == 6
replace age = 18 if AGE2 == 7
* Generates a continuous variable for minors

* Employment Status (Omitted Group is full time workers)
gen parttimewrk = 0 
replace parttimewrk = 1 if JBSTATR2 == 2
* Generates a dummy variable for part time workers

gen volunteerwrk = 0
replace volunteerwrk = 1 if JBSTATR2 == 3
* Generates a dummy variable for volunteer workers/job but did not work for past week

gen umemployed = 0
replace umemployed = 1 if JBSTATR2 == 4
* Generates a dummy variable for unemployed people

gen disabled = 0
replace disabled = 1 if JBSTATR2 == 5
* Generates a dummy variable for disabled people

gen housekeeper = 0
replace housekeeper = 1 if JBSTATR2 == 6
* Generates a dummy variable for full time housekeepers 

gen student = 0 
replace student = 1 if JBSTATR2 == 7
* Generates a dummy variable for students or people in training

gen retiree = 0
replace retiree = 1 if JBSTATR2 == 8
* Generates a dummy variable for retirees

gen nojobother = 0
replace nojobother = 1 if JBSTATR2 == 9
* Generates a dummy variable who answered no job for other reasons

* Income (Omitted group is people making 75k and over)
gen tenkorlower = 0
replace tenkorlower = 1 if IRFAMIN3 == 1

gen tenkto20k = 0
replace tenkto20k = 1 if IRFAMIN3 == 2

gen twentykto30k = 0
replace twentykto30k = 1 if IRFAMIN3 == 3

gen thirtykto40k = 0
replace thirtykto40k = 1 if IRFAMIN3 == 4

gen fourtykto50k = 0
replace fourtykto50k = 1 if IRFAMIN3 == 5

gen fiftykto75k = 0
replace fiftykto75k = 1 if IRFAMIN3 == 6

drop if MJDAY30A == 85 
drop if MJDAY30A == 94
drop if MJDAY30A == 97
drop if MJDAY30A == 98
* Drops observations that did not answer 98 (258/330/247 respondents in 14/15/16)  
* Bad Data 85 (67/78/77 in 14/15/16), Refused 97 (32/32/48 in 14/15/16)
* and Don't Know (53/35/39 in 14/15/16)

gen marjmth = 0
replace marjmth = MJDAY30A if MJDAY30A != 91 & MJDAY30A != 93

save "/Users/davidwan/Downloads/MRP Project/NSDUHcleanminorfinal.dta"







