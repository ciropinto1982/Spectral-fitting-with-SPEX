# Spectral fitting with UV / X-ray SPEX package
This folder contains my codes that perform broadband modelling and line detection of X-ray spectra of astronomical objects using the software SPEX (a UV / X-ray fitting package developed at SRON). It can be adapted to different data, software and platforms. Do not hesitate to contact me for more information and support to implement it or adapting to different fitting packages and data.

- /Convert-spectra-to-SPEX-format/ directory contains a few simple examples that run TRAFO auxiliary task of SPEX directly from command line or via shell scripts in order to convert standard OGIP FITS spectra to SPEX format.

- /SPEX-Gaussian-line-scan/ directory contains a full and basic code to scan Gaussian lines over X-ray spectra.

- /SPEX-fits-in-loop/ directory shows more complex routines that provide examples of fits in loop among different spectral models or observations.

- /SPEX-ionisation-balance/ directory provides detail calculation of ionisation balance particularly for photoionised gas crucial for winds.

- /SPEX-physical-grid-scan/ directory provides detail modellisation and physical model scans implementing multiple line fits with physical plasma models.

- /SPEX-simple-fits/ directory contains simple SPEX executable files that can be edited and then loaded into SPEX typing "log exe SPEX_fit_example" or command-by-command. These routines enable to interactivelt fit one or more spectra simultaneously. Each executable files loads observed spectra, creates the spectral model and fits the model to the data, and plots them all.

- /SPEX-tutorial-RGS-nova/ provide a full tutorial to download XMM/RGS spectra, convert them to SPEX and fit them with SPEX with photoionised gas absorption models.

- For a dedicated branch on the treatment of extended sources see: https://github.com/ciropinto1982/XMM-Newton-Data-Reduction/tree/main/Extended_sources

The readers are recommended to refer to the SPEX manual https://www.sron.nl/astrophysics-spex/manual and the very useful SPEX cookbook filled with practical examples of how to run SPEX http://var.sron.nl/SPEX-doc/cookbookv3.00.00.pdf. SPEX can be downloaded from https://www.sron.nl/astrophysics-spex
