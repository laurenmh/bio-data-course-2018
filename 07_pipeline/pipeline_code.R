################################################################################
### BIO 410/510                                                              ###
### TRANSFORM: Grouping, summarizing and the pipeline                        ### 
################################################################################

## OBJECTIVES:
## To group and aggregate datasets.
## To learn how to plan a workflow.
## To implement a workflow using the pipeline.
## To this end we'll be using the dplyr package.


library(tidyverse)
library(lubridate)

### Let's pick back up where we left on on Wednesday:

wtemp <- read.csv("CalispellCreekandTributaryTemperatures.csv", stringsAsFactors = FALSE) %>%
  as_tibble()
names(wtemp) <- c ("date", "time", "calispell_temp", "smalle_temp", "winchester_temp")
wtemp <- mutate(wtemp, date2 = mdy(date), month = month(date2), year = year(date2))


##################################
## 5) dplyr tool number 4: mutate
##################################

## Let's finish with practicing with mutate! 

## QUESTION: There are a variety of useful creation functions. 
## TASK: Using the documentation in 5.5, please:

## 4) Create a column that is the log of smalle_temp

## 5) Create a column that is the difference in temperature between smalle and winchester

## TASK: Name two other creation functions and give a scenario in which you would use them


####################################
## 6) dplyr tool number 5: summarize
####################################

## Often we want to look at summarized as opposed to raw data. 
## At a basic level, summarize will condense all rows of a variable into one, summarized value.
## For example, let's look at the mean water temperature at Calispell
summarize(wtemp, avg_temp_calispell = mean(calispell_temp, na.rm = TRUE))

## QUESTION: What did na.rm = TRUE do?
## TASK: Can you use summarize to get the max value for the calispell_temp variable?
## QUESTION: Do you think this level of aggregation is very interesting?



###################################
## 6) dplyr tool number 6: group_by
###################################

## I'm more interested in how temperature changes with month or year.
## If we add the group_by function, summarize will give us the requested value FOR EACH GROUP.

## First, let's create a new dataframe table that is equal to to wtemp but includes two grouping variables: month and year
wtemp_by_monthyear <- group_by(wtemp, month, year)
## QUESTION: Print wtemp and wtemp_by_month. Can you see how they differ?

## Use summarize again, but this time on wtemp_by_month.
summarize(wtemp_by_monthyear, avg_temp_calispell= mean(calispell_temp, na.rm=TRUE))

## Let's take this a step further, and look at the mean and standard error.
## First, run this code to store a function that calculates SE
calcSE <- function(x){
  x <- x[!is.na(x)]
  sd(x)/sqrt(length(x))
}

## Then, let's summarize Calispell Creek temperatures both by mean and se and store it as a new dataframe:
wtemp_calispell_summary <- summarize(wtemp_by_monthyear, 
                                    avg_temp_calispell= mean(calispell_temp, na.rm=TRUE),  
                                    se_temp_calispell= calcSE(calispell_temp))

## Notice how this gets our data into great shape for plotting. Just for fun, let's plot mean temp by month and include se
ggplot(wtemp_calispell_summary, aes(x=month, y=avg_temp_calispell)) +
  geom_bar(stat="identity", fill="grey") + 
  geom_errorbar(aes(ymax = avg_temp_calispell + se_temp_calispell, 
                    ymin = avg_temp_calispell - se_temp_calispell), width=.1) + 
  xlab("Month") + ylab("Mean temperature at Calispell Creek (degrees C)") + 
  facet_wrap(~year) 


## One last note on group_by: If you group a dataframe table and then create a new variable with mutate, the value for that variable 
## will be repeated for each member of the group. For example:
mutate(wtemp_by_monthyear, avg_temp_calispell=mean(calispell_temp, na.rm=TRUE))

## QUESTION: Can you think of a scenario in which this is what would want to do?

## Task: There a number of useful summary as well as mutation functions. Using the documentation in 5.6.4, please:

## 1) Summarize wtemp by the number of measurements of calispell_temp in each year

## 2) Summarize wtemp by the number of non-NA measurements of calispell_temp in each year

## 3) Summarize wtemp by the number of unique values of calispell_temp in each year

## 4) Create a column that reflects the amount that calispell_temp deviates from the average that month

#############################################
## 7) dplyr tool number 7: %>% (the pipeline)
#############################################

## It took us a lot of steps to get from the raw data to that graph!
## We had to: 
## 0) turn the dataframe into a dataframe table
## 1) select the date, time and Calispell temperature variable
## 2) filter out the missing values from the temperature variable
## 3) arrange by temperature (well, we didn't haaave to, but it was nice)
## 4) mutate a whole lot! we created the date2 column (a date-time object) and used it to create a month and a year column
## 5) group_by month and year
## 6) summarize temperature by mean and se
## 7) THEN graph

## This is a "workflow" - and dplyr has a handy tool to make this process clear and easy.
## It is called the "pipeline". Everytime a function is followed by the %>%,  it indicates that more work will be done on the object.
## To illustrate, here is the pipeline to create a graphical object stored as "Calispell_monthlytemp" from the initial wtemp dataframe 

Calispell_monthtemp <- wtemp %>%
  
  as_tibble() %>%
  
  select(date, time, calispell_temp) %>%
  
  filter(!is.na(calispell_temp)) %>%
  
  arrange(calispell_temp) %>%  
  
  mutate(date2 = mdy(date), 
         month = month(date2), 
         year = year(date2)) %>%
  
  group_by(month, year) %>%
  
  summarize(avg_temp_calispell = mean(calispell_temp),  
            se_temp_calispell = calcSE(calispell_temp)) %>%
  
  ggplot(aes(x = month, y = avg_temp_calispell)) + 

  geom_bar(stat="identity", fill="grey") + 
  
  geom_errorbar(aes(ymax = avg_temp_calispell + se_temp_calispell, 
                    ymin = avg_temp_calispell-se_temp_calispell), width=.1) + 
  
  xlab("Month") + ylab("Mean temperature at Calispell Creek (degrees C)") +
  
  facet_wrap(~year) 

##  Nice!! Let's look at what we created:
Calispell_monthtemp

## QUESTION: Where is (are) the dataset specified in the pipeline?

## TASK: Using hashtags, comment above each line of the pipeline with a description of what the code below does
