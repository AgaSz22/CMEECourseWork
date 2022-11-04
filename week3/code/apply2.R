#!usr/bin/env Rscript

SomeOperation <- function(v) { # (What does this function do?)
if (sum(v) > 0) { #note that sum(v) is a single (scalar) value #if the sum of values in a row > 0 then multiply by 100
    return (v *100)
} else {
    return (v)
}

}

M <- matrix(rnorm(100), 10, 10)  # using apply()
print (apply(M, 1, SomeOperation))

#print(M) #comparing matrices
    