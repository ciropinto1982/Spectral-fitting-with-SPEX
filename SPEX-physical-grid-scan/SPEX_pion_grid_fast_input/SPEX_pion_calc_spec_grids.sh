#!/bin/ksh

######################################################################################################
###
### SPEX calculation of emission line models of photoionised gas over a predefined parameters space
###
### Do not forget to open a screen session if you want it to run in background.
###
### Avoid to launch in background in order to check the correct production of the emission spectra
###
######## 0) REQUIREMENTS - THINGS THAT NEED TO BE KNOWN BEFORE RUNNING THIS ROUTINE ##################
###
### 1) A SPEX executable file that loads the provided broadband spectral energy distribution (SED)
###    Then adds the multiplicative photoionisation model pion in the emission mode (solid angle=1)
###
### 2) Ionisation balance calculation: pion requires an SED to be provided. For a simple use of pion
###    and how it deals with SED and calculation of the ionisation balance, please, go to the link:
###    https://github.com/ciropinto1982/Spectral-fitting-with-SPEX/tree/master/SPEX-ionisation-balance
###
### 3) Certain ranges NH are adopted for ranges of log xi. These are ad-hoc pre-tested initial values
###    of pion' column density NH for which the fit is already sensitive with DC or DX2 between 10-50.
###    You can increase the range of NH for which pion can be calculated at each log xi, however this
###    will be redundant and just time consuming because you will hardly see lines of optically thick
###    pion with nh > 1e24 cm^-2 or detect significantly lines with nh < 1e19 cm^-2 (see below).
###    Normally, the higher the log xi the higher the NH needs to be in order to produce strong lines.
###
### 4) The routine adopts a grid of log xi, velocity shift = 0, turbulence (width), and NH (cm^-2)
###    Here Solar abundances are adopted, but additional subgrid could be implemented for non-Solar Z.
###    NOTE there is a simpler version of this code that creates pion emission spectral models only
###    for NH = 1e22 cm^-2 (SPEX_pion_calc_spec_n1e22.sh). This is because at low electron densities
###    the NH of pion will be proportional to the spectral model overall normalisation and one could
###    calculate 1 NH for every log xi and then, once loaded in SPEX, fit the overall normalisation.
###    This is very useful if one is primarily interested in the contours of log xi and velocity.
###    The line is adopted to be narrow (100 km/s) as it can always be broadened in SPEX in the fit!
###
### 5) Steps: A) create the grid routine with SPEX commands for the chosed parameter space,
###           B) call SPEX, load SED (or continuum) model and add the pion on top of it (in emission).
###           C) then launch the grid routine within SPEX and save the model for each individual point
###           D) Finally read the output model for each point in the param space and converts it into
###              a SPEX file-model input format using IDL, but can edit it using python or other tools
###
### 6) OUTPUT: grid of pion emiss. models that can be loaded into SPEX file-model & normalisation free
###            A powerful example of how to use these grids is shown in ..........................
###
### IMPORTANT: this codes also uses PYTHON and IDL. Needs some editing to avoid using one or the other
###
### WARNING: The SED for PION must have NO MORE THAN 1024 POINTS (for Mac SPEX and some Linux release. 
###          otherwise you might incur in segment fault (forrtl: severe (174): SIGSEGV), PION crashes.
###
###    License: This public code was developed for and published in the paper Pinto et al. (2020a),
###        DOI: 10.1093/mnras/staa118, arXiv: 1911.09568, bibcode: 2020MNRAS.492.4646P.
###        You're recommended and kindly requested to refer to that paper when using this code.
###
######################### 1) PARALLELISATION and PARAMETER SPACE #####################################

echo "This routine requires some care when defining the directory structure (check create/rm DIR)"

number_of_cores=4 # This chooses the number of cores/CPU/threads used. 4 is optimal for PION emission

export OMP_NUM_THREADS=${number_of_cores}

echo "SPEX: choosing number of cores / threads = ${OMP_NUM_THREADS}"

######################## Preparing the environment (directories and folders) ########################

DIR=$PWD

mkdir file_spex_out # This is the directory where the "raw" pion models will be calculated and stored
mkdir file_spex_cor # This is the directory where the pion models in SPEX-input format will be stored

mkdir log_nh_grids_per_log_xi # directory where the NH ranges for each log xi will be saved

######################## Defyining the sensitive NH ranges for each log_xi range  ###################

xi_range_max=(2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0)                 # definition of the log xi ranges
xi_range_min=(0.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5)

nh_range_max=(22.01 22.51 23.01 23.51 24.01 24.51 25.01 25.51) # and the corresponding nh ranges
nh_range_min=(19.0  19.5  20.0  20.5  21.0  21.5  22.0  22.5)

line_width=100          # normally 100 , 1000 , 10000 , etc    # adopting narrow lines (see above)

xi_min=0.0              # normally 3.0, do not change this (unless required) ionisation param
xi_max=6.01             # normally 5.01 do not change this (unless required) Python needs +.01

hd_min=-14              # normally 1E-7, do not change this (unless required) H volume density
hd_max=-2               # normally 1E-3, do not change this (unless required)
hd_val=-14              # because it's faster, here we adopt a constant low H volume/electron density

xi_step=0.1             # This is only used to constrain the NH range
nh_step=0.1             # normally 0.1, do not change this (unless required)
hd_step=1               # normally 1.0, do not change this (unless required)

type=pion               # type of plasma and file/directory reference

for xi in $(seq ${xi_min} ${xi_step} ${xi_max}) # 2) LOOP OVER LOG_XI
do

if [ ${xi} -ge ${xi_range_min[0]} ] && [ ${xi} -lt ${xi_range_max[0]} ]
then
nh_min=${nh_range_min[0]}
nh_max=${nh_range_max[0]}

elif [ ${xi} -ge ${xi_range_min[1]} ] && [ ${xi} -lt ${xi_range_max[1]} ]
then
nh_min=${nh_range_min[1]}
nh_max=${nh_range_max[1]}

elif [ ${xi} -ge ${xi_range_min[2]} ] && [ ${xi} -lt ${xi_range_max[2]} ]
then
nh_min=${nh_range_min[2]}
nh_max=${nh_range_max[2]}

elif [ ${xi} -ge ${xi_range_min[3]} ] && [ ${xi} -lt ${xi_range_max[3]} ]
then
nh_min=${nh_range_min[3]}
nh_max=${nh_range_max[3]}

elif [ ${xi} -ge ${xi_range_min[4]} ] && [ ${xi} -lt ${xi_range_max[4]} ]
then
nh_min=${nh_range_min[4]}
nh_max=${nh_range_max[4]}

elif [ ${xi} -ge ${xi_range_min[5]} ] && [ ${xi} -lt ${xi_range_max[5]} ]
then
nh_min=${nh_range_min[5]}
nh_max=${nh_range_max[5]}

elif [ ${xi} -ge ${xi_range_min[6]} ] && [ ${xi} -lt ${xi_range_max[6]} ]
then
nh_min=${nh_range_min[6]}
nh_max=${nh_range_max[6]}

else
nh_min=${nh_range_min[7]}
nh_max=${nh_range_max[7]}
fi

Log_nh=($(seq ${nh_min} 0.1 ${nh_max}))      # Array of values between ${nh_min} and ${nh_max}

echo "Available NH grid points = ${#Log_nh[@]}"

#echo "SPEX calc ${type} for Log_xi = ${xi} : NH_min = ${nh_min} ... NH_max = ${nh_max}"

############ Python calculates useful NH in Log scale (to be run only the first time) ################

FILE1_log_nh=log_nh_grids_per_log_xi/log_nh_grid_log_xi_${xi}.txt
FILE2_val_nh=log_nh_grids_per_log_xi/val_nh_grid_log_xi_${xi}.txt

python - <<EOF

import numpy as np

hd_index=${hd_val} # import the chosen hydrogen volume / electron density (in SPEX units of 1e14 cm-3)

hd=10.**hd_index   # H_density chosen to SPEX default (1 cm-3) as faster and not huge changes seen.

Log_NH=np.arange(${nh_min},${nh_max},${nh_step}) # define the correct log nh ranges

np.savetxt('${FILE1_log_nh}',Log_NH,delimiter=' ',fmt='%1.1f')

NH=10**(Log_NH-24)

np.savetxt('${FILE2_val_nh}',NH,delimiter=' ',fmt='%1.5f') # compute the NH value for SPEX pion input

EOF

echo "Python created the following grid files:"

ls -l ${FILE1_log_nh} ${FILE2_val_nh}

done

############ SAVING once the Log_xi grid (each time the xi_grid limits are changed) ##################

var_xi=$(seq ${xi_min} ${xi_step} ${xi_max})

FILE3_log_xi=log_nh_grids_per_log_xi/log_xi_grids.txt

printf "%s\n" "${var_xi[@]}" > ${FILE3_log_xi} # write all array into file (vertic)

#echo "Also, created the following Log_xi grid file:" `ls -l ${FILE3_log_xi}`

################################ ROUTINE EXECUTION ###################################################
#
############################ 1. ROUTINE PRODUCTION : Write outine to be loaded into SPEX #############

echo "First Loop on Line Widths of ${type}:"

for width in ${line_width} # 100 500 1000 2500 5000 # Loop 1 throughout line widht (SPEX km/s)
do

routine_file_in_spex=pion_calc_routine_v${width}

routine_file=${routine_file_in_spex}.com

# IMPORTANT: Creating pion spectral emission models
#
# Here we assume that we have already added a pion component to the SED (see 2. ROUTINE EXECUTION)
# with the components number 1.SED (file-model containing the SED) and 2.pion (PIE-emission lines)
# and we have relate them: "com rel 1 2" i.e. the SED is irradiating (or multiplied by) the PION.

pion_comp_n=2

echo "# SPEX : calculate pion emission for Log_xi, nh, hden, v_sigma, ... "  > ${routine_file}
echo " "                                                                    >> ${routine_file}
echo "# Launch this in SPEX after loading data/model or define the model  " >> ${routine_file}
echo " "                                                                    >> ${routine_file}
echo "# Loop number 1 on width ${width} kms "                               >> ${routine_file}
echo " "                                                                    >> ${routine_file}
echo " par 1 ${pion_comp_n} fc v 0 "                                        >> ${routine_file}
echo " par 1 ${pion_comp_n} om v 1 "                                        >> ${routine_file}
echo " par 1 ${pion_comp_n} zv v 0 "                                        >> ${routine_file}
echo " "                                                                    >> ${routine_file}
echo " plot frame 1 "                                                       >> ${routine_file}
echo " "                                                                    >> ${routine_file}

for hd in 1e${hd_val} #`cat ${DIR}/hd_spex_grid.txt` # Loop 2 Volume Density (SPEX x 1e14 cm-3)
 do

echo "# Loop number 2 on H-density m**-3 "                                  >> ${routine_file}
echo " "                                                                    >> ${routine_file}

FILE_log_xi_grids=${DIR}/log_nh_grids_per_log_xi/log_xi_grids.txt

  for xi in `cat ${FILE_log_xi_grids}`            # 0.1 to 5.0 with 0.1 step (SPEX : erg/s cm)
   do

echo "# Loop number 3 on xi ${xi} erg/s cm "                                >> ${routine_file}
echo " "                                                                    >> ${routine_file}

### Different calling for NH to load value but save output as log-of-the-value
### Storing NH values and log-of-the-values into 2 arrays

index_NH=0

for temp_value in `cat ${DIR}/log_nh_grids_per_log_xi/val_nh_grid_log_xi_${xi}.txt`
 do
 nh_Val[${index_NH}]=${temp_value}
#  echo Loading NH value: ${nh_Val[${index_NH}]} # loading NH in SPEX units for the pion input
 index_NH=$(($index_NH+1))
done

index_NH=0

for temp_value in `cat ${DIR}/log_nh_grids_per_log_xi/log_nh_grid_log_xi_${xi}.txt`
 do
 nh_Log[${index_NH}]=${temp_value}
#  echo Loading NH LogVal ${nh_Log[${index_NH}]} # loading NH in log nh units for the filename
 index_NH=$(($index_NH+1))
done

index_NH=0

# number_NH=`wc -l < ${DIR}/nh_spex_grid.txt` # To retrieve number of NH values for loop

  number_NH="${#Log_nh[@]}"                   # number of available NH points (same as above)

  number_NH=$(echo "${number_NH}-1" | bc -l)  # Subtract 1 as array starts from element 0

   for index_NH in $(seq 0 1 ${number_NH})    # NH in SPEX units of x 1e24 cm-2 (i.e. 1e28 m-2)
    do

 nh=${nh_Val[${index_NH}]}

echo "# Loop number 4 on nh ${nh} (x 10^24 cm-2) "                      >> ${routine_file}
echo "                                           "                      >> ${routine_file}

SPEX_output=${DIR}/file_spex_out/PION_v${width}_hd${hd}_xi${xi}_nh${nh_Log[${index_NH}]}

echo "SPEX pion: width = $width , hd = $hd , xi = $xi , nh = $nh (${nh_Log[${index_NH}]} cm-2)"

echo " p cap ut text \" Photo-Ionisation Emission PION calculation \" " >> ${routine_file}
echo " p cap lt text \" hd${hd} xi${xi} nh${nh_Log[${index_NH}]} \"   " >> ${routine_file}
echo " p cap ut disp t "                                                >> ${routine_file}
echo " p cap lt disp t "                                                >> ${routine_file}
echo " "                                                                >> ${routine_file}
echo " par 1 ${pion_comp_n} nh v ${nh}     "                            >> ${routine_file}
echo " par 1 ${pion_comp_n} xi v ${xi}     "                            >> ${routine_file}
echo " par 1 ${pion_comp_n} v  v ${width}  "                            >> ${routine_file}
echo " par 1 ${pion_comp_n} hd v ${hd}     "                            >> ${routine_file}
echo " "                                                                >> ${routine_file}
echo " par sh f "                                                       >> ${routine_file}
echo " c        "                                                       >> ${routine_file}
echo " p x lo   "                                                       >> ${routine_file}
echo " p y lo   "                                                       >> ${routine_file}
echo " p        "                                                       >> ${routine_file}
echo " "                                                                >> ${routine_file}
echo " p x li  "                                                        >> ${routine_file}
echo " p y li  "                                                        >> ${routine_file}
echo " p adum ${SPEX_output} over "                                     >> ${routine_file}
echo " "                                                                >> ${routine_file}

        done

      done

    done

  done

echo "Created SPEX routine: `ls ${routine_file}`" ; du -sh ${routine_file}

########### 2. ROUTINE EXECUTION : Routine loaded into SPEX after PION model creation ###########

SED_modfile=${DIR}/name_of_the_SED_in_SPEX_file_model_units # IMPORTANT: provide here the SED file

spex<<EOF

### NO DATA NEEDS TO BE LOADED (but if you do it then SPEX will calculate the output energy grid)
###
### IMPORTANT: a grid of wavelengths is predefined "mygrid_0140a002a.egr"
### if you want to produce it yourself type: "egrid lin 1:40 step 0.02 a"
### which is a wavelength grid between 1:40 Angstrom with a 0.02 Angstrom step (OK for gratings)

egrid read ${DIR}/mygrid_0140a002a

############################### CONTINUUM (SED) MODEL ###########################################
###
###
### IMPORTANT: provide the normalisation of the SED file model if required to be different than 1
###            and do not forget to define the distance to your source of the fluxes will be wrong
###            Here we had to use a normalisation due to the SED units and a ULX distance of 3.3 Mpc

com file

par 1 1 no   v 5.8808218E-04
par 1 1 no   s f
par 1 1 file av ${SED_modfile}

fit pr 1
eli 0.3:10
dis 3.3 Mpc

### Adding unabsorbed PION multiplied by the modfile (PIE calc) ###
#
# SOLID ANGLE om = 1 (4pi)
# COVER FRACT fc = 0 ----> no absorption, just pure emission

com pion
com rel 1 2

par 1 2 om v 1
par 1 2 fc v 0

par 1 2 nh v 1e-5
par 1 2 xi v 0
par 1 2 hd v 1e-14
par 1 2 v  v 500
par 1 2 zv v 0

######### Adding Exponential Cutoff onto SED continuum ############
###
### This component is important as we want to save in output the emission of the pion alone and
### the etau exponential cutoff makes sure that the SED is completely killed in the X-ray band.

com etau
com rel 1 2,3

par 1 3 tau0 v 1000
par 1 3 tau0 s f
par 1 3 a    v 0
par 1 3 a    s f

c
par sh f

###################### Plot the calculations ######################
#
# Use "p de null" if you do not want to open plotting windows or run in background / screen mode

p de xs
p ty mo
p vi def f
p fi dis f
p cap id text "SPEX PION calculation / simulation"
p cap ut disp f
p cap lt disp f
p ux ke
p uy ke
p x lo
p y lo
p rx 0.3 10
p ry 1e-10 1e3
p

# Remember to plot linearly each spectrum in the routine to save the QDP files in correct units!
#
# Execution of the pion grid routine:

log exe ${routine_file_in_spex}

q

EOF

########### 3. ROUTINE EXE : IDL - CONVERT PION QDP OUTPUT TO SPEX FILE MODEL INPUT (*.DAT) ##########

cd ${DIR}

echo "IDL convert SPEX output model to SPEX Model-File input"

/Applications/harris/idl/bin/idl<<EOF

print, "Note you might need an additional Normalisation factor in SPEX (5.8808218E-04)"

print, "Calling IDL routine: IDL_Conv_SPEX_file_model.pro"

.r ${DIR}/IDL_Conv_SPEX_file_model.pro

EOF

cd ${DIR}/file_spex_out

echo "Moving SPEX file-model input files (*.dat) to directory: ${DIR}/file_spex_cor/"

mv PION_*.qdp.dat ${DIR}/file_spex_cor/

cd ${DIR}


###################################### END OF THE ROUTINE ############################################
