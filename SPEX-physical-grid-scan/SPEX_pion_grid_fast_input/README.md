Advanced SPEX codes to search for photoionised winds in X-ray plasmas

The scanning of photoionised emission models (PION) has been built with an ad-hoc architecture useful for speeding up the process, especially when more spectra are available and no big changes in the ionisation balance are expect. Once provided the broaband spectral energy distribution (SED), a grid of PION models will be calculated within certain ranges of values of the ionisation parameter (log xi) and the column density (NH) and eventually other such as the velocity dispersion. Once these model spectra are calculated, they gets converted into a format that can be loaded into SPEX as an additive file-model. Finally, an automated routine is run over the created grids of PION models, obtainint C-stat values for all the models when fitting the emission lines, which ultimately provide C-stat contours in the parameter space.

Contents of the directory:

1) mygrid_0140a002a.egr ................... linear grid of wavelengths 1 to 40 Angstron 0.02A step

2) IDL_Conv_SPEX_file_model.pro ..... IDL converter of spectra to SPEX file model input

3) SPEX_pion_calc_spec_grids.sh ...... PION spectra calculation for a range of nh

4) SPEX_pion_calc_spec_n1e22.sh .... PION spectra calculation for nh = 1e22 cm^-2

5) SPEX_pion_grid_fast_input.sh ........ Fast PION physical models scan with file-model grids

Order of scripts execution:

1) Launch either SPEX_pion_calc_spec_grids.sh or SPEX_pion_calc_spec_n1e22.sh
    This will also call some PYTHON commands and IDL_Conv_SPEX_file_model.pro
    
2) Launch SPEX_pion_grid_fast_input.sh to perform the photoionised emission scanning

All these codes have been developed for and published in the paper Pinto et al. (2020a, doi: 10.1093/mnras/staa118, arXiv: 1911.09568, bibcode: 2020MNRAS.492.4646P). You're recommended and kindly requested to refer to that paper when using this code.
