#!/usr/bin/env python3

"""
Author: Agnes Szwarczynska; ass122@ic.ac.uk
Date: 16th Nov 2022
Description: This module produces the Lotka-Voltera model using default parametres. 
It also saves two output figures in the results folder.
"""

###Imports
import numpy as np
import scipy as sc
from scipy import stats
from scipy import integrate
import matplotlib.pylab as p

def run(argv):
    """ This is the main entry point of the programme."""
    ###Defining a function
    def dCR_dt(pops, t =0):  

        R = pops[0]
        C = pops[1]
        dRdt = r * R - a * R * C
        dCdt = -z * C + e * a * R * C
        
        return np.array([dRdt, dCdt])

    type(dCR_dt)

    ###Assigning variables
    r = 1.
    a = 0.1 
    z = 1.5
    e = 0.75

    ###Defining a time vector
    t = np.linspace(0, 15, 1000)

    ###Set the initial conditions for the two populations 
    R0 = 10
    C0 = 5
    RC0 = np.array([R0, C0])

    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

    #pops

    ###Checking whether integration was successful
    type(infodict)
    infodict.keys()
    infodict['message']

    ###Plotting a figure
    f1 = p.figure()

    p.plot(t, pops[:,0], 'g-', label="Resource density") 
    p.plot(t, pops[:,1], 'b-', label="Consumer density")
    p.grid()
    p.legend(loc="best")
    p.xlabel("Time")
    p.ylabel("Population")
    p.title("Consumer-Resource population dynamics")
    #p.show()

    ###Saving the plot
    f1.savefig("../results/LV1_model_1.pdf")

    ###Plotting a figure
    f2 = p.figure()

    p.plot(pops[:,0], pops[:,1], 'r-') 
    p.grid()
    p.legend(loc="best")
    p.xlabel("Resource density")
    p.ylabel("Consumer density")
    p.title("Consumer-Resource population dynamics")
    #p.show()
    
    ###Saving the plot
    f2.savefig("../results/LV1_model_2.pdf")

if __name__ == "__main__":
    import sys
    run(sys.argv)