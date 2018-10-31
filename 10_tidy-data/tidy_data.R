################################################################################
### BIO 410/510                                                             ###
### Wrangle: Tidying Data                                                    ### 
################################################################################

## OBJECTIVES:
## To learn what tidy data means.
## To learn how to tidy data in a way that is traceable and reproducible.
## To this end we'll be using the tidyr and dplyr packages.

## The author of tidyr, Hadley Wickham, discusses the philosophy of tidy data
## in his Tidy Data paper: http://vita.had.co.nz/papers/tidy-data.pdf
## It is really worth a read! 

## What are tidy data?
## Tidy data are data that are easy to transform and visualize. 
## The key idea is that variables are stored in a consistent way.
## Each variable forms a column
## Each observation forms a row
## Each type of observational unit forms a table

## There are five common problems associated with messy data:
## 1) Column headers are values, not variable names
## 2) Multiple variables are stored in one column
## 3) Variables are stored in both rows and columns
## 4) Multiple types of observational units are stored in the same table
## 5) A single observational unit is stored in multiple tables

## Load the tidyverse
library(tidyverse)

#######################################
##1) Problem: Column headers are values
## tidyr solution: gather and spread
#######################################

## We've already seen this problem before! 
## We ignored it for the moment, but now is a good time to fix it.
## Remember the Calispell water temperature data? Let's look at it again:
wtemp <- read_csv("CalispellCreekandTributaryTemperatures.csv") 

## Let's assign more useable column names
names(wtemp) <- c("date", "time", "calispell_temp", "smalle_temp", "winchester_temp")


## QUESTION: What is messy about this data?

## To fix it, we'll use the gather function. 
## Pull up the gather help documentation.
?gather

## Note that the gather() call takes the following arguments, in order
## The dataframe
## The name of the key column to create in the output
## The name of the value column to create in the output
## The columns to gather

wtemp_gathered <- gather(wtemp, site, temperature, calispell_temp:winchester_temp) %>%
  print

## QUESTION: What are the dataframe, key and value names and gathered columns in the above call?

## QUESTION: Even though I would say that having values stored as column headers is messy,
## at times it is extremely useful! Name a scenario in which you would want to convert 
## tidy data to this "wider" format.

## Fortunately, tidyr includes a function to make it easy for us to spread data back out
## From the help, we just specify the dataframe, key and value
?spread

## Try it, this time using the pipeline syntax:
wtemp_gathered %>% 
  spread( site, temperature, fill=NA)

## This is also helpful whenever a single observation is recorded in multiple rows.
## A tip-off that this might be the case is when one column has a name like "variable" and another "value"


#########################################################
##2) Problem: Multiple variables are stored in one column
## tidyr solution: separate
#########################################################

## Let's revisit the Lower Spokane fish data
## I've added a some of the messiness for pedagogical purposes
## Let's read it in and convert it to a dataframe table:
fishcatch <- read.csv("LowerSpokaneFish_Messy.csv") %>%
  tbl_df()

## Now have a look. Which column stores multiple variables?
fishcatch

## The separate command helps us do that.
## The separate command is smart and looks for a pattern to separate on
## This is great! But we could specify if we wanted it,
## as always look at the documentation for syntax: ?separate
fishcatch %>%
  separate(FishLength_Weight, c("Length", "Width"))

## TASK: Let's revisit the gathered wtemp dataframe table. 
## It would be nice to remove the "_temp" from each of the site names
## Do this by adding to that pipeline (copied below)
## First separate site into new "site" and "measurement" columns,
## then remove the unnecessary "measurement" column (hint: select is helpful here)

wtemp_gathered <- wtemp %>%
  gather(site, temperature, calispell_temp:winchester_temp) 





############################################################
## 3) Problem: Variables are stored in both rows and columns
## tidyr solution: gather then filter 
############################################################

## Look again at the fishcatch dataframe table
fishcatch

## QUESTION: What information is implicit based on a row/column combination?




## The headers "CapturedFloyTagNo" and "AppliedFloyTagNo" are all different values of 
## what should be a "TagType" variable

## Let's continue to fishcatch pipeline to clean this up
## We can do it with the gather function, adding an argument to remove NAs
fishcatch %>%
  separate(FishLength_Weight, c("Length", "Width")) %>%
  gather(TagType, TagName, CapturedFloyTagNo, AppliedFloyTagNo, na.rm = TRUE) 

## And really what this variable tells us is: has this fish been tagged before?
## We might prefer to store this information in a binary NewCapture column 
## Let's do that, and save it as a fishcatch2
fishcatch2 <- fishcatch %>%
  separate(FishLength_Weight, c("Length", "Width")) %>%
  gather(TagType, TagName, CapturedFloyTagNo, AppliedFloyTagNo, na.rm = TRUE) %>%
  
  ## NEW CODE SECTION:
  #create the NewCapture column
  mutate(NewCapture = 1, NewCapture = ifelse(TagType=="CapturedFloyTagNo", 0, NewCapture)) %>%
  #remove the redundant TagType column
  select(-TagType) %>%
  print

###############################################################################
##4) Problem: Multiple types of observational units are stored in the same table
## tidyr solution: create two "linked" dataframes by selecting relevant columns; 
## reduce those to unique observations
################################################################################

## How are we doing? At first glance, fiscatch2 is looking pretty good! 
## All the rows are observations, all the columns are variables.
## But here, let's sort by Site and Pass. Do you seen the problem now?

fishcatch2 %>%
  arrange(Site, Pass)


## Our solution is to create two dateframes that represent different observational levels.
## The first will describe effort at the level of the site and pass, 
## and second will describe fish size at the level of the individual fish.

effortdat <- fishcatch2 %>%
  select(Date, Site, Pass, Effort) %>%
  unique() %>%
  print

## Site information vs sampling information
fishdat <-fishcatch2 %>%
  select(Date, Site, Pass, FishNo, Species, Length, Width, ScaleAge, NewCapture) 

## QUESTION: How many rows are in effortdat? And in fishdat? 
## How does this compare to the original fishcatch2?

## Of course, for analysis we often want to join two dataframes at different scales.
## For example, to assess the effect of site-level treatments on individuals,
## Or to relate fish catch numbers with effort! 

## So why did we separate?
## 1) To reduce data entry errors (not repeating all that typing!).
## 2) To reduce data storage requirements (the net size difference can be substantial).
## 3) To easily mutate data at one level before linking it with another.
## For example, we could summarize fishdat by count before joining with effortdat.


## We already learned how to link data frames.
## TASK: Rejoin effortdat and fishdat to make a table for analysis


## If not specified, the join commands will act on as many shared columns as possible, and drop data that don't join.
## But you could specify with by=c("column1", "column2"...).
## For more (as always): ?join


#################################################################################
##5) Problem: A single observational unit is stored in multiple tables
## tidyr solution: 
################################################################################

## The fifth common messy data scenario is when a single observational unit is stored in multiple tables.
## This often happens when the tables are split up by another variable; for example, by the year in which they were collected.
## As long as the format for the individual records is consistent, this is an easy problem to fix:
## Read the files into a list of tables.
## For each table, add a new column that records the original file name 
## (because the file name is often the value of an important variable)
## Combine all tables

## Run this code through - it generates an example of what I'm talking about.
pass1<- fishdat %>% 
  filter(Pass==1)%>%
  select(-Pass)
pass2<-fishdat %>%
  filter(Pass==2) %>%
  select(-Pass)

## Have a look at each data frame.
pass1
pass2

## QUESTION: Where is the information on pass number stored in these dataframes?

## To fix this, first create a new column in each dataframe recording that information.
pass1 <- mutate(pass1, Pass=1)
pass2 <- mutate(pass2, Pass=2)

## Then bind the dataframes together.
tog <- rbind(pass1, pass2) %>%
  print

## QUESTION: This type of messiness often happens when data are collected at different points of time.
## Can you think of a reason why the fix might not always be so easy?






## SAVING A CLEAN DATAFRAME
## Instead of "read_csv" we use "write_csv"
## For example, to save the fishdat dataframe as a .csv file
## called "LowerSpokaneFishCatch.csv" uncomment out this code:
# write_csv(fishdat, "LowerSpokaneFishCatch.csv")

##As always, for help check 
?write_csv


