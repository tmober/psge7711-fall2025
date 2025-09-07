# PSGE 7711
# Getting Set-up in R 

# Note that if you are completing this activity using the Destop version of this script (02_R_Desktop_Set-up.R , then you will have 3 extra steps to complete before you can load the data

###
# Importing data
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
