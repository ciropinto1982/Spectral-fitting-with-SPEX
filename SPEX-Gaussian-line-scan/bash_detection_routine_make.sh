#!/bin/ksh

##################################################################################################################
###
### INFO: bash script that creates a line-detection routine to run into SPEX
###
### - read energy centroi grid in Log_E_grid_0310keV_100kms.txt
### - calculate the FWHM at each energy centroid for a given velocity dispersion
### - update the routine: move the gaussian along the energy grid and update the FWHM, fit and save the parameters
###
##################################################################################################################

home_dir=$PWD                                        # Launching directory

startup_spex_model=${home_dir}/spex_model_RHPBD2LG   # SPEX startup model (useful if at some point fit breaks up)

mkdir linegrid                                       # Create directory where saving the SPEX outputs

outdir=${home_dir}/linegrid                          # DIR where we will put the SPEX outputs

detection_routine_dir=${home_dir}                    # DIR where we will put the line-edtection routine

for width in 1000                                    # Gaussian FWHM, default values: 100 250 500 1000 (... km/s)
 do

detection_routine=${detection_routine_dir}/spex_det_routine_w${width}kms.com

echo "Copying to file ${detection_routine} for all energies in keV and LW = ${width} km/s"

echo "# SPEX Gaussian grid FWHM = ${width}kms in 0.3-10 keV log-spaced"                     > ${detection_routine}
echo "#"                                                                                   >> ${detection_routine}
echo "# Run this before SPEX: echo Parallelisation"                                        >> ${detection_routine}
echo "# Run this before SPEX: number_of_cores=4"                                           >> ${detection_routine}
echo "# Run this before SPEX: export OMP_NUM_THREADS=\${number_of_cores}"                  >> ${detection_routine}
echo "# Run this before SPEX: echo choosing number of cores / threads=\${OMP_NUM_THREADS}" >> ${detection_routine}
echo "#"                                                                                   >> ${detection_routine}
echo "# Created by unix_detection_routine_make.sh "                                        >> ${detection_routine}
echo " "                                                                                   >> ${detection_routine}
echo "par 1 8 ty   v 0"                                                                    >> ${detection_routine}
echo "par 1 8 e    v 7.0"                                                                  >> ${detection_routine}
echo "par 1 8 e:aw s f"                                                                    >> ${detection_routine}
echo "par 1 8 no   r -1e10 +1e10"                                                          >> ${detection_routine}
echo "par 1 8 no   v 1e4"                                                                  >> ${detection_routine}
echo "par wri ${startup_spex_model} over"                                                  >> ${detection_routine}
echo " "                                                                                   >> ${detection_routine}
echo "p fra 1"                                                                             >> ${detection_routine}
echo "p cap lt disp t "                                                                    >> ${detection_routine}
echo " "                                                                                   >> ${detection_routine}

for i in `cat ./Log_E_grid_0310keV_${width}kms.txt`
 do

if [ ${i} -lt 0.4 ] || [ ${i} -gt 10.0 ]  # Try a short one before the default: [ ${i} -lt 0.4 ] || [ ${i} -gt 10.0 ]
then
   echo "Energy ${i} out of range 0.4-10.0 keV"
    x=0 # Random command is necessary if text above gets commented!
else

energy=$(($i))

# Calculate the line width (FWHM)

line_width=`echo "scale=7;${width}*${energy}/300000.*2.355" | bc` # In alternative you can use LUA-calc

echo "Updating code in the file ${detection_routine} for Energy ${i} keV and LW ${line_width} keV"

x=0 # Random command is necessary if everything else gets commented!

# PART1: update E and FWHM of the Gaussian and re-fit the spectrum

echo " "                                                          >> ${detection_routine}
echo "##################################################"         >> ${detection_routine}
echo " "                                                          >> ${detection_routine}
echo " p cap lt text \" Gaussian E0=${i}keV LW=${width}km/s \" "  >> ${detection_routine}
echo " "                                                          >> ${detection_routine}
echo " l e ${startup_spex_model} "                                >> ${detection_routine}
echo " "                                                    >> ${detection_routine}
echo " par 1 8 n     v  1e3   "                             >> ${detection_routine}
echo " par 1 8 e     v  ${i}  "                             >> ${detection_routine}
echo " par 1 8 f     v  ${line_width}"                      >> ${detection_routine}
echo " c   "                                                >> ${detection_routine}
echo " p   "                                                >> ${detection_routine}
echo " fit "                                                >> ${detection_routine}
echo " fit "                                                >> ${detection_routine}
echo " fit "                                                >> ${detection_routine}
echo " par sh fr "                                          >> ${detection_routine}

# PART2: calculate the uncertainty on its normalisation to search for absolute minimum

echo " "                                                    >> ${detection_routine}
echo " system exe \"rm spex_lower_stat.com\" "              >> ${detection_routine}
echo " "                                                    >> ${detection_routine}
echo " err 1 8 no                            "              >> ${detection_routine}
echo " l e spex_lower_stat                   "              >> ${detection_routine}
echo " par 1 8 no s t                        "              >> ${detection_routine}
echo " c                                     "              >> ${detection_routine}
echo " p                                     "              >> ${detection_routine}
echo " fit "                                                >> ${detection_routine}
echo " fit "                                                >> ${detection_routine}
echo " fit "                                                >> ${detection_routine}
echo " par sh fr "                                          >> ${detection_routine}
echo " "                                                    >> ${detection_routine}
echo " system exe \"rm spex_lower_stat.com\" "              >> ${detection_routine}
echo " "                                                    >> ${detection_routine}

# PART3: save output (fit parameters) in the file line_${width}kms_${i}_keV

echo "log out ${outdir}/line_${width}kms_${i}_keV o"        >> ${detection_routine}
echo "par sh fr"                                            >> ${detection_routine}
echo "log close out"                                        >> ${detection_routine}
echo " "                                                    >> ${detection_routine}
echo "system exe \"rm spex_lower_stat.com\"  "              >> ${detection_routine}
echo " "                                                    >> ${detection_routine}

fi

done

echo "The ${detection_routine} routine has been created."

#open ${detection_routine}

done

