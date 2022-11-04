#!usr/bin/env Rscript

###Practicing pre-allocation

NoPreallocFun <- function(x) {
    a <- vector() #empty vector
    for (i in 1:x) {
        a <- c(a,i)
        #print(a)
        #print(object.size(a))
    }
}

system.time(NoPreallocFun(1000)) #displaying time needed to run the function without the pre-allocation

PreallocFun <- function(x) {
    a <- rep(NA, x)
    for (i in 1:x) {
        a[i] <- i #assign
        #print(a)
        #print(object.size(a))
    }
}

system.time(PreallocFun(1000)) #displaying time needed to run the function with the pre-allocation