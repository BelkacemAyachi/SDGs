**************************************************************************
*** Calculate SDG Indicators
*** Using MICS 2014 survey for Sudan
***
*** REPLICATION (AJA)
**************************************************************************




***************************** PREPARING DATA ***************************** 
clear
set more off
cd "C:\Users\10078203\Desktop\SDGs Publication\Sudan\MICS 2014\Replication\Data"

use "hh.dta", clear
rename _all, lower

gen zeros = "0"
egen hh_id_zero1 = concat(hh1 zeros hh2) if hh2 >= 1 & hh2 <= 9
egen hh_id = concat(hh1 hh2) if hh2 >= 10 & hh2 <= 99
replace hh_id = hh_id_zero1 if hh2 >= 1 & hh2 <= 9
destring hh_id, replace
format hh_id %18.0g
label variable hh_id "household ID"
drop hh_id_zero1 zeros

gen governorate = hh7
label define governorate 11 "Northern" 12 "River Nile" 21 "Red Sea" 22 "Kassala" 23 "Gadarif" 31 "Khartoum" 41 "Gezira" 42 "White Nile" 43 "Sinnar" 44 "Blue Nile" 51 "North Kordofan" 52 "South Kordofan" 53 "West Kordofan" 61 "North Darfor" 62 "West Darfor" 63 "South Darfor" 64 "Central Darfor" 65 "East Darfor" 
label variable governorate "governorate"
label values governorate governorate 

save "HHroster_su_mics14.dta", replace

use "hl.dta", clear
rename _all, lower

gen zeros = "0"
egen hh_id_zero1 = concat(hh1 zeros hh2) if hh2 >= 1 & hh2 <= 9
egen hh_id = concat(hh1 hh2) if hh2 >= 10 & hh2 <= 99
replace hh_id = hh_id_zero1 if hh2 >= 1 & hh2 <= 9
label variable hh_id "household ID"
drop hh_id_zero1

egen ind_id_zero1 = concat(hh_id zeros hl1) if hl1 >= 1 & hl1 <= 9
egen ind_id = concat(hh_id hl1) if hl1 >= 10 & hl1 <= 99
replace ind_id = ind_id_zero1 if hl1 >= 1 & hl1 <= 9
destring ind_id, replace 
format ind_id %18.0g
label variable ind_id "individual ID"
drop ind_id_zero1 zeros

destring hh_id, replace
format hh_id %18.0g

gen governorate = hh7
label define governorate 11 "Northern" 12 "River Nile" 21 "Red Sea" 22 "Kassala" 23 "Gadarif" 31 "Khartoum" 41 "Gezira" 42 "White Nile" 43 "Sinnar" 44 "Blue Nile" 51 "North Kordofan" 52 "South Kordofan" 53 "West Kordofan" 61 "North Darfor" 62 "West Darfor" 63 "South Darfor" 64 "Central Darfor" 65 "East Darfor" 
label variable governorate "governorate"
label values governorate governorate 

save "INDroster_su_mics14.dta", replace

use "bh.dta", clear
rename _all, lower

gen zeros = "0"
egen hh_id_zero1 = concat(hh1 zeros hh2) if hh2 >= 1 & hh2 <= 9
egen hh_id = concat(hh1 hh2) if hh2 >= 10 & hh2 <= 99
replace hh_id = hh_id_zero1 if hh2 >= 1 & hh2 <= 9
destring hh_id, replace
format hh_id %18.0g
label variable hh_id "household ID"
drop hh_id_zero1
tostring hh_id, replace
format hh_id  %18s

*bh8 = 0 not in household listing
egen ind_id_zero1 = concat(hh_id bh8) if bh8 >= 10 & bh8 <= 99
egen ind_id_zero2 = concat(hh_id zeros bh8) if bh8 >= 1 & bh8 <= 9
gen ind_id = ind_id_zero1
replace ind_id = ind_id_zero2 if bh8 >= 1 & bh8 <= 9
destring ind_id, replace
format ind_id %18.0g
label variable ind_id "individual ID"
drop ind_id_zero1 ind_id_zero2

egen mother_id_zero1 = concat(hh_id zeros ln) if ln >= 1 & ln <= 9
egen mother_id = concat(hh_id ln) if ln >= 10 & ln <= 99
replace mother_id = mother_id_zero1 if ln >= 1 & ln <= 9
destring mother_id, replace 
format mother_id %18.0g
label variable mother_id "mother ID"
drop mother_id_zero1
destring hh_id, replace
format hh_id %18.0g

gen governorate = hh7
label define governorate 11 "Northern" 12 "River Nile" 21 "Red Sea" 22 "Kassala" 23 "Gadarif" 31 "Khartoum" 41 "Gezira" 42 "White Nile" 43 "Sinnar" 44 "Blue Nile" 51 "North Kordofan" 52 "South Kordofan" 53 "West Kordofan" 61 "North Darfor" 62 "West Darfor" 63 "South Darfor" 64 "Central Darfor" 65 "East Darfor" 
label variable governorate "governorate"
label values governorate governorate 

save "BHroster_su_mics14.dta", replace

use "wm.dta", clear
rename _all, lower

gen zeros = "0"
egen hh_id_zero1 = concat(hh1 zeros hh2) if hh2 >= 1 & hh2 <= 9
egen hh_id = concat(hh1 hh2) if hh2 >= 10 & hh2 <= 99
replace hh_id = hh_id_zero1 if hh2 >= 1 & hh2 <= 9
destring hh_id, replace
format hh_id %18.0g
label variable hh_id "household ID"
drop hh_id_zero1
tostring hh_id, replace
format hh_id  %18s

egen ind_id_zero1 = concat(hh_id zeros ln) if ln >= 1 & ln <= 9
egen ind_id = concat(hh_id ln) if ln >= 10 & ln <= 99
replace ind_id = ind_id_zero1 if ln >= 1 & ln <= 9
destring ind_id, replace 
format ind_id %18.0g
label variable ind_id "individual ID"
drop ind_id_zero1
destring hh_id, replace
format hh_id %18.0g

gen governorate = hh7
label define governorate 11 "Northern" 12 "River Nile" 21 "Red Sea" 22 "Kassala" 23 "Gadarif" 31 "Khartoum" 41 "Gezira" 42 "White Nile" 43 "Sinnar" 44 "Blue Nile" 51 "North Kordofan" 52 "South Kordofan" 53 "West Kordofan" 61 "North Darfor" 62 "West Darfor" 63 "South Darfor" 64 "Central Darfor" 65 "East Darfor" 
label variable governorate "governorate"
label values governorate governorate 

save "WMroster_su_mics14.dta", replace

use "ch.dta", clear
rename _all, lower

gen zeros = "0"
egen hh_id_zero1 = concat(hh1 zeros hh2) if hh2 >= 1 & hh2 <= 9
egen hh_id = concat(hh1 hh2) if hh2 >= 10 & hh2 <= 99
replace hh_id = hh_id_zero1 if hh2 >= 1 & hh2 <= 9
destring hh_id, replace
format hh_id %18.0g
label variable hh_id "household ID"
drop hh_id_zero1
tostring hh_id, replace
format hh_id  %18s

egen ind_id_zero1 = concat(hh_id zeros ln) if ln >= 1 & ln <= 9
egen ind_id = concat(hh_id ln) if ln >= 10 & ln <= 99
replace ind_id = ind_id_zero1 if ln >= 1 & ln <= 9
destring ind_id, replace 
format ind_id %18.0g
label variable ind_id "individual ID"
drop ind_id_zero1
destring hh_id, replace
format hh_id %18.0g

gen governorate = hh7
label define governorate 11 "Northern" 12 "River Nile" 21 "Red Sea" 22 "Kassala" 23 "Gadarif" 31 "Khartoum" 41 "Gezira" 42 "White Nile" 43 "Sinnar" 44 "Blue Nile" 51 "North Kordofan" 52 "South Kordofan" 53 "West Kordofan" 61 "North Darfor" 62 "West Darfor" 63 "South Darfor" 64 "Central Darfor" 65 "East Darfor" 
label variable governorate "governorate"
label values governorate governorate 

save "CHroster_su_mics14.dta", replace



***************************** CALCULATING SDG's *****************************

clear
set more off
cd "C:\Users\10078203\Desktop\SDGs Publication\Sudan\MICS 2014\Replication\Data"

*** SDG Goal 1. End poverty in all its forms everywhere
***	SDG Target 1.3. Implement nationally appropriate social protection systems and measures for all, including floors, and by 2030 achieve substantial coverage of the poor and the vulnerable
*** SDG Indicator 1.3.1. Proportion of population covered by social protection floors/systems, by sex, distinguishing children, unemployed persons, older persons, persons with disabilities, pregnant women, newborns, work-injury victims and the poor and the vulnerable
*** MICS Module Social transfers (ST)
*** MICS Indicator Chapter 14. Social transfers
*** MICS Indicator 14.1. Population covered by social transfers (Number of household members that received any type of social transfers and benefits in the last 3 months/Total number of household members)

*Not available

*** SDG Goal 1. End poverty in all its forms everywhere
***	SDG Target 1.4. By 2030, ensure that all men and women, in particular the poor and the vulnerable, have equal rights to economic resources, as well as access to basic services, ownership and control over land and other forms of property, inheritance, natural resources, appropriate new technology and financial services, including microfinance
*** SDG Indicator 1.4.1. Proportion of population living in households with access to basic services
*** MICS Module Water and sanitation (WS)
*** MICS Indicator Chapter 4. Water, sanitation, and hygiene
*** MICS Indicator 4.2. Use of basic drinking water service (Number of household members using improved sources of drinking water either in their dwelling/yard/plot or within 30 minutes round trip collection time/Total number of household members)

use "HHroster_su_mics14.dta", clear

gen improved_water=0
replace improved_water =1 if ws1==11 | ws1==12 | ws1==13 | ws1==14 | ws1==15 | ws1==31 | ws1==41 | ((ws1 == 91 ) & (ws1==11 | ws1==12 | ws1==13 | ws1==14 | ws1==15 | ws1==31 | ws1==41))
label var improved_water "improved sources of drinking-water"
label values improved_water yes_no

gen hhweight1 = hh11*hhweight
sum improved_water if hh9 == 1 [aw = hhweight1]
scalar sdg_141a = r(mean)*100
scalar list sdg_141a

save "HHroster_su_mics14.dta", replace

*** SDG Goal 1. End poverty in all its forms everywhere
***	SDG Target 1.4. By 2030, ensure that all men and women, in particular the poor and the vulnerable, have equal rights to economic resources, as well as access to basic services, ownership and control over land and other forms of property, inheritance, natural resources, appropriate new technology and financial services, including microfinance
*** SDG Indicator 1.4.1. Proportion of population living in households with access to basic services
*** MICS Module Water and sanitation (WS)
*** MICS Indicator Chapter 4. Water, sanitation, and hygiene
*** MICS Indicator 4.8. Use of basic sanitation service (Number of household members using improved sanitation facilities which are not shared/Total number of household members)

use "HHroster_su_mics14.dta", clear

gen shared_toilet = 3
replace shared_toilet = 2 if ws11 >= 1 & ws11 <= 5
replace shared_toilet = 9 if ws11 == 98 | ws11 == 99
replace shared_toilet = 0 if ws11 == .
replace shared_toilet = 1 if ws10 == 2
label variable shared_toilet "shared toilet"
label define shared_toilet 0 "not shared" 1 "public facility" 2 "5 households or less" 3 "more than 5 households" 9 "missing/dk"
label values shared_toilet shared_toilet

gen improved_sanitation=0
replace improved_sanitation =1 if shared_toilet==0 & (ws8==11 | ws8==12 | ws8==13 | ws8==14 | ws8==15 | ws8==21| ws8==22 | ws8==31)
label var improved_sanitation "Percentage of household members using improved sanitation facilities which are not shared"
label values improved_sanitation yes_no
sum improved_sanitation if hh9 == 1 [aw = hhweight1]
scalar sdg_141b = r(mean)*100
scalar list sdg_141b

save "HHroster_su_mics14.dta", replace

*** SDG Goal 2. End hunger, achieve food security and improved nutrition and promote sustainable agriculture
***	SDG Target 2.2. By 2030, end all forms of malnutrition, including achieving, by 2025, the internationally agreed targets on stunting and wasting in children under 5 years of age, and address the nutritional needs of adolescent girls, pregnant and lactating women and older persons
*** SDG Indicator 2.2.1. Prevalence of stunting (height for age <-2 standard deviation from the median of the World Health Organization (WHO) Child Growth Standards) among children under 5 years of age
*** SDG Indicator 2.2.2. Prevalence of malnutrition (weight for height >+2 or <-2 standard deviation from the median of the WHO Child Growth Standards) among children under 5 years of age, by type (wasting and overweight)
*** MICS Module Anthropometry (AN)
*** MICS Indicator Chapter 2. Nutrition
*** MICS Indicator 2.2. Stunting prevalence (Number of children under age 5 who fall below (a) minus two standard deviations (moderate and severe) (b) below minus three standard deviations (severe) of the median height for age of the WHO standard/Total number of children under age 5)
*** MICS Indicator 2.3. Wasting prevalence (Number of children under age 5 who fall below (a) minus two standard deviations (moderate and severe) (b) minus three standard deviations (severe) of the median weight for height of the WHO standard/Total number of children under age 5)
*** MICS Indicator 2.4. Overweight prevalence (Number of children under age 5 who are above two standard deviations of the median weight for height of the WHO standard/Total number of children under age 5)use "CHroster_su_mics14.dta", clear

use "CHroster_su_mics14.dta", clear


**** Weight for age
gen underweight = 0
replace underweight = 1 if waz2<-2
label var underweight "underweight"
label values underweight yes_no
sum underweight if waz2<=6 & uf9==1 & wazflag==0 [aw=chweight]
scalar sdg_222d = r(mean)*100
scalar list sdg_222d

gen sev_underweight = 0
replace sev_underweight = 1 if waz2<-3
label var sev_underweight "severely underweight"
label values sev_underweight yes_no
sum sev_underweight if waz2<=6 & uf9==1 & wazflag==0 [aw=chweight]
scalar sdg_222e = r(mean)*100
scalar list sdg_222e

**** Height for age
gen stunted = 0
replace stunted = 1 if haz2<-2
label var stunted "stunted"
label values stunted yes_no
sum stunted if haz2<=6 & uf9==1 & hazflag==0 [aw=chweight]
scalar sdg_221a = r(mean)*100
scalar list sdg_221a

gen sev_stunted = 0
replace sev_stunted = 1 if haz2<-3
label var sev_stunted "severely stunted"
label values sev_stunted yes_no
sum sev_stunted if haz2<=6 & uf9==1 & hazflag==0 [aw=chweight]
scalar sdg_221b = r(mean)*100
scalar list sdg_221b

**** Weight for height
gen wasted = 0
replace wasted = 1 if whz2 <- 2
label var wasted "wasted"
label values wasted yes_no
sum wasted if whz2<=6 & uf9==1 & whzflag==0 [aw=chweight]
scalar sdg_222a = r(mean)*100
scalar list sdg_222a

gen sev_wasted = 0
replace sev_wasted = 1 if whz2<-3
label var sev_wasted "severely wasted"
label values sev_wasted yes_no
sum sev_wasted if whz2<=6 & uf9==1 & whzflag==0 [aw=chweight]
scalar sdg_222b = r(mean)*100
scalar list sdg_222b

gen overweight = 0
replace overweight = 1 if whz2>2 & whz2<=6 
label var overweight "overweight"
label values overweight yes_no
sum overweight if whz2<=6 & uf9==1 & whzflag==0 [aw=chweight]
scalar sdg_222c = r(mean)*100
scalar list sdg_222c

save "CHroster_su_mics14.dta", replace

*** SDG Goal 3. Ensure healthy lives and promote well-being for all at all ages
***	SDG Target 3.2. By 2030, end preventable deaths of newborns and children under 5 years of age, with all countries aiming to reduce neonatal mortality to at least as low as 12 per 1,000 live births and under-5 mortality to at least as low as 25 per 1,000 live births
*** SDG Indicator 3.2.1. Under-five mortality rate
*** MICS Modules Birth history (BH) and Child mortality (CM)
*** MICS Indicator Chapter 1. Mortality
*** MICS Indicator 1.5. Under-five mortality rate (Probability of dying between birth and the fifth birthday)

* to be calculated later!!!

*** SDG Goal 3. Ensure healthy lives and promote well-being for all at all ages
***	SDG Target 3.2. By 2030, end preventable deaths of newborns and children under 5 years of age, with all countries aiming to reduce neonatal mortality to at least as low as 12 per 1,000 live births and under-5 mortality to at least as low as 25 per 1,000 live births
*** SDG Indicator 3.2.2. Neonatal mortality rate
*** MICS Module Birth history (BH)
*** MICS Indicator Chapter 1. Mortality
*** MICS Indicator 1.1. Neonatal mortality rate (Probability of dying within the first month of life, i.e. 0-30 days)

* to be calculated later!!!
 
*** SDG Goal 3. Ensure healthy lives and promote well-being for all at all ages
***	SDG Target 3.1. By 2030, reduce the global maternal mortality ratio to less than 70 per 100,000 live births
*** SDG Indicator 3.1.1. Maternal mortality ratio
*** MICS Module Maternal mortality (MM)
*** MICS Indicator Chapter 5. Reproductive health 
*** MICS Indicator 5.19. Maternal mortality ratio (Deaths during pregnancy, childbirth, or within two months after delivery or termination of pregnancy, per 100,000 births within the 7-year period preceding the survey)

* Not available

*** SDG Goal 3. Ensure healthy lives and promote well-being for all at all ages
***	SDG Target 3.1. By 2030, reduce the global maternal mortality ratio to less than 70 per 100,000 live births
*** SDG Indicator 3.1.2. Proportion of births attended by skilled health personnel
*** MICS Module Maternal and newborn health (MN)
*** MICS Indicator Chapter 5. Reproductive health 
*** MICS Indicator 5.7. Skilled attendant at delivery (Number of women age 15-49 years with a live birth in the last 2 years who were attended by skilled health personnel during their most recent live birth/Total number of women age 15-49 years with a live birth in the last 2 years)

use "WMroster_su_mics14.dta", clear

/* 
Completed survey if wm7==1
Last birth in last two years if cm13=="Y"

mn17a=="A" "Medical doctor" 
mn17b=="B" 12 "Nurse / Midwife" 
mn17c=="C" 13 "Health Visitor" 
mn17d=="D" 14 "Trained midwife" 
mn17e=="E" 15 "Medical assistant" 
mn17f=="F" 16 "Traditional birth attendant" 
mn17g=="G" 17 "Community health worker"
mn17x=="X" "Other/missing" 
mn17y=="Y" 98 "No attendant"
*/

gen skilled_attendant = 0
replace skilled_attendant = 1 if mn17a=="A" | mn17b=="B" | mn17d=="D"
label var skilled_attendant "Delivery assisted by any skilled attendant"
label values skilled_attendant yes_no

sum skilled_attendant if wm7==1 & cm13=="Y" [aw=wmweight]
scalar sdg_312 = r(mean)*100
scalar list sdg_312

save "WMroster_su_mics14.dta", replace

*** SDG Goal 3. Ensure healthy lives and promote well-being for all at all ages
***	SDG Target 3.7. By 2030, ensure universal access to sexual and reproductive health-care services, including for family planning, information and education, and the integration of reproductive health into national strategies and programmes
*** SDG Indicator 3.7.1. Proportion of women of reproductive age (aged 15-49 years) who have their need for family planning satisfied with modern methods
*** MICS Module Unmet need (UN)
*** MICS Indicator Chapter 5. Reproductive health 
*** MICS Indicator 5.4. Met need (Number of women of reproductive age (aged 15-49 years) who have their need for family planning satisfied with modern methods/Total number of women age 15-49 years who are currently married or in union)

use "WMroster_su_mics14.dta", clear

*** Met need for limiting
* Married woman using contraceptive method (cp2==1), want no more children (un6==2), 
* using male/female sterilization(does not exist for Sudan, otherwise cp3a=="A" | cp3b=="B"), or 
* declared infecund (un6==3 | un7n==94)
gen met_limit = 0 if mstatus==1
replace met_limit = 1 if cp2==1 & (un6==2 | un6==3 | un7n==94)
sum met_limit if wm7==1 [aw = wmweight], meanonly
scalar sdg_371b = r(mean)*100
scalar list sdg_371b

*** Total met need => contraceptive prevalence among married women 
gen met_need = 0
replace met_need = 1 if cp2==1
sum met_need if mstatus==1 & wm7==1 [aw = wmweight], meanonly
scalar sdg_371 = r(mean)*100
scalar list sdg_371

*** Met need for spacing => "subtracting" met_limit from total met_need
gen met_space = met_need
replace met_space = 0 if met_limit==1
sum met_space if mstatus==1 & wm7==1 [aw = wmweight], meanonly
scalar sdg_371a = r(mean)*100
scalar list sdg_371a

save "WMroster_su_mics14.dta", replace


*** SDG Goal 3. Ensure healthy lives and promote well-being for all at all ages
*** SDG Target 3.7. By 2030, ensure universal access to sexual and reproductive health-care services, including for family planning, information and education, and the integration of reproductive health into national strategies and programmes
*** SDG Indicator 3.7.2. Adolescent birth rate (aged 10-14 years; aged 15-19 years) per 1,000 women in that age group
*** MICS Modules Birth history (BH) and Child mortality (CM)
*** MICS Indicator Chapter 5. Reproductive health 
*** MICS Indicator 5.1. Adolescent birth rate (Age-specific fertility rate for women age 15-19 years)

* Information are necessary to compute fertility rates (all CMC): 
*(1) the dates of births of the children: bh4c
*(2) the date of birth of each woman: wdob
*(3) the date of the survey: wdoi 

use "BHroster_su_mics14.dta", clear

sort hh1 hh_id mother_id bhln
keep hh_id ind_id mother_id bh4c wdob wmweight wdoi hh1 hh2 ln bhln

* identifier for women
egen ident_mom=group(hh1 hh_id mother_id)
egen ident_ind=group(hh1 hh_id mother_id bhln)

* birth number: This is different from bhln !!! 
by ident_mom (bh4c), sort: gene numb=_n

* wide format
reshape wide bh4c, i(ident_ind) j(numb)

tfr2, bvar(bh4c1-bh4c18) length(3) dates(wdoi) wbirth(wdob) ageg(5) awf(wmweight) gr se
*tfr2, bvar(bh4c1-bh4c18) length(3) dates(wdoi) wbirth(wdob) ageg(5) awf(wmweight) gr se saverates("asfr_tfr_iq_mics11")

*[NO MATCH]


** SDG Goal 3. Ensure healthy lives and promote well-being for all at all ages
***	SDG Target 3.b. upport the research and development of vaccines and medicines for the communicable and non-communicable diseases that primarily 
*** affect developing countries, provide access to affordable essential medicines and vaccines, in accordance with the Doha Declaration on 
*** the TRIPS Agreement and Public Health, which affirms the right of developing countries to use to the full the provisions in the Agreement on 
*** Trade-Related Aspects of Intellectual Property Rights regarding flexibilities to protect public health, and, in particular, provide access to medicines for all
*** SDG Indicator 3.b.1. Proportion of the target population covered by all vaccines included in their national programme
*** MICS Modules Immunization (IM)
*** MICS Indicator Chapter 3. Child health
*** MICS Indicator 3.11. Full immunization coverage (Number of children age 12-23/24-35 months who received 
*** all vaccinations recommended in the national immunization schedule by their first/second birthday/Total number of children age 12-23/24-35 months)

use "CHroster_su_mics14.dta", clear

* Fully vaccinated if BCG, Polio3, Pentavalent3 and Measles 1 (MCV1) as per the vaccination schedule in Sudan

*** Compute dates
generate childs_birthday=mdy(ag1m,ag1d,ag1y)
format childs_birthday %td

*BCG
generate date_of_bcg_vac=mdy(im3bm,im3bd,im3by) 
format date_of_bcg_vac %td

*Polio3
generate date_of_polio3_vac=mdy(im3opv3m,im3opv3d,im3opv3y) 
format date_of_polio3_vac %td

*Pentavalent3
generate date_of_penta3_vac=mdy(im3penta3m,im3penta3d,im3penta3y) 
format date_of_penta3_vac %td

*Measles 1
generate date_of_measles1_vac=mdy(im3m1m,im3m1d,im3m1y) 
format date_of_measles1_vac %td


foreach i in bcg polio3 penta3 measles1 {

gen years_`i' =floor(((ym(year(date_of_`i'_vac), month(date_of_`i'_vac)) - ym(year(childs_birthday), month(childs_birthday))) - (day(date_of_`i'_vac) < day(childs_birthday))) / 12)
gen months_`i' =(ym(year(date_of_`i'_vac), month(date_of_`i'_vac)) - ym(year(childs_birthday), month(childs_birthday))) - (day(date_of_`i'_vac) < day(childs_birthday)) - 12*years_`i'
gen days_`i'=date_of_`i'_vac - (dofm(mofd(childs_birthday) + 12*years_`i' + months_`i') + day(childs_birthday) - 1)

label var years_`i' "Child's age (years) at `i' vaccination"
label var months_`i' "Child's age (month) at `i' vaccination"
label var days_`i' "Child's age in (day) at `i' vaccination"
}

*** Denominator: children with vaccination card im1==1
gen fully_vaccinated = 0
replace fully_vaccinated = 1 if years_bcg<1 & years_polio3<1 & years_penta3<1 & years_measles1<1
label var fully_vaccinated "Received all vaccinations by first birthday"
*** Children age 12-23 months 
sum fully_vaccinated if uf9 == 1 & im1==1 & cage >= 12 & cage <= 23 [aw=chweight], meanonly
scalar sdg_3b1a = r(mean)*100
scalar list sdg_3b1a
*** Children age 24-35 months 
sum fully_vaccinated if uf9 == 1 & im1==1 & cage >= 24 & cage <= 35 [aw=chweight], meanonly
scalar sdg_3b1b = r(mean)*100
scalar list sdg_3b1b

save "CHroster_su_mics14.dta", replace


*** SDG Goal 4. Ensure inclusive and equitable quality education and promote lifelong learning opportunities for all
*** SDG Target 4.2. By 2030, ensure that all girls and boys have access to quality early childhood development, care and pre-primary education so that they are ready for primary education
*** SDG Indicator 4.2.2. Participation rate in organized learning (one year before the official primary entry age), by sex
*** MICS Modules Early childhood development (EC)
*** MICS Indicator Chapter 7. Literacy and education 
*** MICS Indicator 7.2. Attendance to early childhood education (Number of children in the relevant age group (one year before the official primary entry age) who are attending an early childhood education programme/Total number of children in the relevant age group)

use "CHroster_su_mics14.dta", clear

gen early_edu = 0
replace early_edu = 1 if cage >= 36 & cage <= 59 & ec5 == 1
label var early_edu "Attending an early childhood education programme"
label value early_edu yes_no
sum early_edu if uf9==1 & cage >= 36 & cage <= 59 [aw=chweight]
scalar sdg_422 = r(mean)*100
scalar list sdg_422

save "CHroster_su_mics14.dta", replace

*** SDG Goal 4. Ensure inclusive and equitable quality education and promote lifelong learning opportunities for all
*** SDG Target 4.5. By 2030, eliminate gender disparities in education and ensure equal access to all levels of education and vocational training for the vulnerable, including persons with disabilities, indigenous peoples and children in vulnerable situations
*** SDG Indicator 4.5.1. Parity indices (female/male, rural/urban, bottom/top wealth quintile and others such as disability status, indigenous peoples and conflict-affected, as data become available) for all education indicators on this list that can be disaggregated
*** MICS Modules Education (ED)
*** MICS Indicator Chapter 7. Literacy and education 
*** MICS Indicator 7.19.a. Education parity indices gender (Net attendance ratio (adjusted) for girls (a) primary school (b) lower secondary school (c) upper secondary school/Net attendance ratio (adjusted) for boys (a) primary school (b) lower secondary school (c) upper secondary school)
*** MICS Indicator 7.19.b. Education parity indices wealth (Net attendance ratio (adjusted) for the poorest quintile (a) primary school (b) lower secondary school (c) upper secondary school/Net attendance ratio (adjusted) for the richest quintile (a) primary school (b) lower secondary school (c) upper secondary school)
*** MICS Indicator 7.19.c. Education parity indices residence (Net attendance ratio (adjusted) for rural residents (a) primary school (b) lower secondary school (c) upper secondary school/Net attendance ratio (adjusted) for the urban residents (a) primary school (b) lower secondary school (c) upper secondary school)

use "INDroster_su_mics14.dta", clear

*** Gender parity index - primary school

* primary school age: 6 to 13 years as in "schage"
gen primary = 0
* Attend primary or higher
replace primary = 1 if schage>=6 & schage<=13 & ed6a>=3 & ed6a<=8
* Adjust for students already completed primary earlier
replace primary = 1 if schage==13 & ed5a ==2& ed4a==3 & ed4b==8
label var primary "Net primary school attendance, adjusted"
label value primary yes_no
sum primary if schage>=6 & schage<=13 [aw=hhweight]

sum primary if hl4==1 & schage>=6 & schage<=13 [aw=hhweight], meanonly
scalar primary_male = r(mean)*100
scalar list primary_male
sum primary if hl4==2 & schage>=6 & schage<=13 [aw=hhweight], meanonly
scalar primary_female = r(mean)*100
scalar list primary_female
scalar primary_parity = primary_female/primary_male
scalar list primary_parity 

*** Gender parity index - secondary school 

* secondary school age: 14 to 16 years as in "schage"
gen secondary = 0 
* Attend secondary or higher
replace secondary = 1 if schage>=14 & schage<=16 & ed6a>=8 & ed6a<=12
* Adjust for students already completed secondary earlier 
replace secondary = 1 if schage==16 & ed5a ==2 & (ed4a==7 | ed4a==8 |ed4a==9) & ed4b>=3 
label var secondary "Net secondary school attendance, adjusted"
label value secondary yes_no
sum secondary if schage>=14 & schage<=16 [aw=hhweight]

sum secondary if hl4==1 & schage>=14 & schage<=16 [aw=hhweight], meanonly
scalar secondary_male = r(mean)*100
scalar list secondary_male
sum secondary if hl4==2 & schage>=14 & schage<=16 [aw=hhweight], meanonly
scalar secondary_female = r(mean)*100
scalar list secondary_female
scalar secondary_parity = secondary_female/secondary_male
scalar list secondary_parity

* ////////////////////////////////////////////////////////////////////////////* 

*** Wealth - primary
sum primary if windex5==1 & schage>=6 & schage<=13 [aw=hhweight], meanonly
scalar poorest_primary = r(mean)*100
sum primary if windex5==5 & schage>=6 & schage<=13 [aw=hhweight], meanonly
scalar richest_primary = r(mean)*100
scalar wealth_primary_parity = poorest_primary/richest_primary
scalar list wealth_primary_parity

*** Wealth - secondary
sum secondary if windex5==1 & schage>=14 & schage<=16 [aw=hhweight], meanonly
scalar poorest_secondary = r(mean)*100
sum secondary if windex5==5 & schage>=14 & schage<=16 [aw=hhweight], meanonly
scalar richest_secondary = r(mean)*100
scalar wealth_secondary_parity = poorest_secondary/richest_secondary
scalar list wealth_secondary_parity 

*** Residence - primary
sum primary if hh6==2 & schage>=6 & schage<=13 [aw=hhweight], meanonly
scalar rural_primary = r(mean)*100
sum primary if hh6==1 & schage>=6 & schage<=13 [aw=hhweight], meanonly
scalar urban_primary = r(mean)*100
scalar residence_primary_parity = rural_primary/urban_primary
scalar list residence_primary_parity

*** Residence - secondary
sum secondary if hh6==2 & schage>=14 & schage<=16 [aw=hhweight], meanonly
scalar rural_secondary = r(mean)*100
sum secondary if hh6==1 & schage>=14 & schage<=16 [aw=hhweight], meanonly
scalar urban_secondary = r(mean)*100
scalar residence_secondary_parity = rural_secondary/urban_secondary
scalar list residence_secondary_parity

save "INDroster_su_mics14.dta", replace


*** SDG Goal 5. Achieve gender equality and empower all women and girls
*** SDG Target 5.3. Eliminate all harmful practices, such as child, early and forced marriage and female genital mutilation 
*** SDG Indicator 5.3.1. Proportion of women aged 20-24 years who were married or in a union before age 15 and before age 18
*** MICS Modules Marriage/Union (MA)
*** MICS Indicator Chapter 8. Child protection
*** MICS Indicator 8.5.a. Early marriage (Number of women age 20-24 years who were first married or in union before age 15/Total number of women age 20-24 years)
*** MICS Indicator 8.5.b. Early marriage (Number of women age 20-24 years who were first married or in union before age 18/Total number of women age 20-24 years)

use "WMroster_su_mics14.dta", clear

* Denominator: Women who were first married/in union (ma1==1 | ma1==2 | ma5==1 | ma5==2)

gen marriage_u15 = 0
replace marriage_u15 = 1 if ma9<15 | wagem <15
sum marriage_u15 if wm7==1 & (ma1==1 | ma1==2 | ma5==1 | ma5==2) [aw = wmweight]
label var marriage_u15 "First married or in union before age 15"
label value marriage_u15 yes_no
scalar sdg_531a = r(mean)*100
scalar list sdg_531a

gen marriage_u18 = 0
replace marriage_u18 = 1 if ma9<18 | wagem <18
sum marriage_u18 if wm7==1 & (ma1==1 | ma1==2 | ma5==1 | ma5==2) [aw = wmweight]
label var marriage_u18 "First married or in union before age 18"
label value marriage_u18 yes_no
scalar sdg_531b = r(mean)*100
scalar list sdg_531b

save "WMroster_su_mics14.dta", replace

*** SDG Goal 5. Achieve gender equality and empower all women and girls
*** SDG Target 5.3. Eliminate all harmful practices, such as child, early and forced marriage and female genital mutilation 
*** SDG Indicator 5.3.2. Proportion of girls and women aged 15-49 years who have undergone female genital mutilation/cutting, by age
*** MICS Modules Female genital mutilation/cutting (FG)
*** MICS Indicator Chapter 8. Child protection
*** MICS Indicator 8.10. Prevalence of FGM/C among women (Number of women age 15-49 years who report to have undergone any form of FGM/C/Total number of women age 15-49 years)

use "WMroster_su_mics14.dta", clear

gen fgm = 0
replace fgm = 1 if fg3==1
label var fgm "Ever circumcised/Experienced female genital mutilation"
label value fgm yes_no

sum fgm if wm7==1 [aw = wmweight], meanonly
scalar sdg_532 = r(mean)*100
scalar list sdg_532

save "WMroster_su_mics14.dta", replace

*** SDG Goal 6. Achieve gender equality and empower all women and girls
*** SDG Target 6.2. By 2030, achieve access to adequate and equitable sanitation and hygiene for all and end open defecation, paying special attention to the needs of women and girls and those in vulnerable situations
*** SDG Indicator 6.2.1. Proportion of population using safely managed sanitation services, including a hand-washing facility with soap and water
*** MICS Modules Handwashing (HW)
*** MICS Indicator Chapter 4. Water, sanitation, and hygiene
*** MICS Indicator 4.11. Handwashing facility with water and soap  (Number of household members with a fixed place for hand washing where water and soap or detergent are present/Total number of household members)

use "HHroster_su_mics14.dta", clear

gen handwashing = 0
replace handwashing=1 if hw2==1 & hw3a==1
label var handwashing "Handwashing facility with water and soap"
label value handwashing yes_no

* Denominator: handwashing observed by interviewer (hw1==1) and households with no place for handwashing (hw1 = 2)
sum handwashing if hh9==1 & (hw1==1 | hw1==2) [aw=hhweight]
scalar sdg_621 = r(mean)*100
scalar list sdg_621

save "HHroster_su_mics14.dta", replace

*** SDG Goal 7. Ensure access to affordable, reliable, sustainable and modern energy for all
*** SDG Target 7.1. By 2030, ensure universal access to affordable, reliable and modern energy services
*** SDG Indicator 7.1.1. Proportion of population with access to electricity
*** MICS Modules Household characteristics (HC)
*** MICS Indicator Chapter 13. Household energy use
*** MICS Indicator 13.1. Access to electricity (Number of household members with access to electricity/Total number of household members)

use "HHroster_su_mics14.dta", clear

gen electricity = 0
replace electricity = 1 if hc8a==1
label var electricity "Access to electricity"
label value electricity yes_no

sum electricity if hh9==1 [aw=hhweight]
scalar sdg_711 = r(mean)*100
scalar list sdg_711

save "HHroster_su_mics14.dta", replace

*** SDG Goal 8. Promote sustained, inclusive and sustainable economic growth, full and productive employment and decent work for all
*** SDG Target 8.7. Take immediate and effective measures to eradicate forced labour, end modern slavery and human trafficking and secure the prohibition and elimination of the worst forms of child labour, including recruitment and use of child soldiers, and by 2025 end child labour in all its forms
*** SDG Indicator 8.7.1. Proportion and number of children aged 5-17 years engaged in child labour, by sex and age
*** MICS Modules Child labour (CL)
*** MICS Indicator Chapter 8. Child protection
*** MICS Indicator 8.2. Child labour (Number of children age 5-17 years who are involved in child labour/Total number of children age 5-17 years)

use "HHroster_su_mics14.dta", clear

*** Child based weights need to be applied instead of HH weights 
* 1. calculate total number of children age 1 - 17 unweighted in order to properly normalize weights.
egen totunw = count(sl1) 
label var totunw "total number of children age 1 - 17"
* 2. compute temporary weight: household weight multiplied with total number of children age 1-17
gen tmpw = hhweight*sl1
* 3. Calculate total number of households with at least one child age 1 - 17 to normalize weights.
egen totw=count(sl1) if sl1>=1 & sl1<=17
label var totw "total number of households with at least one child age 1 - 17"
* 4. Compute slweight
gen slweight = tmpw*totunw/totw
label var slweight "Child based weight"


* 1. Children's involvement in economic activities classified as child labour
* i. age 5-11: 1 hour or more
* ii. age 12-14: 14 hours or more
* iii. age 15-17: 43 hours or more
* The number for the involvement in economic activities are established in CL4.

gen economic_activ_5_11 = 0 if sl9c>=5 & sl9c<=11
replace economic_activ_5_11 = 1 if cl4>=1 & cl4<90
sum economic_activ_5_11 if hh9 == 1 & sl9c>=5 & sl9c<=11 & cl4>=1 [aw = slweight]

gen economic_activ_12_14 = 0 if sl9c>=12 & sl9c<=14
replace economic_activ_12_14 = 1 if cl4>=14 & cl4<90
sum economic_activ_12_14 if hh9 == 1 & sl9c>=12 & sl9c<=14 & cl4>=14 [aw = slweight]

gen economic_activ_15_17 = 0 if sl9c>=15 & sl9c<=17
replace economic_activ_15_17 = 1 if cl4>=43 & cl4<90
sum economic_activ_15_17 if hh9 == 1 & sl9c>=15 & sl9c<=17 & cl4>=43 [aw = slweight]

gen economic_activ = 0 if sl9c>=5 & sl9c<=17
replace economic_activ = 1 if (economic_activ_5_11==1 | economic_activ_12_14==1 | economic_activ_15_17==1)
label var economic_activ "Child is involved in economic activities classified as child labor"
label value economic_activ yes_no

sum economic_activ if hh9 == 1 & sl9c>=5 & sl9c<=17 [aw = slweight]
scalar sdg_871a = r(mean)*100
scalar list sdg_871a


* 2. Children's involvement in household chores
* i. age 5-11 and age 12-14: 28 hours or more
* ii. age 15-17: 43 hours or more
* The number for the involvement in economic activities are established in cl9 and CL12.

gen household_chores_5_14 = 0 if sl9c>=5 & sl9c<=14
replace household_chores_5_14 = 1 if cl12>=28 & cl12<90
sum household_chores_5_14 if hh9 == 1 & sl9c>=5 & sl9c<=14 & cl12>=28 [aw = slweight]

gen household_chores_15_17 = 0 if sl9c>=15 & sl9c<=17
replace household_chores_15_17 = 1 if cl12>=43 & cl12<90
sum household_chores_15_17 if hh9 == 1 & sl9c>=15 & sl9c<=17 & cl12>=43 [aw = slweight]

gen household_chores = 0 if sl9c>=5 & sl9c<=17
replace household_chores = 1 if (household_chores_5_14==1 | household_chores_15_17==1)
 
sum household_chores if hh9 == 1 & sl9c>=5 & sl9c<=17 [aw = slweight]
scalar sdg_871b = r(mean)*100
scalar list sdg_871b


* Total child labour
gen child_labour = 0 if sl9c>=5 & sl9c<=17
replace child_labour = 1 if (economic_activ==1 | household_chores==1)

sum child_labour if hh9 == 1 & sl9c>=5 & sl9c<=17 [aw = slweight]
scalar sdg_871 = r(mean)*100
scalar list sdg_871
save "HHroster_su_mics14.dta", replace


*** SDG Goal 16. Promote peaceful and inclusive societies for sustainable development, provide access to justice for all and build effective, accountable and inclusive institutions at all levels
*** SDG Target 16.2. End abuse, exploitation, trafficking and all forms of violence against and torture of children
*** SDG Indicator 16.2.1. Proportion of children aged 1-17 years who experienced any physical punishment and/or psychological aggression by caregivers in the past month
*** MICS Modules Child discipline (1-4) (UCD) and Child discipline (5-14) (FCD)
*** MICS Indicator Chapter 8. Child protection
*** MICS Indicator 8.3. Violent discipline (Number of children age 1-14 years who experienced any physical punishment and/or psychological aggression by caregivers in the past one month/Total number of children age 1-14 years)

use "HHroster_su_mics14.dta", clear

gen violent_discipline = 0 if sl9c>=1 & sl9c<=14
replace violent_discipline = 1 if cd3c==1 | cd3d==1 | cd3f==1 | cd3g==1 | cd3h==1 | cd3i==1 | cd3j==1 | cd3k==1
label var violent_discipline "Any violent discipline method"
label value violent_discipline yes_no

sum violent_discipline if hh9 == 1 & sl9c>=1 & sl9c<=14 [aw = slweight]
scalar sdg_1621 = r(mean)*100
scalar list sdg_1621

save "HHroster_su_mics14.dta", replace

*** SDG Goal 16. Promote peaceful and inclusive societies for sustainable development, provide access to justice for all and build effective, accountable and inclusive institutions at all levels
*** SDG Target 16.9. By 2030, provide legal identity for all, including birth registration
*** SDG Indicator 16.9.1. Proportion of children under 5 years of age whose births have been registered with a civil authority, by age
*** MICS Modules Birth registration (BR)
*** MICS Indicator Chapter 8. Child protection
*** MICS Indicator 8.1. Birth registration (Number of children under age 5 whose births are reported registered with a civil authority/Total number of children under age 5)

use "CHroster_su_mics14.dta", clear

gen birth_registrated = 0
replace birth_registrated = 1 if br1==1 | br1==2 | br2==1
label var birth_registrated "Total birth registrated"
label value birth_registrated yes_no

sum birth_registrated if uf9 == 1 [aw = chweight]
scalar sdg_1691 = r(mean)*100
scalar list sdg_1691

save "CHroster_su_mics14.dta", replace
