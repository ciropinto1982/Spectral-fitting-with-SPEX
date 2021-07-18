#!/bin/ksh

########################################## ROUTINE DESCRIPTION #######################################################
####                                                                                                              ####
#### This BASH task runs SPEX in loop over XMM/EPIC PN and MOS spectra from different observations as it follows: ####
####                                                                                                              ####
#### 1) Creates an ASCII file where the results will be collected from the files of each obsid fit into one table ####
####                                                                                                              ####
#### 2) Read the available exposures or obsid names                                                               ####
####                                                                                                              ####
#### 3) For each it creates a grid of AMOL compound combinations that can change and are stored in a SPEX routine ####
####                                                                                                              ####
#### 4) For each it opens SPEX, load data and create a continuum (redshidted and absorption corrected) model      ####
####            (here the continuum adopted is a soft blackbody and a hard comtpon-modified blacbbody disk)       ####
####            (this continuum is ideal for ULXs but can be easily modified by adding other components)          ####
####             then it fits the EPIC PN and MOS spectra (with the latter with a free overall normalisation)     ####
####             it saved the bestfit model of each combination and the corresponding free parameters             ####
####             uncertainties are calculated for all parameters along with Bolometric and X-ray luminosities     ####
####             plots are also created (in POSTSCRIPT) and converted to PDF format                               ####
####                                                                                                              ####
#### 5) For each obsid it reads the result (parameter & errors) and stored them in the final file as table rows   ####
####                                                                                                              ####
####    License: This public code was developed for and published in the paper Pinto et al. (2017),               ####
####    DOI: 10.1093/mnras/stx641, arXiv: 1612.05569, bibcode: 2017MNRAS.468.2865P.                               ####
####    You're recommended and kindly requested to refer to that paper when using this code,                      ####
####    especially since you might want to compare your results onto NGC 55 ULX-1 (XMM obsid: 0655050101)         ####
####                                                                                                              ####
######################################################################################################################

########################################### DEFINE DIRECTORIES AND FINAL NAMES #######################################

DIR_home=$PWD

index=1

FILE_results=${DIR_home}/Table_results_bbmbb_nhfixed.txt
 
echo "Observation Chi2  DOF  Norm_BB     Norm_e1_BB  Norm_e2_BB Temp_BB Temp_e1_BB Temp_e2_BB Norm_MBB Norm_e1_MBB Norm_e2_MBB Temp_MBB Temp_e1_MBB Temp_e2_MBB Lum_Xray_BB Lum_Xray_MBB Lum_Bol_BB Lum_Bol_MBB" > ${FILE_results}
echo " "        >> ${FILE_results}

for i in obsid1 obsid2 obsid3 obsid4 obsid5 obsid6 obsid7 obsid8 obsid9
 do

 if [ $i == 000 ]  ### Alternative commands wihin []: [ $index -gt 1 ] or [ $1 != obsid1 ]
 then
  echo "I am temporarily skipping Source/Expo "$i""
 else
 
 cd ${DIR_home}/${i}
  
   echo "Working on obs_id : ${i}"

### LAUNCH SPEX

spex<<EOF

### LOAD DATA

data   PN_ULX1_spec_grp25   PN_ULX1_spec_grp25
data MOS1_ULX1_spec_grp25 MOS1_ULX1_spec_grp25
data MOS2_ULX1_spec_grp25 MOS2_ULX1_spec_grp25
data show

### IGNORE USELESS ENERGY BINS

ign 0:0.3 u ke
ign 7:100 u ke

### PLOT DATA

p de xs
p ty da
p ux ke
p uy ke
p se al
p ba dis t
p ba col 4
p mo col 2
p da col 1
p cap id text "XMM-Newton/EPIC pn & MOS 1,2 (obsid:$i)"
p cap ut disp f
p cap lt disp f
p da lw 3
p mo lw 3
p box lw 3
p cap y lw 3
p cap it lw 3
p cap lt lw 3
p cap ut lw 3
p cap x lw 3

p frame new
p frame 2
p type chi
p ry -6 +6
p rx 0.3 10
p view default f
p cap id disp f
p cap ut disp f
p cap lt disp f
p view y 0.1:0.38
p view x 0.07:0.953
p da lw 3
p mo lw 3
p box lw 3
p cap y lw 3
p cap it lw 3
p cap x lw 3
p x lo
p ux ke

### PLOT 2ND FRAME FOR RESIDUALS

p frame 1
p view default f
p view y 0.42:0.9
p view x 0.07:0.953
p cap x dis f
p box numlab bottom f
p ux ke
p uy fke
p x lo
p y lo
p ry 1e-3 30
p rx 0.3 10
p ux ke

p se 2
p da col 2
p mo col 2
p se 3
p da col 3
p mo col 3
p se al
p mo lt 1
p

### ADOPT DISTANCE AND DEFINE MODEL AND PARAMETERS

dist 1.94 Mpc

com red
com hot
com bb
com mbb
com rel 3:4 1,2

mod show
par show

par 1 1 z v 0.00043
par 1 1 z s frozen

par 1 2 nh r 7.33e-4 1e-2
par 1 2 nh v 2.5e-3
par 1 2 t  r 1e-5 1e-2
par 1 2 t  v 1e-4
par 1 2 t  s f
par 1 2 nh s f

par 1 3 n v 1.1e-2
par 1 3 t r 0.1 5
par 1 3 t v 0.18
par 1 3 n:t s t

par 1 4 n v 2.5
par 1 4 t r 0.1 10
par 1 4 t v 0.8
par 1 4 n:t s t

### CHOSE WHERE TO CALCULATE FLUXES AND ENERGY, CALCULATE AND FIT

elim 0.3:10 ke
calc
plot
par sh fr

### OVERALL NORMALISATION FREE FOR INSTRUMENTS 2 AND 3 (MOS 1,2)

par -2 1 no s t
par -3 1 no s t

l e model_RHBM

fit print 1
fit stat chi2
cal
plo

### SAVE BESTFIT MODEL PARAMETERS

par wri model_RHBM

fit
fit
fit
par sh fr

### UPDATE BESTFIT MODEL PARAMETERS

par wri model_RHBM over

### SAVE PLOT AS POSTSCRIPT AND CONVERT TO PDF

p de cps model_RHBM.ps
p
p clo 2

sys exe "ps2pdf model_RHBM.ps"

# sys exe "open model_RHBM.pdf"

### CALCULATE UNCERTAINTIES AND STORE THEM INTO A FILE

log out spex_fit_results over
err 1 3 no
err 1 3 t
err 1 4 no
err 1 4 t
par sh fr
log close out

### CALCULATE X-RAY LUMINOSITIES AND STORE THEM INTO A FILE

elim 0.3:10
cal

log out spex_calc_lum_xray over
par sh fr
log close out

### CALCULATE BOLOMETRIC LUMINOSITIES AND STORE THEM INTO A FILE

elim 1e-3:1e3
cal

log out spex_calc_lum_bol over
par sh fr
log close out

q

EOF

### READ RESULT FILES OF THE INDIVIDUAL FIT

input_file1=spex_fit_results.out
input_file2=spex_calc_lum_xray.out
input_file3=spex_calc_lum_bol.out

N1=`sed '/Parameter   1    3 norm:/!d' ${input_file1}`
T1=`sed '/Parameter   1    3 t   :/!d' ${input_file1}`
N2=`sed '/Parameter   1    4 norm:/!d' ${input_file1}`
T2=`sed '/Parameter   1    4 t   :/!d' ${input_file1}`
C2=`sed '/Chi-squared value :/!d'      ${input_file1}`
DF=`sed '/Degrees of freedom:/!d'      ${input_file1}`

LX1=`sed '23!d' ${input_file2}`
LX2=`sed '24!d' ${input_file2}`

LB1=`sed '23!d' ${input_file3}`
LB2=`sed '24!d' ${input_file3}`

### SAVE RESULT FILES OF THE INDIVIDUAL FIT INTO THE FINAL TABLE FILE

 echo ${i} ${C2:24:12} ${DF:24:12} ${N1:27:13} ${N1:49:13} ${N1:65:13} ${T1:27:13} ${T1:49:13} ${T1:65:13} ${N2:27:13} ${N2:49:13} ${N2:65:13} ${T2:27:13} ${T2:49:13} ${T2:65:13} ${LX1:57:14} ${LX2:57:14} ${LB1:57:14} ${LB2:57:14} >> ${FILE_results}

 cd ${DIR_home}
 
 fi
 
 index=$(($index+1))
 
done

### OPEN THE FINAL TABLE FILE

#open ${FILE_results}
