## Example 2: Case Study

## This is the companion R script for the R lab

########################################################

# Your goal is to evaluate water quality measurements taken from six locations along a river, which they then use to answer homework questions.

### Water Quality Data

# A research team surveyed a stretch of the Santa Clara River in order to quantify the effects of a sewage treatment plant on aquatic life. Within a 1000-m stretch of river spanning **both upstream and downstream of the sewage treatment plant,** they measured water quality at **six sites**. We will be comparing differences in water quality among these sites.

### Bar graph

# Remember, bar graphs with error bars are a good way to visually represent the mean values of different groups.

# For each water quality variable, visualize the data to determine which sites you think were affected by point-source pollution.

# The parameter variables are: `ph`, `do`, `phosphate`, `nitrogen`, `ec`, `temp`, and `turbidity`.

# Create a bar plot:
ggplot(chemical_parameters,
       aes(x = site,
           y = VARIABLE)) +
  stat_summary(fun = "mean", geom = "bar") +
  stat_summary(fun.data = "mean_se", geom = "errorbar", width = 0.2) +
  labs(title = "Mean Value of Specified Chemical Parameter",
       x = "Site")
       
# - Replace the word `VARIABLE` with the variable name for a parameter and press "Run Code".
# - Check that the variable name is lowercase and spelled correctly. Do not change any other parts of the code. If you make a mistake, press "Start Over".

### ANOVA

# Remember, we use ANOVA to determine whether the means of three or more groups are significantly different.

# For each of the seven water quality parameters, run an ANOVA to determine whether the mean varies by site.

# The parameter variables are: `ph`, `do`, `phosphate`, `nitrogen`, `ec`, `temp`, and `turbidity`.

# Run an ANOVA to determine whether the mean varies by site
chem_anova <- aov(VARIABLE ~ site,
                  data = chemical_parameters)
summary(chem_anova)

# Find the **ANOVA p-value** in the statistical output: it is labeled `Pr(>F)`.


### Tukey test

# Remember, we use a Tukey test after an ANOVA to determine which groups are significantly different.

# For each chemical parameter that significantly varied between sites, run a Tukey test to determine which sites were different.

# The chemical parameter variables are: `ph`, `do`, `phosphate`, `nitrogen`, `ec`, `temp`, and `turbidity`.

# Run a Tukey test using the output from the ANOVA

chem_anova <- aov(VARIABLE ~ site,
                  data = chemical_parameters)
chem_tukey <- HSD.test(chem_anova, "site")
print(chem_tukey$groups)


# Look for the *mean* for each site: these are listed under the name of the variable.
# Find the letters listed under `groups`. These show how the sites separate into groups based on their pair-wise p-values. Sites that share the same letter are similar; sites that do not share the same letter are significantly different.
# Remember, if you run a Tukey test on a variable that produced an insignificant ANOVA p-value, you will find that all six sites are listed as belonging to the same group: a.
