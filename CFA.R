# PSGE 7711: Week 9
# Confirmatory Factor Analysis (CFA) with Test Anxiety Data 


###
# (1) Opening this R script file
# If this file has not opened in the RStudio app, that means you either need to download one ofthe following:
## R (https://cran.r-project.org/)
## RStudio (https://posit.co/download/rstudio-desktop/)
# Both are free to download and install.

# If both are installed and you are still not opening in Rstudio, that means you should right-click on this file to open it with the RStudio app.


### 
# (2) Installing or Loading Required Packages
# install.packages("psych")
library(psych)
# install.packages("lavaan")
library(lavaan)
# Useful tutorial for conducting CFA in lavaan package: https://lavaan.ugent.be/tutorial/cfa.html




###
# (3) Create/set working directory
# Before you go any further, create a folder where you plan to save this file and any other R script files or data files for this course. 
# Move all of those files to that folder.
# This folder will serve as your working direcotry


## This next piece of code is very important as it will help the R application "find" the data you are trying to use or save any output files you are trying to create.
wd <- getwd() # this gets your working directory and saves it as an object in your R environment.
setwd(wd) # this sets your working directory. 

# If you check the "Console" at the bottom of your R Studio window, you should see that the wd is the same as the folder path you just moved this file to.


###
# (4) Importing data
## Make sure that your data file is saved to the same folder as this file. For the time-being
load("test_anxiety_data.Rdata") # this load the "ta_data" dataframe

# you can also import the file as a .csv as follows:
ta_csv <- read.csv("test_anxiety_data.csv")


# This file consists of some previously published student demographic data and responses to a 12-item measure of test anxiety.

# The items are as follows Students responded to each of these using a 5-point Likert scale (1=Strongly Disagree,..., 5=Strongly Agree)
# # Affective Dimenions
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

### 
# (5) Check over and inspect the data file
str(ta_data)

View(ta_data)

head(ta_data)

nrow(ta_data)

### 
# (6a) Specify the Unidimensional Model

ta_model1 <- ' ta_latent_factor  =~ ta_01 + ta_02R + ta_03 
                                  + ta_04R + ta_05 + ta_06R
                                  + ta_07 + ta_08R + ta_09
                                  + ta_10R + ta_11 + ta_12R '

#### (6b) Fit the model to our data
ta_fit1 <- cfa(ta_model1, data = ta_data)


#### (6c) Check the model fit indices and factor loadings
summary(ta_fit1, fit.measures = TRUE, standardized = TRUE)

standardizedsolution(ta_fit1)


### 
# (7a) Specify the Two Correlated Dactors Model

ta_model2 <- ' ta_affect_latent_factor  =~ ta_01 + ta_02R + ta_03 
                                           + ta_04R + ta_05 + ta_06R
               
               ta_cognitive_latent_factor  =~  ta_07 + ta_08R + ta_09
                                               + ta_10R + ta_11 + ta_12R '
    
#### (7b) Fit the model to our data
ta_fit2 <- cfa(ta_model2, data = ta_data)


#### (7c) Check the model fit indices and factor loadings
summary(ta_fit2, fit.measures = TRUE, standardized = TRUE)

standardizedsolution(ta_fit2)



## Based on your evaluation, which one wuld you choose as the "better" model?


