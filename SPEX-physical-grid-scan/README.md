Advanced SPEX codes to search for winds and jets in X-ray plasmas

These automated codes take advantage from SPEX knowledge of atomic lines cross section and energy centroids as well as relatives strength according to the given ionisation balance (and elemental abundances). The routines are optimised to speed up the spectral fits over a well defined deep grid of points in the paramers space (e.g. log_xi, kT, N_H, n_e, v_LOS, etc.) by adopting an ad-hoc structure and parameters initialisation. The main difference between photo- and collisionally-ionised codes is the need for a broadband band spectral energy distribution (SED) or ionising radiation field for the former.

1) SPEX_xabs_grid_fast_input.sh is built on SPEX's model XABS which reproduces and models absorption lines from photo-ionised plasma. This code was developed for and published in the paper Pinto et al. (2020a, https://ui.adsabs.harvard.edu/abs/2020MNRAS.492.4646P/abstract). You're recommended and kindly requested to refer to that paper when using this code.

2) SPEX's model PION (emission and absorption lines from photo-ionised plasma) is yet to be uploaded.

3) SPEX's model CIE (emission lines from collisionally-ionised plasma) is yet to be uploaded.

4) SPEX's model HOT (absorption lines from collisionally-ionised plasma) is yet to be uploaded.

