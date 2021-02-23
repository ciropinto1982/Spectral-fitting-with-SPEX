#!/bin/ksh

######################################################################################################
###
### SPEX scans of collisionally-ionised emission models over a predefined grid in the parameters space
###
### Do not forget to open a screen session if you want it to run in background.
###
### Launching command (in background): ./SPEX_ciez_grid_fast_input.sh > /dev/null 2>&1
###
######## 0) REQUIREMENTS - THINGS THAT NEED TO BE KNOWN BEFORE RUNNING THIS ROUTINE ##################
###
### 1) A SPEX executable file that loads spectra, bestfit continuum model. Plots are optional
###    The addition of a CIE component is done here and coupled with the Galactic ISM absorption
###    For instance, if the components are: hot, bb, dbb, cie then should be "com rel 2:4 1"
###
### 2) No Ionisation balance pre-calculation is needed as CIE is quick to be calculated and fitted.
###    But the USER has to provide a grid of kT values (ideally log-spaced) in a file called:
###    "Val_CIE_T_loggrid.txt". Alternatively, for a linear kT grid just comments the kT-step lines
###
### 3) Initial values tested for some ranges of CIE normalisation. These are ad-hoc pre-tested values
###    of the CIE normalisation for which the fit is already sensitive with DC or DX2 between 10-50.
###    This starting assumption will avoid the calculation of the error (e.g. steppar on the CIE norm)
###    which is necessary to locate minima of C-stat (or Chi2) and always happens at initial low Norm,
###    thereby speeding the routine by (about) a factor 3. If you like you can still run the error
###    calculation by commenting the corresponding lines in the code to be even more accurate.
###
### 4) The routine adopts a grid of CIE kT, redshifts (z), CIE turbulence (width), and fits the norm
###    Here Solar abundances are adopted, but additional subgrid could be implemented for non-Solar Z.
###
### 5) Steps: A) create the grid routine with SPEX commands for the chosed parameter space,
###           B) call SPEX, load data and bestfit (continuum) model and add the CIE on top of it.
###           C) then launch the grid routine within SPEX and save the fit for each individual point
###           D) Finally read C-stat from each fit into a large file containing all the param space
###              You need to update line 316 with the exact CIE component number (here 5 was adopted)
###
### 6) OUTPUT: 3 Table files containing the results as delta C-stat or Norm for each (T,z,width) point
###            1 two-column file (with a header) and 2 matrix-files for the DCstat & Norm 3D contours.
###
###    License: This public code was developed for and published in the paper Pinto et al. (2020a),
###        DOI: 10.1093/mnras/staa118, arXiv: 1911.09568, bibcode: 2020MNRAS.492.4646P.
###        You're recommended and kindly requested to refer to that paper when using this code.
###
######################### 1) PARALLELISATION and PARAMETER SPACE #####################################

export OMP_NUM_THREADS=4 # This chooses the number of cores/CPU/threads used.

echo "Running SPEX onto ${OMP_NUM_THREADS} threads / cores"

SOURCE=SOURCE_NAME # Provide the source name: IMPORTANT is often used as the PATH-TO-DIR

type=cie           # among: xabs pion cie (directory) random choice for your launch-DIR

type_model=cie     # among: xabs pion cie (models)

NC=5               # number of component for which grid runs

LABEL=CR           # Special label for e.g. blue- (CB) or red- (CR) shifted

part=01${LABEL}    # among: 01 ... 10 to run more parts in parallelisation

xi_min=0.1         # 0.1 minimum for kT_CIE in the RGS band (high BKG above 20 Ang)
xi_max=5.0         # 5.0 maximum for kT_CIE in the RGS band (no strong Fe K in xmm)
#xi_step=0.1       # only for linear grid, here we use Log_T distribution (file: Val_CIE_T_loggrid.txt)

zv_min=0           # 0 normally 0 km/s (gas at rest)
zv_max=78000       # 78000 to have up to at least >=0.3c (for the red-shifted part)

width_list=(100 250 500 1000 2500 5000 10000 20000) # Line widths to be adopted in km/s

vstep_list=(500 500 500 700 1000 1500 1500 2000)    # Velocity steps to adopted in km/s

N_of_width=7     # ="${#width_list[@]}" for all line widths (how many to run)

min_item=0       # =0 to start from 1st of the line widths (from which to start)

width_todo=500   # To chose a specific line width

###################### 2) DEFINITION OF DIRECTORIES AND ENV-VARIABLES ################################

mkdir ${PWD}/${type}_grids     # Start to create the (sub)structure of directories

DIR_home=${PWD}/${type}_grids  # Launch routine from current directory or change here

CT_file=${DIR_home}/Val_CIE_T_loggrid.txt # Provide a used-defined (e.g. Log-space) kT grid

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

################### 3) CREATION OF THE SPEX ROUTINE FOR THE GRID  ####################################

max_item=`echo "${N_of_width}-1" | bc`

for item in $(seq ${min_item} 1 ${max_item}) # 1) LOOP OVER LINE WIDTH
 do

if [ ${width_list[${item}]} -ne ${width_todo} ] # != To choose a certain LINE WIDTH (or comment lines)
then
echo "LW = ${width_list[${item}]} temporarily skipping."
else
echo "LW = ${width_list[${item}]} currently working on."

width=${width_list[${item}]}

zv_step=${vstep_list[${item}]}

echo "Line Width = ${width} km/s, assiming grid Step = ${zv_step} km/s" # Check: print the velocities

results_file_1=${DIR_home}/part_${part}/${type_model}_${width}_kms_${part}_2D${LABEL}.dat    # OUTPUT1

mv ${results_file_1} ${results_file_1}.backup  # Back up file of previous run to avoid loss by mistake

echo "# C-ST NO_${type_model} T_CIE  v(km/s) VT (km/s)" >  ${results_file_1}
echo "# "                                               >> ${results_file_1}

results_file_2=${DIR_home}/part_${part}/${type_model}_${width}_kms_${part}_CS_3D${LABEL}.dat # OUTPUT2
results_file_3=${DIR_home}/part_${part}/${type_model}_${width}_kms_${part}_NH_3D${LABEL}.dat # OUTPUT3

mv ${results_file_2} ${results_file_2}.backup  # Back up file of previous run to avoid loss by mistake
mv ${results_file_3} ${results_file_3}.backup  # Back up file of previous run to avoid loss by mistake

    for xi_start in `cat ${CT_file}` # 2) LOOP OVER LOG_XI or T_CIE
     do

if [ ${xi_start} -gt ${xi_max} ] # To test specific LOG_XI or T_CIE
then
#echo "T_CIE = ${xi_start} temporarily skipping."
 x=0
else
echo "T_CIE = ${xi_start} currently working on."

# NORMALISATION StARTING CONDITIONS via statements for different LOG_XI or T_CIE

if [ ${xi_start} -gt 0 ] && [ ${xi_start} -lt 0.15 ]      # CIE norm chosen after manually checked
then
nh_start=3000

elif [ ${xi_start} -ge 0.15 ] && [ ${xi_start} -lt 0.25 ] # or start low (CIE Norm=1) and run errors!
then
nh_start=700

elif [ ${xi_start} -ge 0.25 ] && [ ${xi_start} -lt 0.45 ] # but errors will be redundant and slow.
then
nh_start=400

elif [ ${xi_start} -ge 0.45 ] && [ ${xi_start} -lt 0.75 ]
then
nh_start=300

elif [ ${xi_start} -ge 0.75 ] && [ ${xi_start} -lt 0.95 ]
then
nh_start=250

elif [ ${xi_start} -ge 0.95 ] && [ ${xi_start} -lt 1.35 ]
then
nh_start=200

elif [ ${xi_start} -ge 1.35 ] && [ ${xi_start} -lt 2.0 ]
then
nh_start=150

elif [ ${xi_start} -ge 2.0 ] && [ ${xi_start} -lt 3.5 ]
then
nh_start=100

else
nh_start=50
fi

echo "SPEX code for ${type_model} T_CIE = ${xi_start} and N_H (start) = ${nh_start}" # Check: (xi0,nh0)

startup_model=${DIR_models}/rgs_model_${type_model}_start_${width}kms # To initialise CIE-Norm each z

routine_spex=${DIR_routine}/routine_${type_model}_v${width}kms_xi${xi_start} # SPEX big grid routine

routine_file=${routine_spex}.com        # the COM extension is for file editing and not SPEX loading

echo "# SPEX ${type_model} scan on width, kT and zv (Norm free)" > ${routine_file} # build routine
echo " "                                                        >> ${routine_file}
#echo "p fra 1"                                                 >> ${routine_file} # uncomment lines
#echo " "                                                       >> ${routine_file} # to update plots

# IMPORTANT: Testing (blue- OR red-shifted) CIE for following GRIDs
#
# Let's assume the model components are: 1.hot (ISM absorption), 2.bb, 3.dbb, 4.comt (continuum emiss.)
# We then add a CIE (component 5) and the redshift (component 6), we'll need to relate the components:

echo "com cie"                              >> ${routine_file} # Add CIE emission to the model
echo "com red"                              >> ${routine_file} # Add redshift component for the CIE
echo "com rel 2:4 1"                        >> ${routine_file} # Absorb continuum with ISM hot comp
echo "com rel 5 6,1"                        >> ${routine_file} # Absorb and redshift the CIE component
echo " "                                    >> ${routine_file}
echo "par 1:4 ${NC} no  v ${nh_start}"      >> ${routine_file} # Chose cie param for a startup model
echo "par 1:4 ${NC} t   v ${xi_start}"      >> ${routine_file}
echo "par 2:4 ${NC} no:vm cou 1 ${NC} no:vm">> ${routine_file}
echo "par 1:4 ${NC} v   r 0.0 1e5"          >> ${routine_file}
echo "par 1   ${NC} v   v ${width}"         >> ${routine_file}
echo "par 1   ${NC} t:v s f"                >> ${routine_file}
echo " "                                    >> ${routine_file}
echo "par 1:4 6 flag v 1"                   >> ${routine_file} # Red/Blue-shift for the CIE component
echo "par 2:4 6 z:fl c 1 6 z:fl"            >> ${routine_file} # Flag=1 means redshift is velocity
echo "par 2:4 6 z:fl s f"                   >> ${routine_file} #        and not cosmoligic redshift!
echo " "                                    >> ${routine_file}
echo "par wri ${startup_model} over"        >> ${routine_file} # Saving startup model (NH initialise)
echo " "                                    >> ${routine_file}
echo " fit print 0"                         >> ${routine_file} # To plot each fit type: "fit print 1"

for j in $(seq ${zv_min} ${zv_step} ${zv_max})  # 3) LOOP OVER ZV_LOS
 do

### k=-${j} ### This was previously used for blueshift grids. It is redundant if chosen k=-${z_shift}

 z_shift=$(echo "scale=4;${j}/300000" | bc -l)  # convert velocity shift to redshift for red component

 k=${z_shift} # Positive for red-shift (Put -${z_shift} for blue-shift or adopt a negative ${zv_min})

#echo "SPEX code for ${type_model} T_CIE = ${xi_start} and N_H (start) = ${nh_start}, V_LOS=${k}"

echo "l e ${startup_model}"                               >> ${routine_file} # CIE initialisation
echo " "                                                  >> ${routine_file}
#echo "p cap lt text \" w${width} xi${xi_start} v${k} \" " >> ${routine_file} # uncomment lines
#echo "p cap lt disp t "                                   >> ${routine_file} # to update plots
#echo " "                                                  >> ${routine_file}
echo "par 1 ${NC} no v ${nh_start}"                       >> ${routine_file} # update CIE parameters
echo "par 1 ${NC} t  v ${xi_start}"                       >> ${routine_file}
echo "par 1 ${NC} v  v ${width}   "                       >> ${routine_file}
echo " "                                                  >> ${routine_file}
echo "par 1 6 z v ${k}"                                   >> ${routine_file}
echo " "                                                  >> ${routine_file}
#echo "# NH     = ${nh_start} "                            >> ${routine_file} # comments in routine
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
#echo "system exe \"rm spex_lower_stat.com\" "             >> ${routine_file} # delete old errors
#echo "err 1 ${NC} nh "                                    >> ${routine_file} # run error calc
#echo "l e spex_lower_stat "                               >> ${routine_file} # load new lower CS
#echo "par 1 ${NC} nh s t "                                >> ${routine_file} # free searched par
#echo "c "                                                 >> ${routine_file}
##echo "p "                                                 >> ${routine_file}
#echo " fit "                                              >> ${routine_file}
#echo " fit "                                              >> ${routine_file}
#echo " fit "                                              >> ${routine_file}
#echo " fit "                                              >> ${routine_file}
#echo " par sh f "                                         >> ${routine_file}
#echo " "                                                  >> ${routine_file}
#echo "system exe \"rm spex_lower_stat.com\" "             >> ${routine_file} # delete old errors
echo " "                                                             >> ${routine_file}
echo "log out ${DIR_outgrid}/${type_model}_${width}_${xi_start}_${k} over" >> ${routine_file} # save
echo "par sh f"                                                      >> ${routine_file}    # each fit
echo "log close out"                                                 >> ${routine_file}    # results
echo " "                                                             >> ${routine_file}

done

#done

###################### 4) EXECUTION OF THE SPEX ROUTINE FOR THE GRID  ################################
###
### At first load data, bestfit continuum model: "log exe ${spex_startup}"
### Then launch the routine for CIE scann grids: "log exe ${routine_spex}"

spex<<EOF
log exe ${spex_startup}
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

sed -i '' '/<->/d'        ${input_file} # If it doesnt work in Linux remove the option -i
sed -i '' '/bb/d'         ${input_file} # You might have to add/remove '' ahead option -i
sed -i '' '/Instrument/d' ${input_file}
sed -i '' '/sect/d'       ${input_file}
sed -i '' '/Flux/d'       ${input_file}
sed -i '' '/phot/d'       ${input_file}
sed -i '' '/----/d'       ${input_file}
sed -i '' '/^$/d'         ${input_file}

 CSTAT=`sed '/C-statistic       :/!d'     ${input_file}` # search line containing CSTAT parameter

#NORM=`sed '/ 1    ${NC} ${type_model} nh/!d'   ${input_file}` # Does not work (see below)
 NORM=`sed '/ 1    5 cie  no/!d'          ${input_file}`       # IMPORTANT: Needs exact line (5 cie)

# echo "'/ 1    ${NC} ${type_model} nh/!d'" # apparently prints same but does not work (see above)
# echo "'/ 1    5 xabs nh/!d'"

 echo ${CSTAT:24:12} ${NORM:41:13} ${xi_start} ${k} ${width} >> ${results_file_1} # update output1
#echo ${CSTAT:24:12} ${NORM:41:13} ${xi_start} ${k} ${width}

 echo -n ${CSTAT:24:12} " " >> ${results_file_2} # update output file 2
 echo -n ${NORM:41:13}  " " >> ${results_file_3} # update output file 3

# For contour plots: MATRIX with CIE kT as rows and v_LOS as columns (easier)
#                    Save two files, one for CSTAT and one for Norm (in Z-axis)

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

