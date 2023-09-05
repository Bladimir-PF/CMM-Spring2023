#######################  PSQF 6272 HW01 using R ################################

# Set width of output and number of significant digits printed,
# number of digits before using scientific notation, shut off significance stars
options(width=120, digits=8, scipen=9, show.signif.stars=FALSE)

#####  Check to see if packages are downloaded, install if not, then load  #####

if (!require("readxl")) install.packages("readxl")
library(readxl) # To import xls or xlsx data as table

if (!require("psych")) install.packages("psych")
library(psych) # To add summary functions

if (!require("lme4")) install.packages("lme4")
library(lme4) # To estimate MLMs using lmer

if (!require("lmerTest")) install.packages("lmerTest")
library(lmerTest) # To get Satterthwaite DDF in lmer

if (!require("performance")) install.packages("performance")
library(performance) # To get ICC using lmer

if (!require("TeachingDemos")) install.packages("TeachingDemos")
library(TeachingDemos) # To create text output files

# Clear workspace (re-run as needed for troubleshooting purposes)
#rm(list = ls())

###########################################################################
# Define variables for working directory and data name -- CHANGE THESE
filesave = "C:\\Dropbox/23_PSQF6272hw/HW01/data/"
filename = "HW01_11111111.xlsx"
setwd(dir=filesave)

# Import homework data
HW01 = read_excel(paste0(filesave,filename)) 
# Convert to data frame to use in analysis
HW01 = as.data.frame(HW01)

# Here are the labels (not to be included in data used in lmer)
#SiteID=    "SiteID: Site ID number"
#PersonID=  "PersonID: Person ID number"
#yrsexp=    "yrsexp: Years Experience of Site Group Leader"
#treattype= "treattype: Treatment A=1 or B=2
#sitetype=  "sitetype: Rural=1 or Urban=2
#anxiety=   "anxiety: Post-Test Anxiety Outcome"

# Your code to create or center predictors goes here


# Open external file to save results to -- turn off to use console instead
txtStart(file="PSQF6272_HW01_Output.txt")

# Your code to estimate models goes here