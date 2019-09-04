* Datafile used: NSDUH_2014.dta
* Author: David Wan
* Date: November 2, 2018
* Sample Size: n=55271
* Data source: NSDHU 2014 cycle
capture log close
cd "/Users/davidwan/Downloads/MRP Project"
log using datafile.log, replace text
*Create log file

clear
use "/Users/davidwan/Downloads/MRP Project/NSDUHclean2014.dta"

append using NSDUHclean2015 NSDUHclean2016

save "/Users/davidwan/Downloads/MRP Project/NSDUHclean.dta"
