Tutorial for running photo-ionisation balance calculation in SPEX

Two different approches are considered depending on the requirements: instantaneous ion-bal calculation (PION) and pre-calculated ion-bal (XABS). The PION model is convolved by the spectral continuum or the broadband SED and instantaneously calculates the ionisation balance, computing the strength of the emission and/or absorption lines for the fitted values of NH, log_xi, nH, etc. It's the most powerful code currently available but a bit slow, especially for the emission component. The XABS model is applied onto but not convolved for the spectral continuum. It in fact receives as input the ionisation balance (a file called xabs_inputfile) pre-calculated before by PION or other codes onto the brodband SED (see below). It's currently the fastest photoionisation code available but only works for absorption lines.

1) PION (emission and absorption lines)

- pion-calc / SPEX_calc_ionbal_pion.sh runs the photoionisation calculation with PION
- pion-calc / python_plot_results.py reads the results and make plots

2) XABS (absorption lines)

- xabs-calc / SPEX_calc_ionbal_xabs.sh runs the photoionisation calculation with XABSINPUT
- xabs-calc / python_plot_ionbal.py reads the results and make plots
