### INFO: this routine creates a Log grid of energy
###       and calculates the FWHM at each energy for a given set
###       of velocity dispersion values
###       A different step (number of points is adopted for each width
###       as broader lines requires less resolution and step points)
###       Output: 2 files (energies & FWHM) for each velocity dispersion

# Import my favourite libraries

import numpy as np
import math
#import scipy.stats
#import matplotlib.pyplot as plt
#import pandas as pd
#import itertools

#from scipy import optimize
#from decimal import Decimal
#from math import cos
#from math import log
#from math import sqrt
#from matplotlib.pyplot import cm
#from scipy.optimize import curve_fit
#from matplotlib import pyplot
#from scipy.odr import *

# Info about detectors and constants
#
# 2000

outdir="./"

c=3.0e5        # lightspeed in km/s

Emin_RGS=0.3   # keV
Emax_RGS=2.0   # keV

Emin_epic=0.300  # keV
Emax_epic=9.999  # keV

#number_of_points=1000 # for 1000 km/s step
#number_of_points=2000 # for  500 km/s step
#number_of_points=4000 # for  250 km/s step
#number_of_points=1e4  # for  100 km/s step

number_of_points=[1000,2000,3000,4000]

line_width_kms=[1000,500,250,100]

for i in range(0,len(number_of_points)):
	# Create Log range (of Energy in keV):
	Log_E=np.logspace(math.log10(Emin_epic), math.log10(Emax_epic), num=number_of_points[i])
	np.set_printoptions(precision=6)
	np.set_printoptions(formatter={'float': '{: 0.6f}'.format})
	
	#pyplot.text(0.04, 0.32, 'V = %.2f + %.2f * HR' %(out.beta[0],out.beta[1]),color='red')
	
# Save values into text files
	
	np.savetxt(str(outdir)+'Log_E_grid_0310keV_'+str(line_width_kms[i])+'kms.txt',Log_E,delimiter=' ', fmt='%1.6f')
	
	FWHM=Log_E*line_width_kms[i]/c*2.35
	
	np.savetxt(str(outdir)+'Log_F_grid_0310keV_'+str(line_width_kms[i])+'kms.txt',FWHM,delimiter=' ', fmt='%1.6f')

# Check grid properties: FWHM of 1st and last energy points point and their energy step

	print("FWHM (min) =",FWHM[0]/Log_E[0]*c/2.35,"km/s")
	print("FWHM (max) =",FWHM[len(Log_E)-1]/Log_E[len(Log_E)-1]*c/2.35,"km/s")

	print("FWHM (min) =",FWHM[0],"keV")
	print("FWHM (max) =",FWHM[len(Log_E)-1],"keV")
	
	print("DE/E*c (min) =",(Log_E[1]-Log_E[0])/Log_E[0]*c,"km/s")
	print("DE/E*c (max) =",(Log_E[len(Log_E)-1]-Log_E[len(Log_E)-2])/Log_E[len(Log_E)-2]*c,"km/s")

