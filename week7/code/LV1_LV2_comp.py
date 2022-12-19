#!/usr/bin/env python3

"""
Author: Agnes Szwarczynska; ass122@ic.ac.uk
Date: 16th Nov 2022
Description: Profiling LV1 and LV2 scripts
"""

__author__ = "Agnes Szwarczynska (ass122@ic.ac.uk)"
__date__ = "16th Nov 2022"


###Imports
from cProfile import Profile
import pstats
from io import StringIO
import LV2
import LV1

###Profiling LV2
pr = Profile() #an object of class profile

pr.enable()
LV2.run([]) #running the LV2 script
pr.disable()

s = StringIO()
ps = pstats.Stats(pr, stream=s)
ps.print_stats([]).sort_stats("calls") 

print("LV2:")
print(f"{s.getvalue()}\n") #printing the output of LV2 profiling

###Profiling LV1
pr_2 = Profile() #an object of class profile

pr_2.enable()
LV1.run([]) #running the LV1 script
pr_2.disable()

s_2 = StringIO()
ps_2 = pstats.Stats(pr, stream=s_2)
ps_2.print_stats([]).sort_stats("calls")

print("LV1:")
print(f"{s_2.getvalue()}\n") #printing the output of LV1 profiling

