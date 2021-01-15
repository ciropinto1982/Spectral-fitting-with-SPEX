#!/bin/ksh

##################################################################################################################
###
### INFO: bash script that runs line-detection routine in SPEX (created earlier by unix_detection_routine_make.sh)
###
### - open SPEX, load data and bestfit continuum model    (i.e. spex_continuum_model_fit.com)
### -            run the line detection routine available (e.g. spex_det_routine_w1000kms.com)
### -            this creates a "*.out" file for each energy centroid and line width adopted
### - read all SPEX results "*.out" for each line width into a single "*.txt" file with bash "sed" command
###
##################################################################################################################

home_dir=$PWD                                        # Launching directory

mkdir linegrid                                       # Create directory where saving the SPEX outputs

work_dir=${home_dir}                                 # DIR where SPEX will be executed

read_dir=${home_dir}/linegrid                        # DIR where SPEX outputs are to be read

out_dir=${home_dir}                                  # DIR where final table / results are saved

# To launch SPEX and run more detection routines: define Parallelisation parameters

number_of_cores=4

export OMP_NUM_THREADS=${number_of_cores}

echo "choosing number of cores / threads=${OMP_NUM_THREADS}"

# Defining directories and startup files

startup_spex_continuum=${home_dir}/spex_continuum_model_fit  # SPEX startup (load data and continuum model)

startup_spex_model=${home_dir}/spex_model_RHPBD2LG     # SPEX startup model (useful if at some point fit breaks up)

detection_routine_dir=${home_dir}                      # DIR where we have put the line-edtection routine

# Define routine and run SPEX

for width in 1000          # Gaussian FWHM, try first on one before the default values: 100 250 500 1000 (... km/s)
 do

detection_routine=${detection_routine_dir}/spex_det_routine_w${width}kms # Note ".com" is removed for SPEX input

echo "Running SPEX detection routine for width = ${width} km/s"

cd ${work_dir}

spex<<EOF

l e ${startup_spex_continuum}

sys exe "echo Adding a gaussian component (to correct for redshit, i.e. in the AGN rest-frame, uncomment: com rel 8 1)"

com gau
#com rel 8 1

par 1 8 ty   v 0
par 1 8 e    v 7
par 1 8 e:fw s f
par 1 8 norm r -1e10 +1e10
par 1 8 norm v 1e4
c
p
par sh fr

### Load starteup G-model if available i.e. ${startup_spex_model}(.com) and/or create it

#l e ${startup_spex_model}

par wri ${startup_spex_model} over

## Load the routine detection

l e ${detection_routine}
quit
EOF

cd ${home_dir}

# Read all results (linegrid) into a file for each line width

output_file=${out_dir}/results_gaus_${width}kms.txt

echo "# Energy C-STAT  Norm " >  ${output_file}

for i in `cat ${home_dir}/Log_E_grid_0310keV_${width}kms.txt`
 do

if [ ${i} -lt 0.4 ] || [ ${i} -gt 10.0 ]        # Default: [ ${i} -lt 0.4 ] || [ ${i} -gt 10.0 ]
then
        # echo "Energy ${i} out of range 0.4-10.0 keV"
    x=0 # Random command is necessary if text above gets commented!
else

energy=$(($i))

input_file=${read_dir}/line_${width}kms_${i}_keV.out

  if [ ! -f "${input_file}" ]
   then
            # echo "${input_file} does not exists"
        x=0 # Random command is necessary if text above gets commented!
   else
   
     CSTAT=`sed '/C-statistic       :/!d'       ${input_file}`
     GNORM=`sed '/1    8 gaus norm Norm /!d'    ${input_file}`

     echo ${i} ${CSTAT:20:20} ${GNORM:38:16}
     echo ${i} ${CSTAT:20:20} ${GNORM:38:16} >> ${output_file}

### ERROR=`sed '/Errors:/!d' ${input_file}` # This is OK only if the Gaussian normalisation was saved
###
### echo ${i} ${CSTAT:20:20} ${ERROR:26:14} ${ERROR:48:14} ${ERROR:64:14}
### echo ${i} ${CSTAT:20:20} ${ERROR:26:14} ${ERROR:48:14} ${ERROR:64:14} >> ${output_file}

  fi

fi

done

echo "Done: Gaussian line scan has been saved in file: ${output_file}"

done
