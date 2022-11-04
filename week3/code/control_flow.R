#!usr/bin/env Rscript

###Control flow in R

a <- TRUE
if (a == TRUE) {
    print("a is TRUE")
} else {
    print ("a is FALSE")
}

a

a <- TRUE
if (a) {
    print("a is TRUE")
} else {
    print ("a is FALSE")
}

a

# if statements

z <- runif(1)
if (z <= 0.5) {print ("Less than a half")}
z

z <- runif(1)
if (z <= 05) {
    print ("Less than a half")
}

# for loops
for (i in 1:10) {
    j <- i * i
    print(paste(i,"square is", j))
}

### Running a loop over a vector of strings

for(species in c("Helidoxa rubinoides",
                "Boissonneaua jardini",
                "Sula nebouxii")) {
    print(paste("The species is", species))
                }
                
v1 <- c("a","bc","def")
for (i in v1) {
    print(i)
}

i <- 0
while (i < 10) {
    i <- i+1
    print(i^2)
}

i