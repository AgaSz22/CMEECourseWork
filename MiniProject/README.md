## README file for the MiniProject

### Brief description: 
The aim of the MiniProject was to get familiar with data anlysis and model fitting in the context of bacterial growth.

### Languages
- R language, RStudio 2022.07.2 Build 576 version
- bash
- LaTeX, LaTeX2e version updated in 2020

### Dependencies:
In my analysis, I used following R packages:

- tidyverse: useful for data wrangling, visualization and analysis; contains other packages, such as ggplot2 or dplyr
- minpack.lm: required to call the nlsLM function that incorporates the the Levenberg-Marquardt fitting algorithm
- reshape2: useful for data manipulation; includes functions such as melt(), which was necessary for plotting the violin plots that require long data format
- beepr: contains the beep() function, which notifies the user once the analysis and plotting has been finished; it may be helpful when running the script in the background

and following LaTeX packages:

- inputenc: explicitly states the encoding type, e.g.UTF-8
- graphicx: manages graphics
- geometry: allows to customize page layout
- caption & subcaption: enable to customize captions
- hyperref: allows to produce hypertext links
- babel & tocbibind: needed for referencing

### Project structure:
- code folder: 
  + MiniProject_main_script.R - the main script that performs the data analysis and plotting
  + run_Miniproject.sh - bash script that runs everything
  + Miniproject_good_model.R - produces Fig 1.a
  + Miniproject_bad_model.R - produces Fig 1.b
  + CompileLatex.sh - compiles the final report
  + MiniProject_Latex - words.sum - needed for the automatic word count
  + texcount.pl - needed for the automatic word count
  + MiniProject_Latex.tex - the final report
  + MiniprojectBib.bib - bibliography

- results folder: 
  + Miniproject_Latex.pdf - the final report in a pdf format
  + CMEE_miniproject_output - output table with model parameters and coefficients as well as AICc,  $R^{2}$ etc. values. 
  + population_growth_models.pdf - stores all explorative plots that were not used in the report.

- data folder: 
  + LogisticGrowthData.csv - main dataset
  + LogisticGrowthMetaData.csv - metadata for the main dataset

### Contact: 
Agnes Szwarczynska; aas122@ic.ac.uk
