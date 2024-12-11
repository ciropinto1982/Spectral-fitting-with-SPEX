# SPEX simple script to plot the contribution
#      of each species to the ISM transmission
#
# SLAB model for the ions and
# AMOL for dust / molecules
#
# but it can be done with any absorber e.g. "hot"
# Bulk command: FCOV=0 suppress a whole absorber
###                                                                                                      
###    IMPORTANT: SPEX is an automatically parallelised code which will use all CPU available!           
###    If you want to chose the number of cores (parallelisaiton), before opening SPEX run the following:
###    export OMP_NUM_THREADS=4                                                                          
###    echo "SPEX: choosing number of cores / threads = ${OMP_NUM_THREADS}"                              

echo "Run SPEX to extract transmission of species"

#: '

spex<<EOF

# Define model: powerlaw * slab * amol

 com po
 com sla
 com amo
 com rel 1 2,3

# Continuum parameters

 par 1 1 no v 12.566
 par 1 1 ga v 0

# Absorption parameters

 par 1 2 v  v 30
 par 1 2 o1 v 22
 par 1 2 o2 v 20.5
 par 1 2 o3 v 20.
 par 1 2 o4 v 19.5
 par 1 2 o5 v 19.0
 par 1 2 o6 v 19.5
 par 1 2 o7 v 20.5
 par 1 2 o8 v 20.0
 
 par 1 3 i1 v 3103
 par 1 3 n1 v 1e-7
 
 par wri model_ISM over
 
# Open main plot window

 p de xs
 p ty mo
 p vi def f
 p vi y 0.13:0.95
 p vi x 0.07:0.953
 p fi dis f
 p ux a
 p x li
 p y li
 p ry 0 1
 p rx 18 24
 p cap y text Transmission
 p cap id disp f
 p cap ut disp f
 p cap lt disp f
 p da lw 3
 p mo lw 3
 p box lw 3
 p cap y lw 3
 p cap it lw 3
 p cap x lw 3
 p cap x fh 1.1
 p cap y fh 1.1
 p box fh 1.1

 calc
 plot

# Full  transmission : save output as QDP file

log exe model_ISM
c
p
plot adum trans_all over

# Neutral gas only : save output as QDP file

log exe model_ISM
par 1 2 o2:o8 v 1
par 1 3 n1    v 0
c
p
plot adum trans_o1 over

# Weakly ionised only : save output as QDP file

log exe model_ISM
par 1 2 o1    v 1
par 1 2 o5:o8 v 1
par 1 3 n1    v 0
c
p
plot adum trans_lowion over

# Highly ionised only : save output as QDP file

log exe model_ISM
par 1 2 o1:o4 v 1
par 1 3 n1    v 0
c
p
plot adum trans_highion over

# Dust / molecules only : save output as QDP file

log exe model_ISM
par 1 2 o1:o8 v 1
c
p
plot adum trans_dust over

quit
EOF

#'

############# PLOT WITH PYTHON #############

echo "Run python to plot the transmission"

python - <<EOF

import numpy as np
import matplotlib.pyplot as plt

w1, e1, e2, t1 = np.loadtxt("trans_all.qdp", usecols=(0,1,2,3), unpack=True, skiprows=1)
w2, e1, e2, t2 = np.loadtxt("trans_o1.qdp", usecols=(0,1,2,3), unpack=True, skiprows=1)
w3, e1, e2, t3 = np.loadtxt("trans_lowion.qdp", usecols=(0,1,2,3), unpack=True, skiprows=1)
w4, e1, e2, t4 = np.loadtxt("trans_highion.qdp", usecols=(0,1,2,3), unpack=True, skiprows=1)
w5, e1, e2, t5 = np.loadtxt("trans_dust.qdp", usecols=(0,1,2,3), unpack=True, skiprows=1)

fig1=plt.figure(1)

plt.rcParams.update({'font.size': 15})

# FRAME 1
frame1=fig1.add_axes((.15,.15,.8,.8))

plt.plot(w1, t1, c='black' , linestyle='-', label="Full ISM")
plt.plot(w2, t2, c='red'   , linestyle='--', label="Neutral gas")
plt.plot(w3, t3, c='blue'  , linestyle='-.', label="Weakly ionised")
plt.plot(w4, t4, c='cyan'  , linestyle=':', label="Highly ionised")
plt.plot(w5, t5, c='green' , linestyle='-', label="Dust silicates")

plt.xlabel("Wavelength ($\AA$)", fontsize=15)
plt.ylabel("Transmission", fontsize=15)
frame1.set_xlim([18,25])
frame1.set_ylim([0,1.01])

plt.legend(loc='lower left', fontsize=13, framealpha=1.)

plt.savefig('transmission.png',bbox_inches='tight')
plt.close('all')

EOF

open transmission.png
