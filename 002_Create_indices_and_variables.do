
/****    Bureaucratic Locus of Control Replication Code     ****/
/****             DATE: April 26, 2020                      ****/

//This file creates the BLOC indices and other variables used in the analysis
use Ethiopia_Civil_Servants_data_public, clear

// ****** DEFINE THE 4 BLOC COMPONENTS ***********
local internality "m13_LOC_1 m13_LOC_6 m13_LOC_9 m13_LOC_12 m13_LOC_17 m13_LOC_26 m13_LOC_27 m13_LOC_31"
local powerfulothers "m13_LOC_13 m13_LOC_14 m13_LOC_15 m13_LOC_20 m13_LOC_24 m13_LOC_25 m13_LOC_28 m13_LOC_30"
local chance "m13_LOC_5 m13_LOC_7 m13_LOC_10 m13_LOC_18 m13_LOC_19 m13_LOC_22 m13_LOC_23 m13_LOC_29"
local powersystem "m13_LOC_2 m13_LOC_3 m13_LOC_4 m13_LOC_8_rev m13_LOC_11 m13_LOC_16 m13_LOC_21 m13_LOC_32"


// ****************** CREATE BLOC INDICES IN 2 WAYS ***********************************
// **** METHOD 1: Simple aggregated BLOC index without standardization ****************


egen internality1 = rmean(`internality') if loc_final_sample
egen powerfulothers1 = rmean(`powerfulothers') if loc_final_sample
egen chance1 = rmean (`chance') if loc_final_sample
egen powersystem1 = rmean (`powersystem') if loc_final_sample

foreach var of varlist internality1 powerfulothers1 chance1 powersystem1 {
sum `var' if loc_final_sample
gen z_`var' = (`var'-r(mean))/r(sd) if loc_final_sample
}

label variable internality1 "Internality: row means of Internality variables"
label variable powerfulothers1 "Powerful Others: row means of Powerful Other variables"
label variable chance1 "Chance: row means of Chance variables"
label variable powersystem1 "Power of the System: row means of Power of the System variables"

//Reverse of external LOC indices
gen powerfulothers1_rev = -powerfulothers1 if loc_final_sample
gen chance1_rev = -chance1 if loc_final_sample
gen powersystem1_rev = -powersystem1 if loc_final_sample

egen loc1_agg = rowmean(internality1 powerfulothers1_rev chance1_rev powersystem1_rev) if loc_final_sample 
label variable loc1_agg  "Aggregated LOC index 1: row means of all 4 internal and external components"


// **************************************************************************************
// *****************METHOD 2: Create the Standardized BLOC Index ************************

//First standardize each item for each component and then aggregate
foreach var of varlist `internality' {

sum `var'  if loc_final_sample
gen z_`var' = (`var'-r(mean))/r(sd) if loc_final_sample

}
egen internality2 = rmean(z_m13_LOC_1 z_m13_LOC_6 z_m13_LOC_9 z_m13_LOC_12 z_m13_LOC_17 z_m13_LOC_26 z_m13_LOC_27 z_m13_LOC_31) if loc_final_sample


foreach var of varlist `powerfulothers'{

sum `var' if loc_final_sample
gen z_`var' = (`var'-r(mean))/r(sd) if loc_final_sample

}
egen powerfulothers2 = rmean(z_m13_LOC_13 z_m13_LOC_14 z_m13_LOC_15 z_m13_LOC_20 z_m13_LOC_24 z_m13_LOC_25 z_m13_LOC_28 z_m13_LOC_30) if loc_final_sample
 
foreach var of varlist `chance' {
 
sum `var' if loc_final_sample
gen z_`var' = (`var'-r(mean))/r(sd) if loc_final_sample

}
egen chance2 = rmean(z_m13_LOC_5 z_m13_LOC_7 z_m13_LOC_10 z_m13_LOC_18 z_m13_LOC_19 z_m13_LOC_22 z_m13_LOC_23 z_m13_LOC_29) if loc_final_sample

foreach var of varlist `powersystem' {

sum `var' if loc_final_sample
gen z_`var' = (`var'-r(mean))/r(sd) if loc_final_sample

}
egen powersystem2 = rmean(z_m13_LOC_2 z_m13_LOC_3 z_m13_LOC_4 z_m13_LOC_8_rev z_m13_LOC_11 z_m13_LOC_16 z_m13_LOC_21 z_m13_LOC_32) if loc_final_sample

foreach var of varlist internality2 powerfulothers2 chance2 powersystem2 {
sum `var' if loc_final_sample
gen z_`var' = (`var'-r(mean))/r(sd) if loc_final_sample
}

label variable internality2 "Internality"
label variable powerfulothers2 "Powerful Others"
label variable chance2 "Chance"
label variable powersystem2 "Power of the System"
label variable z_internality2 "Aggregate score (standardized) of the Internality Component"
label variable z_powerfulothers2 "Aggregate score (standardized) of the Powerful Others Component"
label variable z_chance2 "Aggregate score (standardized) of the Chance Component"
label variable z_powersystem2 "Aggregate score (standardized) of the Powerful System Component"

//Aggregate components, standardize again 
gen z_powerfulothers2_rev = -z_powerfulothers2 if loc_final_sample
gen z_chance2_rev = -z_chance2 if loc_final_sample
gen z_powersystem2_rev = -z_powersystem2 if loc_final_sample

egen loc_agg = rowmean(z_internality2 z_powerfulothers2_rev z_chance2_rev z_powersystem2_rev) if loc_final_sample
sum loc_agg if loc_final_sample
gen z_loc_agg = (loc_agg-r(mean))/r(sd) if loc_final_sample

label variable loc_agg "Aggregate score of all 4 LOC components"
label variable z_loc_agg "Aggregate score (standardized) of all 4 LOC components"
label variable z_powersystem2_rev "Aggregate score (standardized) of the Powerful System Component reversed"


/*************** ORGANISATION-LEVEL BLOC INDEX ************************/
//Create an organizational aggregation of BLOC items

//Mark the start of the organization if also loc_final_sample
egen tag = tag(organisation_code loc_final_sample)
replace tag = 0 if loc_final_sample == 0

foreach var of varlist internality2 powerfulothers2 chance2 powersystem2 { 
bys organisation_code: egen `var'_orgav = mean(`var') if loc_final_sample

}

foreach var of varlist internality2 powerfulothers2 chance2 powersystem2 {

sum `var'_orgav if tag
gen z_`var'_orgav = (`var'_orgav-r(mean))/r(sd) if tag

}


foreach var of varlist z_powerfulothers2_orgav z_chance2_orgav z_powersystem2_orgav {
gen `var'_rev = -`var'
}

egen loc_aggregate_orgav = rowmean(z_internality2_orgav z_powerfulothers2_orgav_rev z_chance2_orgav_rev z_powersystem2_orgav_rev) if tag


sum loc_aggregate_orgav
gen z_loc_aggregate_orgav = (loc_aggregate_orgav-r(mean))/r(sd) if tag
label variable z_loc_aggregate_orgav "Aggregate organization score (standardized) of all 4 LOC components"


//******************SHORTER BLOC INDEX AFTER 2 FACTOR EFA ******************************
//See "BLOC_analysis_online_appendix.do" for factor analysis

//Shorter factor index as above
global ext_factor_small  z_m13_LOC_14 z_m13_LOC_15 z_m13_LOC_20 z_m13_LOC_24 z_m13_LOC_25 z_m13_LOC_28 z_m13_LOC_30 z_m13_LOC_19 z_m13_LOC_22 z_m13_LOC_29 z_m13_LOC_16 z_m13_LOC_21
global int_factor_small  z_m13_LOC_9 z_m13_LOC_12 z_m13_LOC_26 


//Generate indices from this reduced set of items
egen ext_factor2 = rmean($ext_factor_small) if loc_final_sample
egen int_factor2 = rmean($int_factor_small) if loc_final_sample


foreach var of varlist ext_factor2 int_factor2 {
sum `var' if loc_final_sample
gen z_`var' = (`var'-r(mean))/r(sd) if loc_final_sample
}

label variable ext_factor2 "Smaller set of externality items from factor analysis"
label variable int_factor2 "Smaller set of internality items from factor analysis"
label variable z_ext_factor2 "Smaller set of externality items from factor analysis, standardized"
label variable z_int_factor2 "Smaller set of internality items from factor analysis, standardized"

gen z_ext_factor2_rev = -z_ext_factor2 if loc_final_sample

egen loc_agg_factor2 = rowmean(z_int_factor2 z_ext_factor2_rev) if loc_final_sample
sum loc_agg_factor2 if loc_final_sample
gen z_loc_agg_factor2 = (loc_agg_factor2-r(mean))/r(sd) if loc_final_sample

label variable z_loc_agg_factor2 "Aggregated BLOC Index from smaller set of items after 2 factor EFA"

/************* GINI SCORES *******/
//Calculate GINI scores at the organization level based on the BLOC components

gen gini_internality = . 
gen gini_powerfulothers = .
gen gini_powersystem = .
gen gini_chance = .
gen gini_all =.

levelsof organisation_code
local levels = r(levels)

foreach l of local levels{

  count if organisation_code == `l' & loc_final_sample

  if r(N) > 0{
   ineqdeco internality1 if loc_final_sample & organisation_code == `l'
   replace gini_internality = r(gini) if loc_final_sample & organisation_code == `l'
  }

 }

foreach l of local levels{

  count if organisation_code == `l' & loc_final_sample

  if r(N) > 0{
   ineqdeco powerfulothers1 if loc_final_sample & organisation_code == `l'
   replace gini_powerfulothers = r(gini) if loc_final_sample & organisation_code == `l'
  }

 }
 
foreach l of local levels{

  count if organisation_code == `l' & loc_final_sample

  if r(N) > 0{
   ineqdeco powersystem1 if loc_final_sample & organisation_code == `l'
   replace gini_powersystem = r(gini) if loc_final_sample & organisation_code == `l'
  }

 }
 
foreach l of local levels{

  count if organisation_code == `l' & loc_final_sample

  if r(N) > 0{
   ineqdeco chance1 if loc_final_sample & organisation_code == `l'
   replace gini_chance = r(gini) if loc_final_sample & organisation_code == `l'
  }

 }

//alternate way using the aggregate of all indices and a thiel transformation
gen gini_index = internality1 - powerfulothers1 - powersystem1 - chance1
sum gini_index
replace gini_index = gini_index -r(min)


foreach l of local levels{

  count if organisation_code == `l' & loc_final_sample

  if r(N) > 0{
   ineqdeco gini_index if loc_final_sample & organisation_code == `l'
   replace gini_all = r(gini) if loc_final_sample & organisation_code == `l'
  }

 }
 
label variable gini_internality "Inquality score of distribution of LOC internality items within an organization"
label variable gini_powerfulothers "Inquality score of distribution of LOC powerful others items within an organization"
label variable gini_powersystem "Inquality score of distribution of LOC powerful system items within an organization"
label variable gini_chance "Inquality score of distribution of LOC chance items within an organization"
label variable gini_all "Inquality score of distribution of LOC index, including all 4 components, within an organization"


//Satisfaction
gen satisfied = (m6_1_cs_satisf >=3)
replace satisfied = . if m6_1_cs_satisf == .
label variable satisfied "Satisfied or Very Satisfied with experience in Civil Service"

//Motivation 
gen motiv_more = m6_1_cs_work_motiv2>100
replace motiv_more = . if m6_1_cs_work_motiv2 == .
label variable motiv_more "More motivated now than at start in Civil Service"

//Trust
gen trust = inlist(m6_5_trust_ppl, 3,4)
replace trust = . if m6_5_trust_ppl == .
label variable trust "Trust somewhat or a lot"

//Promotion
gen promotion = inlist(m6_3a_prom_confidence, 4,5)
replace promotion = . if m6_3a_prom_confidence ==.
label variable promotion "Somewhat or very confident of promotion"

//Received award
gen received_award = (m6_4_reward_cert==3)| (m6_4_reward_comm==3) | (m6_4_reward_fb==3)| ///
(m6_4_reward_fin==3) | (m6_4_reward_nonfin==3)| ( m6_4_reward_prom==3)| ( m6_4_reward_raise ==3)

replace received_award = . if (m6_4_reward_cert==900)| (m6_4_reward_comm==900) | (m6_4_reward_fb==900)| ///
 (m6_4_reward_fin==900) | (m6_4_reward_nonfin==900)| ( m6_4_reward_prom==900)| ( m6_4_reward_raise ==900)

replace received_award = . if (m6_4_reward_cert==998)| (m6_4_reward_comm==998) | (m6_4_reward_fb==998)| ///
(m6_4_reward_fin==998) | (m6_4_reward_nonfin==998)| ( m6_4_reward_prom==998)| ( m6_4_reward_raise ==998)

replace received_award = . if m6_4_reward_cert==.
label variable received_award "Received monetary or non-monetary award"

//Save this dataset which can now be used for analysis
save "Ethiopia_Civil_Servants_data_after_var_creation", replace
