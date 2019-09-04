* Datafile used: NSDUHcleanfinal.dta
* Author: David Wan
* Date: November 6, 2018
* Sample Size: n=126247
* Data source: NSDHU 2014-2016 cycles
capture log close
cd "/Users/davidwan/Downloads/MRP Project"
log using MRPanalysis.log, replace text
* Create log file

clear
use "/Users/davidwan/Downloads/MRP Project/NSDUHcleanfinal.dta"
* Use combined NSDUH dataset which has been cleaned
set more off

* Education variables (Omitted group is High School graduates)
* lessthanhs somecol colgrad 

* Age (Omitted group is people 20 to 25)
* under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover

* Employment Status (Omitted Group is full time workers)
* parttimewrk volunteerwrk umemployed disabled housekeeper student retiree nojobother

* Income (Omitted group is people making 75k and over)
* tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k

* Race (Omitted group is white)
* black nativeam nativehi asian hispanic multirace

* Gender (Omitted group is females)
* male

* Marijuana Law regime
tab MEDMJLAW

* Marijuana Use intensity in last month
tab marjmth

drop if minor == 1
* 20584 non adult observerations dropped 

* Marijuana Use participation in last month
gen marjmthpart = 1
replace marjmthpart = 0 if marjmth == 0

*Marijuana Use intesnity in last year
tab mrdaypyr

* Probability models for marijuana participation

reg marjmthpart tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover

reg marjmthpart tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover parttimewrk volunteerwrk umemployed disabled housekeeper student retiree nojobother 

reg marjmthpart tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover parttimewrk volunteerwrk umemployed disabled housekeeper student retiree nojobother black nativeam nativehi asian hispanic multirace

*logit marjmthpart tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover
*mfx

*logit marjmthpart tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover parttimewrk volunteerwrk umemployed disabled housekeeper student retiree nojobother 
*mfx

logit marjmthpart tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover parttimewrk volunteerwrk umemployed disabled housekeeper student retiree nojobother black nativeam nativehi asian hispanic multirace
mfx

*probit marjmthpart tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover
*mfx

*probit marjmthpart tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover parttimewrk volunteerwrk umemployed disabled housekeeper student retiree nojobother 
*mfx

probit marjmthpart tenkorlower tenkto20k twentykto30k thirtykto40k fourtykto50k fiftykto75k MEDMJLAW lessthanhs somecol colgrad male under20 twenty6to29 thirtyto34 thirty5to49 fiftyto64 sixty5andover parttimewrk volunteerwrk umemployed disabled housekeeper student retiree nojobother black nativeam nativehi asian hispanic multirace
mfx
