################################################################################
### BIO 410/510                                                             ###
### MODULE 2: Intro to visualization with ggplot2                            ### 
################################################################################

## OBJECTIVE:
## To develop a "grammar of graphics"
## To become comfortable using ggplot2 for exploratory data visualization

## About a grammar of graphics:
## The author of ggplot2, Hadley Wickham, discusses his graphing philosophy
## in his Grammar of Graphics  paper: http://vita.had.co.nz/papers/layered-grammar.pdf
## There is also excellent ggplot2 documentation at: http://docs.ggplot2.org/current/

## What is a grammar of graphics?
## A grammar of graphics is a tool that enables us to concisely describe the components of a graph.
## This allows us to move beyond named graphics (e.g., a "barplot") 
## and gain insight into the structure that underlies graphics.
## Components that make up a graph include:
## Data and aesthetic mapping
## Geometric objects
## Scales
## Facet specification
## Statistical transformations
## The coordinate system (position)

## Together, the data, mapping, statistical transformation and geometric object form a layer.
## A plot may have multiple layers; for example, 
## Overlaying a scatterplot with a smoothed line.

## Thus, a layered grammar of graphics builds a plot this way:
## A default dataset and set of mappings from variables to aesthetics.
## One or more layers. Each layer includes have one geometric object, one statistical transformation,
## one position adjustment, and one dataset and set of aesthetic mappings.
## One scale for each aesthetic mapping.
## A coordinate system (ie, Cartesian, Polar, etc).
## The facet specification.

## First let's load ggplot2
library(ggplot2)


################################################################################
### Preliminary: Reading the data                                            ###
################################################################################

## First we'll read in the data and get it ready to use.
## Make sure your working directory is set to where you downloaded the file
SpokaneFish <- read.csv(file="LowerSpokaneFish.csv", header=TRUE)

# Fix dates
SpokaneFish$Date <- as.Date(SpokaneFish$Date, "%m/%d/%Y")

# Have a look at the head and structure of SpokaneFish
# Based on the str command, how many fish species are in the SpokaneFish dataframe?
head(SpokaneFish)
str(SpokaneFish)

# Lets focus on just one species, redband trout, which is actually a subspecies of rainbow trout
# Redbank trout have been facing population declines due to habitat loss and competition with exotic species
# We'll select just Redband trout that have been aged
Redband <- subset(SpokaneFish, Species=="RB" & is.na(ScaleAge)==F )   #This is one of several ways to subset data


#############################
## 1) Aesthetics and mapping
############################

## There is often a length requirement for take from fishing
## What is the distribution of legnths of redband trout in the lower Spokane River? 
ggplot(Redband, aes(x=Length)) + geom_histogram()

## TASK: What factors might affect this distribution? 
## TASK: Make a histogram of the distribution of those factors



## QUESTION: In the code below, what is the default dataset? What are the aesthetics?
## QUESTION: When you run the code below, why don't we see a graph?
ggplot(Redband, aes(x=ScaleAge, y=Length))



######################################
## 2) Adding layers: Geometric objects
######################################

## We need to specify a layer!
## At a minimum, we must specify a geometric object (what shape to add to the plot)
ggplot(Redband, aes(x=ScaleAge, y=Length)) + geom_point()

## TASK: Visualize the relationship between redband length and weight



## We can also add aesthetics to the geometric object
## For example, we can integrate these relationships by coloring points based on ScaleAge
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point(aes(color=as.factor(ScaleAge)))


## TASK: Modify the aesthetics of the geometric object so that the shape of the points varies with as.factor(ScaleAge)
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point(aes(color=as.factor(ScaleAge)))


## TASK: visit the ggplot2 documentation webpage at http://docs.ggplot2.org/current/
## Name five other geometric objects


################################################
## 3) Adding layers: Statistical transformations
################################################

## A stat takes a dataset as input and visualizes a new, processed dataset with new variables as output.

## For example, if we could relate length and width by calculating and graphing a smoothing function:
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point() + geom_smooth()

## We also can specify a model to fit
## Looks like a quadratic function fits it well:
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point() + geom_smooth(formula = y ~ poly(x,2))

## QUESTION: How and why do the following lines differ from the one above, and from each other?
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point(aes(color=as.factor(ScaleAge))) + geom_smooth(formula = y ~ poly(x,2))
ggplot(Redband, aes(x=Length, y=Weight, color=as.factor(ScaleAge))) + geom_point() + geom_smooth(formula = y ~ poly(x,2))

## QUESTION: What would be a better model fit for the second figure?
## TASK: Modify the code to use that model. Hint: ?geom_smooth will give you the possible arguments that you could specify



## Another example of a statistical transformation is geom_boxplot() which:
## Calculates a new dataset based on statistically transforming the default dataset and aesthetics (Weight and ScaleAge)
## In this case, it creates a dataframe of  the mean and upper and lower quantiles of Weight within ScaleAge
## Adds this transformed data as a geometric object
ggplot(Redband, aes(x=as.factor(ScaleAge), y=Weight)) + geom_boxplot()

## QUESTION: Can you name another statistical transformation?


#########################################
## 4) Altering scales
#########################################

## A scale controls the mapping from data to aesthetic attribute. 
## For example, the following are all aspects of scale:
## The size and color of points and lines, axes limits and labels

## Let's start by revisiting our basic length by weight scatter plot
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point()

## We could alter the size and color and shape of the points
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point(size=1, color="darkblue", shape=1)

## We could add on to alter the x and y axes scales; for example, let's make put them on a log10 scale
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point(size=1, color="darkblue", shape=1) +
  scale_x_log10() + scale_y_log10()

## We could customize the x and y axis labels
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point(size=1, color="darkblue", shape=1) +
  scale_x_log10() + scale_y_log10() +
  xlab("Redband trout length (mm)") + ylab("Redband trought weight (g)")

## TASK: Create a histogram of scale age with dark blue filled bars


## TASK: Relate length with scale age on a log-log scale

#########################################
## 6) Specifying facets
#########################################


## Faceting makes it easy to graph subsets of an entire dataset. 
## For example, we could relate length and width within each age class.
## We do that by adding a facet specification to our initial graph:
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point() + facet_wrap(~ScaleAge)

## We could also make a grid by faceting one variable by another.
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point() + facet_grid(Year~ScaleAge) 


## TASK: Make a histogram of length faceted by scale age
## QUESTION: Is the distribution of length normal within age?

## TASK: Using the full SpokaneFish dataset, make a histogram of length faceted by species
## Why did we focus on redband trout?
