# PSGE 7711: Week 3
# Calculating Correlations with BFI data


# install or load packages into library
# install.packages("psych")
library(psych)
# install.packages("corrplot")
library(corrplot)

# For this activity, we'll be using the Big Five Inventory (BFI) data available in the psych package.
# Here are some details about this dataset: https://www.rdocumentation.org/packages/psych/versions/2.2.5/topics/bfi
# Note that some items are nregatively keyed, so before we caluclate total/mean scale scores, 
# we need to find out which ones must be revser coded.


# This function allows us to access the BFI data from the psych package:
## we are only interested in the first 25 columns so we're going to subset just those
bfi_data <- as.data.frame(psych::bfi)[c(1:25)]



# lets look at the data
print(bfi_data)
View(bfi_data)

# check the structure of the data
str(bfi_data)

# get the variables names
names(bfi_data)

# get a quick snapshot of the descriptives
psych::describe(bfi_data)


# now, let's calculate the correlations between items
cor(bfi_data, use = "pairwise.complete.obs")

# creating a corrplot
corrplot(cor(bfi_data, use = "pairwise.complete.obs"), 
         order = "original", 
         type = "upper")
