#!/bin/ksh

######################################################################################################
###
### SPEX scans of photoionisation emission models over a predefined grid in the parameters space
###
### Do not forget to open a screen session if you want it to run in background.
###
### Launching command (in background): ./SPEX_pion_grid_fast_input.sh > /dev/null 2>&1
###
######## 0) REQUIREMENTS - THINGS THAT NEED TO BE KNOWN BEFORE RUNNING THIS ROUTINE ##################
###
### 1) A SPEX executable file that loads spectra, bestfit continuum model. Plots are optional
###    The addition of a pion file-model component is done here and coupled to Galactic ISM absorption
###    For instance, if the components are: hot (ISM), bb, dbb, pmf then should be "com rel 2:4 1"
###    IMPORTANT: data & executed models in the executable must have full-path for SPEX to find them!
###
### 2) Ionisation balance calculation: pion require a pre-calculated photo-ionisation balance
###    SPEX's default is based on Seyfert 1 AGN NGC 5548. You can provide your own ion-bal file
###    by typing "par sec comp file av xabsinput_file". To learn how to produce it from the SED, see:
###    https://github.com/ciropinto1982/Spectral-fitting-with-SPEX/tree/master/SPEX-ionisation-balance
###    Here we will use the pion model file spectra computed by the code SPEX_pion_calc_spec_n1e22.sh
###
### 3) Initial NH values tested for some ranges of log xi. These are ad-hoc pre-tested initial values
###    of xabs' column density NH for which the fit is already sensitive with DC or DX2 between 10-50.
###    This starting assumption will avoid the calculation of the error on NH (e.g. steppar on the NH)
###    which is necessary to locate minima of C-stat (or Chi2) and always happens at initial low NHs,
###    thereby speeding the routine by (at least) a factor 3. If you like you can still run the error
###    calculation by commenting the corresponding lines in the code (see below) to be more accurate.
###
### 4) The routine adopts a grid of log xi, velocity shifts, turbulence (width), and NH (cm^-2)
###    Here Solar abundances are adopted, but additional subgrid could be implemented for non-Solar Z.
###    IMPORTANT: this is a simpler and faster version that uses pion emission spectral models created
###    only for NH = 1e22 cm^-2 (although loops can be added). This is because at low electron density
###    the NH of pion will be proportional to the spectral model overall normalisation and one could
###    calculate 1 NH for every log xi and then, once loaded in SPEX, fit the overall normalisation.
###    This is very useful if one is primarily interested in the contours of log xi and velocity.
###    The line is adopted to be narrow (100 km/s) as it can always be broadened in SPEX in the fit!
###    If you want to test larger line widths, add the "vgau" component and convolved PMF with it.
###
### 5) Steps: A) create the grid routine with SPEX commands for the chosed parameter space,
###           B) call SPEX, load data and bestfit (continuum) model and add the pion file model.
###           C) then launch the grid routine within SPEX and save the fit for each individual point
###           D) Finally read C-stat from each fit into a large file containing all the paramet. space
###              You need to update line 355 with the exact pion component number (here 5 was adopted)
###
### 6) OUTPUT: 3 Table files containing results as delta Cstat or Normalisation for each (xi,zv,width)
###            1 two-column file (with a header) and 2 matrix-files for the DCstat and Norm 3D contour
###
###    License: This public code was developed for and published in the paper Pinto et al. (2020a),
###        DOI: 10.1093/mnras/staa118, arXiv: 1911.09568, bibcode: 2020MNRAS.492.4646P.
###        You're recommended and kindly requested to refer to that paper when using this code.
###
######################### 1) PARALLELISATION and PARAMETER SPACE #####################################

export OMP_NUM_THREADS=4 # This chooses the number of cores/CPU/threads used.

echo "Running SPEX onto ${OMP_NUM_THREADS} threads / cores"

SOURCE=SOURCE_NAME # Provide the source name: IMPORTANT is often used as the PATH-TO-DIR

type=pion          # among: xabs pion cie (directory) to choose name for launch directory

type_model=pion    # among: xabs pion cie (models), in this case it's "pion" of course

NC=5               # number of component for which grid runs

LABEL=PIE          # Grid on Pion model files (photo-ionised emission)

part=01${LABEL}    # among: 01 ... 10 to run more parts in parallelisation

xi_min=2.0         # 2.0 short part as it's just a PMF (two cold lines below)
xi_max=5.01        # 5.0 short part as it's just a PMF (very few lines above)
xi_step=0.1        # normally 0.1, perhaps 0.2 is also OK for broad lines

zv_min=-39000      # -39000 (blueshifted up to -0.12255c or -0.121 relativ-corrected)
zv_max=+69000      # +69000 ( redshifted from +0.23c or +0.261c) all multiple of 600!

width_list=(100 250 500 1000 2500 5000 10000 20000) # km/s, to convolve via "vgau" if needed

vstep_list=(500 500 600 700 1000 1500 1500 2000)    # km/s, Different from xabs, but=CIE

N_of_width=7       # "${#width_list[@]}" 4 all line widths (min_item+1 at least)

min_item=0         # =0 to start from 1st of the line widths (from which to start)

width_todo=500     # To chose a specific line width

###################### 2) DEFINITION OF DIRECTORIES AND ENV-VARIABLES ################################

mkdir ${PWD}/${type}_grids     # Start to create the (sub)structure of directories

DIR_home=${PWD}/${type}_grids  # Launch routine from current directory or change here

mkdir ${DIR_home}/part_${part}                     # Where this routine is actually run
mkdir ${DIR_home}/part_${part}/linegrid            # Where each individual fit is saved
mkdir ${DIR_home}/part_${part}/detection_routines  # Where routine.com is written/stored
mkdir ${DIR_home}/part_${part}/rgs_models          # Where each initial model.com is saved

DIR_routine=${DIR_home}/part_${part}/detection_routines

DIR_models=${DIR_home}/part_${part}/rgs_models

DIR_outgrid=${DIR_home}/part_${part}/linegrid

DIR_startspex=/PATH/TO/DIRECTORY/WITH/SPEX/BESTFIT   # Directory containing SPEX's fit executable file

spex_startup=${DIR_startspex}/spex_continuum_besffit # SPEX executable: loads data and continuum model

cd ${DIR_home}/part_${part}                          # Go where this routine is actually run

DIR_PIE_calc=/PATH/TO/DIRECTORY/WITH/SPEX/pion_grids/file_spex_cor # where pion file model are stored

xabs_inputfile=/PATH/TO/DIRECTORY/WITH/SPEX/xabs_inputfile.dat     # if also xabs absorption is added

################### 3) CREATION OF THE SPEX ROUTINE FOR THE GRID  ####################################

max_item=`echo "${N_of_width}-1" | bc`

for item in $(seq ${min_item} 1 ${max_item}) # 1) LOOP OVER LINE WIDTH
 do

if [ ${width_list[${item}]} -ne ${width_todo} ] # != To choose a specific LINE WIDTH
then
echo "LW = ${width_list[${item}]} temporarily skipping."
else
echo "LW = ${width_list[${item}]} currently working on."

width=${width_list[${item}]}

zv_step=${vstep_list[${item}]}

echo "Line Width = ${width} km/s, assiming grid Step = ${zv_step} km/s" # Check: print the velocities

results_file_1=${DIR_home}/part_${part}/${type_model}_${width}_kms_${part}_2D${LABEL}.dat    # OUTPUT1

mv ${results_file_1} ${results_file_1}.backup # Back up file of previous run to avoid loss by mistake

echo "# C-ST N_${type_model} Logxi vLOS vLW" >  ${results_file_1}
echo "# "                                    >> ${results_file_1}

results_file_2=${DIR_home}/part_${part}/${type_model}_${width}_kms_${part}_CS_3D${LABEL}.dat # OUTPUT2
results_file_3=${DIR_home}/part_${part}/${type_model}_${width}_kms_${part}_NH_3D${LABEL}.dat # OUTPUT3

mv ${results_file_2} ${results_file_2}.backup # Back up file of previous run to avoid loss by mistake
mv ${results_file_3} ${results_file_3}.backup # Back up file of previous run to avoid loss by mistake

    for xi_start in $(seq ${xi_min} ${xi_step} ${xi_max}) # 2) LOOP OVER LOG_XI
     do

if [ ${xi_start} -gt 6 ] # To test specific LOG_XI or T_CIE
then
#echo "T_CIE = ${xi_start} temporarily skipping."
 x=0
else
echo "Log_xi (PIE) = ${xi_start} currently working on."

### NORMALISATION StARTING CONDITIONS via statements for different LOG_XI or T_CIE
###
### Such normalisation are ad-hoc and chosen manually for the extreme of each log xi range
### to speed up the fit without the need for calculating the error and slowing down the fits
### Alternatively, start from a low normalisation of the pion file model component (e.g. 1)
### and then run the error calc on it to search for lower Cstat (see "err 1 ${NC} nh" below)

if [ ${xi_start} -ge 0 ] && [ ${xi_start} -lt 0.5 ]     # nh_start chosen after manually checked
then
nh_start=5e5

elif [ ${xi_start} -ge 0.5 ] && [ ${xi_start} -lt 1.0 ] # or start low (NH=1e-4) and run errors!
then
nh_start=2e5

elif [ ${xi_start} -ge 1.0 ] && [ ${xi_start} -lt 2.5 ] # but errors will be redundant and slow.
then
nh_start=1e5

elif [ ${xi_start} -ge 2.5 ] && [ ${xi_start} -lt 3.5 ]
then
nh_start=5e5

elif [ ${xi_start} -ge 3.5 ] && [ ${xi_start} -lt 4.5 ]
then
nh_start=2e6

elif [ ${xi_start} -ge 4.5 ] && [ ${xi_start} -lt 5.5 ]
then
nh_start=2e7

else
nh_start=2e8
fi

echo "SPEX code for ${type_model} Log_xi = ${xi_start} and Norm (start) = ${nh_start}"

startup_model=${DIR_models}/rgs_model_${type_model}_start_${width}kms # To initialise NH at each z-fit

routine_spex=${DIR_routine}/routine_${type_model}_v${width}kms_xi${xi_start} # SPEX big grid routine

routine_file=${routine_spex}.com        # the COM extension is for file editing and not SPEX loading

echo "# SPEX ${type} scan loop on width, xi and zv (NH free)" > ${routine_file}  # build the routine
echo " "                                                     >> ${routine_file}
#echo "p fra 1"                                              >> ${routine_file}  # uncomment lines
#echo " "                                                    >> ${routine_file}  # to update plots

# IMPORTANT: Testing (blue-/red-shifted) PION file model for following GRIDs
#
# Here we assume that we have a certain continuum model such as: hot (ISM) * bb + dbb + comt
# Let's add the calculated PION file-model of a certain grid and a xabs model of photoionised absorber
# The additional xabs model will be used in case we have already found a significant detection using
# the code "SPEX_xabs_grid_fast_input.sh". You can comment xabs-related commands to remove it.
# Example model: 1.hot (ISMabs), 2.bb, 3.dbb, 4.comt (continuum emission), 5.file, 6.red, 7.xabs
# and we have relate them: "e.g. com rel 2:5 1" i.e. all absorbed Galactic ISM (hot component)
#
# Here we adopt the PION file models calculated just for NH = 1e22 cm^-2 and fit its normalisation to
# simplify the code architecture and speed up the computing a lot (see justification above). These
# were calculated by the code SPEX_pion_calc_spec_n1e22.sh within a range of ionisation parameters xi.
# However, if you want to make contours of the NH (rather than the scaled normalisation) and correct
# for any systematics due to line opacity, you can add here a loop among the pion file model spectra
# calculated all the NH values corresponding to each log xi range (higher NH for higher log xi).

log_xi_file=${DIR_PIE_calc}/PION_v500_hd1e-14_xi${xi_start}_nh22.0.qdp.dat # PION file model name

# Preparation of a startup model to load when fitting each different velocity or redshift:
# This will avoid to start each fit with the PMF normalisation from the previous fit!
#
# IMPORTANT: the example shown here is using 4 sectors in SPEX, which is a frequent case with
# XMM-Newton data if you have 4 sectors for RGS, MOS1, MOS2, and pn. If you have only one sector
# i.e. you are using exactly the same model, including all normalisations, for all instruments,
# you can remove the characters ":4" and the lines where some parameters were coupled among the
# sectors 2:4 and the sector 1, such as: "par 2:4 ${NC} no:f cou 1 ${NC} no:f"
#
# If you want to simplify the code, you can add all the components (e.g. PMF, redshift and xabs)
# back in the SPEX executable file and keep in this code only the commands related to the update
# of the parameters just like done for the xabs code "SPEX_xabs_grid_fast_input.sh".
# For this exercise I preferred to show you here how to do it in the main code as well.
# This gives you the advantage of using the SPEX bestfit continuum model for any physical models
# automated grids afterwards by adding pion, xabs, cie, etc. in the code rather than the SPEX bestfit

echo "com file"                             >> ${routine_file} # Component for PION file-model grid
echo "com red"                              >> ${routine_file} # Add redshift component for PMF above
echo "com rel 2:4 1"                        >> ${routine_file} # Continuum absorbed by ISM hot comp
echo "com rel 5 6,1"                        >> ${routine_file} # PION PMF redshifted, absorbed by ISM
echo " "                                    >> ${routine_file}
echo "par 1:4 ${NC} norm s  t"              >> ${routine_file} # Chose parameters for a startup model
echo "par 1:4 ${NC} norm v  ${nh_start}"    >> ${routine_file} # Pair model par for RGS, MOS1-2 and pn
echo "par 1:4 ${NC} file av ${log_xi_file}" >> ${routine_file} # load PION file model calculated spec
echo "par 2:4 ${NC} no:f cou 1 ${NC} no:f"  >> ${routine_file}
echo " "                                    >> ${routine_file}
echo "par 1:4 6 flag v 1"                   >> ${routine_file} # Red/Blue-shift for the PIE component
echo "par 2:4 6 z:fl c 1 6 z:fl"            >> ${routine_file} # Flag=1 means redshift is velocity
echo "par 2:4 6 z:fl s f"                   >> ${routine_file} #        and not cosmoligic redshift!
echo " "                                    >> ${routine_file}
echo "# Adding Xabs at its best-fit"        >> ${routine_file} # Adding a xabs photoionised absorber
echo " "                                    >> ${routine_file} # if significant detection was already
echo "com xabs "                            >> ${routine_file} # achieve in previous runs of the code
echo "com rel  2:4 7,1 "                    >> ${routine_file} # SPEX_xabs_grid_fast_input.sh
echo "com rel  5   6,7,1 "                  >> ${routine_file} # otherwise comment these lines
echo " "                                    >> ${routine_file} # and anything related to the
echo "par 2:4 7 nh:col cou 1 7 nh:col  "    >> ${routine_file} # component number 7 (i.e. xabs)
echo "par 1:4 7 col av ${xabs_inputfile} "  >> ${routine_file} # here you provide the ionis. balance
echo " "                                    >> ${routine_file} # calculation (xabs_inputfile)
echo "par 1:4 7 nh s t "                    >> ${routine_file} # update xabs parameters
echo "par 1:4 7 xi s t "                    >> ${routine_file}
echo "par 1:4 7 v  s f "                    >> ${routine_file}
echo "par 1:4 7 zv s t "                    >> ${routine_file}
echo "par 1:4 7 nh r  1e-3   1.0  "         >> ${routine_file}
echo "par 1:4 7 xi r  1.0    6.0  "         >> ${routine_file}
echo "par 1:4 7 v  r  100    1e4  "         >> ${routine_file}
echo "par 1:4 7 zv r -1e5    0"             >> ${routine_file}
echo "par 1:4 7 nh v  0.1 "                 >> ${routine_file} # These are just casual values, which 
echo "par 1:4 7 xi v  3.0 "                 >> ${routine_file} # will change from source to source
echo "par 1:4 7 v  v ${width} "             >> ${routine_file} # just run the "xabs" fast scan first!
echo "par 1:4 7 zv v -30000 "               >> ${routine_file}
echo " "                                    >> ${routine_file}
echo "par wri ${startup_model} over"        >> ${routine_file} # Saving startup model (PMF initialise)
echo " "                                    >> ${routine_file}
echo " fit print 0"                         >> ${routine_file} # To plot each fit type: "fit print 1"

for j in $(seq ${zv_min} ${zv_step} ${zv_max})  # 3) LOOP OVER ZV_LOS
 do

### k=-${j} ### This was previously used for blueshift grids. It is redundant if chosen k=-${z_shift}

 z_shift=$(echo "scale=4;${j}/300000" | bc -l)  # convert velocity shift to redshift for red component

k=${z_shift} # Positive for red-shift (Put -${z_shift} for blue-shift or adopt a negative ${zv_min})

echo "l e ${startup_model}"                               >> ${routine_file}  # PMF initialisation
echo " "                                                  >> ${routine_file}
#echo "p cap lt text \" w${width} xi${xi_start} v${k} \" " >> ${routine_file} # uncomment lines
#echo "p cap lt disp t "                                   >> ${routine_file} # to update plots
#echo " "                                                  >> ${routine_file}
echo "par 1 ${NC} no v ${nh_start}"                       >> ${routine_file}  # Update normalisation
#echo "par 1 ${NC} t  v ${xi_start}"                       >> ${routine_file}
#echo "par 1 ${NC} v  v ${width}   "                       >> ${routine_file}
echo "par 1 6     z  v ${k}       "                       >> ${routine_file}  # Update red/blue-shift
echo " "                                                  >> ${routine_file}
#echo "# NH     = ${nh_start} "                            >> ${routine_file}
#echo "# T_CIE = ${xi_start} "                            >> ${routine_file}
#echo "# V_turb = ${width}    "                            >> ${routine_file}
#echo "# V_LOS  = ${k}        "                            >> ${routine_file}
#echo " "                                                  >> ${routine_file}
echo " c "                                                >> ${routine_file} # calculate model
#echo " p   "                                              >> ${routine_file}
echo " fit "                                              >> ${routine_file} # fit the model
echo " fit "                                              >> ${routine_file} # i.e. continuum
echo " fit "                                              >> ${routine_file} # and NH parameters
#echo " fit "                                              >> ${routine_file}
#echo " fit "                                              >> ${routine_file}
#echo " par sh f "                                         >> ${routine_file}
#echo " "                                                  >> ${routine_file}
#echo "system exe \"rm spex_lower_stat.com\" "             >> ${routine_file}
#echo "err 1 ${NC} nh "                                    >> ${routine_file}
#echo "l e spex_lower_stat "                               >> ${routine_file}
#echo "par 1 ${NC} nh s t "                                >> ${routine_file}
#echo "c "                                                 >> ${routine_file}
##echo "p "                                                 >> ${routine_file}
#echo " fit "                                              >> ${routine_file}
#echo " fit "                                              >> ${routine_file}
#echo " fit "                                              >> ${routine_file}
#echo " fit "                                              >> ${routine_file}
#echo " par sh f "                                         >> ${routine_file}
#echo " "                                                  >> ${routine_file}
#echo "system exe \"rm spex_lower_stat.com\" "             >> ${routine_file}
echo " "                                                             >> ${routine_file}
echo "log out ${DIR_outgrid}/${type_model}_${width}_${xi_start}_${k} over" >> ${routine_file}
echo "par sh f"                                                      >> ${routine_file} # save
echo "log close out"                                                 >> ${routine_file} # each fit
echo " "                                                             >> ${routine_file} # results

done

#done

###################### 4) EXECUTION OF THE SPEX ROUTINE FOR THE GRID  ################################
###
### At first load data, bestfit continuum model: "log exe ${spex_startup}"
### Then launch the routine for PION scan grids: "log exe ${routine_spex}"

spex<<EOF
log exe ${spex_startup}

#p de xs
#p ty da
#p ux ke
#p x lo
#p rx 0.3 10
#p uy fa
#p y lo
#p ry 1e-3 1
#p

log exe ${routine_spex}
q
EOF

################# 5) READ THE SPEX RESULTS IN ONE FILE PER LINE WIDTH  ###############################

#  for xi_start in $(seq ${xi_min} ${xi_step} ${xi_max}) # 2) LOOP OVER LOG_XI
#   do

   for j in $(seq ${zv_min} ${zv_step} ${zv_max})  # 3) LOOP OVER ZV_LOS
    do

    ### k=-${j} ### This is redundant (see comment above for the same command occurrence)

    z_shift=$(echo "scale=4;${j}/300000" | bc -l) # convert velocity shift to redshift

    k=${z_shift} # Positive for red-shift (Put -${z_shift} for blue-shift or a negative ${zv_min})

    input_file=${DIR_outgrid}/${type_model}_${width}_${xi_start}_${k}.out # individual fit to read

if [ ! -f "${input_file}" ]
then
test_command=0 # if file for a certain point does not exist, ignore it or comment next line to track
#   echo "File ${input_file} does not exists"
else

# Removing useless lines containing e.g. "<=>" from ${input_file} to save space!

sed -i '/<->/d'        ${input_file} # If it doesnt work in Linux remove the option -i
sed -i '/bb/d'         ${input_file} # You might have to add/remove '' after option -i
sed -i '/Instrument/d' ${input_file}
sed -i '/sect/d'       ${input_file}
#sed -i '/Flux/d'       ${input_file}
sed -i '/phot/d'       ${input_file}
sed -i '/rest/d'       ${input_file}
sed -i '/----/d'       ${input_file}
sed -i '/^$/d'         ${input_file}

 CSTAT=`sed '/C-statistic       :/!d'     ${input_file}` # search line containing CSTAT parameter

#NORM=`sed '/ 1    ${NC} ${type_model} nh/!d'   ${input_file}` # Does not work (see below)
 NORM=`sed '/ 1    5 file norm/!d'          ${input_file}`     # IMPORTANT: Needs exact line (5 file)

# echo "'/ 1    ${NC} ${type_model} nh/!d'" # apparently prints same but does not work (see above)
# echo "'/ 1    5 xabs nh/!d'"

 echo ${CSTAT:24:12} ${NORM:41:13} ${xi_start} ${k} ${width} >> ${results_file_1} # update output1
#echo ${CSTAT:24:12} ${NORM:41:13} ${xi_start} ${k} ${width}

 echo -n ${CSTAT:24:12} " " >> ${results_file_2} # update output file 2
 echo -n ${NORM:41:13}  " " >> ${results_file_3} # update output file 3

# For contour plots: MATRIX with log_xi as rows and v_LOS as columns (easier)
#                    Save two files, one for CSTAT and one for normalisation (in Z-axis)

fi 

    done

echo " " >> ${results_file_2} # output2: put a space between each point
echo " " >> ${results_file_3} # output3: put a space between each point

fi

   done

#echo "${results_file_1} content:" # to print the final results (OUTPUT 1) in the terminal window
#cat ${results_file_1}
#echo "${results_file_2} content:" # to print the final results (OUTPUT 2) in the terminal window
#cat ${results_file_2}
#echo "${results_file_3} content:" # to print the final results (OUTPUT 3) in the terminal window
#cat ${results_file_3}

fi

done

cd ${DIR_home}

###################################### END OF THE ROUTINE ############################################

