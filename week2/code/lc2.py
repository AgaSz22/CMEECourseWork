#!/usr/bin/env python3

"""
Author: Agnes Szwarczynska; ass122@ic.ac.uk
Date: 11th Oct 2022
Description: Getting familiar with list comprehensions
"""


# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
from telnetlib import theNULL


rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
 
# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.

###1
print("Months and rainfall values when the amount of rain was greater than 100mm:")
rainfall_values_1=[rainfall[x] for x in range(len(rainfall)) if (rainfall[x][1]) > 100 ]
print(rainfall_values_1)

###2
print("Months when the amount of rain was less than 50mm:")
rainfall_values_2=[rainfall[x][0] for x in range(len(rainfall)) if (rainfall[x][1]) < 50 ]
print(rainfall_values_2)

###3
print("Months and rainfall values when the amount of rain was greater than 100mm:")
for x in range(len(rainfall)):
    if (rainfall[x][1]) > 100:
        print(rainfall[x])

print("Months names when the amount of rain was less than 50mm:")
for x in range(len(rainfall)):
    if (rainfall[x][1]) < 50:
        print(rainfall[x][0])

