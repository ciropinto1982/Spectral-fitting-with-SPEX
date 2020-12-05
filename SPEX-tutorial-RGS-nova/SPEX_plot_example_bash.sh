### BASH: Open the spectra to plot them in SPEX

### Information:
###
### Each command can be loaded also individually
### or loaded outside as a ".com" file via "log exe"

spex<<EOF

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
p mod lw 5
p mod dis f
p box lw 3
p cap y lw 3
p cap it lw 3
p cap x lw 3
p lin dis t
p lin lt 4
p

### Step 3: Save the plot into a postscript file
### open 2nd device: CPS, save postscript, close it

plot de cps spex_plot.ps
plot
plot clo 2

quit
EOF

### Convert POSTSCRIPT to PDF and open it

ps2pdf spex_plot.ps
open spex_plot.pdf
