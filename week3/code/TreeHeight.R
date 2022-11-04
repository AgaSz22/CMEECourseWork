#!usr/bin/env Rscript

# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

List_of_trees <- read.csv("../data/trees.csv", header = TRUE)
List_of_trees <- as.data.frame(List_of_trees)

List_of_trees <- List_of_trees[,-1]

TreeHeight <- function(degrees, distance) {
    radians <- degrees * pi/180
    height <- distance * tan(radians)
    return (height)
}


x <- rep(NA,120)
for (i in rownames(List_of_trees)) {
    distance <- List_of_trees[i, "Distance.m"]
    degrees  <- List_of_trees[i, "Angle.degrees"]
    
    Tree.Height.value <- (TreeHeight(degrees, distance))
    
    x[as.integer(i)] <- Tree.Height.value
    print(Tree.Height.value)
    
}

print(x)

List_of_trees['Tree.Height.m'] <- x


write.csv(List_of_trees, "../results/Trees_output.csv")
