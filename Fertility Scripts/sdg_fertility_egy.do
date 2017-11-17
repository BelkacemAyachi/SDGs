*** SDG Goal 3. Ensure healthy lives and promote well-being for all at all ages
*** SDG Target 3.7. By 2030, ensure universal access to sexual and reproductive health-care services, including for family planning, information and education, and the integration of reproductive health into national strategies and programmes
*** SDG Indicator 3.7.2. Adolescent birth rate (aged 10-14 years; aged 15-19 years) per 1,000 women in that age group
*** MICS Modules Birth history (BH) and Child mortality (CM)
*** MICS Indicator Chapter 5. Reproductive health 
*** MICS Indicator 5.1. Adolescent birth rate (Age-specific fertility rate for women age 15-19 years)


*******  MICS5 - RH1
*******  MICS5 - 06 - fert_b.sps  for calculation of births.
*******  MICS5 - 06 - fert_e.sps  for calculation of exposure.
*******  MICS5 - 06 - fert_c.sps  for calculation of probabilities and rates, and final tables.


clear
set more off
cd "C:\Users\10064142\Desktop\SDGs Publication\Egypt\DHS 2014\Datasets"
*use "Datasets 20170807/BHroster_su_mics14.dta", clear
*gen maxper = 5
*gen period = 36


forvalue zinou=1/18 {

use "EGBR61FL.dta", clear
gen maxper = 5
gen period = 36

tab sgov, gen(gov)

forvalue anast=1/4{
keep if gov`zinou'==1

*if (`zinou'==1) keep if bh3 == 1
*if (`zinou'==2) keep if bh3 == 2 
*if (`zinou'==3) keep if hh6 == 1
*if (`zinou'==4) keep if hh6 == 1





* Select subsample to study
* For entire sample, comment out all lines
* and REPEAT BELOW FOR STEP 2!!!
* keep if bh3 == 1 		/*** Boys ***/
* keep if bh3 == 2 		/*** Girls ***/
* keep if hh6 == 1 		/*** Urban ***/
* keep if hh6 == 2 		/*** Rural ***/


**************************** STEP 1: BIRTHS **************************************
* Calculates births to women 10-49 for specified periods preceding the interview *
**********************************************************************************

* Set upper and lower limits for date of analysis period (delete month of interview)
gen upplim = v008 - 1 
gen lowlim = v008 - (maxper * period)

* Weight Data
svyset [pw = v005]

* Compute mother's age at the time of birth
gen agembm = (v011 - wdob)

* Creates age groups for mothers
gen age5 = int(agembm / 60) - 2
drop if age5 <= 0
label var age5 "Mother's age at time of the birth"
label define age5  1 "15-19" 2 "20-24" 3 "25-29" 4 "30-34" 5 "35-39" 6 "40-44" 7 "45-49"
label value age5 age5

* Select only children born in the periods of analysis
keep if v011 >= lowlim & v011 <= upplim

* Determine period of birth
gen colper = int((upplim - v011) / period)
label var colper "Number of years preceding the survey"
label define colper 0 "0-2" 1 "3-5" 2 "6-8" 3 "9-11" 4 "12-14"
label value colper colper

* Aggregate births by age group and save to "births.txt"
forvalues i = 0/4 {
	svy: tab age5 if colper == `i', count
	tabout age5 using "sdg_su_incomplete\births`i'.txt" if colper == `i', svy style(csv) format(7) h1(nil) h2(nil) h3(nil) replace
}

*
* Compile and save to "births.dta"
forvalues i = 0/4 {
	insheet using "sdg_su_incomplete\births`i'.txt", delimiter(",") clear
	gen colper = `i'
	rename v1 age5
	rename v2 births
	drop if age5 == "Total"
	save "sdg_su_incomplete\births`i'.dta", replace
	erase "sdg_su_incomplete\births`i'.txt"
}
use "sdg_su_incomplete\births0.dta", clear
forvalues i = 1/4 {
append using "sdg_su_incomplete\births`i'.dta"
erase "sdg_su_incomplete\births`i'.dta"
}
erase "sdg_su_incomplete\births0.dta"
sort colper age5
label define colper 0 "0-2" 1 "3-5" 2 "6-8" 3 "9-11" 4 "12-14"
label value colper colper
order colper age5 births
save "sdg_su_incomplete\births.dta", replace


************************************ STEP 2: EXPOSURE ***********************************************
* Calculates exposure of all women 10-49 years of age for specified periods preceding the interview *
*****************************************************************************************************

set more off
use "Datasets 20170807/WMroster_su_mics14.dta", clear
gen maxper = 5
gen period = 36

* Select subsample to study
* For entire sample, comment out all lines
* and REPEAT BELOW FOR STEP 2!!!
* keep if bh3 == 1 		/*** Boys ***/
* keep if bh3 == 2 		/*** Girls ***/
* keep if hh6 == 1 		/*** Urban ***/
* keep if hh6 == 2 		/*** Rural ***/

gen colper = 0
gen age = .
gen age5 = .
gen upplim = .
gen lowlim = .
gen highexp = .
gen lowexp = .
gen rweight = .
label var age5 "Mother's age at time of the birth"
label define age5  1 "15-19" 2 "20-24" 3 "25-29" 4 "30-34" 5 "35-39" 6 "40-44" 7 "45-49"
label var colper "Number of years preceding the survey"
label define colper 0 "0-2" 1 "3-5" 2 "6-8" 3 "9-11" 4 "12-14"

forvalues i = 0/4 {
	* Set upper limits for date of analysis period
	replace upplim = v008 - (period * colper) - 1
	* Calculate age of woman and her 5-year age group
	replace age = upplim - wdob
	replace age5 = int(age / 60)
	label value age5 age5
	* Calculate exposure in months in the current age group and previous age group during the analysis period. 
	* higexp = exposure in current age group during the analysis period in months.
	* lowexp = exposure in previous age group during the analysis period in months.
	replace highexp = age - (age5 * 60) + 1
	replace highexp = period if highexp > period
	replace lowexp = 0
	replace lowexp = period - highexp if highexp < period
	* Create a weight equal to exposure in current age group
	replace rweight = highexp * v005
	svyset [pw = rweight]
	* This sets 15-19 = 1, rather than 3 as above. Other age groups are similarly affected (i.e., 20-24 becomes 2 instead of 4).
	replace age5 = age5 - 2
	* Output high end exposure to aggregate file; women younger than 15 are excluded.
	svy: tab age5 highexp if age5 > 0, count
	tabout age5 highexp if age5 > 0 using "sdg_su_incomplete\highexp`i'.txt", svy style(csv) format(7) h1(nil) h2(nil) h3(nil) replace
	* Create a weight equal to exposure in previous age-group.
	replace rweight = lowexp * v005
	svyset [pw = rweight]
	* Reduce age group by one (i.e., the value of age5 for women 15-19 drops from 1 to 0;the value of age5 for women 20-24 drops from 2 to 1, and so one for the other age groups.
	replace age5 = age5 - 1
	* Output low end exposure to aggregate file; women younger than 20 are excluded.
	svy: tab age5 lowexp if age5 > 0 & lowexp > 0, count
	tabout age5 lowexp if age5 > 0 & lowexp > 0 using "sdg_su_incomplete\lowexp`i'.txt", svy style(csv) format(7) h1(nil) h2(nil) h3(nil) replace
	* Define period for next iteration.
	replace colper = colper + 1
}

* Aggregate data on exposure

forvalues i = 0/4 {
	insheet using "sdg_su_incomplete\highexp`i'.txt", delimiter(",") clear
	keep v1 v38
	drop if v1 == "Total" | v1 == ""
	gen colper = `i'
	rename (v1 v38) (age5 exposure)
	order colper age5 exposure
	save "sdg_su_incomplete\highexp`i'.dta", replace
	erase "sdg_su_incomplete\highexp`i'.txt"
	insheet using "sdg_su_incomplete\lowexp`i'.txt", delimiter(",") clear
	keep v1 v38
	drop if v1 == "Total" | v1 == ""
	gen colper = `i'
	rename (v1 v38) (age5 exposure)
	order colper age5 exposure
	save "sdg_su_incomplete\lowexp`i'.dta", replace
	erase "sdg_su_incomplete\lowexp`i'.txt"
}

use "sdg_su_incomplete\highexp0.dta", clear
append using "sdg_su_incomplete\lowexp0.dta"
forvalues i = 1/4 {
append using "sdg_su_incomplete\highexp`i'.dta"
append using "sdg_su_incomplete\lowexp`i'.dta"
erase "sdg_su_incomplete\highexp`i'.dta"
erase "sdg_su_incomplete\lowexp`i'.dta"
}
erase "sdg_su_incomplete\highexp0.dta"
erase "sdg_su_incomplete\lowexp0.dta"
collapse (sum) exposure, by(colper age5)
replace exposure = exposure / 12
save "sdg_su_incomplete\exposure.dta", replace


************************************************ STEP 3: FERTILITY RATES **************************************************
* Calculates age-specific fertility rates for all women 15-49 years of age for specified periods preceeding the interview *
***************************************************************************************************************************

* Merge births and exposure in each age group
use "sdg_su_incomplete\births.dta", clear
merge 1:1 colper age5 using "sdg_su_incomplete\exposure.dta"
drop if _merge != 3
drop _merge
sort colper age5
drop if age5 == "10-14"

* Set the value of births equal to 0 if its current value is system missing
replace births = 0 if births == .

* Calculate age-specific fertility rates
gen asfr = 1000 * births / exposure

* Accumulate age-specific fertility rates
gen sumasfr = .
replace sumasfr = asfr if age5 == "15-19"
replace sumasfr  = asfr + sumasfr[_n-1] if (age5 != "15-19" & age5 != "10-14")

gen cum_births = .
gen cum_expos = .
replace cum_births = births if age5 == "15-19"
replace cum_expos = exposure if age5 == "15-19"
replace cum_births  = births + cum_births[_n-1] if (age5 != "15-19" & age5 != "10-14")
replace cum_expos  = exposure + cum_expos[_n-1] if (age5 != "15-19" & age5 != "10-14")

* Calculate total fertility rate. 
* The total fertility rate (TFR) is calculated by summing the age-specific fertility rates (sumasfr) calculated for each of the 5-year age groups of women,
* from age 15 through to age 49. The TFR denotes the average number of children to which a woman will have given birth by the end of her reproductive years (by age 50) 
* if current fertility rates prevailed
gen tfr  = 5 * sumasfr / 1000

* The general fertility rate (GFR) is the number of live births to women age 15-49 years during a specified period,
* divided by the average number of women in the same age group during the same period, expressed per 1,000 women
gen gfr = 1000 * cum_births / cum_expos if age5 == "45-49"

label var age5 "Mother's age at time of the birth"
label var colper "Number of years preceding the survey"
label var births "Births"
label var exposure "Exposure"
label var asfr "Age Specific Fertility Rate"
label var tfr "Total Fertility Rate"
label var gfr "General Fertility Rate"

tabstat asfr tfr if colper == 0, by(age5) nototal
save "fertility_gov`zinou'", replace

}
*end of the zinou loop

*end of the anast loop
}
