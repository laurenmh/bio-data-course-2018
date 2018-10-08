################################################################################
### BIO  410/510                                                             ###
### Visualization: Linking data to geometric objects in ggplot2              ### 
################################################################################

## OBJECTIVE:
## To practice a "grammar of graphics"
## To become familiar with different types of graphs
## To determine the best graph to fit the question and data
## Handy reference: http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html#1.%20Correlation

## First let's load the tidyverse
## This is a suite of useful packages that includes ggplot2 
library(tidyverse)

########################################
### The 8 categories of graphics in R ##
########################################

##################
### Correlation ##
##################

## Let's start by using a data set built into ggplot2
## The mpg dataset looks at the gas efficiency of different cars 
data(mpg, package = "ggplot2")

## Let's use a scatterplot to relate city and highway mileage
ggplot(mpg, aes(cty, hwy)) + geom_point()

## Looks alright, but the graph may be hiding some information...
## QUESTION: How many data points are in mpg?
## TASK: Try another correlation-focused geom that addresses this problem


##################
### Deviation   ##
##################
## Used to compare variation in values between small number of items (or categories) with respect to a fixed reference.

## Whether the graphical type is a deviation graph or a composition graph (or a ranking graph) may depend on the underlying data structure

## geom_bar() is a bit tricky because it can make both a bar chart and a histogram
## the default of geom_bar is to set stat to count
## so if you give it just a continuous x value, it will make a histogram:
ggplot(mpg, aes(hwy)) + geom_bar()

## In order to have the geom create bars and not a histogram, you must:
## 1) Set stat = identity
## 2) Provide both an x and a y insdie the aes(), where x is either a character or factor and y is numeric


## Let's look at how much different models of cars deviate from the average gas mileage
data("mtcars")  # load data

## A LOT of graphing is first getting the data in the right format
## We will learn to do this later, but for now run the following: 
mtcars$`car name` <- rownames(mtcars)  # create new column for car names
mtcars$mpg_z <- round((mtcars$mpg - mean(mtcars$mpg))/sd(mtcars$mpg), 2)  # compute normalized mpg
mtcars$mpg_type <- ifelse(mtcars$mpg_z < 0, "below", "above")  # above / below avg flag
mtcars <- mtcars[order(mtcars$mpg_z), ]  # sort
mtcars$`car name` <- factor(mtcars$`car name`, levels = mtcars$`car name`)

## QUESTION: What does the column mpg_z contain? How about mpg_type?

ggplot(mtcars, aes(x=`car name`, y=mpg_z, label=mpg_z)) + 
  geom_bar(stat='identity', aes(fill=mpg_type), width=.5) + coord_flip()

## TASK: Try another deviation graph on this dataset, such as a diverging dot plot


##################
### Ranking     ##
##################
## Used to compare the position or performance of multiple items with respect to each other. 
## Actual values matters somewhat less than the ranking.

# Prepare data: group mean city mileage by manufacturer
## Again, a lot of graph creation starts with data manipulation,  but for now:
cty_mpg <- aggregate(mpg$cty, by=list(mpg$manufacturer), FUN=mean)  # aggregate
colnames(cty_mpg) <- c("make", "mileage")  # change column names
cty_mpg <- cty_mpg[order(cty_mpg$mileage), ]  # sort
cty_mpg$make <- factor(cty_mpg$make, levels = cty_mpg$make) 

##QUESTION: What does the mileage column of cty_mpg contain?

ggplot(cty_mpg, aes(x=make, y=mileage)) + 
  geom_bar(stat="identity", width=.5, fill="tomato3") + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6))

## TASK: Try another ranking plot, such as a lollipop chart

#######################
### Distribution     ##
#######################
## When you have lots and lots of data points and want to study where and how the data points are distributed.

## Histograms can be accomplished with either geom_bar() or geom_histogram()
ggplot(mpg, aes(hwy)) + geom_histogram()

## TASK: Try making a histogram on a categorical variable, such as manufacturer
## What does this do? 

## TASK: Try making a boxplot comparing the distribution of cty (city mileage) within class of car


#######################
### Composition      ##
#######################
## Bar charts and pie charts are classic ways of showing composition of a dataset.

freqtable <- table(mpg$manufacturer)
df <- as.data.frame.table(freqtable)
names(df) = c("manufacturer", "freq")

## TASK: Make a bar chart of the number of cars (freq) by manufacturer using the data frame df



#######################
### Change           ##
#######################
## Time series are often best visualized with line graphs.
data("economics")

## TASK: Use the economics dataset to plot the proportion of the population
# that is unemployed over time



#############################
### Groups  & Spatial      ##
#############################
## Let's put a pin on these last two, ggplot2 extension packages can be useful for these.

################################################################################
### YOUR TURN: CO2 TRENDS                                                    ###
################################################################################

## First we'll read in the data and get it ready to use
## You can find the data and read more about it here: https://climate.nasa.gov/vital-signs/carbon-dioxide/
## In particular, the metadata is at the top of the txt file  if you click on the Download Data button

## Let's import the data directly from the web
## This requires the package data.table
## It may not be on your computer, in which case install it
install.packages("data.table")
library(data.table)

## Let's skip down to the data, which starts at line 61
CO2data <- fread('ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_mm_mlo.txt', skip = 60)
names(CO2data) <- c("year", "month", "decimalDate", "averageCO2", "interpolatedCO2", "trendCO2", "numberDays")


#########################
## Read about the data ##
#########################
## Why are there three different columns for CO2? 
## What does numberDays refer to? 
## What does -99.99 in the average column and -1 in the number of days column mean?



########################
## Visualize the data ##
########################
## How do atmospheric CO2 concentrations change over the time series?
## What category of graph will you use?
## What statistical transformation will you use?
## Does the underlying data differ if you use the interpolated or trend columns? 
## Does the statistical transformation differ if you use the interpolated or trend columns?



########################
## Visualize the data ##
########################
## Which months are the CO2 values at the maximum? Minimum? Why is this?
## What category of graph will you use?
## What statistical transformation will you use? 



################################################################################
### YOUR TURN: TEMPERATURE TRENDS                                            ###
################################################################################

## First we'll read in the data and get it ready to use
## You can find the data and read about it here: https://climate.nasa.gov/vital-signs/global-temperature/

tempdata <- fread('http://climate.nasa.gov/system/internal_resources/details/original/647_Global_Temperature_Data_File.txt')


#########################
## Read about the data ##
#########################
## What information is in each of the three columns?
## Using the names() function to give tempdata descriptive column headings
## Please name the first column year


########################
## Visualize the data ##
########################
## Recreate the graph on the website using all three columns
## Recreate the graph on the website using two columns and a statistical transformation

