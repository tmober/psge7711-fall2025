# PSGE 7711
# Getting Set-up in R 



# Congratulations! It seems that you've figured out how to open the R file! Note that this activity is meant to be conducted in Posit Cloud.

###
# (1) Opening this R script file
# If this file has not opened in the RStudio app, that means you need to download one of the following:
## R (https://cran.r-project.org/)
## RStudio (https://posit.co/download/rstudio-desktop/)
# Both are free to download and install.

# If both are installed and you are still not opening in Rstudio, that means you should right-click on this file to open it with the RStudio app.


### 
# (2) Installing or Loading Required Packages
install.packages("psych")
library(psych)
install.packages("corrplot")
library(corrplot)

###
# (2) Create/set working directory
# Before you go any further, create a folder where you plan to save this file and any other R script files or data files for this course. 
# Move all of those files to that folder.
# This folder will serve as your working directory


## This next piece of code is very important as it will help the R application "find" the data you are trying to use or save any output files you are trying to create.
wd <- getwd() # This gets your working directory and saves it as an object in your R environment.
setwd(wd) # This sets your working directory. 

# If you check the "Console" at the bottom of your R Studio window, you should see that the wd is the same as the folder path you just moved this file to.


###
# (3) Importing data
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
# (6) Check over and inspect the data file
str(ta_data)

View(ta_data)

head(ta_data)

nrow(ta_data)

### 
# (5) Descriptive statistics


mean(ta_data$ta_01, na.rm = TRUE)
sd(ta_data$ta_01, na.rm = TRUE)


mean(ta_data$ta_02R, na.rm = TRUE)
mean(ta_data$raw_ta_02, na.rm = TRUE)


## We can use a pre-built function "describe" from the "psych" package to check the descriptives for multiple variables at once
psych::describe(ta_data)

## In some cases, it may make more sense to focus on the descriptives of just the items on the scale rather than demographics.
ta_data_subset <- subset(ta_data, select = c(ta_01:raw_ta_12))
str(ta_data_subset)

psych::describe(ta_data_subset)


###
# (6) Creating a plot
hist(ta_data$ta_01)

###
# (7) Creating a correlation matrix and correlation plot
correlations <- cor(ta_data_subset)
correlations

corrplot::corrplot(correlations) 
corrplot::corrplot(correlations, method = 'number') # colorful number


###
# (8) Saving a file to a .csv or R data file (.rds)
write.csv(correlations, "correlations.csv", row.names = FALSE)
# This will allow you to save the correlation matrix without row names being included in the file
