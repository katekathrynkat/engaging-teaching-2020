### ENGAGING TEACHING SYMPOSIUM 2020
### There's an app for that: Interactive teaching tools for the biology classroom
### Kate Culhane
### 21 October 2020

### EXAMPLE 2: CASE STUDY
### Companion R script

########################

### EVALUATING WATER QUALITY DATA ###

# A research team surveyed a stretch of the Santa Clara River in order to
  # quantify the effects of a sewage treatment plant on aquatic life. Within 
  # a 1000-m stretch of river spanning both upstream and downstream of the
  # sewage treatment plant, they measured water quality at six sites. We will 
  # be comparing differences in water quality among these sites.

### Load packages:
library(tidyverse) # group of useful packages: readr, dplyr, ggplot2, etc.
library(agricolae) # package with function for Tukey test

### Load data:
chemical_parameters <- read_csv('chemical_parameters.csv')

### Data exploration:
View(chemical_parameters) # view the data
str(chemical_parameters) # see the structure of the data
colnames(chemical_parameters) # see the column names: notice each parameter has its own column

### BAR GRAPH ###

# Bar graphs with error bars can be good way to visually represent the mean 
  # values of different groups.

# Create a bar plot:
ggplot(chemical_parameters,
       aes(x = site,
           y = ph)) + # change this argument to create graphs for other parameters
  stat_summary(fun = "mean",
               geom = "bar") +
  stat_summary(fun.data = "mean_se",
               geom = "errorbar",
               width = 0.2) +
  labs(title = "Mean Value of Specified Chemical Parameter",
       x = "Site")
       
### ANOVA ###

# ANOVA determines whether the means of 3 or more groups are 
  # significantly different.

# Run an ANOVA to determine whether the mean varies by site:
chem_anova <- aov(ph ~ site, # change this argument to run ANOVAs on other parameters
                  data = chemical_parameters)
summary(chem_anova) # the p-value is labeled Pr(>F)

### TUKEY TEST ###

# Tukey tests are post-hoc tests, used after an ANOVA to determine which 
  # groups are significantly different.

# Run a Tukey test using the output from the ANOVA:
chem_tukey <- HSD.test(chem_anova, # uses the output from the ANOVA
                       "site") 
print(chem_tukey$groups)

# How to read Tukey test results:
# Look for the mean for each site listed under the name of the variable.
# The letters listed under each variable show how the sites separate into 
  # groups based on their pair-wise p-values. Sites that share the same 
  # letter are similar; sites that do not share the same letter are 
  # significantly different.
# Remember, if you run a Tukey test on a variable that produced an 
  # insignificant ANOVA p-value, you will find that all six sites are 
  # listed as belonging to the same group: a.
