# PSGE 7711: Week 2
# Importing and Manipulating Data

# Congratulations! It seems that you've figured out how to open the R file! Note that this activity is meant to be conducted using the desktop RStudio application.

# install.packages("psych") # Use this if you have never installed "psych" before
library(psych) 


# Set your working directory
## This tells you where your working directory is currently set
getwd()

# If you want to change your working directory, you can use this script below.
#setwd() 

# You can also change your working directory by going to "Session/Set Working Directory" from the menu bar above.


# Importing data
# Assuming this file and the course_survey_data.csv are saved in the same location (e.g., your desktop), you should be able to run the following script to import your data.

## Import as a .csv
course_survey_data <- read.csv("course_survey_data.csv")

# Look at the variable of the data 
names(course_survey_data)

# Check the number of rows in the data (in this case, indicating the number of responses)
nrow(course_survey_data)

# Check the data structure (shows the variable formats)
str(course_survey_data)

# View the data in a new window
View(course_survey_data)





# Get descriptive statistics of the data (Hint: There are many ways to calculate the descriptive statistics, one of which could invovle using the psych package.)
## Mean and standard deviation for psychom_familiar

## Mean and standard deviation for psychom_relevant

## Pearson correlation coefficient between those to variables.





