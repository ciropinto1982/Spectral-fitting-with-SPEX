# SPEX tutorial to fit complex and line-rich RGS spectra of novae and supersoft sources

0) Download SPEX from link below. You’ll need XQUARTZ or X11 for plotting windows.

   The link will provide installer, manuals and cookbooks.

https://www.sron.nl/astrophysics-spex

1) Some ad-hoc codes and examples can also be found at the following link:

https://github.com/ciropinto1982/Spectral-fitting-with-SPEX

2) Download RGS data from XMM-XSA website

http://nxsa.esac.esa.int/nxsa-web/#search

Source name: V2491 Cygni, Observation ID: 0552270501, Download spectra: RGS (PPS)

3) Convert OGIP-FITS spectra and responses to SPEX SPO/RES format with TRAFO

./TRAFO_FITS_to_SPEX_convert.sh

4) Open the spectra to plot them in SPEX

BASH script: ./SPEX_plot_example_bash.sh

SPEX script: log exe SPEX_plot_example_spex (.com is removed)

or open SPEX and copy/paste individual commands

5) Open, plot and fit spectra with SPEX

SPEX script: log exe SPEX_fits_example_spex (.com is removed)

or open SPEX and copy/paste individual commands

*License -* All these codes have been developed for and published in the paper Pinto et al. (2012b), doi: 10.1051/0004-6361/201117835, arXiv: 1206.2143, bibcode: 2012A&A...543A.134P. You're recommended and kindly requested to refer to that paper when using this code.
