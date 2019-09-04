* Datafile used: NSDUHcleanfinal.dta
* Author: David Wan
* Date: November 6, 2018
* Sample Size: n=20584
* Data source: NSDHU 2014-2016 cycles
capture log close
cd "/Users/davidwan/Downloads/MRP Project"
log using minorfmmanalysis.log, replace text
* Create log file

clear
use "/Users/davidwan/Downloads/MRP Project/NSDUHcleanminorfinal.dta"
* Use combined NSDUH dataset which has been cleaned
set more off

drop if minor == 0
* 126247 adult observerations dropped 

drop if marjmth == 0
* 18135 observerations dropped 

* Generate an age squared variable
gen agesq = age * age

* Generate age dummies (omitted group is 12 years old)
gen age13 = 0
replace age13 = 1 if age == 13

gen age14 = 0
replace age14 = 1 if age == 14

gen age15 = 0
replace age15 = 1 if age == 15

gen age16 = 0
replace age16 = 1 if age == 16

gen age17 = 0
replace age17 = 1 if age == 17

* Generates a finite mixture model 
fmm marjmth tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW black nativeam nativehi asian hispanic multirace male age agesq, components (2) mixtureof(normal) 
estat ic

fmm marjmth tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW male age13 age14 age15 age16 age17 black nativeam nativehi asian hispanic multirace, components (2) mixtureof(normal) 
estat ic

fmm marjmth tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW black nativeam nativehi asian hispanic multirace male age agesq, components (2) mixtureof(negbin2)
estat ic

fmm marjmth tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW male age13 age14 age15 age16 age17 black nativeam nativehi asian hispanic multirace, components (2) mixtureof(negbin2) difficult
estat ic




histogram marjmth, frequency
