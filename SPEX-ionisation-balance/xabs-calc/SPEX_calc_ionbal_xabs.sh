### Routine that uses SPEX/pion to calculate ionisation balance and heating/cooling rates
###
### Here it is applied to the time averaged SED of NGC 1313 X-1
###
### It loads the input SED spectrum (two column: energies in units of Rydberg and flux denisity in e.g. Jansky)
###
### SPEX is available here: https://www.sron.nl/astrophysics-spex
###
### Manual:   http://var.sron.nl/SPEX-doc/manualv3.02/manual.html
### Cookbook: http://var.sron.nl/SPEX-doc/cookbookv3.0/cookbook.html
### Minihelp: https://www.sron.nl/plugins/content/moskt/Browse.php?fDocumentId=87435
###
### xabsinput: https://spex-xray.github.io/spex-help/tools/xabsinput.html

### Step 0: make sure you know where SPEX is poiting (type e.g. "which spex" or "which xabsinput")
###
### xabsinput is pointing to /opt/spex/bin/xabsinput
### spex      is pointing to /opt/spex/bin/spex
###
### Step 1: choose option "3", which adopts SPEX/pion code instead of Cloudy (1) or XSTAR (2) to calculate ion-bal
###
### Step 2: define name for the input SED file (see above)
###
### Step 3: a file containing the abundances, it can be empty if the abundances are adopted to be Solar (Lodders+2009)
###
### Step 4: the directory where the results of each iteration and the final ionbal file are saved
###
### Step 5: the last input of xabsinput is the directory where SPEX is poiting.
###
### xabsinput will iterate over log_xi from -8.5 to +6.5 with a step of log_xi = 0.1
### at the lowest log_xi (e.g. from )
###
### IMPORTANT: To have a sufficiently broad energy band, xabsinput adds a value of 10^{-10} at energies of 10^{-8} and 10^9 Ryd. 
###            Take care that the SED scaling would essentially imply 10^{-10} to be a very small value. 
###            The energies in the file should be in increasing order, and within the 10^{-8} and 10^9 Ryd interval.
###
### WARNING: The SED for PION calculation must have NO MORE THAN 1024 POINTS (when using Mac-related SPEX and some Linux release. 
###          otherwise you might incur in the following segment fault (forrtl: severe (174): SIGSEGV) and PION crashes.


SED=SED_ngc1313_Ry_Jy_ge1024bin.dat
ABU=abundances.txt

mkdir xabs_results

xabsinput<<EOF
3
${SED}
${ABU}
./xabs_results
/opt/spex/bin/spex
EOF

### Note: at this stage, should have xabsinput run correctly you'll see the following files:
###
### - file.dat containing the SED but converted to a model file spectrum that was used by SPEX/pion
### - xabs_results/column...dat files containing the ionic distribution for each log_xi value
### - xabs_inputfile which is the actual ionisation balance file and ionic fractionation

### let's move the file.dat SED file to the xabs_results directory as it's a product of the xabsinput run

mv file.dat xabs_results/

### Note: for some (very low) values of log_xi (e.g. -8.5 to -5.5) the equilibrium cannot be calculated,
###       in which case xabsinput would have returned a "**********" and saved as kT in the xabs_inputfile file
###
### The commands below show how to correct the file, which is necessary in order to use it into SPEX/xabs model
###
### Substitute bad points "**********" (non equilibrium) with low kT sequence "     0.100"
###
### Two alternative ways of correcting the xabs_inputfile file (photoionisation equilibrium SPEX input)
### are provided in case either "sed" or "awk" do not work. In Linux you may have to add the option "-i" in sed.

cd xabs_results/

 awk '{sub(/\*\*\*\*\*\*\*\*\*\*/,"\     0.100")}5' xabs_inputfile > temp1.txt && mv temp1.txt xabs_inputfile_corr1

 sed 's/\*\*\*\*\*\*\*\*\*\*/\ \ \ \ \ 0.100/g' xabs_inputfile > temp2.txt && mv temp2.txt xabs_inputfile_corr2

cd ..

echo "Calculation is done, check files: xabs_inputfile, xabs_inputfile_corr1/2"

echo "In order to use it in SPEX you can type 'par sec comp col av PATH-TO-FILE/xabs_inputfile_corr1' "
echo "                      where 'sec' is the sector number and 'comp' is the xabs component number. "

### Cut the first part of the (corrected) xabs_inputfile to plot the ionisation balance with PYTHON
###
### this creates the file xabs_inputfile_corr1_cut.dat containing only the (xi,kT) pairs.

cd xabs_results/

sed -n -e '1,151p' xabs_inputfile_corr1 > xabs_inputfile_corr1_cut.dat

cd ..

echo "The file xabs_inputfile_corr1_cut.dat can be used to plot log_xi VS kT (ionbal and S-curves)."
