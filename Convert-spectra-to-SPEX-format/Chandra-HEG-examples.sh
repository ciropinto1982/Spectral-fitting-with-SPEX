### Here are a few examples of how to convert spectra from standard OGIP FITS format to SPEX format.

### In loop we convert Chandra HEG and MEG individual spectra provided by the Chandra pipelines
### The files can be stored into bash or other shells scripts and run sequentially.
###
### At the end of the conversion, we will plot the spectra both in XSPEC and SPEX

### Trafo will ask in sequence the following information:
### 1) input format e.g OGIP (=1), 2) number of spectra to be converted (=1, i.e. one-by-one),
### 3) number of groups of response matrix (10000 are OK for most CCD and most grating spectra),
### 4) matrix partitioning (=3 if yes) and 5) corresponding components (=16, any power of 2),
### 6) name of input source FITS spectrum file OGIP, 7) if available (=yes otherwise =no/n) then
### 8) provide the background spectrum file, 9) if ignore bad pixels (=yes/no), 10) the response matrix
### 11) if HEG effective area is not stored in response and there is additional ARF file,
### then to "Read nevertheless an effective area file? (y/n) [no]:" we need to answer "yes/y".
### and 12) provide the effective area ancilliary file (*.arf)
### then 13) enter any shift in bins (0 recommended) and, finally,
### 14,15) the names of the output source spectrum (background subtracted) & response in SPEX format.
###
### For each spectrum, TRAFO will create .SPO and .RES files for the spectrum and the response
### with all the required information. They are loaded into SPEX with "data resp_file spec_file"
###
### When providing the file_names for response and spectrum do not add the SPO/RES extensions,
### the same thing applies when loading them into SPEX (data resp_file spec_file)
###
### TRAFO does not overwrite previously existing SPO/RES files, either change name or delete
### eventual SPO/RES files from previous conversion as done below

rm `find . -name "*.spo"` `find . -name "*.res"`

for i in acis_14654_heg_m1 acis_14654_heg_p1 acis_14654_meg_m1 acis_14654_meg_p1
 do

echo "Converting ${i}.fits (OGIP) to ${i}.spo (SPEX) format"

trafo << EOF
1
1
10000
3
16
${i}.fits
n
y
${i}.rmf
y
${i}.arf
0
${i}
${i}
EOF

done

echo "Plotting spectra in XSPEC"

xspec << EOF
data 1:1 acis_14654_heg_m1.fits
data 2:2 acis_14654_heg_p1.fits
data 3:3 acis_14654_meg_m1.fits
data 4:4 acis_14654_meg_p1.fits
resp 1:1 acis_14654_heg_m1.rmf
resp 2:2 acis_14654_heg_p1.rmf
resp 3:3 acis_14654_meg_m1.rmf
resp 4:4 acis_14654_meg_p1.rmf
arf  1:1 acis_14654_heg_m1.arf
arf  2:2 acis_14654_heg_p1.arf
arf  3:3 acis_14654_meg_m1.arf
arf  4:4 acis_14654_meg_p1.arf
cpd /xs
pl
model 1:source1 po
0

model 2:source2 po
0

model 3:source3 po
0

model 4:source4 po
0

EOF

echo "Plotting spectra in SPEX"

spex << EOF
da acis_14654_heg_m1 acis_14654_heg_m1
da acis_14654_heg_p1 acis_14654_heg_p1
da acis_14654_meg_m1 acis_14654_meg_m1
da acis_14654_meg_p1 acis_14654_meg_p1
ign ins 1:2  0:1   u ke
ign ins 1:2 10:1e2 u ke
ign ins 3:4  0:0.7 u ke
ign ins 3:4  8:1e2 u ke
bin ins 1:4 0.7:10 5 u ke
p de xs
p ty da
p se 1
p da col 1
p li col 1
p se 2
p da col 2
p li col 2
p se 3
p da col 3
p li col 3
p se 4
p da col 4
p li col 4
p ux ke
p uy fke
p x lo
p y lo
p rx 0.5 10
p ry 1 1000
p
p de cps HEG_MEG_o1.ps
p
p clo 2
q
EOF

ps2pdf HEG_MEG_o1.ps
