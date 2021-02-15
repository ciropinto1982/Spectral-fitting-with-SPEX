### Routine that uses SPEX/pion to calculate ionisation balance and heating/cooling rates
###
### Here it is applied to the time averaged SED of NGC 1313 X-1
###
### It loads the input SED spectrum (two column in units of keV, phot/s/keV)
### SED must be a SPEX model file, it requires a number in 1st line indicating the number of rows (keV,flux) pairs
###
### SPEX is available here: https://www.sron.nl/astrophysics-spex
###
### Manual:   http://var.sron.nl/SPEX-doc/manualv3.02/manual.html
### Cookbook: http://var.sron.nl/SPEX-doc/cookbookv3.0/cookbook.html
### Minihelp: https://www.sron.nl/plugins/content/moskt/Browse.php?fDocumentId=87435

### Step 1: define name for the input SED file (1 header line, then two column in units of keV, phot/s/keV)
###         define name for the output file containint the xi-T balance and the H-C rates
###         and create directory "pion_results" to save individual steps for each xi value

SED="SED_ngc1313_keV_PhotskeV.dat"

pion_HC_rates="pion_HC_rates.dat"

mkdir pion_results

### Step 2: add one row as header to the output file

echo "# Log_xi Tempe (keV) CS (kms) H:Compton_s H:free-free H:photo-ele H:Compton_i H:Auger_ele C:iCompton  C:elec_ion  C:recombina C:free-free C:coll-ion  Tot_heating Tot_cooling" >  ${pion_HC_rates}
echo "                                                         " >> ${pion_HC_rates}

### Step 3: SPEX "for" loop over several (log) xi values

xi_min=-6.5 # Define the range of log_xi values
xi_max=+6.5
xi_step=0.1

for xi_loop in $(seq ${xi_min} ${xi_step} ${xi_max})
do

i=`printf '%.*f\n' 1 ${xi_loop}`   # round log_xi value to 1 digit in Linux

echo "Assuming Log xi=" ${i}

spex<<EOF

com file
com pion
com rel  1 2

### Loading Spectral Energy Distributio in SPEX format

par 1 1 file av ${SED}

par 1 1 norm v 1

### Assuming a certain distance, for NGC 1313 it is about 4 Mpc

dist 4 Mpc

### Update Photoionised abdorber paramerets

par 1 2 xi range  ${xi_min} ${xi_max}
par 1 2 xi v      ${i}

### Choose the volume (or electron) density (in units of 10^20 m^-3 or 10^14 cm^-3)

par 1 2 hden v 1e-8

c

### Some times you might find the following error:
###
### Error nr   2 occurred in process:  40 (condec    )
### Errors are usually caused by inappropriate model parameters.
### Further results are unpredictable (no proper model is calculated)
### Adjust your parameters and retry.
### For fits or error searches, problems may be solved by restricting the allowed range
### If no hint is given below, please contact the SPEX developers
### No equilibrium solution is possible
### Perhaps too much Compton heating?
### Try cutting the hardest part of the spectrum
###
### This means that for some bad parameter values equilibrium cannot be calculated.

### Save output (heating / cooling rates and plasma characteristics)
###             into a file pion_results/pion_plasma_logxi_${i}.out (ascii)

log output pion_results/pion_plasma_logxi_${i} over
par sh fr
asc ter 1 2 plas
asc ter 1 2 heat
log close output

q
EOF

### Step 4: read SPEX results from the individual (log) xi value and append them to the output file
###
###         more physical processes might be available in the SPEX files and can be manually added here.
###         in this example the 10 dominant processes and the total H-C rates are read and copied.

echo "Reading and appending the results for Log xi=" ${i}

log_xi=`grep '1    2 pion xil'      pion_results/pion_plasma_logxi_${i}.out | awk '{print $9}'`
te_keV=`grep 'Electron temperature' pion_results/pion_plasma_logxi_${i}.out | awk '{print $4}'`

cs=`grep 'Sound speed' pion_results/pion_plasma_logxi_${i}.out | awk '{print $4}'`

HCS=`grep 'Heating by Compton scattering        :' pion_results/pion_plasma_logxi_${i}.out | awk '{print $6}'`
HFF=`grep 'Heating by free-free absorption      :' pion_results/pion_plasma_logxi_${i}.out | awk '{print $6}'`
HPE=`grep 'Heating by photo-electrons           :' pion_results/pion_plasma_logxi_${i}.out | awk '{print $5}'`
HCI=`grep 'Heating by Compton ionisation        :' pion_results/pion_plasma_logxi_${i}.out | awk '{print $6}'`
HAE=`grep 'Heating by Auger electrons           :' pion_results/pion_plasma_logxi_${i}.out | awk '{print $6}'`
CIC=`grep 'Cooling by inverse Compton scattering:' pion_results/pion_plasma_logxi_${i}.out | awk '{print $6}'`
CEI=`grep 'Cooling by electron ionisation       :' pion_results/pion_plasma_logxi_${i}.out | awk '{print $6}'`
CRR=`grep 'Cooling by radiative recombination   :' pion_results/pion_plasma_logxi_${i}.out | awk '{print $6}'`
CFF=`grep 'Cooling by free-free emission        :' pion_results/pion_plasma_logxi_${i}.out | awk '{print $6}'`
CCE=`grep 'Cooling by collisional excitation    :' pion_results/pion_plasma_logxi_${i}.out | awk '{print $6}'`
CDR=`grep 'Cooling by dielectronic recombination:' pion_results/pion_plasma_logxi_${i}.out | awk '{print $6}'`
CAE=`grep 'Cooling by adiabatic expansion       :' pion_results/pion_plasma_logxi_${i}.out | awk '{print $6}'`

HTOT=`grep 'Total heating                        :' pion_results/pion_plasma_logxi_${i}.out | awk '{print $4}'`
CTOT=`grep 'Total cooling                        :' pion_results/pion_plasma_logxi_${i}.out | awk '{print $4}'`

echo $log_xi $te_keV $cs $HCS $HFF $HPE $HCI $HAE $CIC $CEI $CRR $CFF $CCE $HTOT $CTOT >> ${pion_HC_rates}

done

echo "SPEX pion-balance calculation is done, check file: ${pion_HC_rates}"
