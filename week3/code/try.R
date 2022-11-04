#!usr/bin/env Rscript

rm(list=ls())  ###Clearing the environment

doit <- function(x) {
    temp_x <- sample(x, replace = TRUE)
    if(length(unique(temp_x)) > 30) {#only take mean if sample was sufficient
         print(paste("Mean of this sample was:", as.character(mean(temp_x))))
        } 
    else {
        stop("Couldn't calculate mean: too few unique values!")
        }
    }


###Generating a population 

set.seed(1345) # again, to get the same result for illustration
popn <- rnorm(50)
hist(popn)

### lapply() without try()
#lapply(1:15, function(i) doit(popn))

### lapply() with try()
result <- lapply(1:15, function(i) try(doit(popn), FALSE))

###Looking at errors
class(result)

result

###Storing errors
result <- vector("list", 15) #Preallocate/Initialize
for(i in 1:15) {
    result[[i]] <- try(doit(popn), FALSE)
    }