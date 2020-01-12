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

# Now let's plot the changes in capture rates over time using a for loop
# We can loop around the `filter`` and `ggplot` functions to create a plot.
# Then save that plot. And we'll loop through each of our species to do this

for(i in select_species$species_id){
  #select the species and make a temporary data frame for the loop
  data_tmp <- species_counts %>% filter(species_id==i)
  
  #ggplot code (in slightly different syntax than before) that plots points and lines for each state
  #describe the data.frame and aesthetics
  p <- ggplot(data_tmp, aes(x = year, y = n, group = sex, color = sex))
  #then add the individual plots and graphics commands to that general ggplot fxn
  p <- p + geom_point() + geom_line() + ggtitle(i)
  p
  #save the figure using the paste function that we talked about earlier
  ggsave(file = paste0(i, '_ByYearBySex','.png'), device = 'png', dpi = 300)
}

# So using this tool, we just printed out and saved figures all at once
# Let's dissect what happened here:
# We made a list of species that we wanted to make a figure for
# Then we selected data from our data frame for each of the species that we wanted
# We built a ggplot figure based upon the species data (using paste to customize the figures)
# Then we used the name of the species to build a file name so that we can save unique files for each

# For loops are a pretty powerful strategy in R and figuring out how to get your code to run in for loops 
# can save you a ton of time and energy and is often well worth it

# Let's add a bit more complexity, what if we want the loop to take an action only some of the time?
# Using 'if' statements we can create conditional statementss that allow us to shape how the loop behaves
# Let's only graph species with more than 10 years worth of data, but let the for loop decide to graph or not

# Now let's implement an if statement in the previous loop
for(i in select_species$species_id){
  #select the species and make a temporary data frame for the loop
  data_tmp <- species_counts %>% filter(species_id==i)
  
  if(length(unique(data_tmp$year)) > 10){
    #ggplot code (in slightly different syntax than before) that plots points and lines for each state
    #describe the data.frame and aesthetics
    p <- ggplot(data_tmp, aes(x = year, y = n, group = sex, color = sex))
    #then add the individual plots and graphics commands to that general ggplot fxn
    p <- p + geom_point() + geom_line() + ggtitle(i)
    p
    #save the figure using the paste function that we talked about earlier
    ggsave(file = paste0(i, '_ByYearBySex','.png'), device = 'png', dpi = 300)
  } else {
    print(paste0(i,' did not have enough years, skipping'))
  }
}


#reminder: the if/else structure in the loop, if the if statement is TRUE, the first statement in the brackets if run. If it's FALSE then the else statement is run. The else statement isn't required, you can just use the if portion.
#the if statement must result in a boolean response (TRUE/FALSE)

#Trouble-shooting for loops. For loops can be difficult to troubleshoot when they hit a snag so I wanted to give you a couple of tips on troubleshooting them.

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


## CHALLENGE
#create a loop that makes a presence over time graph for each species. For species with above median presence for our 10 species group let's use a smooth line, for below median species let's just use points with no line


# For loops can be kinda slow and clunky. They're very versatile
# but come at the expense of cluttery and slow.

# There are other ways of packaging r scripts and turning them into something that runs efficiently
# Without clutter and are more memory effecient
# And thats functions

# Function writing, why learn it?
# There's a couple of reasons learning functions is helpful. One you can write your own common functions.
# Two you can better understand how to troubleshoot your code and other peoples' functions. 
# Three the principles of function writing teach us more about good coding tips to learn including reproduciability.  

# What is a function and why is it necessary in R
# A function is the backbone of R's structure and creates Rs versatility.
# A function lets you package code into one unit that doesn't need to be loaded multiple times, or rewritten.

sem <- function(numbers, na.rm = TRUE){
  se <- sd(numbers, na.rm = na.rm)/sqrt(length(numbers))
  return(se)
}

sem(surveys_complete$hindfoot_length)


c(hi = mean(surveys_complete$hindfoot_length) + sem(surveys_complete$hindfoot_length),
  mean = mean(surveys_complete$hindfoot_length),
  lo = mean(surveys_complete$hindfoot_length) - sem(surveys_complete$hindfoot_length))

#infact you can put functions inside of functions
ci_fun <- function(numbers, na.rm = TRUE){
  c(hi = mean(numbers) + sem(numbers),
    mean = mean(numbers),
    lo = mean(numbers) - sem(numbers)
  )
}

ci_fun(surveys_complete$hindfoot_length)

#And we can create a list of all these functions, so we never have to write them again, just load them.
# Show how to source

# A function is the functional unit in R. R is built around vectorization and function writing.
# Once you understand this you'll get better at understanding why R does things the way it does them. 
# And be able to fix functions or use them for your own troubleshooting
# A function is anything that has two parenthesis after it's name. 
# But a function is simply a way to package up code and run it in a confined space. For example lets look at sd

sd

# you see that? That's actually the underlying code in the function.

# but why do this?
# 1. It's much cleaner. Typing sd() and not having anyone worry about the underlying stuff can be good for readability.
# 2. It's reproducible, and no one can mess with the function. This code will work everytime the way its supposed to, there's no accidently messing up the code. You can hand this to someone and it will always work. And then hark back to #1
# 3. Much easier to give finished product to collaborator or someone with lower R understanding. Including package building
# 4. It's more memory friendly.

### CHALLENGE 

# I want to create a function that converts farenheit measurements to celsius. Lets see if we can do that real quick

# (F - 32) * 5/9

f_to_c <- function(temp_values){
  (temp_values - 32) * 5/9
}

# discuss default arguments

#using if statements we can make a modal function that does fairly different things depending on what mode the user defines

temp_to_c <- function(temp_values, input_temp="F"){
  if(input_temp=="F"){
    newtemps <-  f_to_c(temp_values)}
  if(input_temp=="K"){newtemps <- temp_values - 273.15}
  if(input_temp=="C"){newtemps <- temp_values}
  return(newtemps)
}

# Finally we get to apply functions
# 'Apply' functions are essentially packaged functions with built in for loops
# they 'apply' a function across multiple inputs.
# This can be used to summarize, split, group, etc.

# Apply
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
