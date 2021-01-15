# Python routine to read the results from linegrid search 
# The code is equivalent to the IDL script but opensource

import numpy as np
import matplotlib.pyplot as plt
#import scipy.stats
#import math
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

########################################################

# Defining directories and data files to load:

readir='./'

outfile1='results_gaus_1000kms'

infile01='results_gaus_1000kms'

# Loading data:

print('Reading the results from SPEX Gaussian Line Detection .................')

en01,dc01,no01=np.loadtxt(readir+infile01+'.txt', usecols=(0,1,2), unpack=True)

# Manipulating data:

max_01=717      # +1.0 _alldata

mix_dc_all=717  # This is a control value (max C-stat) in case some E-fits are broken (and huge C-stat)

dc01[np.where(dc01 > max_01)]=max_01

######################################################################################################

# Plot data: Figure 1 for 2 BB continuum model and solar abundances

fig1=plt.figure(1)

# FRAME 1
frame1=fig1.add_axes((.12,.575,.85,.4)) # Y: 0.1-0.3+0.00, 0.3-0.5+0.025, 0.5-0.7+0.050, 0.7-0.9+0.075
	
plt.plot(en01, ((max_01-dc01))*np.sign(no01), c='grey', linestyle='-', label="FWHM = 1000 km/s")

plt.legend(loc='upper right', fontsize=11, framealpha=0.) # ,bbox_to_anchor=(0.75, 1.04)

plt.ylabel("$\Delta$C-stat", fontsize=13)

y_line     = en01*0.

plt.plot(en01,y_line, c='black', linestyle='-')

#pyplot.text(0.4, 100, '2 BB', horizontalalignment='right')

# FRAME 2
frame2=fig1.add_axes((.12,.15,.85,.4))

plt.plot(en01, np.sqrt((max_01-dc01))*np.sign(no01), c='grey', linestyle='-' )

y_line     = en01*0.
y_line_up2 = en01*0.+5
y_line_dw2 = en01*0.-5
y_line_up3 = en01*0.+10
y_line_dw3 = en01*0.-10

plt.plot(en01,y_line, c='black', linestyle='-')

plt.fill_between(en01, y_line_up2, y_line_dw2, color='grey', alpha='0.25')
plt.fill_between(en01, y_line_up3, y_line_dw3, color='grey', alpha='0.25')

plt.ylabel("Significance ($\sigma$)", fontsize=13)
plt.xlabel("Energy (keV)", fontsize=13)

frame1.set_xscale('log')
frame2.set_xscale('log')
#frame1.set_xlim([0.3,10])
#frame2.set_xlim([0.3,10])
#frame1.set_ylim([-800/10,1500/10])

frame1.set_xticklabels([]) #Remove x-tic labels for the first frame

#frame1.set_yticklabels([15])

plt.rcParams.update({'font.size': 12})

plt.savefig(outfile1+'.pdf')
plt.close('all')

######################################################################################################

print('Check PDF file: ' +outfile1+'.pdf' +'.....................')
