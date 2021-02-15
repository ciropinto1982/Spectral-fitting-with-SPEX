import numpy as np
import matplotlib.pyplot as plt
from scipy import optimize
import pandas as pd

#------------ Definitions ---------------------------------------

convert_Ry_to_keV=0.013605698  # multiplicative

convert_keV_to_K =1.16050e+07  # multiplicative

convert_Ang_to_keV=12.3984428  # to be devided by wavelength

#-------------- Load data from pion (xi, T, cs, Heating, Cooling) ----------------

# Log_xi Tempe (keV) CS kms H:Compton_s H:free-free H:photo-ele H:Compton_i H:Auger_ele C:iCompton  C:elec_ion  C:recombina C:free-free C:coll-ion  Tot_heating Tot_cooling

# ,log_xi ,te_keV ,cs ,HCS ,HFF ,HPE ,HCI ,HAE ,CIC ,CEI ,CRE ,CFF ,CCE ,HTOT ,CTOT

# log_xi,T = np.loadtxt('pion_HC_rates.dat', usecols=(0,1), unpack=True)

log_xi,T, cs ,HCS ,HFF ,HPE ,HCI ,HAE ,CIC ,CEI ,CRE ,CFF ,CCE ,HTOT ,CTOT = np.loadtxt('pion_HC_rates.dat', usecols=(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14), unpack=True)

#log_xi,T, cs ,HCS ,HFF ,HPE ,HCI ,HAE ,CIC ,CEI ,CRE ,CFF ,CCE ,HTOT ,CTOT = np.loadtxt('pion_HC_rates_PhotskeV.dat', usecols=(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14), unpack=True)

#-------------- Heating / cooling rates curves ----------------------------------

# Remember to conver to erg/s/cm**3 (i.e. W/m**3*10.) 

plt.rcParams.update({'font.size': 24})
plt.figure(figsize=(18,12))
plt.semilogy(log_xi, 10.*HTOT,	  c='black',  linewidth=3.0, label='Total heating')
plt.semilogy(log_xi, 10.*HCS,	  c='blue',   linewidth=3.0, label='Compton scattering')
plt.semilogy(log_xi, 10.*HPE,	  c='red',    linewidth=3.0, label='photo-electrons')
plt.semilogy(log_xi, 10.*HCI*10., c='green',  linewidth=3.0, label='Compton ionisation * 10')
plt.semilogy(log_xi, 10.*HAE,	  c='purple', linewidth=3.0, label='Auger electrons')
#plt.semilogy(log_xi, 10.*HFF*100000.,	c='orange',    label='free-free absorption')
#plt.title("Heating VS Cooling")
plt.ylabel("Heating Rate (erg/s/cm**3)", fontsize=28)
plt.xlabel("Log xi (erg/s cm)", fontsize=28)
plt.tick_params(axis='both', which='major', labelsize=24)
plt.tick_params(axis='both', which='minor', labelsize=24)
plt.xlim([-1,6])
plt.ylim([1e-17,1e-8])
plt.rcParams.update({'font.size': 20})
plt.legend(bbox_to_anchor=(0.45, 0.47)) # or horizontally up?
plt.savefig('plot_heating_rates.pdf')
plt.close('all')

plt.rcParams.update({'font.size': 24})
plt.figure(figsize=(18,12))
plt.semilogy(log_xi, 10.*CTOT,	c='black', linewidth=3.0,  label='Total cooling', linestyle='-')
plt.semilogy(log_xi, 10.*CCE,	c='green', linewidth=3.0, label='Collisional excitation', linestyle='-')
plt.semilogy(log_xi, 10.*CFF,	c='red',   linewidth=3.0, label='Free-free emission', linestyle='-')
plt.semilogy(log_xi, 10.*CIC,	c='blue',  linewidth=3.0, label='Inverse Compton scattering', linestyle='-')
plt.semilogy(log_xi, 10.*CEI,	c='orange',linewidth=3.0, label='Electron ionisation', linestyle='-')
plt.semilogy(log_xi, 10.*CRE,	c='purple',linewidth=3.0, label='Recombination', linestyle='-')
#plt.title("Heating VS Cooling")
plt.ylabel("Cooling Rate (erg/s/cm**3)", fontsize=28)
plt.xlabel("Log xi (erg/s cm)", fontsize=28)
plt.tick_params(axis='both', which='major', labelsize=24, width=2.0)
plt.tick_params(axis='both', which='minor', labelsize=24, width=2.0)
plt.xlim([-1,6])
plt.ylim([1e-17,1e-8])
plt.rcParams.update({'font.size': 20})
plt.legend(bbox_to_anchor=(0.45, 0.37)) # or horizontally up?
plt.savefig('plot_cooling_rates.pdf')
plt.close('all')

#-------------- xi VS T curves ----------------------------------

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

#-------------- xi VS pressure curves ----------------------------------

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

#----------------------------------------------------------------------
