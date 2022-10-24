#!/usr/bin/env python3

"""Programm that aligns two DNA sequences and """

__appname__ = 'DNA algorithm'
__author__ = 'Agnes Szwarczynska(aas122@ic.ac.uk)'

## imports ##
from os import write
import sys # module to interface our program with the operating system
from struct import calcsize
import csv

## functions ##

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)

def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")
    
    return score

def main(argv):
    f = open("../data/seq.csv", "r")
    sequences_input = csv.reader(f)
    for line in sequences_input:
        sequences = line

    seq1 = str(sequences[0])
    seq2 = str(sequences[1])

    # Assign the longer sequence s1, and the shorter to s2
    # l1 is length of the longest, l2 that of the shortest

    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths

    # now try to find the best match (highest score) for the two sequences
    my_best_align = None
    my_best_score = -1


    for i in range(l1): # Note that you just take the last alignment with the highest score
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 # think about what this is doing!
            my_best_score = z 
    print(my_best_align)
    print(s1)
    print("Best score:", my_best_score)

    #save the output in a different file in the results folder
    with open("../results/align_seq_output.txt", 'w') as g:
        g.write(my_best_align + '\n'+ s1 + '\n' + "Best score:" + str(my_best_score))

    return 0

if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)