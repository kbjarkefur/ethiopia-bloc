
/****    Bureaucratic Locus of Control Replication Code     ****/
/****             DATE: April 26, 2020                      ****/


/****************************************************************

This file replicates a few tables in the Online Appendix.

NOTE: Variables including any identifying information as well as individual 
characteristics that when put together may identify individuals has been
removed from the dataset to preserve the privacy of Ethiopian Civil Servants. 

*****************************************************************/


//Import dataset with BLOC indices and variables
use Ethiopia_Civil_Servants_data_after_var_creation, clear


*****************************************  TABLE OA6 **************************************************
//Factor analysis and loadings for 2 and 4 factor solutions

//Define the components
global internality_vars m13_LOC_1 m13_LOC_6 m13_LOC_9 m13_LOC_12 m13_LOC_17 m13_LOC_26 m13_LOC_27 m13_LOC_31
global powerfulothers_vars m13_LOC_13 m13_LOC_14 m13_LOC_15 m13_LOC_20 m13_LOC_24 m13_LOC_25 m13_LOC_28 m13_LOC_30
global chance_vars m13_LOC_5 m13_LOC_7 m13_LOC_10 m13_LOC_18 m13_LOC_19 m13_LOC_22 m13_LOC_23 m13_LOC_29
global powersystem_vars m13_LOC_2 m13_LOC_3 m13_LOC_4 m13_LOC_8 m13_LOC_11 m13_LOC_16 m13_LOC_21 m13_LOC_32

//Exploratory Factor Analysis
//2 factors
factor $internality_vars $powerfulothers_vars $chance_vars $powersystem_vars if loc_final_sample,  factors(2)
rotate, promax factors(2)
//Figure OA2
screeplot

//4 factors
factor $internality_vars $powerfulothers_vars $chance_vars $powersystem_vars if loc_final_sample, factors(4)
rotate, promax factors(4)

*****************************************  TABLE AO7A **************************************************

//Alpha Scores

//All items
alpha $internality_vars $powerfulothers_vars $chance_vars $powersystem_vars if loc_final_sample,  item
//Individual Components
alpha $internality_vars if loc_final_sample, item
alpha $powerfulothers_vars if loc_final_sample, item
alpha $chance_vars if loc_final_sample, item
alpha $powersystem_vars if loc_final_sample, item 

//All items included in smaller scale derived from factor analysis
 alpha m13_LOC_14 m13_LOC_15 m13_LOC_20 m13_LOC_24 m13_LOC_25 m13_LOC_28 m13_LOC_30 m13_LOC_19 m13_LOC_22 ///
 m13_LOC_29 m13_LOC_16 m13_LOC_21 m13_LOC_9 m13_LOC_12 m13_LOC_26 if loc_final_sample, item 

 *****************************************  TABLE AO7B **************************************************

//Correlations between BLOC components
pwcorr z_internality2 z_powerfulothers2 z_chance2 z_powersystem2 if loc_final_sample, star(0.01)





 
