# PSGE 7711: Week 9
# Exploratory Factor Analysis (EFA) with BFI data


### 
# (1) Installing or Loading Required Packages
# install.packages("psych")
library(psych)
# install.packages("lavaan")
library(lavaan)
# Useful tutorial for conducting CFA in lavaan package: https://lavaan.ugent.be/tutorial/cfa.html
# install.packages("corrplot")
library(corrplot)
# Useful for creating a visual plot of correlations

### 
# (2) Load and Subset only the Survey Data
# For this activity, we'll be using the Big Five Inventory (BFI) data available in the psych package.
# Here are some details about this dataset: https://www.rdocumentation.org/packages/psych/versions/2.2.5/topics/bfi
# Note that some items are nregatively keyed, so before we caluclate total/mean scale scores, 
# we need to find out which ones must be revser coded.

# This function allows us to access the BFI data from the psych package:
## we are only interested in the first 25 columns so we're going to subset just those
bfi_data <- as.data.frame(psych::bfi)[c(1:25)]


### 
# (3) Check over and inspect the data file
str(bfi_data)
head(bfi_data)
nrow(bfi_data)



### 
# (4) Calculate a marrix of the pairwise correlations between items
correlations <- cor(bfi_data, use = "pairwise.complete.obs")

# creating a corrplot
corrplot(cor(bfi_data, use = "pairwise.complete.obs"), 
         order = "original", 
         type = "upper")


###
# (5) Conduct parallel analysis to produce a scree plot and determine the approximate number of factors/components
fa.parallel(bfi_data)


###
# (6) EFA with 3 factor solution
bfi_efa3 <- fa(bfi_data, 
                   nfactors = 3, 
                   rotate = "oblimin") # oblimin is an oblique rotation that assumes factors are correlated

summary(bfi_efa3)
print(bfi_efa3$loadings, cutoff = 0.3) # we are setting a cut-off of .3 which means that any loadings below that value won't be printed

## Notice that all of the loadings for the "open-mindedness" items are below .3.
## This might not be a good solution since it seems that this dimension in particular has a lot of complex/cross-loadings.



###
# (7) EFA with 4 factor solution
bfi_efa4 <- fa(bfi_data, 
               nfactors = 4, 
               rotate = "oblimin") # oblimin is an oblique rotation that assumes factors are correlated

summary(bfi_efa4)
print(bfi_efa4$loadings, cutoff = 0.3) # we are setting a cut-off of .3 which means that any loadings below that value won't be printed

## Notice that some items do not appear to load on any factors (e.g., A1).
## Notice also that the "agreeableness" and "extraversion" items appear to load on the same factor.


###
# (8) EFA with 5 factor solution
bfi_efa5 <- fa(bfi_data, 
               nfactors = 5, 
               rotate = "oblimin") # oblimin is an oblique rotation that assumes factors are correlated

summary(bfi_efa5)
print(bfi_efa5$loadings, cutoff = 0.3) # we are setting a cut-off of .3 which means that any loadings below that value won't be printed

## Our solution is a bit more interpretable, but we still have some complex/cross-loadings (e.g., N4, O4).
## It might be worth looking into these items a little further. 


###
# (9) EFA with 6 factor solution
bfi_efa6 <- fa(bfi_data, 
               nfactors = 6, 
               rotate = "oblimin") # oblimin is an oblique rotation that assumes factors are correlated

summary(bfi_efa6)
print(bfi_efa6$loadings, cutoff = 0.3) # we are setting a cut-off of .3 which means that any loadings below that value won't be printed

## The number of complex/cross-loadings gets even worse with the 6 factor solution.


## With this data and the EFAs we've produced, it seems that is reason to support either a 4 or 5 factor solution.

