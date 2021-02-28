# Tutorial for running a Gaussian line scan in SPEX

The example shown here fits a low-flux spectrum of AGN IRAS 13223-3809. Follow the order of the following tasks:

1) spex_continuum_model_fit.com

Loads the XMM / pn and RGS spectra, creates a continuum model and fits the data. This is necessary also to understand the energy range over which to run the Gaussian scan.

Output files: spex_model_RHPB.com, spex_model_RHPBD2L.com, spex_model_RHPBD2LG.com, IRAS_EPIC_RGS_1_OF_10_FIT.ps, IRAS_EPIC_RGS_1_OF_10_FIT.pdf

2) pyth_energy_loggrid_make.py

Use python to create a log-spaced energy grid useful to create the scanning routine.

Output files: Log_E_grid_0310keV_1000kms.txt, Log_F_grid_0310keV_1000kms.txt, ...

3) bash_detection_routine_make.sh

This bash scripts read the energies from e.g. Log_E_grid_0310keV_1000kms.txt, calculates the FWHM for each energy and write the scanning routine.

Output files: spex_det_routine_w1000kms.com, ...

4) bash_detection_routine_run.sh

This bash scripts calls SPEX bestfit continuum, runs the scanning routine for each desired line width, and save the results in a table ascii file (energy, C-stat, Gauss-normalisation).

Output files: results_gaus_1000kms.txt, ...

5) pyth_result_loggrid_plot.py

This simple python script reads the table results and makes a plot of C-stat and significance.

Output files: results_gaus_1000kms.pdf, ...

6) The code can also be found on my GitHub page at:

https://github.com/ciropinto1982/Spectral-fitting-with-SPEX/tree/master/SPEX-Gaussian-line-scan

*License -* This public code was developed for and published in the paper Pinto et al. (2018a), DOI: 10.1093/mnras/sty231, arXiv: 1708.09422, bibcode: 2018MNRAS.476.1021P. You're recommended and kindly requested to refer to that paper when using this code.
