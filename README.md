# Bureaucratic Locus of Control
Kerenssa Kay, Daniel Rogger, and Iman Sen

June 2020

## Notes
The Ethiopian Civil Servants Survey (ECSS) was undertaken by the World Bank’s Bureaucracy Lab between June and September 2016. The survey included professional level staff and directors or heads of federal ministries or agencies, regional bureaus, and woreda (district) offices. It was undertaken in close collaboration with the Ministry of Public Service and Human Resource Development (now the Civil Service Commission).  

To protect the anonymity of Civil Servants in Ethiopia, we have not included any individual level characteristics of civil servants. However, some aggregated characteristics at the organization level have been included.

The public data only includes variables that are used in the analysis of the Bureaucratic Locus of Control, and to show the relationship with outcomes such as performance and motivation.

## Instructions for Replication
1. Click on the "Clone" button on the top left corner of this page to Clone the repository to GitHub desktop or Download a ZIP file with its contents.
1. If you chose to download a ZIP file, extract the zipped folder and files. 
1. To run the code, the data file should be in the same folder as the do files.
1. To reconstruct some of the outputs in the paper run the do file: “001_Master.do”. This will run all the other do files in sequence.
1. All regression output and figures will be saved in the “Output” folder.

## File List
-	Ethiopia_Civil_Servants_data_public.dta: Cleaned and de-identified Ethiopia Civil Servants data containing variables needed to recreate the outputs shown
-	001_Master.do creates the “Output” directory and runs the other do files in sequence
-	002_Create_indices_and_variables.do: Creates the BLOC indices and other variables used in the analysis
-	003_BLOC_analysis_main_paper.do: Creates exact or modified outputs for Tables 1,2,4,5 and Figures 1A and 1B in paper
-	004_BLOC_analysis_online_appendix.do: Creates outputs for Tables OA6, OA7A, OA7B and Figure OA2 in the online appendix
