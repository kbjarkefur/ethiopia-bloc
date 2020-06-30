
/****    Bureaucratic Locus of Control Replication Code     ****/
/****             DATE: April 26, 2020                      ****/

//Main.do runs the other do files in sequence

//Create these directories for the outputs
//Make a directory called Output which will contain all regression output and figures
capture mkdir "Output"

 
//Run the do files in this order
//Need the command "ineqdeco" installed before running
ssc install ineqdeco
 
do 002_Create_indices_and_variables.do
do 003_BLOC_analysis_main_paper.do
do 004_BLOC_analysis_online_appendix.do
