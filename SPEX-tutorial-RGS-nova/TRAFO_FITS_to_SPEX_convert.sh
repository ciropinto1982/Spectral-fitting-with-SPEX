### TRAFO: convert OGIP-FITS spectra and response to SPEX SPO/RES format

### More examples of how to convert OGIP FITS spectra to SPEX format can also be found here:
### https://github.com/ciropinto1982/Spectral-fitting-with-SPEX/tree/master/Convert-spectra-to-SPEX-format

### Here we convert RGS 1 and 2 individual spectra provided by the XMM-Newton/SAS

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

### Information on the RESPONSE MATRIX:
###
### Here we use the PPS premade by the XMM-XSA: the response file is P*OBSID*WREMAT1000.FIT
### If you run your own reduction routine then: the response file is P*OBSID*RSPMAT1001.FIT
###
### SPEX does not modify pre-existing SPO/RES files.
### If needed, use different output names or delete the pre-existing SPO/RES before running TRAFO.

echo "Converting ungrouped RGS spectra to SPEX format: first order RGS spectra"

trafo << EOF
1
1
10000
3
16
0552270501R1S004SRSPEC1001.FIT
y
0552270501R1S004BGSPEC1001.FIT
y
0552270501R1S004WREMAT1000.FIT
no
0
rgs1_spec
rgs1_resp
EOF

trafo << EOF
1
1
10000
3
16
0552270501R2S005SRSPEC1001.FIT
y
0552270501R2S005BGSPEC1001.FIT
y
0552270501R2S005WREMAT1000.FIT
no
0
rgs2_spec
rgs2_resp
EOF

echo "SPEX formatted spectra: `find .name "*spo"`"
echo "SPEX formatted respmat: `find .name "*res"`"

