### This code can be loaded into SPEX with the command: log exe EPIC_fit
###
### It loads the EPIC spectrum, plot the data, ..
### .. creates a continuum model and fit it to the data
### "#" identifies commented lines that the code will ignore
###
### All the commands can also be individually copied/edited and pasted in the terminal
### Remember to save your work into new .com files !!!
###
### SPEX is available here: https://www.sron.nl/astrophysics-spex
###
### Manual:   http://var.sron.nl/SPEX-doc/manualv3.02/manual.html
### Cookbook: http://var.sron.nl/SPEX-doc/cookbookv3.0/cookbook.html
### Minihelp: https://www.sron.nl/plugins/content/moskt/Browse.php?fDocumentId=87435
###
### See SPEX site for exercises, other documentation and the code
###
### The spectra must be converted to SPEX format from OGIP via TRAFO
### before loading the spectra and their responses into SPEX
###
### Here we show how to fit the X-ray spectrum (e.g. XMM/EPIC-pn) of a bright X-ray
### source, such as an X-ray binary or ULX found in a nearby (2 Mpc) galaxy,
### assuming a powerlaw continuum corrected for redshift and interstellar absorption.
### Further steps below show how to add blackbody and other components.
###                                                                                                      
###    IMPORTANT: SPEX is an automatically parallelised code which will use all CPU available!
###    If you want to chose the number of cores (parallelisaiton), before opening SPEX run the following:
###    export OMP_NUM_THREADS=4                                                                          
###    echo "SPEX: choosing number of cores / threads = ${OMP_NUM_THREADS}"                              

### Step 1: load the data (spectrum.spo and response.res) and remove useless bins

 da response spectrum

 data show

 ign ins 1  0:0.3 u ke
 ign ins 1 10:100 u ke

### Step 2: plot the data, here we also define the axes range
 
 p de xs
 p ty da
 p ux ke
 p uy fke
 p x lo
 p y lo
 p rx 0.3 10
 p ry 1e-2 100
 p 
 
 p cap id text "This is the id title of the plot"
 plot cap ut disp f
 plot cap lt disp f
 
 p se al
 p da lw 3
 p mo lw 5
 p box lw 3
 p cap y lw 3
 p cap it lw 3
 p cap x lw 3
 p
 
### Step 3: adopt a distance for your source, e.g. 1.9 Megaparsec
  
 dist 2 mpc

### Step 4: create a model of powerlaw corrected by the source redshift (e.g. 0.000474)
### the powerlaw is also absorbed by neutral gas (our Galaxy + intrinsic to the source)
### See https://ned.ipac.caltech.edu/forms/byname.html for distance and redshift
### We chose: Model = redshift * absorber * powerlaw
### Relate powerlaw to redshift and absorption with "com rel 3 1,2"
 
 com red
 com hot
 com po
 com rel 3 1,2
 
 model show

### Define some parameters for the components, limit their range of value
### ... or freeze the parameters
### "parameter sector component acronym status frozen "
### Freeze the temperature of the (quasi-neutral) gas to 1e-5 keV
### Range the slope of the powerlaw between 1 and 5 (if beyond them is not physical)
 
 par 1 1 z v 0.000474
 
 par 1 1 z status frozen
 
 par 1 2 nh v 1e-3
 par 1 2 t  r 1e-5 1
 par 1 2 t  v 1e-5
 par 1 2 t  s f
 
 par 1 3 no v 20000
 par 1 3 ga r 1 5
 par 1 3 ga v 2

### Step 5: choose fitting details and the luminosity range
###
### Tell the code to plot each fit iteration (fit print 1)
### Choose between C-statistics (fit meth cs) or Chi-square (fit meth clas)
### Evaluate fluxes and luminosities in the 0.3 - 10 keV band (elim 0.3:10 ke)
 
 fit print 1
 fit meth cs
 elim 0.3:10 ke

### Step 6: Calculate, plot, and fit the model:
###
### Important: it is a good practic to first calculate the model and chose
### a starting order of magnitude for the normalisations which makes sense
### just to avoid that the fit goes crazy (although a proper errors search
### would fix any issues from getting stuck into local minima later on).

 c
 f
 p

### SPEX will show all fit parameters after the fit is done, however you can
### just show the free parameters of the model by typing: "par show free"

### Step 7: Save the plot into a postscript file
### open as a 2nd devide: CPS, save plot into a file and close it

 plot de cps model_name.ps
 plot
 plot clo 2
 
### To save the model parameters type: "par wri model_name".
### The code will write a file model_name.com
### that can be loaded with the command: "log exe model_name"
### then you will need to type "calc" and "plot" to evaluate and plot it.

### In the following lines there are some useful exercises that I invited you to try
### by uncommenting each lines or simply compy and paste each line into the terminal.

### Step 8: Calculate 1 sigma (68%) uncertainties on some parameters e.g. the powerlaw slope (gamma):
# 
# error 1 3 gamm
# 
### if a lower chi-square (or c-stat) is found then the code will save a new model
### in the file "spex_lower_stat.com". Load this file with "log exe spex_lower_stat",
### thaw (i.e. free) the parameter "par 1 3 gamm s t" and fit again!

### Step 9: to add another component e.g. blackbody (bb) careful with a LOW starting normalization!
# 
# com bb
# com rel 4 1,2
# par 1 4 no v 1e-5 
# par 1 4 t  v 1
# par 1 4 t  r 0.1 10

### Step 10: local spectral features and lines?
### If you want to make a more detailed plot with a new frame for the residuals
### (deviations between the data and the model) then uncomment the following lines:
#
# plot frame new 
# plot frame 2
# plot type chi
# p ux ke
# p x lo
# p ry -5 5
# p rx 0.3 10
# plot view default f 
# plot cap id disp f
# plot cap ut disp f
# plot cap lt disp f
# plot view y 0.1:0.5
# plot view x 0.07:0.953
# p da lw 3
# p mo lw 5
# p box lw 3
# p cap y lw 3
# p cap it lw 3
# p cap x lw 3
# p frame 1
# plot view default f 
# plot view y 0.5:0.9
# plot view x 0.07:0.953
# plot cap x dis f
# plot box numlab bottom f
# p
