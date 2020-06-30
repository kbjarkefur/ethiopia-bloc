

/****    Bureaucratic Locus of Control Replication Code     ****/
/****             DATE: April 26, 2020                      ****/


/****************************************************************

This file replicates some of the Tables and Figures in the main paper.

NOTE: Variables including any identifying information as well as individual 
characteristics that when put together may identify individuals have been
removed from the dataset to preserve the privacy of Ethiopian Civil Servants. 

*****************************************************************/

//Import dataset with BLOC indices and variables
use Ethiopia_Civil_Servants_data_after_var_creation, clear

*****************************************  TABLE 1 **************************************************

//Summary stats for all BLOC variables by internal and external components
//NOTE: This code does not create the output table, but shows the summary statistics

//Internal Component
local internality "m13_LOC_17 m13_LOC_9 m13_LOC_6 m13_LOC_31 m13_LOC_26 m13_LOC_27 m13_LOC_12 m13_LOC_1"
//External Components
local powerfulothers "m13_LOC_15 m13_LOC_13 m13_LOC_24 m13_LOC_20 m13_LOC_28 m13_LOC_25 m13_LOC_14 m13_LOC_30"
local chance "m13_LOC_5 m13_LOC_22 m13_LOC_18 m13_LOC_7 m13_LOC_10 m13_LOC_23 m13_LOC_19 m13_LOC_29"
local powersystem "m13_LOC_11 m13_LOC_4 m13_LOC_3 m13_LOC_2 m13_LOC_16 m13_LOC_8_rev m13_LOC_21 m13_LOC_32"

//Output in Stata
tabstat `internality' if loc_final_sample , stat(mean sd N) col(stat)
tabstat `powerfulothers' if loc_final_sample , stat(mean sd N) col(stat)
tabstat `chance' if loc_final_sample , stat(mean sd N) col(stat)
tabstat `powersystem' if loc_final_sample , stat(mean sd N) col(stat)


*****************************************  TABLE 2  **************************************************

//Summary Statistics for Aggregate BLOC Indices

//BLOC Indices summary statistics including aggregate index, and internal and external components
foreach var of varlist loc1_agg internality1 powerfulothers1 chance1 powersystem1 {

tabstat `var' if loc_final_sample, s(mean sd)

}


*****************************************  TABLE 4 **************************************************

//Relation between BLOC and various Motivation and Performance Indicators
//Dependent Variable: Aggregated and Standardized BLOC scale including all 4 components
//NOTE: this shows an example of how the regressions were run, but won't recreate exact results as the individual control variables are not included in the dataset


//Column 1: Appraisal
reg z_loc_agg bsc_total_staff_list if loc_final_sample,  cluster(organisation_code)

//Column 2: Job Satisfaction (only asked to employees)
reg z_loc_agg satisfied if loc_final_sample, cluster(organisation_code)

//Column 3: Motivation (only asked to employees)
reg z_loc_agg motiv_more if loc_final_sample, cluster(organisation_code)

//Column 4: Trust (only asked to employees)
reg z_loc_agg trust if loc_final_sample, cluster(organisation_code)

//Column 5: Career track (only asked to employees)
reg z_loc_agg m6_1_comb_career_track if loc_final_sample, cluster(organisation_code)

//Column 6: Confidence in promotion
reg z_loc_agg promotion if loc_final_sample, cluster(organisation_code)

//Column 7: Received award
reg z_loc_agg received_award if loc_final_sample, cluster(organisation_code)


*****************************************  TABLE 5 **************************************************
//Relation between BLOC and Measures of Inequality of Locus of Control distribution at the organizational level

//List controls at the organization level
local org_controls female_org m2_1_resp_age_org _3_tertiaryeduc_org _4_masterseduc_org currpos_org m2_1_civserv_yrs_org m2_1_civserv_org_nr_org m2_1_currorg_yrs_org _1_grade_org manager_org

foreach var of varlist gini_internality gini_powerfulothers  gini_chance gini_powersystem gini_all{

reg z_loc_aggregate_orgav `var' `org_controls', robust 
local pvalue = Ftail(e(df_m), e(df_r), e(F))
outreg2 using "Output\Table5.xls", br adjr2 keep(`var') addstat("F stat", e(F), "P-value", `pvalue' ) nocons addtext("Organizational Controls:Yes")


}

***************************************  FIGURES  ****************************************************
//Figures 1A and 1B
//Optional: set scheme plotplain
//Distribution of the standardized loc aggregate score and individual components

kdensity z_loc_agg if loc_final_sample, saving("Output//z_loc_agg", replace)
kdensity z_internality2 if loc_final_sample, saving("Output//z_loc_internality", replace)
kdensity z_powerfulothers2 if loc_final_sample, saving("Output//z_loc_powerfulothers", replace)
kdensity z_chance2 if loc_final_sample, saving("Output//z_loc_chance", replace)
kdensity z_powersystem2 if loc_final_sample, saving("Output//z_loc_powersystem", replace)
  
