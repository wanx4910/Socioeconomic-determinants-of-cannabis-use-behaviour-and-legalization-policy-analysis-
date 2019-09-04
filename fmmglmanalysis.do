* Datafile used: NSDUHcleanfinal.dta
* Author: David Wan
* Date: November 6, 2018
* Sample Size: n=15060
* Data source: NSDHU 2014-2016 cycles
capture log close
cd "/Users/davidwan/Downloads/MRP Project"
log using fmmglmanalysis.log, replace text
* Create log file

clear
use "/Users/davidwan/Downloads/MRP Project/NSDUHcleanfinal.dta"
* Use combined NSDUH dataset which has been cleaned
set more off

drop if minor == 1
* 20584 minor with employment observerations dropped 

* Marijuana Use participation in last month
gen marjmthpart = 1
replace marjmthpart = 0 if marjmth == 0

drop if marjmth == 0

fmm marjmth tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad black nativeam nativehi asian hispanic multirace male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover, components (2) mixtureof(normal) 
estat ic

fmm marjmth tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad black nativeam nativehi asian hispanic multirace male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover, components (2) mixtureof(poisson) 
estat ic

histogram marjmth, frequency
*fmm marjmth tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad minor black nativeam nativehi asian hispanic multirace male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover, components (2) mixtureof(negbin2) difficult search(on)

*reg marjmth tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad minor black nativeam nativehi asian hispanic multirace male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover

*ovtest 

*glm marjmth tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad minor black nativeam nativehi asian hispanic multirace male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover
*linktest

*boxcox marjmth tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad minor black nativeam nativehi asian hispanic multirace male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover
