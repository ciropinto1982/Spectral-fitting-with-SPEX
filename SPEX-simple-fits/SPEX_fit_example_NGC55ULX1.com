########################################## SCRIPT DESCRIPTION ######################################################
###                                                                                                              ###
### A basic SPEX continuum modelling of the XMM-Newton/EPIC-pn spectrum of NGC 55 ULX-1 (observation 0655050101) ###
###                                                                                                              ###
### The detailed XMM data reduction and spectra-to-SPEX formatting for the 0655050101 can be found here:         ###
### https://github.com/ciropinto1982/XMM-Newton-Data-Reduction/blob/main/XMM_data_reduction_single.sh            ###
###                                                                                                              ###
### 1) Load the data (response matrix and background-subtracted source spectrum formatted to SPEX via trafo)     ###
###                                                                                                              ###
### 2) Open plotting window (XQuartz on Mac / X-Windows on Linux) and plot the data in desired (in S.I.) units   ###
###                                                                                                              ###
### 3) Create spectral continuum model of emission components corrected by redshift and Galactic absorption      ###
###                                                                                                              ###
### 4) Fit the data with the adopted model, save each model parameters in other ".com" files for quick loading   ###
###                                                                                                              ###
### 5) Calculate the uncertainties on specific parameters, check other models and save windows into PS plots     ###
###                                                                                                              ###
### NOTE 1: "#" identifies commented lines that the code will ignore                                             ###
### NOTE 2: SPEX recognises simplified commands e.g. "plot type data" -> "p ty da" to speed typing up!           ###
### NOTE 3: SPEX is not case-sensitive. "plot ty da" and "PLOT TY DA" are equivalent commands                    ###
###                                                                                                              ###
###    If you want to chose the number of cores (parallelisaiton), before opening SPEX run the following:        ###
###    export OMP_NUM_THREADS=4                                                                                  ###
###    echo "SPEX: choosing number of cores / threads = ${OMP_NUM_THREADS}"                                      ###
###                                                                                                              ###
###    SPEX is available here: https://www.sron.nl/astrophysics-spex                                             ###
###    Manual:   http://var.sron.nl/SPEX-doc/manualv3.02/manual.html                                             ###
###    Cookbook: http://var.sron.nl/SPEX-doc/cookbookv3.0/cookbook.html                                          ###
###    Minihelp: https://www.sron.nl/plugins/content/moskt/Browse.php?fDocumentId=87435                          ###
###                                                                                                              ###
###    License: This public code was developed for and published in the paper Pinto et al. (2017),               ###
###    DOI: 10.1093/mnras/stx641, arXiv: 1612.05569, bibcode: 2017MNRAS.468.2865P.                               ###
###    You're recommended and kindly requested to refer to that paper when using this code,                      ###
###    especially since you might want to compare your results onto NGC 55 ULX-1 (XMM obsid: 0655050101)         ###
###                                                                                                              ###
###    IMPORTANT: SPEX is an automatically parallelised code which will use all CPU available!                   ###
###    If you want to chose the number of cores (parallelisaiton), before opening SPEX run the following:        ###
###    export OMP_NUM_THREADS=4                                                                                  ###
###    echo "SPEX: choosing number of cores / threads = ${OMP_NUM_THREADS}"                                      ###
###                                                                                                              ###
########################################## DATA MANAGEMENT #########################################################

### Step 1: load and manage the data (response and spectrum)
###
### The response file (.res) is entered first and then the file containing the spectrum (.spo).
### You can avoid confusion by giving the same filename to both .res and .spo files (just as done here).
### Remember that the order of the words in the commands is very important!

data PN_SRC_spec_grp25 PN_SRC_spec_grp25

### Show some basic details on the data e.g. exposure and SRC/BKG count rate to check data were loaded.

data show

### Ignore useless bins. In particular, EPIC is badly calibrated below 0.3 keV and above 10 keV.
###
### Because the data were already grouped there is no need to further binning it.
### Otherwise you could have rebinned here e.g. "obin ins 1 0.3:10 u keV" for the C-stat optimal binning

ign ins 1  0:0.3 u ke
ign ins 1 10:100 u ke

### Step 2: Open an X-Window and plot the data, choose color for SRC and BKG spectra
###
### First plot will be done in count rate Y-axis (phot/s/keV) and keV X-axis.
### We will show the background (p ba dis t) otherwise (p ba dis f)
### Note that in SPEX YES=TRUE=FREE=T and NO=FAULT=FROZEN=F
### Aestetical choices have been take for other things including the plot linewidths
### For different plot units see: http://var.sron.nl/SPEX-doc/manual/manualse99.html

p de xs
p ty da
p ux ke
p uy ke
p se 1
p ba dis t
p ba col 4
p mo col 2
p da col 1
p cap id text "NGC 55 ULX-1 : XMM-Newton/EPIC-pn (obsid:0655050101)"
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
p

### Let's plot in flux units (i.e. spectral shape) by correcting for the effective area
### and adopt a log-log scale to stretch the scale and better show the spectrum.
### This way we can see the important of the BKG above 5 keV which is obvious as the
### source NGC 55 ULX-1 is known to be very soft with a low flux above 2 keV.

p ux ke
p uy fke
p x lo
p y lo
p rx 0.3 10
p ry 1e-3 20
p

######################################## SPECTRAL CONTINUUM MODELLING ##############################################

### Step 3: adopt a distance of 2 Megaparsec (i.e. the distance of NGC 55 galaxy)
###
### IMPORTANT: for nearby (redshift < 0.01) sources do not use the hubble law but rather Cepheids (if available)
###            or other more accurate methods as local motions between the galaxies might be important.

dist 2 Mpc

### Step 4: create a model of blackbody emission corrected for source redshift (0.00043)
###         and absorbed by neutral gas (inside our Galaxy and in the NGC 55 galaxy or around the ULX)
###
### See https://ned.ipac.caltech.edu to search for known distances and redshifts
### Model = redshift * absorber * blackbody
### Relate blackbody to redshift and absorption with "com rel 3 1,2"
### IMPORTANT: in SPEX the words and models order is relevant!

com red
com hot
com bb
com rel 3 1,2

### Show adopted model and SPEX's default parameters

mod show
par show

### Define some parameters for the components, limit their range of value to some physical values
### especially for the temperatures or freeze the parameters (e.g. "par sec comp acro status frozen")
### Set and freeze the temperature of the (neutral) gas to 1e-4 keV (or lower) or it may be ionised
### The NH will hardly be higher than 1E+22 cm^-2 (= 1e-2 in SPEX units) or you wouldn't see any soft X-rays at all.
### The NH will hardly be lower than the HI value towards the NGC 55 galaxy (7.33E+20 cm^-2 = 7.33e-4 in SPEX units)
### see this website: https://heasarc.gsfc.nasa.gov/cgi-bin/Tools/w3nh/w3nh.pl
###
### Trick number 1 : you would never start a fit from some crazy parameters values. The parameter space is
###                  very complex and you might risk to get stuck in one of the many local minima, totally
###                  missing the bestfit, let alone a physically motivated set of model parameters.
###
### For instance, a blackbody area = 1E16 m**2 would be huge for an XRB or a ULX. Same for NH = 1E28 / m**2!
### We will start with T_BB = 0.5 keV as most flux is below 1 keV and Norm_BB = 1e-4 (SPEX units) or lower.

par 1 1 z v 0.00043
par 1 1 z s frozen

par 1 2 nh r 7.33e-4 1e-2
par 1 2 nh v 1e-3
par 1 2 t  r 1e-5 1e-2
par 1 2 t  v 1e-4
par 1 2 t  s f
par 1 2 nh s t
 
par 1 3 n v 1
par 1 3 t r 0.1 10
par 1 3 t v 0.5
par 1 3 n:t s t

### Calculate the model with the new parameters and over-plot it onto the spectrum, and estimate
### the observed (absorbed) flux & the intrinsic (unabsorbed) luminisity within the 0.3-10 keV range.
### Show them along with the current free model parameters:

elim 0.3:10 ke
calc
plot
par sh fr

### If the model does not appear in the plot, before fitting is good to try to change the normalisation manually
### (a few orders of magnitude higher or lower) and then re-calculate and plot. Alternatively fit the data and see
### what happens. In the worse case you can run the error calculation which may find the absolute minima (see below)

par 1 3 n v 1e-3
par 1 3 t v 0.3
cal
pl

### Step 5: choose fitting details, SPEX's default is C-stat over Classical Levenberg-Marquardt
###
### In particular, choose between C-statistics (fit stat cstat, SPEX default) or Chi-quare (fit stat chi2)
### Chose to plot each fit iteration (fit print 1) or not (fit print 0) and then you type "plot" at the end.

fit print 1
fit stat cstat
cal
plo

### Actually run fit: sometimes it might get stuck in local minima, in which case test typing more times "fit"
### and show the updated values of the free parameters at the end of the (single or multiple) fit run.

fit
fit
fit
par sh fr

### You can save the model parameters by typing "par wri model_name" such as "par wri model_RHB".
### SPEX will write ascii file named "model_name.com". Next time you to reload these parameters, you do not need
### to refit or to type each manually but simply type: "log exe model_name" without the ".com" extensio.
### IMPORANT: SPEX does not save the model defition (e.g. com component, com rel ...) but just parameter values!
###           also, SPEX does not "overwrite" existing mode files unless you type "par wri model_name overwrite"

par wri model_RHB

### Updating plot lower-title with model currently being used (to better distinguish among them):

p fr 1
p cap lt dis t
p cap lt text "SPEX model: model_RHB.com"
p

### Step 6: Save the plot into a postscript file (optional, open devide CPS, plot and close it)
###         You need to open a 2nd plotting device (PS), plot inside it, and CLOSE it (or you keep editing PS file!)
###         If you want to convert it into a PDF file via ps2pdf and open it you can run simple shell commands.
###         "open ...pdf" will work if your machine is set up to recognise and quickly open PDF files.

p de cps model_RHB.ps
p
p clo 2

# sys exe "ps2pdf model_RHB.ps"
# sys exe "  open model_RHB.pdf"

### At this stage you would have noticed that a single blackbody is not able to reproduce the whole spectrum,
### not even the overall broadband (0.3-10 keV) shape, with a clear hard excess in the data above 2 keV.

### Step 7: Add a 2nd plot frame to better visualise the residuals (different between data and model)

p frame new
p frame 2
p type chi
p ry -20 20
p rx 0.3 10
p view default f
p cap id disp f
p cap ut disp f
p cap lt disp f
p view y 0.1:0.38
p view x 0.07:0.953
p da lw 3
p mo lw 5
p box lw 3
p cap y lw 3
p cap it lw 3
p cap x lw 3
p x lo

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
p ry 1e-3 20
p rx 0.3 10
p

p de cps model_RHB.ps
p
p clo 2

# sys exe "ps2pdf model_RHB.ps"
# sys exe "  open model_RHB.pdf"

### Step 8: Add a second (hotter) continuum emission component, e.g. a 2nd blackbody
###         BB are commonly used when modelling soft spectra of high-luminosity XRB states.

com bb
com rel 4 1,2

par 1 4 n v 1e-6
par 1 4 t r 0.1 10
par 1 4 t v 1
par 1 4 n:t s t

cal
pl
par sh fr

fit
fit
fit
par sh fr

par wri model_RHB2

### Updating plot lower-title with model currently being used (to better distinguish among them):

p fr 1
p cap lt dis t
p cap lt text "SPEX model: model_RHB2.com"
p

### The 2 blackbody model provides a much better description of the spectrum (Cstat~Chi2~222, dof~96).
### Let's zoom on the residuals in frame 2.

pl frame 2
pl ry -5 5
pl

### Saving a new postscript file with the new bestfit (2 components):

p de cps model_RHB2.ps
p
p clo 2

# sys exe "ps2pdf model_RHB2.ps"
# sys exe "  open model_RHB2.pdf"

### The residuals appear mainly sharp, possibly due to the winds often detect in ULX deep RGS spectra.
### However there still seems to be a small hard excess, which is OK since ULXs can show very broad spectra
### with possibly 3 components or 2 components with the hard being very broad (super-Eddington disc).

### Step 8: Let's substitute the hot BB with a BB modified by coherent Compton scattering (MBB model). This is
###         faster and a better description than a diskBB (https://var.sron.nl/SPEX-doc/manualv3.05/manualse68.html)

com del 4
com mbb
com rel 4 1,2

par 1 4 n v 1
par 1 4 t r 0.1 10
par 1 4 t v 1
par 1 4 n:t s t

cal
pl
par sh fr

fit
fit
fit
par sh fr

par wri model_RHBM

### Updating plot lower-title with model currently being used (to better distinguish among them):

p fr 1
p cap lt dis t
p cap lt text "SPEX model: model_RHBM.com"
p

### Saving a new postscript file with the new bestfit (2 components):

p de cps model_RHBM.ps
p
p clo 2

# sys exe "ps2pdf model_RHBM.ps"
# sys exe "  open model_RHBM.pdf"

### The MBB provides only a small improvement to the fit (Cstat~Chi2~208, dof~96).
### This is likely due to the fact that the residuals are very sharp and from narrow spectral lines!
### Just like resolved in the RGS spectra of NGC 55 ULX-1 (see Pinto+2017).

### Exercise 1 : do you get any improvement if you substitute mbb with a disk blackbody (dbb)?
###
### Exercise 2 : do you get any improvement if you substitute mbb with a comptonisation (comt)?
###              to avoid degeneracy, couple comt's seed photon to TBB by "par 1 4 t0 cou 1 3 t"
###              note that ULXs are very soft, you'd start fitting with comt t1=1 and comt tau=1.
###
### Exercise 3 : calculate uncertainties on parameters e.g. on the NH: "err 1 2 nh"
###
### Exercise 4 : calculate the total X-ray luminosity (0.3-10 keV) and Ionising luminosity (13.6 eV - 13.6 keV).
###              Assuming a BH compact object with mass = 10 Msun. Is the ULX super-Eddington? By how much?

###################################### SPECTRAL LINE PLASMA MODELLING ##############################################

### Step 9 : Let's test a restframe emission-line model of plasma in collisional ionisation equilibrium (CIE)
###          This is an additive component which needs to be multiplied (related) by redshift and ISM absorption.
###          Given that the main features are around 1 keV we'll start with a kT_CIE = 1
###          If you calculate N_CIE = 1 would be 4 order of magnitude lower than the continuum luminosity,
###          so let's start with N_CIE = 100 to feel the change in the model and then fit.
###          Given the low spectral resolution of CCD spectra, let's assume solar abundances (default)
###          Same for any line broadening (vrms) or additional Doppler / redshift applied to the CIE component.
###          CCDs have low resolution around 1 keV and you'll easily get widths > 10^4 km/s (i.e. the resolution).

com cie
com rel 5 1,2

par 1 5 no v 100
par 1 5 t  v 1

cal
plo

fit
fit
fit
par sh fr

par wri model_RHBMC

### Updating plot lower-title with model currently being used (to better distinguish among them):

p fr 1
p cap lt dis t
p cap lt text "SPEX model: model_RHBMC.com"
p

### Saving a new postscript file with the new bestfit (2 continuum components + CIE):

p de cps model_RHBMC.ps
p
p clo 2

# sys exe "ps2pdf model_RHBMC.ps"
# sys exe "  open model_RHBMC.pdf"

### The CIE provides a substantial improvement to the fit (Cstat~Chi2~147, dof~94),
### which is not yet formally acceptable as additional absorption features might be present.

### Step 10: Let's test a blueshifted absorption-line model of plasma in foto-ionisation equilibrium (xabs)
###          This is a multiplicative component for which the continuum needs to be multiplied (related).
###          Given that a strong feature is around 0.75 keV likely from O VIII (0.654 keV) then let's adopt
###          Doppler shift -65000 similar to other ULXs and ultrafast outflows in AGN.
###          Also, not optically thick gas (otherwise we won't see absorption lines) -> NH = 1e22 cm^-2
###          And a medium log xi (~4) as the default SPEX ionisation balance would give you loads of O VII-VIII.
###          Given the low spectral resolution of CCD spectra, let's assume solar abundances (default)
###          Same for any line broadening (v) or additional Doppler / redshift applied to the xabs component.
###          CCDs have low resolution around 1 keV and you'll easily get widths > 10^4 km/s (i.e. the resolution).

com xabs
com rel  3:4 6,1,2

par 1 6 nh v  0.01
par 1 6 xi v  4
par 1 6 v  v  100
par 1 6 zv v -65000

cal
plo

### SPEX will answer "No filename for xabs model; take default" because you have not provided the ionisatio balance
### calculated for the specific source and will therefore adopt the default one which will of course differ. This
### means that the log xi values will be slight wrong. "PION" model does the perfect job, but requires extra care.

fit
fit
fit
par sh fr

par wri model_RHBMCX

### Updating plot lower-title with model currently being used (to better distinguish among them):

p fr 1
p cap lt dis t
p cap lt text "SPEX model: model_RHBMCX.com"
p

p de cps model_RHBMCX.ps
p
p clo 2

# sys exe "ps2pdf model_RHBMCX.ps"
# sys exe "  open model_RHBMCX.pdf"

### The XABS provides a small improvement to the fit (Cstat~Chi2~133, dof~92),
### because many featues will likely melt with those of the CIE.
### Saving a new postscript final with the new bestfit (2 continuum components * XABS + CIE):

### Exercise 5 : do you get any improvement if you substitute xabs with a on-the-go calculate (absorbing) pion?
#
# com del 6
# com pion
# com rel  3:4 6,1,2
#
# par 1 6 nh v  0.1
# par 1 6 xi v  4
# par 1 6 v  v  100
# par 1 6 zv v -65000
# par 1 6 fc v 1
# par 1 6 om v 0
#
# cal
# plo
# fit
# fit
# fit
# par sh fr
# par wri model_RHBMCP

###################################### SPECTRAL LINE GAUSSIAN MODELLING ############################################

### Step 11: Remove all plasma models and see whther we can model the strongest 1 keV feature with a Gaussian line
###          This is an additive component which needs to be multiplied (related) by redshift and ISM absorption.
###          Choose an energy range and a normalisation range to avoid Gaussian line out of energy band (& physics).
###          The "type" parameter for the "gaus" component choses among keV (0) and Angstrom (1) units input.
###          Let's begin with a frozen low physical line width (1e-3 keV), with instrumental broadening dominant.
###          Let's begin with an emission-like feature by assuming normalisation positive and E0 fixed to 1keV.
###          Let's begin with an emission-like feature by assuming normalisation positive and E0 fixed to 1keV.

com del 6
com del 5

com gaus
com rel 3:5 1,2

par 1 5 ty  v  0
par 1 5 no  r  0 +1e5
par 1 5 no  v  1
par 1 5 e   r  0.3 10
par 1 5 e   v  1
par 1 5 e   s  f
par 1 5 fw  v  1e-3
par 1 5 fw  r  0 1
par 1 5 e:f s  f
par 1 5 w:a s  f

cal
pl
par sh fr

fit
fit
fit
par sh fr

par wri model_RHBMG

### Updating plot lower-title with model currently being used (to better distinguish among them):

p fr 1
p cap lt dis t
p cap lt text "SPEX model: model_RHBMG.com"
p

p de cps model_RHBMG.ps
p
p clo 2

# sys exe "ps2pdf model_RHBMG.ps"
# sys exe "  open model_RHBMG.pdf"

### Exercise 6 : do you get any improvement if you release the Gaussian energy centroid and fwhm?
#
# par 1 5 e s t
# par 1 5 f s t
# cal
# pl
# par sh fr
#
# fit
# fit
# fit
# par sh fr

### Trick number 2 : can fit get stuck in local minima? Definitel yes, especially for very small/high starting value
###                  and this can be the case if you fit the FWHM starting from 1e-3 (keV). The fit ends up with the
###                  the same starting value. To check if this happened, run an error calculation:

# err 1 5 fw

### The calculation might show you the following:
###
### During the error search a lower C-stat was encountered.
### Parameter value:    0.27779
### C-stat    value:         141.37
### This is the lowest fit statistic so-far. Consider re-fitting.
### See command file spex_lower_stat.com for start parameters.
### In that file, the current parameter is frozen. Fit, thaw parameter, fit.
### Parameter   1    5 fwhm:   1.00000E-03 Errors:  -1.00000E-03 ,   0.38954
###
### In this case, load execute the file "spex_lower_stat.com" containing the suggested new model parameters
### Release again the parameter of which you've calculate error as it is always frozen into spex_lower_stat.com
### and re-run the fit again. Have you noticed any difference at all?

# log execute spex_lower_stat
# par 1 5 fw s t
# ca
# p
# par sh fr
#
# f
# f
# f
# par sh fr

### Exercise 7 : do you get any improvement if you invert the Gaussian into a negative one?
###              this can be done by chosing "par 1 5 no r -1e5 0"
###              what if you add a 2nd negative/positive gaussian (i.e. component 6), any improvement?

####################################################################################################################
