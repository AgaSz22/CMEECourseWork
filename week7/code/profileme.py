#!/usr/bin/env python3

"""
Author: Agnes Szwarczynska; ass122@ic.ac.uk
Date: 18th Nov 2022
Description: An illustrative program for testing profiling.
"""

def my_squares(iters): 
    """squaring"""  
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """joining"""
    out = ""
    for i in range(iters):
        out += string.join(",")
    return out


def run_my_funcs(x,y):
    """squaring and joining"""    
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0


run_my_funcs(10000000, "My string")