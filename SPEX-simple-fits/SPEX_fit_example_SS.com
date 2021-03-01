### SPEX executable file: Open, plot and fit spectra with SPEX

### Information:
###
### Each command can be loaded also individually
### or loaded outside as a ".sh" file via "spex<<EOF ... EOF"
###
### To open SPEX type: "spex"

### Step 1: load the data (response.res and spectrum.spo) and remove useless bins

da rgs1_resp rgs1_spec
da rgs2_resp rgs2_spec

ign ins 1:2  0:7  u a
ign ins 1:2 37:40 u a

### Show detail about data e.g. count statistics

data show

### Rebin the spectra by a given factor

bin ins 1:2 7:37 2 u a

### Step 2: plot the data, here we also define the axes range

p de xs
p ty da
p ux a
p uy a
p x li
p y li
#p rx 7 27
#p ry 0 3
p

p cap id text "Nova V 2491 Cygni : RGS 1 & 2 spectra"
plot cap ut disp f
plot cap lt disp f

p set al
p dat lw 3
p mod lw 3
p mod col 2
p mod dis t
p box lw 3
p cap y lw 3
p cap it lw 3
p cap x lw 3
p lin dis t
p lin lt 4
p

### plot in Y-log units ###
#
# p ry 1e-3 3
# p y lo

### Step 3: Save the plot into a postscript file
### open 2nd device: CPS, save postscript, close it
#
# plot de cps spex_plot.ps
# plot
# plot clo 2
#
#### Convert POSTSCRIPT to PDF and open it (via "system execute")
#
# system exe "ps2pdf spex_plot.ps"
# system exe "open spex_plot.pdf"

### Step 4: Plot the residuals
###
### Open a second (sub) window and arrange windows coordinates

p frame new
p frame 2
p type chi
p ux a
p x li
p ry -30 30
p rx 7 37
p view default f
p cap id disp f
p cap ut disp f
p cap lt disp f
p view y 0.1:0.4
p view x 0.07:0.953
p set al
p dat lw 3
p mod lw 3
p mod dis t
p mod col 2
p box lw 3
p cap y lw 3
p cap it lw 3
p cap x lw 3
p lin dis f
p lin lt 4
p frame 1
p view default f
p view y 0.42:0.92
p view x 0.07:0.953
p cap x dis f
p box numlab bottom f
p

### Step 4: FIT DATA CONTINUUM
###
### IMPORTANT 1: SPEX USES S.I. UNITS, NOT CGS !!!!!!!!!!
### IMPORTANT 2: SPEX WORKS WITH LUMINOSITY, NOT FLUXES!!
###              PROVIDE SOURCE DISTANCE IF KNOWN !!!!!!!
###
### NOTE: NH (Galaxy) = 4.2x10^25 m^-2 (10^21 cm^-2)

### Assuming: distance = 10kpc
### Assuming: updating plot at every fit iteration
### Assuming: evaluate fluxes/xlum betweem 0.3-10 keV
### Assuming: spex hot model for ISM, fix a low temperature
### Assuming: spex bb model for nova continuum

dist 10 kpc
fit pri 1
eli 0.3:10

com hot
com bb
com rel 2 1

par 1 1 nh v 4.2E-03
par 1 1 t  v 2.0E-04
par 1 1 t  s f

par 1 2 no v 0.01
par 1 2 t  v 0.1

### Calculate and plot model, and show free parameters and xlum/fluxes

c
p
par sh fr

### To save model type "par wri model_spex_RGS_HBmodel_spex_RGS_HB"
### To upda model type "par wri model_spex_RGS_HBmodel_spex_RGS_HB over"
### To load model type "log exe model_spex_RGS_HBmodel_spex_RGS_HB"

### fit the spectrum (at the end all parameters are shown)

f
f
f

### Show only free parameters and xlum/fluxes

par sh fr

### Free ISM oxygen abundance:
###
### par 1 1 08 s t

### Step 5: FIT DATA CONTINUUM + ABSORPTION LINES
###
### Adding an absoring xabs (pre-calculated photoionised absorber)
### Default SPEX ionisation balance is calculated for AGN NGC 5548
### Same commands are used for "pion" on-the-go ionbal calculation
### Log_xi and more par will differ for other SED (other continuum)
### Main difference: pion can also be used in emission (but slow)

com xabs
com rel 2 3,1

### Start values: NH = 1e25 m-2, log_xi=3, v_width=1000, zv=-1000

par 1 3 nh v  1e-2
par 1 3 xi v  3
par 1 3 v  v  1000
par 1 3 zv v -1000

par 1 3 nh s t
par 1 3 xi s t
par 1 3 v  s t
par 1 3 zv s t

c
p
par sh fr

### fit the spectrum (at the end all parameters are shown)

f
f
f

### Show only free parameters and xlum/fluxes

par sh fr

### Free oxygen and nitrogen abundances (but limiting their range!)

par 1 3 07:08 s t
par 1 3 07:08 r 0.01 100

c
p
par sh fr

f
f
f
par sh fr

### To save model type "par wri model_spex_RGS_HBmodel_spex_RGS_HBX"
### To upda model type "par wri model_spex_RGS_HBmodel_spex_RGS_HBX over"
### To load model type "log exe model_spex_RGS_HBmodel_spex_RGS_HBX"

### Step 6: FIT DATA CONTINUUM + ABSORPTION LINES + EMISSION LINES
###
### Adding a collisionally ionised emission component (CIE)
### Same commands are used for "pion" on-the-go ionbal calculation
### Log_xi and more par will differ for other SED (other continuum)

com cie
com rel 4 1

par 1 4 no v 0.1
par 1 4 t  v 1

c
p
par sh fr

f
f
f

### Couple XABS and CIE abudances and line-widths
### If you want to z-shift the CIE you need to use redshift RED component

par 1 4 v  cou 1 3 v
par 1 4 07 cou 1 3 07
par 1 4 08 cou 1 3 08

c
par sh fr

f
f
f

### To save model type "par wri model_spex_RGS_HBmodel_spex_RGS_HBXC"
### To upda model type "par wri model_spex_RGS_HBmodel_spex_RGS_HBXC over"
### To load model type "log exe model_spex_RGS_HBmodel_spex_RGS_HBXC"

### Release RGS 1 and 2 effective area by freeing RGS 2 norm-constant

par -2 1 no s t
c
par sh fr

### Step XX: Save the plot into a postscript file
### open 2nd device: CPS, save postscript, close it

plot de cps spex_fits.ps
plot
plot clo 2

### Convert POSTSCRIPT to PDF and open it (via "system execute")

system exe "ps2pdf spex_fits.ps"
system exe "open spex_fits.pdf"

### To close SPEX type: "quit"
