################################################################################
### BIO 410/510                                                             ###
### TRANSFORM: Rearranging data                                              ### 
################################################################################

## Another way to think about ggplot naming (from https://beanumber.github.io/sds192/lab-ggplot2.html)
# In ggplot2, aesthetic means “something you can see”. Each aesthetic is a mapping between a visual cue and a variable. Examples include:
#   
# position (i.e., on the x and y axes)
# color (“outside” color)
# fill (“inside” color)
# shape (of points)
# line type
# size
# 
# Each type of geom accepts only a subset of all aesthetics—refer to the geom help pages to see what mappings each geom accepts. Aesthetic mappings are set with the aes() function.

#### TODAY ####
## OBJECTIVES:
## To learn how manipulate data into a form useable for analysis and graphs.
## To do this in a way that each step is traceable and reproducible.
## To this end we'll be using the dplyr package.

## dplyr is in the tidyverse:
library(tidyverse)

########################
##1) Reading in the data
########################

## We will use a dataset of water temperature in Calispell Creek and its tributories  from eastern Washington State.
## These type of data are ripe for for scripted analysis because their formats remain constant 
## but graphs frequently need to be updated to reflect new data.

## Remember to set your working directory to where the file is!!! 

rawdat <- read.csv("CalispellCreekandTributaryTemperatures.csv", stringsAsFactors = FALSE) 

## QUESTION TO PONDER (EXTRA): What does stringsAsFactors mean? Why would we want to make it false?

## Let's assign more useable column names
names(rawdat) <- c("date", "time", "calispell_temp", "smalle_temp", "winchester_temp")



#################################
## 2) dplyr tool number 0: tbl_df
#################################


## The first step of working with data in dplyr is to load the data in what the package authors call
## a 'tibble'
## Use this code to create a new tibble called wtemp.
## Tibbles are similar to data frames but with some useful features: https://cran.r-project.org/web/packages/tibble/vignettes/tibble.html
wtemp <- as_tibble(rawdat)

## One of the best features is the printing
## Let’s see what is meant by this 
wtemp

## REVIEW QUESTION AND PLAY (EXTRA): What class is wtemp? How many rows does wtemp have? How many columns?

## To reinforce how nice this is, print rawdat instead:
rawdat

## Ophf! To never see that again, let's remove rawdat from the workspace
rm(rawdat)

## Another way to get a tibble when you upload is to use the readr package, also in the tidyverse
rawdat_alt <- read_csv("CalispellCreekandTributaryTemperatures.csv") 

# EXTRA QUESTION TO PONDER: why did we not need stringsAsFactors for this? 

#################################
## 3) dplyr tool number 1: select
#################################

## Let's imagine that we are only intested in the temperature at the Calispell site
## select helps us to reduce the dataframe to just columns of interesting
select(wtemp, calispell_temp, date, time)

## QUESTION: Are the columns in the same order as wtemp?


## NOTE: We didn't have to type wtemp$date etc as we would outside of the tidyverse
## the select() function knows we are referring to wtemp.

## Recall that in R, the : operator is a compact way to create a sequence of numbers. For example:
5:20

## Normally this notation is just for numbers, but select() allows you to specify a sequence of columns this way.
## This can save a bunch of typing! 

## TASK: Select date, time and calispell_temp using this notation

## Print the entire tibble again, to remember what it looks like.
## We can also specify the columns that we want to discard. Let's remove smalle_temp, winchester_temp that way:
select(wtemp, -smalle_temp, -winchester_temp)

## EXTRA TASK: Get that result a third way, by removing all columns from smalle_temp:winchester_temp.
## Be careful! select(wtemp, -smalle_temp:winchester_temp) doesn't do it...


#################################
## 3) dplyr tool number 2: filter
#################################

#Now that you know how to select a subset of columns using select(), 
#a natural next question is “How do I select a subset of rows?” 
#That’s where the filter() function comes in.

## I might be worried about high water temperatures. 
## Let's filter the the dataframe table to only include data with temperature equal or greater than 15 C
filter(wtemp, calispell_temp >= 15)

## QUESTION: How many rows match this condition?

## We can also filter based on multiple conditions. 
## For example, did the water get hot on the 4th of July, 2013? I want both conditions to be true:
filter(wtemp, calispell_temp >= 15, date == "7/4/13")

##And I can filter based on "or" - if any condition is true. 
## For example, was water temp >=15 at any site?
filter(wtemp, calispell_temp >= 15 | smalle_temp >= 15 | winchester_temp >= 15)

##QUESTION: How many rows match this condition?

## Finally, we might want to only get the row which do not have missing data
## We can detect missing values with the is.na() function
## Try it out:
is.na(c(3,5, NA, 6))

## Now put an exclamation point (!) before is.na() to change all of the TRUEs to FALSEs and FALSEs to TRUEs
## This tells us what is NOT NA:
!is.na(c(3,5, NA, 6))


## NOTE: To see all possible unique values in a column, use the unique function:
unique(wtemp$calispell_temp)

## TASK: Time to put this all together. Please filter all of the rows of wtemp 
## for which the value of calispell_temp is not NA.
## How many rows match this condition?

## EXTRA TASK: Please filter all the values of calispell_temp where the temp is greater or equal to 15, or is na

##################################
## 4) dplyr tool number 3: arrange
##################################

## Sometimes we want to order the rows of a dataset according to the values of a particular variable
## For example, let's order the dataframe by calispell_temp 
arrange(wtemp, calispell_temp)

## QUESTION: What is the lowest temperature observed in Calispell Creek?

## But wait! We're more worried about high temperatures.
## To do the same, but in descending order, you have two options. 
arrange(wtemp, -calispell_temp)
arrange(wtemp, desc(calispell_temp))

## And you can arrange by multiple variables. 
## TASK: arrange the tibble by date (ascending) and smalle_temp (descending)

## EXTRA TASK: How could you use arrange() to sort all missing values to the start? (Hint: use is.na()).


##################################
## 5) dplyr tool number 4: mutate
##################################

## It’s common to create a new variable based on the value of one or more variables already in a dataset. 
## The mutate() function does exactly this.

## I like that the data are all in C. But what if we want to talk to an "I'm not a scientist" politician about water temperature?
## We might want to convert it to F.
mutate(wtemp, calispell_temp_F = calispell_temp*9/5 + 32)

## To make our data more usable, we also might want to summarize data across time, or by month and year.
## The lubridate package helps a lot with this! Here is just a taste, but if you need to work with dates for your project check out the package.
## There is also a great swirl tutorial on how to use it.
## Let's load lubridate:
library(lubridate)

## TASK: Look at the lubridate help page. What do the functions with 'y' 'm' and 'd' (in various orders) do?  
?lubridate

## Try it out:
mdy("1/13/09")

## Once dates are saved as date-time objects, we can extract information from them. Try it out.
## First, let's save the character string as a date-time object:
mydate <- mdy("1/13/09")

## Then extract the month and day:
month(mydate)
day(mydate)

##QUESTION: How would you extract the year from mydate?

## Let's use the mutate and mdy functions to create a variable called date2 that stores the date as a date-time object.
mutate(wtemp, date2 = mdy(date))

## Finally, we can use mutate to create several columns. For example, let's create date2, then create a column for month and year
mutate(wtemp, date2 = mdy(date), month = month(date2), year = year(date2))

## Let's go ahead and save those changes in an object called wtemp2 object:
wtemp2 <- mutate(wtemp, date2 = mdy(date), month = month(date2), year = year(date2))

## EXTRA TASKS (definitely do these!): There are a variety of useful creation functions. Using the documentation in 5.5, please:
## 1) Create a column that is the ranked values of calispell_temp

## 2) Create a column that is the mean value of calispell_temp (hint: you might need to add na.rm = T)

## 3) Create a column that is the amount that calispell_temp deviates from its mean

## 4) Create a column that is the log of smalle_temp

## 5) Create a column that is the difference in temperature between smalle and winchester

## TASK: Name two other creation functions and give a scenario in which you would use them

####################################
## 6) dplyr tool number 5: summarize
####################################

## Often we want to look at summarized as opposed to raw data. 
## At a basic level, summarize will condense all rows of a variable into one, summarized value.
## For example, let's look at the mean water temperature at Calispell
summarize(wtemp2, avg_temp_calispell = mean(calispell_temp, na.rm = TRUE))

## QUESTION: What did na.rm = TRUE do?
## TASK: Can you use summarize to get the max value for the calispell_temp variable?
## QUESTION: Do you think this level of aggregation is very interesting?


###################################
## 6) dplyr tool number 6: group_by
###################################

## That last one was supposed to be a leading question. I don't think mean temperature is that insightful. 
## I'm more interested in how temperature changes with month or year.
## If we add the group_by function, summarize will give us the requested value FOR EACH GROUP.

## First, let's create a new tibble that is equal to to wtemp2 but includes two grouping variables: month and year
wtemp_by_monthyear <- group_by(wtemp, month, year)

## QUESTION: Print wtemp and wtemp_by_monthyear. Can you see how they differ?

## Use summarize again, but this time on wtemp_by_month.
summarize(wtemp_by_monthyear, avg_temp_calispell= mean(calispell_temp, na.rm = TRUE))


## Whoa there are a lot of missing values...
## For this (and always) its good to do a count on the number of data points you are using
## TASK: Combine filter and summarize to get a count of the number of actual data points for calispell temp


