# PSGE 7711: Week 11
# Measurement Invariance with Test Anxiety Data 


# This output provides documentation for an analysis looking at whether the assumption of measurement invariance holds between individuals who identify as male or female.



###
# Opening this R script file
# If this file has not opened in the RStudio app, that means you either need to download one of the following:
## R (https://cran.r-project.org/)
## RStudio (https://posit.co/download/rstudio-desktop/)
# Both are free to download and install.

# If both are installed and you are still not opening in Rstudio, that means you should right-click on this file to open it with the RStudio app.



### 
# Installing or Loading Required Packages
# install.packages("psych")
library(psych)
# install.packages("lavaan")
library(lavaan)
# Useful tutorial for conducting CFA in lavaan package: https://lavaan.ugent.be/tutorial/cfa.html



#################
# Create/set working directory
#################

## Before you go any further, create a folder where you plan to save this file and any other R script files or data files for this course. 
## Move all of those files to that folder.
## This folder will serve as your working direcotry


## This next piece of code is very important as it will help the R application "find" the data you are trying to use or save any output files you are trying to create.
wd <- getwd() # this gets your working directory and saves it as an object in your R environment.
setwd(wd) # this sets your working directory. 

# If you check the "Console" at the bottom of your R Studio window, you should see that the wd is the same as the folder path you just moved this file to.


#################
# Importing data
#################

## Make sure that your data file is saved to the same folder as this file. For the time-being
load("test_anxiety_data.Rdata") 

# you can also import the file as a .csv as follows:
ta_csv <- read.csv("test_anxiety_data.csv")


#################
# Review variable labeling
#################

# This file consists of some previously published student demographic data and responses to a 12-item measure of test anxiety.

# The items are as follows Students responded to each of these using a 5-point Likert scale (1=Strongly Disagree,..., 5=Strongly Agree)
# # Affective Dimensions
# ## Physiological arousal 
# "I feel very jittery when taking an important test." = ta_01
# "While taking examinations, I don't feel uneasy or upset. [R]" = ta_02R
# "I feel very panicky when I take an important test." = ta_03
# 
# ## Tension
# "During tests, I can feel relaxed. [R]" = ta_04R
# "During important tests, I am so tense that my stomach gets upset." = ta_05
# "During examinations, I feel calm and facts or ideas come to me fluidly. [R]" = ta_06R


# # Cognitive Dimension
# ## Worry
# "I feel defeated while working on important tests." = ta_07
# "I feel confident while taking tests. [R]" = ta_08R
# "Even when I'm well prepared for a test, I feel very nervous about it." = ta_09
#
# ## Cognitive interference
# "Thoughts of doing poorly on a test don't interfere with my ability to concentrate. [R]" = ta_10R
# "During tests, I find myself thinking about the consequences of failing." = ta_11
# "My mind feels clear when I am working on a test. [R]" = ta_12R


#################
# Check over and inspect the data file
#################
str(ta_data)

View(ta_data)

head(ta_data)

nrow(ta_data)


#################
# Specify the Unidimensional Model
#################

ta_model <- ' ta_latent_factor  =~ ta_01 + ta_02R + ta_03 
                                  + ta_04R + ta_05 + ta_06R
                                  + ta_07 + ta_08R + ta_09
                                  + ta_10R + ta_11 + ta_12R '

## Fit the model to our data
ta_cfa <- cfa(ta_model, data = ta_data)


## Check the model fit indices and factor loadings
summary(ta_cfa, fit.measures = TRUE, standardized = TRUE)

standardizedsolution(ta_cfa)

## Save some fit measures we're interested in to compare with those of other models we wil run later in this script
ta_cfa.fitmeasures <- 
  fitMeasures(ta_cfa, c("chisq","pvalue","df",
                         "cfi","tli",
                         "rmsea", "rmsea.ci.lower", "rmsea.ci.upper",
                         "srmr", "mfi"))


#################
# Test for Measurement Invariance  
#################

## Testing for measurement invariance of the construct between male and female respondents.  

## Testing CFA  

## Step 1: Configural model
ta_model_configural.fit <- 
  cfa(ta_model, 
      estimator = "WLSM", 
      group = "biological_sex_n",
      std.lv = TRUE, 
      verbose = FALSE,
      data = ta_data)
summary(ta_model_configural.fit, fit.measures = TRUE)


## Step 2: The metric invariance model (only factor loadings constrained)
ta_model_metric.fit <- 
  cfa(ta_model, 
      estimator = "WLSM",
      group = "biological_sex_n",
      group.equal = c("loadings"),
      #group.partial = c(""),
      std.lv = TRUE, 
      verbose = FALSE,
      data = ta_data)
summary(ta_model_metric.fit, fit.measures=TRUE)


### Compare configural and metric invariance models  
ta_model_metric.anova <- anova(ta_model_metric.fit, ta_model_configural.fit)



## Step 3: The scalar invariance model (both factor loadings and intercepts constrained)
ta_model_scalar.fit <- 
  cfa(ta_model, 
      estimator = "WLSM", 
      group = "biological_sex_n",
      group.equal = c("loadings", 
                      "intercepts"),
      group.partial = c(""),
      std.lv = TRUE, 
      verbose = FALSE,
      data = ta_data)
summary(ta_model_scalar.fit, fit.measures=TRUE)

### Compare metric and scalar invariance models  
ta_model_scalar.anova <- anova(ta_model_scalar.fit, ta_model_metric.fit)


## Step 4: The strict invariance model (factor loadings, intercepts, and residuals constrained)  
ta_model_strict.fit <- 
  cfa(ta_model, 
      estimator = "WLSM", 
      group = "biological_sex_n",
      group.equal = c("loadings", 
                      "intercepts", 
                      "residuals",
                      "lv.variances"), # the (residual) variances of the latent variables
      group.partial = c(""),
      std.lv = TRUE, 
      verbose = FALSE,
      data = ta_data)
summary(ta_model_strict.fit, fit.measures=TRUE)


### Compare strict and scalar invariance models
ta_model_strict.anova <- anova(ta_model_strict.fit, ta_model_scalar.fit)



### Create summary table to compare model fit indices
ta_model_mi.stats <- rbind(
  fitmeasures(ta_model_configural.fit,
              fit.measures = c("chisq","pvalue","df",
                               "cfi","tli",
                               "rmsea", "rmsea.ci.lower", "rmsea.ci.upper",
                               "srmr", "mfi")),
  fitmeasures(ta_model_metric.fit, 
              fit.measures = c("chisq","pvalue","df",
                               "cfi","tli",
                               "rmsea", "rmsea.ci.lower", "rmsea.ci.upper",
                               "srmr", "mfi")),
  fitmeasures(ta_model_scalar.fit, 
              fit.measures = c("chisq","pvalue","df",
                               "cfi","tli",
                               "rmsea", "rmsea.ci.lower", "rmsea.ci.upper",
                               "srmr", "mfi")),
  fitmeasures(ta_model_strict.fit, 
              fit.measures = c("chisq","pvalue","df",
                               "cfi","tli",
                               "rmsea", "rmsea.ci.lower", "rmsea.ci.upper",
                               "srmr", "mfi")))

# Review table and calculate difference statistics to make a determination about where model fit "drops off" based on some recommended thresholds presented in class
ta_model_mi.stats


