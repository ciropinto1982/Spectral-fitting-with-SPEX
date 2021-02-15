import numpy as np
import matplotlib.pyplot as plt
from scipy import optimize
import pandas as pd

#-------------- Definitions --------------------------------------------------------

convert_Ry_to_keV=0.013605698  # multiplicative

convert_keV_to_K =1.16050e+07  # multiplicative

convert_Ang_to_keV=12.3984428  # to be devided by wavelength

#-------------- Load data from pion (xi, T) ----------------------------------------

log_xi, T = np.loadtxt('xabs_results/xabs_inputfile_corr1_cut.dat', usecols=(0,1), unpack=True)

# note that temperatures are in eV as default of xabsinut output

T = T / 1e3

#-------------- xi VS T curves -----------------------------------------------------

Log_T_K = np.log10(T * convert_keV_to_K)

plt.rcParams.update({'font.size': 18})

#plt.scatter(log_xi, T, c='pink', label='measurement', marker='.', edgecolors=None)
plt.plot(log_xi, Log_T_K,	c='b') # , label='NGC 1313 ULX-1'
#plt.title("Log xi VS T")
plt.ylabel("Log T (K)")
plt.xlabel(r'Log $\xi$ (erg/s cm)')
plt.xlim([-1,6])
plt.ylim([4.0,7.5])

#plt.legend(loc='upper left')

plt.savefig('plot_xi_T_curve.pdf')

plt.close('all')

#-------------- xi VS pressure curves ----------------------------------------------

xi = 10**log_xi
	
psi=19222. * xi / T / convert_keV_to_K

plt.plot(psi,log_xi, c='r') # , label='NGC 1313 ULX-1'
#plt.title("Log xi VS Xi")
plt.ylabel(r'Log $\xi$ (erg/s cm)')
plt.xlabel(r'Pressure ($\Xi \sim \xi / T$)')
plt.xlim([4,16])
plt.ylim([0.5,4])

#plt.legend(loc='upper left')

plt.savefig('plot_xi_psi_curve.pdf')

plt.close('all')

#----------------------------------------------------------------------------------
