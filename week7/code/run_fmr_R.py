"""
Author: Agnes Szwarczynska; ass122@ic.ac.uk
Date:18th Nov 2022
Description: Using subprocess to run an R script
"""

###Imports
import subprocess

p = subprocess.Popen("Rscript --verbose fmr.R", shell=True).wait()

if p == 0:
    print("Script was run successfully. Enjoy your day!")
else:
    print("Oooops! Errors encountered")


