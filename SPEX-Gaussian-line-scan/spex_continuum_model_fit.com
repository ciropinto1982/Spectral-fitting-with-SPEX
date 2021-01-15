# INFO: SPEX routine to fit the continuum
#
# MODEL: BB+powerlaw + 2 delta line broadened with Laor profile

# 1) LOAD DATA

da rgs_stacked rgs_stacked
da epn_stacked epn_stacked

ign  0:0.40 u ke
ign 10:1000 u ke

ign ins 1 2.0:10 u ke
ign ins 2 0:1.77 u ke

# 2) Optimal binning in SPEX:

obin ins 1 0.3:10 u ke
obin ins 2 0.3:10 u ke

# 3) PLOT DATA

p de xs
p ty da
p ux ke
p rx 0.4 10
p x lo
p uy fa
p ry 1e-2 1
p y lo
p se 1
p da col 14
p li col 14
p se 2
p da col 1
p li col 1
p se al
p line dis t
p back dis f
p back lt  4
p view default f
p cap id disp f
p cap ut disp f
p cap lt disp f
p box lw 3
p cap y lw 3
p cap it lw 3
p cap x lw 3
p da lw 3
p mo lw 3
p cap id disp t
p cap id text "IRAS 13224 pn-RGS low-flux (1-of-10) spectra"
p

### Shift by a fac 1.3 (display purpose) the pn spec to match RGS

shiftplot instrument 2 region 1 2 1.3

###### TO MAKE A POSTSCRIPT:
###
### p de cps IRAS_EPIC_RGS_1_OF_10_SPEC.ps
### p
### p clo 2

# 4) Create and calculate model: hot(red(po+bb)

dist 0.06580 z

com red
com hot
com po
com bb
com re 3:4 1,2

par 1 1 z  v 0.06580

par 1 2 nh r 5.e-4 7.e-4
par 1 2 nh v 6.75e-4
par 1 2 nh s f
par 1 2 t  r 2.e-4 1e-3
par 1 2 t  v 2e-4
par 1 2 t  s f
par 1 2 v  v 10

par 1 3 no v 1.1e8
par 1 3 ga r 1 5
par 1 3 ga v 2.768

par 1 4 no v 1e-8
par 1 4 t v 0.5
par 1 4 t r 0.01 5

elim 0.3:10

fit print 1

### Load besfit model if already available/provided

l e ./spex_model_RHPB
c
p

#### Re-fit the model
# f
# f
# f
# f
# par sh fr
# par wri ./spex_model_RHPB over
# par sh fr

### Adding two delta lines blurred with Laor model
###
### Energies need to be fixed at least the one at 7 keV
### otherwise they are degenerate with the inclination.

com delt
com delt
com laor

com rel 5:6 7,1,2

par 1 5 e v 0.8
par 1 6 e v 7.0

par 1 5 e v 1
par 1 5 e s f
par 1 6 e v 7
par 1 6 e s f

par 1 5 no v 4527886
par 1 6 no v 966831.

par 1 7 r1 s t
par 1 7 r2 s f
par 1 7 q  s t
par 1 7 h  s t
par 1 7 i  s t

### Free the pn/RGS relative (area) normalisation

par -2 1 no s t
par -2 1 no v 0.8

### Load besfit model if already available/provided

l e ./spex_model_RHPBD2L
c
p

#### Re-fit the model
# f
# f
# f
# par sh fr
# c
# p
# par wri ./spex_model_RHPBD2L over

###### TO MAKE A POSTSCRIPT:
###
### p de cps IRAS_EPIC_RGS_1_OF_10_FIT.ps
### p
### p clo 2
###
### sys exe "ps2pdf IRAS_EPIC_RGS_1_OF_10_FIT.ps"
### sys exe "open IRAS_EPIC_RGS_1_OF_10_FIT.pdf"
