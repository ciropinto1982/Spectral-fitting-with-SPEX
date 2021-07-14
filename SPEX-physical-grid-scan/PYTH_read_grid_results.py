###################################################################################################
############                                                                      #################
############ PYTHON SCRIPT : READ & PLOT SPEX MULTI-D GRID RESULTS (Delta C-Stat) #################
############                                                                      #################
###################################################################################################

import scipy.stats
import math
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import itertools
from matplotlib.colors import BoundaryNorm
from matplotlib.ticker import MaxNLocator

T=np.loadtxt('xabs_XXX_kms_final_3D_CS.dat')
T=np.array(T)

T=np.max(T)-T # Calculate the Delta C-Stat from the maximum C-STAT (from continuum) or provide Continuum C-STAT

INDEX_TLE0=np.where((T < 0)) # to remove negative points from bad fits (if you provide Continuum-only CS).
T[INDEX_TLE0]=0              # to remove negative points from bad fits (if you provide Continuum-only CS).

xi_min=0        # minimum log xi value used by the grid (to be updated)
xi_max=6.01     # maximum log xi value used by the grid + 0.01 (or the last point be ignored)
xi_step=0.1     # step of log xi value used by the grid

zv_min=0        # minimum zv (v_LOS) value used by the grid (to be updated)
zv_max=105000.1 # maximum zv (v_LOS) value used by the grid + 0.01 (or last point be ignored)
zv_step=500     # step of zv (v_LOS) value used by the grid

c=3.0e5         # define speed of light

ylist = np.arange(xi_min,xi_max,xi_step) # define range of log xi

ylist = ylist[0:T.shape[0]]              # To limit log xi at those actually in the grids

xlist = np.arange(zv_min,zv_max,zv_step)/c # define range of line-of-sight velocities

xlist=-1.0*xlist                           # Because blueshifts are negative!

xlist_uncor = xlist                        # uncorrected zv (original SPEX XABS values)

xlist=1.0*(np.sqrt((1+xlist)/(1-xlist))-1) # Relativistic correction for red/blue-shift

# If you have ignored the command "xlist=-1.0*xlist" then in the Rel-corr invert xlist signs.

X, Y = np.meshgrid(xlist, ylist)           # Creating grid mesh for the contour plots

fig = plt.figure(figsize=(7,5))
left, bottom, width, height = 0.12, 0.11, 0.9, 0.85
ax = fig.add_axes([left, bottom, width, height]) 

cmap = plt.get_cmap('jet')
cp = ax.contourf(X, Y, T, 50, cmap=cmap)   # "50" = number of colors in the side bar (arbitrary)
ax.set_ylabel("Log $\\xi$ (erg/s cm)")
ax.set_xlabel('Velocity [c]')
ax.set_xlim([0,-0.301])                    # a bit longer than -0.3c to make sure not misses 0.3c
ax.set_ylim([xi_min,xi_max])
cb=fig.colorbar(cp, orientation='vertical')
cb.ax.set_ylabel("$\Delta C-stat$")

ax.text(-0.03,3.10,"Photoionised", horizontalalignment='left',color='white',rotation=0,fontsize=18)
ax.text(-0.03,2.50,"Absorption",   horizontalalignment='left',color='white',rotation=0,fontsize=18)

plt.rcParams.update({'font.size': 15})
plt.savefig('PYTH_read_grod_results.pdf')
plt.close('all')

INDEX_MAX=np.where(T == np.max(T))

print('Max of Delta C-stat = ',np.max(T))                   # Delta C-stat maximum
print('v_LOS of Max C-stat = ',c*xlist_uncor[INDEX_MAX[1]]) # SPEX XABS original value
print('z [c] of Max C-stat = ',xlist[INDEX_MAX[1]])         # Rel-effects corrected
print('Logxi of Max C-stat = ',ylist[INDEX_MAX[0]])         # Best-fit log xi

###################################################################################################
