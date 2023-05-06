Tutorial for running photo-ionisation balance calculation in SPEX

The example shown here runs the PI equilibrium calculaion for NGC 1313 X-1. Follow the order of the following tasks:

1) SPEX_calc_ionbal_xabs.sh

Loads the SED from the template file SED_ngc1313_Ry_Jy_ge1024bin.dat, calculates and saves the ionisation balance for individual values of log_xi, and save them all into a single ascii data file: xabs_inputfile (and corrects it for bad xi values without equilibrium) and the shortest version xabs_inputfile_corr1_cut.dat to plot curves with python.

2) python_plot_ionbal.py

Reads the (log_xi, kT) results from the file xabs_inputfile_corr1_cut.dat and plots the ionisation balance in the file plot_xi_T_curve.pdf, the stability S curve in plot_xi_psi_curve.pdf, respectively.

3) python_plot_ionbal.py

Reads the ionic fractions from the individual outputs and plots them for each value of ionisation parameter.

