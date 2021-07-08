### Trafo routine to convert spectra to SPEX format for sectors reading
###
### "SECTORS" is the SPEX solution to simultaneously fit several spectra
### assuming spectral models with different (or coupled) parameters
### This is ideal in the case you have different observations.
###
### Here spectra from the same camera (e.g XMM/EPIC PN) but different observations
### are put in different sectors (i.e. one region and model per sector or spectrum)
### Of course it still enables the use the a free overall, relative, instrumental normalisation
### in the fit e.g. by later on typing "par -2 1 norm stat thaw"
###
### Let's assume you have already converted rebinned/grouped the spectra with grppha or specgroup
### but you have NOT yet converted the individual spectra to SPEX format from standard OGIP FITS
### format using the routines XMM-EPIC-examples.sh.
###
### Also, let's assume we want to convert spectra from 5 different observations
### Trafo will ask in sequence the following information:
###
### 1) input format e.g OGIP (=1), 2) number of spectra to be converted (=5),
### 3) number of groups of response matrix (10000 are OK for most CCD and grating spectra),
### 4) numer of sectors (=5, one for each observation)
### 5) number of 1st sector (start with 1) and 1st region (or spectrum, starts with 1)
### 6) matrix partitioning (=3 if yes) and 7) corresponding components (=16, power of 2),
### 8) nome of input source FITS spectrum file OGIP, because we have provided an already
### grouped spectrum trafo will recognise the response, background and ARF files.
### 9) For MOS spectra you'll need to provide a lower model bin boundary
### e.g. "3e-5 5e-3", which doesnt apply to PN and most spectra.
### 10) and whether or not we want to keep the binning choice (=yes/y or =no/n)
### 11) a possible shift in the response if trafo recommends it (e.g. =1),
### 12) enter any shift in bins (0 recommended) and finally
### 13) Then in loop sector 2 reg 2 (i.e observation 2), sector 3 reg 3 (observation 3), etc.
### 14) the names of the output spectrum (source & background) and response in SPEX format.
###
### The output file will contain all the spectral from each observations
### Once loaded in SPEX via e.g. "data SEC5_REG5_PN_grp25 SEC5_REG5_PN_grp25"
### you will need to define the number of sectors before creating any model by typing
### the command "sector new" for each new sector, in this case 4 times (as there are 5 in total).

file_spectrum1=${DIR_OBS1}/PN_src_spec_grp25
file_spectrum2=${DIR_OBS2}/PN_src_spec_grp25
file_spectrum3=${DIR_OBS3}/PN_src_spec_grp25
file_spectrum4=${DIR_OBS4}/PN_src_spec_grp25
file_spectrum5=${DIR_OBS5}/PN_src_spec_grp25

trafo<<EOF
1
5
10000
5
1 1
3
16
${file_spectrum1}.fits
y
y
1
0
2 2
3
16
${file_spectrum2}.fits
y
y
1
0
3 3
3
16
${file_spectrum3}.fits
y
y
1
0
4 4
3
16
${file_spectrum4}.fits
y
y
1
0
5 5
3
16
${file_spectrum5}.fits
y
y
1
0
SEC5_REG5_PN_grp25
SEC5_REG5_PN_grp25
EOF
