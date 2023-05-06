print('# Python routine to manipulate and plot Ionic Columns #')

# Import libraries

import scipy.stats
import math
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import itertools

from scipy import optimize
from decimal import Decimal
from math import cos
from math import log
from math import sqrt
from matplotlib.pyplot import cm
from scipy.optimize import curve_fit
from matplotlib import pyplot
from scipy.odr import *

# Defining constants and conversion factors:

convert_Ry_to_keV=0.013605698  # multiplicative

convert_keV_to_K =1.16050e+07  # multiplicative

convert_keV_to_Hz=2.42e+17     # multiplicative

convert_Ry_to_Hz=convert_Ry_to_keV*convert_keV_to_Hz # multiplicati

convert_Ang_to_keV=12.3984428  # to be devided by wavelength

convert_Ang_to_Hz=3.00e18      # to be devided by wavelength

convert_Ja_to_ErgSCm2Hz=1e-23  # multiplicative

# From Jansky to photons/cm2/s/keV : 1.51   x 10^3 F_Jansky / E_keV
# From Jansky to ergs/s/cm2/Hz     : 10^-23 x      F_Jansky

###################################################################

print('1a) Load col: XMM fit (keV,Jansky)')

col01='column01.dat'
col07='column07.dat'
col08='column08.dat'
col10='column10.dat'
col12='column12.dat'
col14='column14.dat'
col16='column16.dat'
col26='column26.dat'

hxi,h1,h2      = np.loadtxt(col01, usecols=(0,1,2), unpack=True, skiprows=1)
nxi,n6,n7      = np.loadtxt(col07, usecols=(0,6,7), unpack=True, skiprows=1)
oxi,o7,o8      = np.loadtxt(col08, usecols=(0,7,8), unpack=True, skiprows=1)
nexi,ne9,ne10  = np.loadtxt(col10, usecols=(0,9,10), unpack=True, skiprows=1)
mgxi,mg11,mg12 = np.loadtxt(col12, usecols=(0,11,12), unpack=True, skiprows=1)
sixi,si13,si14 = np.loadtxt(col14, usecols=(0,13,14), unpack=True, skiprows=1)
sxi,s15,s16    = np.loadtxt(col16, usecols=(0,15,16), unpack=True, skiprows=1)
fexi,fe17,fe18,fe19,fe20,fe21,fe22,fe23,fe24,fe25,fe26 = np.loadtxt(col26, usecols=(0,17,18,19,20,21,22,23,24,25,26), unpack=True, skiprows=1)

print('2a) Plot col: XMM (keV,Ja)')

fig1=plt.figure(1)

# FRAME 1
frame1=fig1.add_axes((.13,.13,.8,.8))

### The plot is done such that N_H (tot) = 1e24/cm**-2

#plt.plot(hxi, 14+h1, c='blue',  linestyle='-', label="H I"   )
#plt.plot(hxi, 14+h2, c='blue',  linestyle=':', label="H II"  )
plt.plot(oxi, 14+n7  , c='grey' , linestyle='--', label="N VII"  )
plt.plot(oxi, 14+o7  , c='black', linestyle='-' , label="O VII"  )
plt.plot(oxi, 14+o8  , c='black', linestyle=':' , label="O VIII" )
plt.plot(oxi, 14+ne9 , c='red'  , linestyle='-' , label="Ne IX"  )
plt.plot(oxi, 14+ne10, c='red'  , linestyle=':' , label="Ne X"   )
plt.plot(oxi, 14+mg11, c='blue' , linestyle='-' , label="Mg XI"  )
plt.plot(oxi, 14+mg12, c='blue' , linestyle=':' , label="Mg XII" )
#plt.plot(oxi, 14+fe17, c='green' , linestyle='-' , label="Fe XVII")
plt.plot(oxi, 14+fe18, c='green' , linestyle='-', label="Fe XVIII")
plt.plot(oxi, 14+fe19, c='green' , linestyle='--', label="Fe XIX")
plt.plot(oxi, 14+fe20, c='green' , linestyle=':' , label="Fe XX")
#plt.plot(oxi, 14+fe23, c='blue' , linestyle='-' , label="Fe XXIII")
#plt.plot(oxi, 14+fe24, c='blue' , linestyle='--', label="Fe XXIV")
plt.plot(oxi, 14+fe25, c='pink' , linestyle='-', label="Fe XXV")
plt.plot(oxi, 14+fe26, c='pink' , linestyle=':' , label="Fe XXVI")

plt.xlabel(r'Log $\xi$ (erg/s cm)', fontsize=15)
plt.ylabel("Log $N_{ion}$ (cm$^{-2}$)", fontsize=15)

#frame1.legend(loc='upper right', fontsize=12, framealpha=1., bbox_to_anchor=(1.1, 1.1),edgecolor='black')

frame1.legend(loc='upper right', fontsize=12, framealpha=1) # ,bbox_to_anchor=(0.75, 1.04)

frame1.set_xlim([-1,6])
frame1.set_ylim([16,21])
#frame1.set_xscale('log')
##frame1.set_xlim([0.3,0.6])
##frame1.set_xticklabels([])

plt.savefig('plot_col_new.pdf')
plt.close('all')
