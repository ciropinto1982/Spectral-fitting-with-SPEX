
print, "IDL convert SPEX PION output spectrum to a SPEX Model-File input"

print, "Note you might need an additional Normalisation factor (due to distance)"

;;; LOAD DATA (several files) : loop over all PION model spectra that have been calculated

DIR_FILES_IN="/path/to/pion_grids/directory/"

PION_loop_results=file_search(DIR_FILES_IN+'PION_v*.qdp')

  window,0, XSIZE=800, YSIZE=500, TITLE='IDL - Pion grids conversion'
  device,retain=2,decomposed=0

  LOADCT, 3

 !P.thick=1
 !X.thick=2
 !Y.thick=2
 !P.charthick=1
 !P.charsize=1
  
for loop=0, n_elements(PION_loop_results)-1 do begin

  print,"Converting file: ",strcompress(PION_loop_results[loop])

  file=PION_loop_results[loop]
  
  fname=strcompress(file)+".dat"
 
  readcol,strcompress(file),energy,energy_err1,energy_err2,flux

 index=where(flux gt 0 and energy ge 0.3 and energy le 10) ;;; stop outside 0.3-10 keV or file gets too large

 plot,energy,flux, /xlog, /ylog, /xstyle, /ystyle, xtitle="E (keV)", ytitle="Flux (phot/s/m2/keV)", $
      title=strcompress(PION_loop_results[loop]), xrange=[0.1,2e1], yrange=[1e-10,1e3]

 oplot,energy[index],flux[index], color=150, linestyle=2
 
 ; Factor 5e-4 (below) to ignore if you already adopted the correct normalisation when running PION grid calc!
 
 Matrix=[transpose(energy[index]),transpose(flux[index])*5e-4] 
 
  openw,lun,fname,/get_lun
  printf, lun, n_elements(index)
  printf, lun, Matrix
  Free_lun, lun
  
  print,"Check outp file: ",fname

endfor
          
;;; device,/close
;;; set_plot,'x'

END
