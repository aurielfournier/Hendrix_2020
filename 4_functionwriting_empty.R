########LESSON 3 ###############
### -- Commonly used tools in R for repeated tasks
### -- By - Matt Boone, Evan Adams,  and Auriel Fournier
### -- https://github.com/aurielfournier/AOS2019AK


### Commonly used tools in R for repeated tasks

# use install.packages() if you don't have these already
library(dplyr)
library(ggplot2) 

### Paste Functions

# Whatever you put in quotes will be printed to the console. This is useful because it will print out while code is running, including inside functions and for loops.

?paste
?paste0
x <- 
paste0('hello','my','name','is',x)
paste('hello','my','name','is',x)

#This becomes useful when you add in dynamic variables
i <- 

paste0('i am ',i)


### For loops -- or how to write code in a way that you can do repeated actions





for(i in c(1,2,3,4,5) ){
  print(i)
}

















# Lets read our cleaned data set from yesterday, and remind ourselves what it looks like
surveys_complete <- read.csv("surveys_complete.csv")
head(surveys_complete)
str(surveys_complete)

# 1. Lets start by remaking our data table counting the amount of species caught per year per sex
species_counts <- surveys_complete %>% group_by(species_id,year,sex) %>% count()

# 2. To add another layer, lets see if theres any species that were not caught very often and we can filter out
species_counts %>% group_by(species_id,sex) %>% tally(n)

select_species <- species_counts %>% group_by(species_id) %>% tally(n) %>% filter(n>200)

























#reminder: the if/else structure in the loop, if the if statement is TRUE, the first statement in the brackets if run. If it's FALSE then the else statement is run. The else statement isn't required, you can just use the if portion.
#the if statement must result in a boolean response (TRUE/FALSE)

#Trouble-shooting for loops. 

#1. Put in a line at the top that allows you to read in a dummy variable

for(i in 1:10){
  #i<-1
  print(i)
  
}

#2. Print the outputs, or save middle outputs
for(i in c(1,2,NA,4)){
  print(i)
  sub_data<-i+1
  print("heres the middle data set")
  print(sub_data)
  print('now printing mean')
  mean(sub_data)
}

#3. Write the for loop last
for(i in 1:10){
  #i<-1
  mean(i)+2
  print(paste0('the answer is: ', i))
}

## Challenge

# For loops can be kinda slow and clunky. They're very versatile
# but come at the expense of cluttery and slow.

# Function writing



























### CHALLENGE 

# I want to create a function that converts farenheit measurements to celsius. Lets see if we can do that real quick

# (F - 32) * 5/9








#using if statements we can make a modal function that does fairly different things depending on what mode the user defines

temp_to_c <- function(temp_values, input_temp="F"){
  if(input_temp=="F"){
    newtemps <-  f_to_c(temp_values)}
  if(input_temp=="K"){newtemps <- temp_values - 273.15}
  if(input_temp=="C"){newtemps <- temp_values}
  return(newtemps)
}


# Apply functions

set.seed(1234)

dat <- matrix(rnorm(100,mean=50, sd=40), nrow=10, ncol=10)

## check
apply(dat, 1, sum)
apply(dat, 2, sum)
apply(dat, 2, f_to_c)

# lapply
list()


####################################################
# Summary of if and for loops, functions, and apply
#####################################################################

##-'for' loops are best to do tasks that can not be vectorized or when memory is an issue
##- 'for' loops are ideal for looping through files or starter values
##-'If' statements should only be used if vectorizing was not an option
##-If you have to make more than one 'if' statement you can probably vectorize it
##-Neither is ideal for math, since R is very good at doing this
##-Exceptions are when a function can not be vectorized or when referencing previous values
##-Also for lowering memory usage 
##-(If your files exceed 1.5gb looping or other packages may be requried)
##-apply is a great way to vectorize functions over large amounts of data in a way that can mimic for loops

#end of lesson
