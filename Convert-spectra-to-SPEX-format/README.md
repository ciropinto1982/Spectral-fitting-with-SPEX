# TRAFO conversion of ordinary FITS spectra to SPEX format

- Chandra-HEG-examples.sh converts HETGS (HEG and MEG) grating spectra from Chandra
- XMM-RGS-examples.sh converts RGS 1,2 grating spectra from XMM-Newton
- XMM-EPIC-examples.sh converts EPIC MOS 1,2 and pn CCD spectra from XMM-Newton
- XMM-EPIC-examples-sectors.sh converts EPIC spectra for simultaneous fits
- XMM-EPIC-examples-sectors-preformatted.sh joins pre-formatted SPO/RES files


NOTE: with the new SPEX version 3.07 you need to answer if you want the derivatives of the response matrix
      to be calculated. Also, chose a non partiotioning of the matrix (option 1 instead of options 2,3)!!!
      Finally, v3.07 has a more strict and conservative input system, proviude the OGIP spectra with the 
      correct name without spaces.
