### Here are a few examples of how to convert spectra from standard OGIP FITS format to SPEX format.

### The first example shows how to convert an EPIC-pn spectrum provided by the XMM-Newton satellite
### The files can be stored into bash or other shells scripts and run sequentially.

### Trafo will ask in sequence the following information:
### 1) input format e.g OGIP (=1), 2) number of spectra to be converted (=1), 
### 3) number of groups of response matrix (10000 are OK for most CCD and grating spectra), 
### 4) matrix partitioning (=3 if yes) and 5) corresponding components (=16, power of 2), 
### 6) nome of input source FITS spectrum file OGIP, 7) if available (=yes) then 8) provide
### the background file, 9) if ignore bad pixels, then 10) the response matrix, 
### 11) For MOS spectra (see below) you'll need to provide the lower model bin boundary 
### e.g. "3e-5 5e-3", then 12) a possible shift in the response if trafo recommends it (e.g. =1), 
### 13) if available (=yes) then 14) provide also the ancilliary file for the effective area (ARF).
### then 15) enter any shift in bins (0 recommended) and finally
### 16) the names of the output spectrum (source & background) and response in SPEX format.

echo "Converting ungrouped EPIC-PN spectrum to SPEX format:"

trafo<<EOF
1
1
10000
3
16 
PN_source_unbinned_spectrum.fits 
y
PN_background_spectrum.fits
y
PN_response_matrix.rmf
1
y
PN_effective_area.arf
0
PN_spectrum_unbinned 
PN_response_unbinned
EOF

echo "Converting pre-grouped EPIC-PN spectrum to SPEX format:"

# You can always rebin/group the spectra once loaded into SPEX. However, if the spectrum was grouped 
# or binned according outside SPEX by e.g. HEAsoft FTOOLS, then the grouped spectrum FITS file already
# has the information for the background spectrum, the response, the effective area and the binning.
# In this case the trafo script is much shorter as we only need to provide the name of the grouped spectrum
# and whether or not we want to keep the binning choice (=yes/y or =no)

trafo<<EOF
1
1
10000
3
16 
PN_source_spectrum_binned.fits 
y
y
1
0
PN_spectrum_binned 
PN_response_binned
EOF

echo "Converting pre-grouped EPIC-MOS1 spectrum to SPEX format:"

# Also in this case we only need to provide the name of the FITS containing the MOS1 grouped spectrum.
# However, MOS1 has no lower boundary limits, therefore we added them through "3.E-5 5.E-3".
# Note that the conversion of MOS2 spectra to SPEX format is identical to that of MOS1.

trafo<<EOF
1
1
10000
3
16 
MOS1_source_spectrum_binned.fits 
y
y
3.E-5 5.E-3
1
0
MOS1_spectrum_binned 
MOS2_response_binned
EOF
