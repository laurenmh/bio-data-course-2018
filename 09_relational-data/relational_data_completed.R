################################################################################
### BIO 410/510                                                             ###
### TRANSFORM: Relational data                                              ### 
################################################################################

## OBJECTIVES:
# To learn what relational data are and why this is a useful data structure
# To learn how to join datasets using dplyr syntax
# To become comfortable developing workflows that integrate multiple data frames

# Lesson material adapted from: Paula Andrea Martinez, Timothée Poisot (eds): "Data Carpentry: SQL for Ecology lesson.
# "Version 2017.04.01, April 2017,
#http://www.datacarpentry.org/sql-ecology-lesson/

# You can learn more about the Portal Project here:
# https://portal.weecology.org/


## WHY USE A RELATIONAL DATABASE?
# Using a relational database serves several purposes
# 
# It keeps your data separate from your analysis
# This means there’s no risk of accidentally changing data when you analyze it
# If we get new data we can just rerun the script
# It’s fast, even for large amounts of data
# It improves quality control of data entry

## WHAT ARE RELATIONAL DATABASES?
# Relational databases store data in tables with fields (columns) and records (rows)
# Data in tables has types, and all values in a field have the same type (list of data types)
# Queries (or dplyr syntax) let us look up data or make calculations based on columns

## Characteristics: 
# Every row-column combination contains a single atomic value, i.e., not containing parts we might want to work with separately.
# One field per type of information
# No redundant information
# Split into separate tables with one table per class of information
# Needs an identifier in common between tables – shared column - to reconnect (known as a foreign key).


# Load the tidyverse
library(tidyverse)

# Handy se function
calcSE <- function(x){
  x <- x[!is.na(x)]
  sd(x)/sqrt(length(x))
}

## Read in the data
surveys <- read_csv("surveys.csv")
species <- read_csv("species.csv")
plots <- read_csv("plots.csv")

## QUESTION: What are the primary keys of the plots, species and surveys data frames?


## EXERCISE: On paper, draw a diagram depicting the relationships between the three data frames.


## EXERCISE: How has the hindfoot length and weight of Dipodomys species changed over time?

# What would I need to answer these questions?
# Which files have the data I need? 
# What operations would I need to perform if I were doing these analyses by hand?






##############################################
## Example workflow to answer this question ##
##############################################

# join together survey and species data
sumdat <- inner_join(surveys, species, by="species_id") %>%
  
  # just retain Dipodomys records
  filter(genus == "Dipodomys") %>%
  
  # group by year
  group_by(year) %>%
  
  # calculate the replication number, mean and se of length and mean and se of weight
  summarize(repnum = n(), 
            meanlength = mean(hindfoot_length, na.rm=T), 
            selength = calcSE(hindfoot_length),
            meanweight = mean(weight, na.rm=T),
            seweight = calcSE(weight))

# graph length
ggplot(sumdat, aes(x = year, y= meanlength)) + geom_point() + geom_line() +
  geom_errorbar(aes(ymin = meanlength - selength, ymax = meanlength + selength)) 

# graph weight
ggplot(sumdat, aes(x = year, y= meanweight)) + geom_point() + geom_line() +
  geom_errorbar(aes(ymin = meanweight - seweight, ymax = meanweight + seweight)) 

## QUESTION: Could the species identity be affecting these patterns? How would you check? 


# join together survey and species data
sumdat <- inner_join(surveys, species, by="species_id") %>%
  
  # just retain Dipodomys records
  filter(genus == "Dipodomys") %>%
  
  # group by year
  group_by(year, species) %>%
  
  # calculate the replication number, mean and se of length and mean and se of weight
  summarize(repnum = n(), 
            meanlength = mean(hindfoot_length, na.rm=T), 
            selength = calcSE(hindfoot_length),
            meanweight = mean(weight, na.rm=T),
            seweight = calcSE(weight))

# graph length
ggplot(sumdat, aes(x = year, y= meanlength, color = species)) + geom_point() + geom_line() +
  geom_errorbar(aes(ymin = meanlength - selength, ymax = meanlength + selength)) 

# graph weight
ggplot(sumdat, aes(x = year, y= meanweight)) + geom_point() + geom_line() +
  geom_er
##############################################
##             YOUR TURN                    ##
##############################################

## Working with a partner, for the following questions please answer:
# What would I need to answer these questions?
# Which files have the data I need? 
# What operations would I need to perform if I were doing these analyses by hand?

# We will take these one at a time. 
# Put your stickys up when you are ready, we will discuss as a class and then will code the workflows.

## QUESTIONS: 
# Q1) How many plots from each type are there?
plots %>%
  group_by(plot_type) %>%
  summarize(rep = n())

# Q2) How many specimens of each species were captured in each type of plot?
specimens <- inner_join(plots, surveys, by = "plot_id") %>%
  group_by(plot_type, species_id) %>%
  summarize(num_spp = n())

# Q3) What is the average weight of each taxa?
taxaweight <- inner_join(surveys, species, by = "species_id") %>%
  group_by(taxa, species_id) %>%
  summarise(meanweight = mean(weight, na.rm = T)) %>%
  group_by(taxa) %>%
  summarise(meanweight = mean(meanweight, na.rm = T)) 
  
