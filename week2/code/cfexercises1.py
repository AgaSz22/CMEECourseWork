#!/usr/bin/env python3
"""Some functions exemplifying the use of control statements"""
#docstrings are considered part of  the running code (normal comments are #stripped).Hence you can accesss your docstrings at run time.

#__appname__ = "cfexercise"
__author__ = "Agnes Szwarczynska (ass122@ic.ac.uk)"
__version__ = "0.0.1"
__license__ = "License for this code/program"

##imports##
import sys ## module to interface our program with the operating system
import doctest
from tempfile import tempdir

#A couple of functions

def foo_1(x):
    return x ** 0.5


def foo_2(x,y):
    if x>y:
        return x
    return y


def foo_3(x,y,z):    #printing x,y,z in ascending order
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y = tmp
    return [x, y, z]


def foo_4(x):      #calculates factorial of x
    result = 1
    for i in range(1, x+1):
        result = result * i
        print(result)
    return result


def foo_5(x): ## a recursive function that calculates the factorial of x
    if x ==1:
        return 1
    if x ==0:
        return 1
    return x * foo_5(x-1)


def foo_6(x): # Calculate the factorial of x in a different way; no if statement involved
    facto = 1
    if x==0:
        return 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto


def main(argv):
    """Main entry point of the program"""
    print("This is cfexercise")
    print(foo_1(5))
    print(foo_2(5,4))
    print(foo_3(5,4,7))
    print(foo_4(5))
    print(foo_5(5))
    print(foo_6(5))
    return 0 # NOTE: indented using two tabs or 4 spaces


if __name__ == "__main__":
    """Makes sure the "main function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)   