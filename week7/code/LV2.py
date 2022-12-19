#!/usr/bin/env python3

"""
Author: Agnes Szwarczynska; ass122@ic.ac.uk
Date: 16th Nov 2022
Description: Visualising Lotka-Voltera model with various parametres
"""

__author__ = "Agnes Szwarczynska (ass122@ic.ac.uk)"
__date__ = "16th Nov 2022"


###Imports
import numpy as np
import scipy as sc
from scipy import stats
from scipy import integrate
import matplotlib.pylab as p
import sys

###

def run(argv):
    """This is the main entry point of the programme."""
    ###Defining a function
    def dCR_dt(pops, t =0): 
        R = pops[0]
        C = pops[1]
        dRdt = r * R *(1 - R/K) - a * R * C
        dCdt = -z * C + e * a * R * C
        
        return np.array([dRdt, dCdt])

    type(dCR_dt)

    ###Assigning variables

    if len(sys.argv) != 6:
        print("Insufficient number of arguments provided. Running the script with default parametres")
        r = 1.0
        a = 0.9 
        z = 0.5
        e = 0.5
        K = 20
        
    else:
        r = float(sys.argv[1])
        a = float(sys.argv[2])
        z = float(sys.argv[3])
        e = float(sys.argv[4])
        K = float(sys.argv[5])


    ###Defining a time vector
    t = np.linspace(0, 300, 4000)

    ###Set the initial conditions for the two populations 
    R0 = 1
    C0 = 1
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
    p.text(150, 1.15, f"\n r = {r}\n a = {a}\n z = {z}\n e = {e}\n K = {K}", fontsize=12)
    #p.text(180, 6, f"K prey = {pops[-1][0]}", fontsize=12)
    #p.show()

    f2 = p.figure()

    p.plot(pops[:,0], pops[:,1], 'r-') 
    p.grid()
    p.legend(loc="best")
    p.xlabel("Resource density")
    p.ylabel("Consumer density")
    p.title("Consumer-Resource population dynamics")
    p.text(1.2, 1, f"\n r = {r}\n a = {a}\n z = {z}\n e = {e}\n K = {K}", fontsize=12)
    #p.show()

    ###Saving the plot

    f1.savefig("../results/LV2_model_1.pdf")
    f2.savefig("../results/LV2_model_2.pdf")

    #Printing final prey and predator densities
    print(f"The final prey density is {pops[-1][0]}.\nThe final predator density is {pops[-1][1]}")

    ###If the script is run by itself

if __name__ == "__main__":
    import sys
    run(sys.argv)