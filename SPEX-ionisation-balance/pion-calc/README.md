Tutorial for running photo-ionisation balance calculation in SPEX

The example shown here runs the PI equilibrium calculaion for NGC 1313 X-1. Follow the order of the following tasks:

1) SPEX_calc_ionbal_pion.sh

Loads the SED from the template file SED_ngc1313_keV_PhotskeV.dat, calculates and saves the ionisation balance for individual values of log_xi, and save them all into a single ascii data file: pion_HC_rates.dat.

2) python_plot_results.py

Reads the results from the file pion_HC_rates.dat and plots the ionisation balance in the file plot_xi_T_curve.pdf, the stability S curve in plot_xi_psi_curve.pdf, and the heating and cooling rates in the files plot_heating_rates.pdf and plot_cooling_rates.pdf, respectively.
