################################################################################
### BIO 410/510                                                             ###
### MODULE 1: Intro to R and RStudio                                         ### 
################################################################################

## OBJECTIVE:
## To explore the basic building blocks of the R programming language.
## To become comfortable running and writing R code and working together.
## We will practice the concepts of 'function' and 'argument', 
## and learn some basic functions in R. 
## Create a resource to refer back to.

########################################################################
## 1) In it's simplest form, R can be used as an interactive calculator. 
########################################################################

## Type this in the console; note the use of the operator '+' 
2 + 5

## Now run the same code but this time run it from the script
## Instead of copying 2 + 3 into the console, click on or highlight the line and run cmd-R or cntl-R 
## Or, in a pinch, click on the line and click the run icon to the right in RStudio above the script
2 + 3

## Now try running the lines preceded by hashtags
## What happens? Why might this be useful?

## TASK: Use the other basic algebraic operators: '-', '*', '/' and '^' to 
## substract, multiply, etc. the values 2 and 3.
 
## Like any good interactive calculator, 
## R follows the standard mathematical order of operations. 
## Type:
3+2/8

#Now type:
(3+2)/8

## QUESTION: Why are the results different?

## EXTRA TASK: What is the result of: multiplying 5 by 11, then dividing that value by 3, 
## adding 6 to it, and rising that result to 2? Write this operation as a 
## single line of code.


######################################################
## 2) Functions can replace basic algebraic operators.
######################################################

## Type this into the console:
sum(2, 3)

## QUESTION: What is 'sum'? 

#Now type:
Sum(2, 3)

# The above command should give you an error. This is because R distinguishes 
# lower case from UPPER case. The function 'sum' is not the same 
# as 'Sum', and in this case 'Sum' does not exist.


## In addition to the common arithmetic operators +, -, / and ^, other useful operators are
## mean() for the mean, sqrt() to take the square root, and abs() for the absolute value


################################################
##3) Results can be stored and reused as objects.
################################################

## We've summed 2 and 3 a lot! This time let's just save the results for future use.
## Type:
x <- sum(2,3)

## This can be read as "x gets 2 plus 3". Notice that R did not print the result 5 this time.
## To view the contents of the variable x, jut type x and press Enter:
x

## Now store the results of x/8 in a new variable y:
y <- x/8

##QUESTION: What is the value of y?


######################################################
##4) A collection of values can be stored as a vector.
######################################################

## The easiest way to create a vector is with the c() function, 
## which stands for 'concatenate' or 'combine'. 
## Let's store a vector of 1.1, 9 and 3.14 in a variable called z:
z <- c(1.1, 9, 3.14)

## Type z to view its contents:
z

## QUESTION: What do you notice about z?
## TASK: How long is z? Use the function length() to confirm the length of this vector.


## You can combine vectors to make a new vector. 
## EXTRA TASK: Create a new vector that contains z, 555,then z again in that order.


## Numeric vectors can be used in arthimetic expressions. 
## Type:
z *2 +100

## Create a new vector my_sqrt:
my_sqrt <- sqrt(z-1)

## QUESTION: Before you look at it, what do you think my_sqrt contains?


###################################################
##5) Vectors can be created as sequences of numbers.
###################################################

## The simplest way to create a sequence is by using the ':' operator.
## Type:
1:20

## QUESTION: What happens if we instead type 20:1?

## The seq() function gives us more control over the sequence
## Type:
seq(1,20)

## This gives the same output as 1:20. But let's say we want the numbers to range from
## 0 to 10 but at 0.5 increments. Try it out:
seq(0,10, by=.5)

## Or maybe we don't care about the increment, we just want 30 numbers between 5 and 10.
## Try it out:
my_seq <- seq(5,10, length=30)


## QUESTION: What is my_seq?
## TASK: Confirm that my_seq has length 30.

## EXTRA PLAY
## Maybe we want to create a vector that contains 40 0s. 
## Type:
rep(0, times=40)

## Or maybe we want to create a vector that contains 10 repetitions of the vector (0,1,2,3,4)
## Type: 
rep(c(0,1,2,3,4), times=10)

## EXTRA TASK: Can you generate the same vector by integrating the seq() and rep() functions?

#################################################
##6) Values can be characters as well as numbers.
#################################################

## What's your favorite species?
## Mine is Lasthenia californica (California goldfields!)
## To make sure we remember that, let's make a vector called "drhalletts_favorite":
drhalletts_favorite <- c("Lasthenia", "calfornica")

## View that vector. But typing drhalletts_favorite takes a looong time. 
## To save time, type l then press tab. What happens?

## TASK: Use the function length to confirm the length of drhalletts_favorite.

## What if I want genus and species to be grouped as a single character string?
## Type:
drhalletts_favorite2 <- paste("Lasthenia", "californica")

## TASK: Use the function length to confirm the length of drhalletts_favorite2.

## EXTRA TASK: Use the function 'paste' to join together the genus and species of your 
## favorite species. 
## EXTRA TASK: Concatenate c() your favorite species and mine (drhalletts_favorite2) 
## in a vector called our_favorites.



################################################################################
##7) Vectors can be combined into matrices and data frames                  ### 
################################################################################


## Let's start with matrices. These are similar to vectors in that all of the 
## data must be of the same type (e.g., numbers), but matrices have 2 dimensions 
## (rows x columns). Matrices (e.g., for correlation and covariance coefficients)
## are common in statistics and in population biology, where population 
## projection matrices are used.

## We'll first create a simple vector containing the number 1 through 24. 
## The colon : operator can be used to create a sequence.
firstvector <- 1:24

## Take a look at the dim help file
?dim 

## According to ?dim, the dim() function can be used to both retrieve or SET the dimensions of an object.
## Let's use it to set the dimensions of firstvector.
dim(firstvector) <- c(4,6)

## QUESTION: What are the dimensions of firstvector now? Use dim() to find out
## QUESTION: What is the class of firstvector now? Use the class() function to find out.

## Congratulations, you've changed a 24-element into a 4 row by 6 column matrix!
## To reflect this change, let's assign our new matrix to an object called "firstmatrix"
firstmatrix <- firstvector

## Suppose that firstmatrix represents the happiness levels over time for some
## students of the class. Each row represents a student and each
## column represents happiness level taken at 6 times during this session.
## It would be useful to label the rows so that we know who the students are.
## We'll add a column to the matrix to do this.

students <- c("Megha", "Georgia", "Yi", "Dan")

## Now we'll use the cbind() function to combine participants and firstmatrix.
# cbind indicates "column bind" - it to binds columns together. rbind is the corresponding function for rows.
cbind(students, firstmatrix)

## QUESTION: what attributes of the matrix change when we do this?

## Remember that a matrix can only contain one type of data! 
## We added a character vector to a numeric matrix!
## And what did R do in response? Forced all of the numbers into character values. 

## QUESTION: What data structure allows columns with different data types?

## Let's create a dataframe called "happydata" by binding students and first matrix
happydata <- data.frame(students, firstmatrix)

## TASK: View the contents of happydata.
## TASK: Find the class and dimension of happydata.


## EXTRA PLAY 

## The names of the columns are not descriptive. So we'll fix that.
## TASK: Create a vector called cnames containing "student", "time1", "time2", "time3", "time4", "time5", "time6"
## Hint: you could copy those names from above. Don't forget to concatenate using c()!

## TASK: Use the names() function to set the column names attribute for our 
## data frame. This will be similar to our use of dim() to set the dimension of a vector.

## TASK: View the final data frame.

## There are many ways to skin a cat. We could also make a matrix using the matrix function.
secondmatrix <- matrix(1:24, nrow=4, ncol=6)

## We can check to see if the matrices are the same using the identical() function.
identical(firstmatrix, secondmatrix)  #Did we succeed?

##################################
##8) Anatomy of a function    ####
##################################

## Let's take a closer look at functions
## Functions have 5 different properties
## 1) the name, 2) the body, 3) the arguments, 4) the default values, 5) the last line of code

## Below is Grolemund's "roll two dice" function
roll2 <- function(bones = 1:6){
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}

## roll2 is the name of the function. What are the other components of the function?

## What happens if you run roll2 without supplying any arguments?
roll2()

#################################################
##9) R libraries are bundles of functions    ####
#################################################

## R is open-source, which means that anyone can share code by creating an R package (also called a library)
## R packages are bundles of functions, often based around a theme
## You only have to install a package once, using the function install.packages()
## But you have to load an installed package each R session

## For example, try printing the code underlying the function gather
gather

## What happened? Why? 

## gather is a function in the package tidyr
## If you are using your own computer, install tidyr now by uncommenting and running the following code:
# install.packages("tidyr")

## If you are using a lab computer, tidyr is already installed. Everyone try loading it now:
library("tidyr")

## Now what happens when you print gather?

## gather is a function to help "tidy" data, which we will cover later
## but as a preview, let's use it to transform the matrix happy data
gather(happydata, key = "timepoints", value = "happiness", 2:ncol(happydata))

## What did gather do? Why might this be useful? 

##################################
##10) Getting help as we go along.
#################################

## The arguments to each function are alway documented. 
## Let's look up the possible arguments for the paste function.
##Type: 
?paste

## TASK: Using the help for this function, identify what is the role of the 
## argument 'sep'.
## TASK: Does this argument have a predetermined value? What is that value?
## TASK: Use 'paste' to join together the genus and species names of your 
## favorite species using the character '_' to separate the two words.


##################################
##11) Next week setup  ###########
#################################

## There are a lot of different tools available to learn R
## One of my favorites is an R package called swirl
## With the motto "Learn R, in R"
## Install and load swirl now


## swirl includes different modules. To reinforce some of this lesson, and to learn more about how R treats vectors, you will be working through swirl modules in class next Monday.

