#######################  PSQF 6272 HW01 using R ################################

# Set width of output and number of significant digits printed,
# number of digits before using scientific notation, shut off significance stars
options(width=120, digits=8, scipen=9, show.signif.stars=FALSE)

#####  Check to see if packages are downloaded, install if not, then load  #####
# if (!require("readxl")) install.packages("readxl")

library(psych) # To add summary functions
library(lme4) # To estimate MLMs using lmer
library(lmerTest) # To get Satterthwaite DDF in lmer
library(performance) # To get ICC using lmer

# Load Jonathan's custom R functions from folder within working directory
functions = paste0("R functions/",dir("R functions/"))
temp = lapply(X=functions, FUN=source)

# Clear workspace (re-run as needed for troubleshooting purposes)
#rm(list = ls())

# Data
dat1 <- data.frame(readxl::read_excel("HW01/HW01_01445225.xlsx"))

# Here are the labels (not to be included in data used in lmer)
#SiteID=    "SiteID: Site ID number"
#PersonID=  "PersonID: Person ID number"
#yrsexp=    "yrsexp: Years Experience of Site Group Leader"
#treattype= "treattype: Treatment A=1 or B=2
#sitetype=  "sitetype: Rural=1 or Urban=2
#anxiety=   "anxiety: Post-Test Anxiety Outcome"

# Your code to create or center predictors goes here
dat1$Treat_B <- dat1$treattype - 1
dat1$YexpLead_5 <- dat1$yrsexp - 5
dat1$Site_Urban <- dat1$sitetype - 1

# Your code to estimate models goes here

## Section 1
m0 <- lmer(formula = anxiety ~ 1 + (1|SiteID),
           REML = T,
           data = dat1)
llikAIC(m0, chkREML=FALSE); summary(m0, ddf="Satterthwaite")
icc(m0); ranova(m0)

summary(m0, ddf="Satterthwaite")$coef[1] - 1.96 * data.frame(VarCorr(m0))[1,5]
summary(m0, ddf="Satterthwaite")$coef[1] + 1.96 * data.frame(VarCorr(m0))[1,5]

## Section 2
m1 <- lmer(formula = anxiety ~ 1 + YexpLead_5 + Site_Urban + (1|SiteID),
           REML = T,
           data = dat1)

llikAIC(m1, chkREML=FALSE); summary(m1, ddf="Satterthwaite")
contestMD(m1, ddf="Satterthwaite", L=rbind(c(0,1,0),c(0,0,1)))
pseudoRSquaredinator(smallerModel=m0, largerModel=m1)
totalRSquaredinator(model=m1, dvName="anxiety", data=dat1)

## Section 3
m2 <- lmer(formula = anxiety ~ 1 + YexpLead_5 + Site_Urban * Treat_B + (1|SiteID),
           REML = T,
           data = dat1)
llikAIC(m2, chkREML=FALSE); summary(m2, ddf="Satterthwaite")
contestMD(m2, ddf="Satterthwaite", L=rbind(c(0,1,0,0,0),c(0,0,1,0,0),c(0,0,0,1,0),c(0,0,0,0,1)))
icc(m2); ranova(m2)
pseudoRSquaredinator(smallerModel=m0, largerModel=m2)
totalRSquaredinator(model=m2, dvName="anxiety", data=dat1)
contest1D(m2, ddf="Satterthwaite", L=rbind(c(0,0,0,1,1)))









