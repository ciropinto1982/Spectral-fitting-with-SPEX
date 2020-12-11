# Spectral fitting
This folder contains my codes that perform broadband modelling and line detection of X-ray spectra of astronomical objects using the software SPEX (a UV / X-ray fitting package developed at SRON). It can be adapted to different data, software and platforms. Do not hesitate to contact me for more information and support to implement it or adapting to different fitting packages and data.

- /SPEX-simple-fits/ directory contains simple SPEX executable files that can be edited and then loaded into SPEX typing "log exe SPEX_fit_example" or command-by-command. These routines enable to interactivelt fit one or more spectra simultaneously. Each executable files loads observed spectra, creates the spectral model and fits the model to the data, and plots them all.

- /SPEX-fits-in-loop/ directory shows more complex routines that provide examples of fits in loop among different spectral models or observations.

- /Convert-spectra-to-SPEX-format/ directory contains a few simple examples that run TRAFO auxiliary task of SPEX directly from command line or via shell scripts in order to convert standard OGIP FITS spectra to SPEX format.

The readers are recommended to refer to the SPEX manual https://www.sron.nl/astrophysics-spex/manual and the very useful SPEX cookbook filled with practical examples of how to run SPEX http://var.sron.nl/SPEX-doc/cookbookv3.00.00.pdf. SPEX can be downloaded from https://www.sron.nl/astrophysics-spex
