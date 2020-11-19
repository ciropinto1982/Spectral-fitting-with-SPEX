#!/bin/ksh

echo "This code reads the list of sources and for each of them runs SPEX in loop."

########################################## ROUTINE DESCRIPTION #######################################################
####                                                                                                              ####
#### This script runs SPEX over different sources and combinations of AMOL comounds, the basic code does this:    ####
####                                                                                                              ####
#### 1) Read the source names from a list stored inside an ascii file: source name is equal to spectrum file name ####
####                                                                                                              ####
#### 2) For each it creates a file where all results will be collected and also individual files of each fit      ####
####                                                                                                              ####
#### 3) For each it creates a grid of AMOL compound combinations that can change and are stored in a SPEX routine ####
####                                                                                                              ####
#### 4) For each it opens SPEX, load data and continuum model (a previously made setup file : source_name.com)    ####
####             then it loaded the AMOL grid routine into SPEX and fit in series all the combinations defined    ####
####             then it saved the bestfit model of each combination and the corresponding free parameters        ####
####                                                                                                              ####
#### 5) For each it reads the result from any single iteration alphabetically and stored them in the result file  ####
####                                                                                                              ####
######################################################################################################################

########################################### DEFINE DIRECTORIES #######################################################

DIR_home=$PWD # To tell where you are and where this routine will start from and will come back to (current directory)

mkdir ${DIR_home}/dir_fitting/amol_models

mkdir ${DIR_home}/dir_fitting/amol_result

DIR_models=${DIR_home}/dir_fitting/amol_models # Directory with new AMOL models from individual fits

DIR_result=${DIR_home}/dir_fitting/amol_result # Directory with new results from individual fits

DIR_oldmod=${DIR_home}/dir_fitting/RGS_models  # Directory with prefitted continuum/hot models

############################################ 1) SOURCE LIST ##########################################################

index=0  # Random index to associate the values read from the lists to a certain variable

for i in `cat $PWD/list_of_sources.txt`       # Read source name from the list of sources
 do
 SRC[index]=$i
# echo "Loading source name ${SRC[$index]}"   # Uncomment to show source names
 index=$(($index+1))
 done

index=0  # Re-start the index to read the next list and associate items to variable array

############################################ OTHER PARAMETERS ########################################################
#
# Uncomment the following lines if you need to load special parameters from file lists such as NH and distance
#
# for i in `cat $PWD/list_of_distances.txt`     # Read list of source distance (kpc) or redshifts
#  do
#  Z[index]=$i
##  echo "Loading source name ${SRC[$index]} with distance ${Z[$index]} kpc" # Uncomment to show name and distance
#  index=$(($index+1))
#  done
#
# index=0
#
# for i in `cat $PWD/list_of_NH.txt`            # Read list of column density (start value or adopted value)
#  do
#  NH[index]=$i
## echo "Loading source name ${SRC[$index]} with distance ${Z[$index]} kpc and NH ${NH[$index]} 1e20cm**-2"
#  index=$(($index+1))
#  done
#
# index=0
#
################################################## START LOOP ########################################################

for i in `cat $PWD/list_of_sources.txt` # Read source name from the list of sources
 do

ID_start=0                # Number of the source before which to skip the analysis default 0
ID_stop=4                 # Number of the source after which to stop the analysis default 4

 if [ ${index} -lt ${ID_start} ] || [ ${index} -gt ${ID_stop} ]   # IF statement: skip sources above
 then

 echo "Skipping source number ${index}: ${SRC[$index]}"

 else

 echo "Analysin source number ${index}: ${SRC[$index]}"

# echo "Go to the fitting directory: ${DIR_home}/dir_fitting"

cd ${DIR_home}/dir_fitting

SPEX_SETUP_FILE=${SRC[$index]} # loading e.g. source_name_sector.com

# echo "Read SPEX executable file (to load data and continuum model): `ls ${SRC[$index]}.com`"

################# 2) CREATING FILE TO COLLECT RESULTS (updated after each iteration) #################################

SPEX_RESULT_FILE=${DIR_home}/dir_fitting/${i}.txt

echo  "# Iter-N C-Stat #" >  ${SPEX_RESULT_FILE}
echo  " "                 >> ${SPEX_RESULT_FILE}

############################### 3) CREATING LOOP OVER DIFFERENT AMOL MODELS ##########################################

SPEX_AMOLS_FILE=${DIR_home}/SPEX_amol_executable.com

echo  "### spex executable file that runs line search routine ###" >  ${SPEX_AMOLS_FILE}
echo  "### This routine is created by SPEX_fitting_routine.sh ###" >> ${SPEX_AMOLS_FILE}
echo  " "                                                          >> ${SPEX_AMOLS_FILE}

AMOL_ID=(126 2010 3103 4103) # Define AMOL available IDs to use in the grids

AMOL_ST=(thawn frozen) # Define status (thawn or frozen) for each compound

AMOL_NH=(1.0E-9 0)    # Define starting NH (0 or 1.0E-9) for each compound

iteration=0

for ii in {0..0}        # Loop on 1st AMOL compound
 do

 for jj in {1..1}       # Loop on 2nd AMOL compound
  do

  for ll in {2..2}      # Loop on 3rd AMOL compound
   do

   for mm in {3..3}     # Loop on 4th AMOL compound
    do

    for st_nh in {0..1} # Loop over free (and NH >0) or frozen (and NH==0)
     do

echo "This is iteration number: ${iteration}"

# echo It is more safe to first load a predefined model manually fitted before starting every iteration
# echo Should one fit break up then the next ones will not break too as the continuum is always reloaded

echo  " log exe ${DIR_oldmod}/${i}_PBH               "                  >> ${SPEX_AMOLS_FILE}
echo  " log exe ${DIR_oldmod}/${i}_PBH_abunfree      "                  >> ${SPEX_AMOLS_FILE}
echo  " log exe ${DIR_oldmod}/${i}_PBH_abunfree_amol "                  >> ${SPEX_AMOLS_FILE}
echo  " "                                                               >> ${SPEX_AMOLS_FILE}

# echo Updating the AMOL indexes, free/frozen ones, update plot title and obtain a zeroth order fit:

echo "AMOL combination 1-to-4 = ${AMOL_ID[ii]} ${AMOL_ID[jj]} ${AMOL_ID[ll]} ${AMOL_ID[mm]} "

echo  " par 1 4 n1 s ${AMOL_ST[st_nh]} "                                >> ${SPEX_AMOLS_FILE}
echo  " par 1 4 n2 s ${AMOL_ST[st_nh]} "                                >> ${SPEX_AMOLS_FILE}
echo  " par 1 4 n3 s ${AMOL_ST[st_nh]} "                                >> ${SPEX_AMOLS_FILE}
echo  " par 1 4 n4 s ${AMOL_ST[st_nh]} "                                >> ${SPEX_AMOLS_FILE}
echo  " par 1 4 n1 v ${AMOL_NH[st_nh]} "                                >> ${SPEX_AMOLS_FILE}
echo  " par 1 4 n2 v ${AMOL_NH[st_nh]} "                                >> ${SPEX_AMOLS_FILE}
echo  " par 1 4 n3 v ${AMOL_NH[st_nh]} "                                >> ${SPEX_AMOLS_FILE}
echo  " par 1 4 n4 v ${AMOL_NH[st_nh]} "                                >> ${SPEX_AMOLS_FILE}
echo  " "                                                               >> ${SPEX_AMOLS_FILE}

# echo "AMOL index available ${AMOL_ID[$ii]}" # Show which compound is assigned to AMOL INDEX 1
# echo "AMOL index available ${AMOL_ID[$jj]}"
# echo "AMOL index available ${AMOL_ID[$ll]}"
# echo "AMOL index available ${AMOL_ID[$mm]}"

OUTOUT_models=${DIR_models}/models_${i}_iter_${iteration}_${AMOL_ID[ii]}_${AMOL_ID[jj]}_${AMOL_ID[ll]}_${AMOL_ID[mm]}

OUTOUT_result=${DIR_result}/result_${i}_iter_${iteration}_${AMOL_ID[ii]}_${AMOL_ID[jj]}_${AMOL_ID[ll]}_${AMOL_ID[mm]}

# echo Updating the AMOL indexes, show in the plot title and obtain a zeroth order fit:

echo  " sys exe \" echo loading amol component i1 = ${AMOL_ID[ii]} \" " >> ${SPEX_AMOLS_FILE}
echo  " sys exe \" echo loading amol component i2 = ${AMOL_ID[jj]} \" " >> ${SPEX_AMOLS_FILE}
echo  " sys exe \" echo loading amol component i3 = ${AMOL_ID[ll]} \" " >> ${SPEX_AMOLS_FILE}
echo  " sys exe \" echo loading amol component i4 = ${AMOL_ID[mm]} \" " >> ${SPEX_AMOLS_FILE}
echo  " "                                                               >> ${SPEX_AMOLS_FILE}
echo  " par 1 4 i1 v ${AMOL_ID[ii]} "                                   >> ${SPEX_AMOLS_FILE}
echo  " par 1 4 i2 v ${AMOL_ID[jj]} "                                   >> ${SPEX_AMOLS_FILE}
echo  " par 1 4 i3 v ${AMOL_ID[ll]} "                                   >> ${SPEX_AMOLS_FILE}
echo  " par 1 4 i4 v ${AMOL_ID[mm]} "                                   >> ${SPEX_AMOLS_FILE}
echo  " "                                                               >> ${SPEX_AMOLS_FILE}
echo  " pl cap ut dis f "                                               >> ${SPEX_AMOLS_FILE}
echo  " pl cap lt dis t "                                               >> ${SPEX_AMOLS_FILE}
echo  " pl cap lt text \" ${AMOL_ID[ii]} ${AMOL_ID[jj]} ${AMOL_ID[ll]} ${AMOL_ID[mm]} \" " >> ${SPEX_AMOLS_FILE}
echo  " ca "                                                            >> ${SPEX_AMOLS_FILE}
echo  " pl "                                                            >> ${SPEX_AMOLS_FILE}
echo  " "                                                               >> ${SPEX_AMOLS_FILE}
echo  " fit print 1 "                                                   >> ${SPEX_AMOLS_FILE}
echo  " cal         "                                                   >> ${SPEX_AMOLS_FILE}
echo  " fit         "                                                   >> ${SPEX_AMOLS_FILE}
#echo  " fit         "                                                   >> ${SPEX_AMOLS_FILE}
#echo  " fit         "                                                   >> ${SPEX_AMOLS_FILE}
echo  " par sh fr   "                                                   >> ${SPEX_AMOLS_FILE}
echo  " "                                                               >> ${SPEX_AMOLS_FILE}

# echo Now save the fitted model and calculate error bars to improve fit:

echo  " par wri ${OUTOUT_models} over "                                 >> ${SPEX_AMOLS_FILE}
echo  " "                                                               >> ${SPEX_AMOLS_FILE}

# echo Uncomment the following lines if you want to run the error calc
#
# echo Note: that if you set NH and Status with index above (e.g. par 1 4 n1 s ${AMOL_ST[st_nh]}) then
# echo       it wont run the error calculation and no time would be wasted. You can do it for all compounds

# echo  ' sys exe "rm spex_lower_stat.com" '                            >> ${SPEX_AMOLS_FILE}
# echo  "  "                                                            >> ${SPEX_AMOLS_FILE}
# echo  " error 1 4 n1 "                                                >> ${SPEX_AMOLS_FILE}
# echo  " "                                                             >> ${SPEX_AMOLS_FILE}
# echo  " l e spex_lower_stat "                                         >> ${SPEX_AMOLS_FILE}
# echo  " cal         "                                                 >> ${SPEX_AMOLS_FILE}
# echo  " pl "                                                          >> ${SPEX_AMOLS_FILE}
# echo  " par 1 4 n1 s ${AMOL_ST[st_nh]} "                              >> ${SPEX_AMOLS_FILE}
# echo  " fit         "                                                 >> ${SPEX_AMOLS_FILE}
# echo  " fit         "                                                 >> ${SPEX_AMOLS_FILE}
# echo  " fit         "                                                 >> ${SPEX_AMOLS_FILE}
# echo  " par sh fr   "                                                 >> ${SPEX_AMOLS_FILE}
# echo  "                                   "                           >> ${SPEX_AMOLS_FILE}
# echo  ' sys exe "rm spex_lower_stat.com"  '                           >> ${SPEX_AMOLS_FILE}
# echo  " "                                                             >> ${SPEX_AMOLS_FILE}

# echo Now save the finals results (if you like re-calculate error bars):

echo  " log output ${OUTOUT_result} over  "                             >> ${SPEX_AMOLS_FILE}
echo  " par sh fr "                                                     >> ${SPEX_AMOLS_FILE}
echo  " log close output "                                              >> ${SPEX_AMOLS_FILE}
echo  " "                                                               >> ${SPEX_AMOLS_FILE}

iteration=$(($iteration+1)) # updating iteration number for each AMOL combination

done
done
done
done
done

echo "All AMOL level 2 commands in ${SPEX_AMOLS_FILE}"

######################################## 4) IT IS TIME TO RUN SPEX! ##################################################

# echo Uncomment the following lines to run SPEX (load setup file and AMOL grid routine)
#
#SPEX_AMOLS_FILE=${DIR_home}/SPEX_amol_executable
#
#spex<<EOF
#
# sys exe "echo SPEX is loading the file ${SPEX_SETUP_FILE}.com"
#
# log exe ${SPEX_SETUP_FILE}
#
# sys exe "echo SPEX is loading the file ${SPEX_AMOLS_FILE}.com"
#
# log exe ${SPEX_AMOLS_FILE}
#
# quit
#
#EOF

########################################## 5) COLLECTING ALL RESULTS #################################################

 echo "Searching for individual results in ${DIR_result}"

 iteration_rr=0

 for rr in `ls ${DIR_result}/result_${i}_*`
  do

 CSTAT=`sed '/C-statistic       :/!d'  ${rr}`

 echo " " ${iteration_rr} " "  ${CSTAT:24:12}
 echo " " ${iteration_rr} " " "${CSTAT:24:12}"  >> ${SPEX_RESULT_FILE}

 iteration_rr=$(($iteration_rr+1)) # updating iteration number while reading results

 done

################################################ FINISH OFF ##########################################################

cd ${DIR_home}      # go back to start directory (where this routine is launched)
  
  fi

index=$(($index+1)) # updating source number after every iteration

  done

######################################### END OF THE MAIN COMMANDS ###################################################
