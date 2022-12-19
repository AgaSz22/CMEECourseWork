"""
Author: Agnes Szwarczynska; ass122@ic.ac.uk
Date: 18th Nov 2022
Description: An illustrative program, built on profileme.py, for testing profiling.
"""

def my_squares(iters):
    """squaring"""
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """joining"""
    out = ""
    for i in range(iters):
        out += "," + string
    return out

def run_my_funcs(x,y):
    """squaring and joining"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000, "My string")