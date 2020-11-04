### Here are a few examples of how to convert spectra from standard OGIP FITS format to SPEX format.

### The first example shows how to convert RGS 1 and 2 individual spectra provided by the XMM-Newton/SAS
### The files can be stored into bash or other shells scripts and run sequentially.
### The last examples shows how to confert a stacked RGS spectrum to SPEX format.

### In particular, I also show how to retreive and use exposure information when converting the spectra.
### In this way one won't need to update each time the name of the source spectrum, BKG and response.

### Trafo will ask in sequence the following information:
### 1) input format e.g OGIP (=1), 2) number of spectra to be converted (=1), 
### 3) number of groups of response matrix (10000 are OK for most CCD and most grating spectra),
### 4) matrix partitioning (=3 if yes) and 5) corresponding components (=16, power of 2), 
### 6) nome of input source FITS spectrum file OGIP, 7) if available (=yes) then 8) provide
### the background file, 9) if ignore bad pixels, then 10) the response matrix
### 11) RGS effective area info is already stored in response and no additional ARF file is required.
### Therefore to "Read nevertheless an effective area file? (y/n) [no]:" we need to answer "no".
### then 12) enter any shift in bins (0 recommended) and, finally,
### 13,14) the names of the output spectrum (source & background) and response in SPEX format.
###
### For each spectrum, TRAFO will create .SPO and .RES files for the spectrum and the response
### with all the required information. They are loaded into SPEX with "data resp_file spec_file"
###
### When providing the file_names for response and spectrum do not add the SPO/RES extensions,
### the same thing applies when loading them into SPEX (data resp_file spec_file)


echo "Extracting information and exposure detail from the RGS 1 ans 2 eventlist files:"

R1_EVE=`find . -name '*R1*EVENLI*'`
R2_EVE=`find . -name '*R2*EVENLI*'`

R1_EVE=${R1_EVE:2}
R2_EVE=${R2_EVE:2}

did=${R1_EVE:0:11}
expno1=${R1_EVE:13:4}
expno2=${R2_EVE:13:4}

srcid=1        # This number becomes=3 if RGS spectra are extracted on coordinates different than pointing

echo "Converting ungrouped RGS spectra to SPEX format: first order RGS spectra"

trafo << EOF
1
1
10000
3
16
`ls ${did}R1${otype}${expno1}SRSPEC100${srcid}.FIT`
y
`ls ${did}R1${otype}${expno1}BGSPEC100${srcid}.FIT`
y
`ls ${did}R1${otype}${expno1}RSPMAT100${srcid}.FIT`
no
0
ULX1_rgs1_expbkg
ULX1_rgs1_expbkg
EOF

trafo << EOF
1
1
10000
3
16
`ls ${did}R2${otype}${expno2}SRSPEC100${srcid}.FIT`
y
`ls ${did}R2${otype}${expno2}BGSPEC100${srcid}.FIT`
y
`ls ${did}R2${otype}${expno2}RSPMAT100${srcid}.FIT`
no
0
ULX1_rgs2_expbkg
ULX1_rgs2_expbkg
EOF

echo "Converting ungrouped RGS spectra to SPEX format: second order RGS spectra"

trafo << EOF
1
1
100000
3
16
`ls ${did}R1${otype}${expno1}SRSPEC200${srcid}.FIT`
y
`ls ${did}R1${otype}${expno1}BGSPEC200${srcid}.FIT`
y
`ls ${did}R1${otype}${expno1}RSPMAT200${srcid}.FIT`
no
0
ULX1_rgs1_expbkg_o2
ULX1_rgs1_expbkg_o2
EOF

trafo << EOF
1
1
100000
3
16
`ls ${did}R2${otype}${expno2}SRSPEC200${srcid}.FIT`
y
`ls ${did}R2${otype}${expno2}BGSPEC200${srcid}.FIT`
y
`ls ${did}R2${otype}${expno2}RSPMAT200${srcid}.FIT`
no
0
ULX1_rgs2_expbkg_o2
ULX1_rgs2_expbkg_o2
EOF

echo "Converting stacked RGS specta to SPEX format:"

### You can always rebin/group the spectra once loaded into SPEX. However, if the spectrum was grouped
### or binned according outside SPEX by e.g. HEAsoft FTOOLS, then the grouped spectrum FITS file already
### has the information for the background spectrum, the response, the effective area and the binning.
### In this case the trafo script is much shorter as we only need to provide the name of the grouped spectrum
### and whether or not we want to keep the binning choice (=yes/y or =no)
###
### The same occurs if we want to convert RGS spectra stacked with e.g. XMM-SAS task rsgcombine, see below.
###
### TRAFO will create rgs_stacked_source_spectrum.SPO and rgs_stacked_source_spectrum.RES files
### for the spectrum and the response, respectively, with all the required information.
### Load them in SPEX with "data rgs_stacked_source_spectrum rgs_stacked_source_spectrum"

trafo << EOF
1
1
10000
3
16
`ls rgs_stacked_source_spectrum.fits`
y
no
0
rgs_stacked_source_spectrum
rgs_stacked_source_spectrum
EOF

