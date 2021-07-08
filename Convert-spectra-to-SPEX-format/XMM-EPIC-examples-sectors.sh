### Trafo routine to convert spectra to SPEX format for sectors reading
###
### "SECTORS" is the SPEX solution to simultaneously fit several spectra
### assuming spectral models with different (or coupled) parameters
### This is ideal in the case you have different observations.
###
### Here spectra from different cameras (e.g XMM/EPIC PN and MOS) but the same observatioms
### are put in the same sector (i.e. one model shared among them) but different regions
### which enables the use the a free overall, relative, instrumental normalisation in the fit
### e.g. by later on typing "par -2 1 norm stat thaw"
###
### Let's assume you have already converted to SPEX format invidual spectra from standard OGIP
### FITS format using the routines XMM-EPIC-examples.sh and that MOS 1 and 2 where previously stacked
###
### Also, let's assume we want to convert spectra from three different observations
### Trafo will ask in sequence the following information:
###
### 1) input format e.g SPEX (=3), 2) number of spectra to be converted (=6),
### 3) number of groups of response matrix (10000 are OK for most CCD and grating spectra),
### 4) numer of sectors (=3, one for each observation)
### 5) number of 1st sector (start with 1) and 1st region (or spectrum, starts with 1)
### 6) nome of input source SPEX-formatted SPO spectrum file (e.g. PN) and 7) its RES response file
### 8) Then in loop sector 1 reg 2 (e.g. MOS), sector 2 reg 3 (PN for observation 2), etc.
### 9) the names of the output spectrum (source & background) and response in SPEX format.
###
### The output file will contain all the spectral from each observations
### Once loaded in SPEX via e.g. "data SEC3_REG6_PN_MOS_spec SEC3_REG6_PN_MOS_spec"
### you will need to define the number of sectors before creating any model by typing
### the command "sector new" for each new sector, in this case twice (as there are 3 in total).

P1=OBSERVATION1_PN_spec
P2=OBSERVATION2_PN_spec
P3=OBSERVATION3_PN_spec

M1=OBSERVATION1_MOS_spec
M2=OBSERVATION2_MOS_spec
M3=OBSERVATION3_MOS_spec

trafo<<EOF
3
6
10000
3
1 1
${P1}
${P1}
1 2
${M1}
${M1}
2 3
${P2}
${P2}
2 4
${M2}
${M2}
3 5
${P3}
${P3}
3 6
${M3}
${M3}
SEC3_REG6_PN_MOS_spec
SEC3_REG6_PN_MOS_spec
EOF

