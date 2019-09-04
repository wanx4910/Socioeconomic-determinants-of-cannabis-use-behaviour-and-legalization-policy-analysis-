* Datafile used: NSDUHclean.dta
* Author: David Wan
* Date: November 6, 2018
* Sample Size: n=169314
* Data source: NSDHU 2014-2016 cycles
capture log close
cd "/Users/davidwan/Downloads/MRP Project"
log using datafile.log, replace text
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

* Age (Omitted group is people of age 20 to 25)
gen under20 = 0
replace under20 = 1 if AGE2 == 1
replace under20 = 1 if AGE2 == 2
replace under20 = 1 if AGE2 == 3
replace under20 = 1 if AGE2 == 4
replace under20 = 1 if AGE2 == 5
replace under20 = 1 if AGE2 == 6
replace under20 = 1 if AGE2 == 7
replace under20 = 1 if AGE2 == 8
* Generates a dummy variables for people who are under the age of 20

gen twenty6to29 = 0
replace twenty6to29 = 1 if AGE2 == 13
* Generates a dummy variable for people between the age of 26 to 29

gen thirtyto34 = 0
replace thirtyto34 = 1 if AGE2 == 14
* Generates a dummy variable for people between the age of 30 to 34

gen thirty5to49 = 0
replace thirty5to49 = 1 if AGE2 == 15
* Generates a dummy variable for people between the age of 35 to 23

gen fiftyto64 = 0
replace fiftyto64 = 1 if AGE2 == 16
* Generate a dummy variable for people between the age of 50 to 64

gen sixty5andover = 0
replace sixty5andover = 1 if AGE2 == 17
* Generate a dummy variable for people between the age of 65 and over
* The reference group is people age 20 to 25

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

drop if JBSTATR2 == 98
drop if JBSTATR2 == 99
* Drops observations that did not answer (30/405/527 respondents in 14/15/16)  
* and legitimate skips (6683/6639/7068 respondents in 14/15/16)

gen marjmth = 0
replace marjmth = MJDAY30A if MJDAY30A != 91 & MJDAY30A != 93

save "/Users/davidwan/Downloads/MRP Project/NSDUHcleanfinal.dta"







