# SPEX Gaussian grid FWHM = 1000kms in 0.3-10 keV log-spaced
#
# Run this before SPEX: echo Parallelisation
# Run this before SPEX: number_of_cores=4
# Run this before SPEX: export OMP_NUM_THREADS=${number_of_cores}
# Run this before SPEX: echo choosing number of cores / threads=${OMP_NUM_THREADS}
#
# Created by unix_detection_routine_make.sh 
 
par 1 8 ty   v 0
par 1 8 e    v 7.0
par 1 8 e:aw s f
par 1 8 no   r -1e10 +1e10
par 1 8 no   v 1e4
par wri /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG over
 
p fra 1
p cap lt disp t 
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.014492keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.014492  
 par 1 8 f     v  .0550636
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.014492_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.039156keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.039156  
 par 1 8 f     v  .0552572
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.039156_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.063907keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.063907  
 par 1 8 f     v  .0554515
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.063907_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.088744keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.088744  
 par 1 8 f     v  .0556465
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.088744_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.113669keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.113669  
 par 1 8 f     v  .0558422
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.113669_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.138682keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.138682  
 par 1 8 f     v  .0560386
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.138682_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.163783keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.163783  
 par 1 8 f     v  .0562355
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.163783_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.188971keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.188971  
 par 1 8 f     v  .0564333
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.188971_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.214249keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.214249  
 par 1 8 f     v  .0566316
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.214249_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.239615keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.239615  
 par 1 8 f     v  .0568308
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.239615_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.265071keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.265071  
 par 1 8 f     v  .0570307
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.265071_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.290616keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.290616  
 par 1 8 f     v  .0572312
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.290616_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.316250keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.316250  
 par 1 8 f     v  .0574325
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.316250_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.341975keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.341975  
 par 1 8 f     v  .0576343
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.341975_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.367791keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.367791  
 par 1 8 f     v  .0578371
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.367791_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.393697keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.393697  
 par 1 8 f     v  .0580403
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.393697_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.419694keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.419694  
 par 1 8 f     v  .0582445
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.419694_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.445783keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.445783  
 par 1 8 f     v  .0584492
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.445783_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.471963keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.471963  
 par 1 8 f     v  .0586548
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.471963_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.498235keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.498235  
 par 1 8 f     v  .0588611
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.498235_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.524600keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.524600  
 par 1 8 f     v  .0590681
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.524600_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.551058keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.551058  
 par 1 8 f     v  .0592755
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.551058_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.577608keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.577608  
 par 1 8 f     v  .0594840
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.577608_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.604252keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.604252  
 par 1 8 f     v  .0596933
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.604252_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.630990keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.630990  
 par 1 8 f     v  .0599031
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.630990_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.657821keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.657821  
 par 1 8 f     v  .0601137
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.657821_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.684747keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.684747  
 par 1 8 f     v  .0603252
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.684747_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.711768keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.711768  
 par 1 8 f     v  .0605371
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.711768_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.738884keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.738884  
 par 1 8 f     v  .0607500
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.738884_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.766095keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.766095  
 par 1 8 f     v  .0609636
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.766095_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.793401keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.793401  
 par 1 8 f     v  .0611781
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.793401_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.820804keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.820804  
 par 1 8 f     v  .0613932
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.820804_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.848303keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.848303  
 par 1 8 f     v  .0616091
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.848303_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.875899keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.875899  
 par 1 8 f     v  .0618255
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.875899_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.903591keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.903591  
 par 1 8 f     v  .0620431
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.903591_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.931381keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.931381  
 par 1 8 f     v  .0622612
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.931381_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.959269keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.959269  
 par 1 8 f     v  .0624800
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.959269_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=7.987255keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  7.987255  
 par 1 8 f     v  .0626997
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_7.987255_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.015339keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.015339  
 par 1 8 f     v  .0629201
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.015339_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.043522keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.043522  
 par 1 8 f     v  .0631415
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.043522_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.071804keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.071804  
 par 1 8 f     v  .0633636
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.071804_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.100186keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.100186  
 par 1 8 f     v  .0635864
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.100186_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.128667keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.128667  
 par 1 8 f     v  .0638099
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.128667_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.157249keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.157249  
 par 1 8 f     v  .0640343
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.157249_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.185931keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.185931  
 par 1 8 f     v  .0642594
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.185931_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.214714keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.214714  
 par 1 8 f     v  .0644853
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.214714_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.243598keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.243598  
 par 1 8 f     v  .0647121
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.243598_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.272583keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.272583  
 par 1 8 f     v  .0649395
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.272583_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.301671keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.301671  
 par 1 8 f     v  .0651680
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.301671_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.330861keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.330861  
 par 1 8 f     v  .0653971
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.330861_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.360153keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.360153  
 par 1 8 f     v  .0656270
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.360153_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.389548keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.389548  
 par 1 8 f     v  .0658578
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.389548_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.419047keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.419047  
 par 1 8 f     v  .0660893
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.419047_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.448650keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.448650  
 par 1 8 f     v  .0663217
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.448650_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.478356keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.478356  
 par 1 8 f     v  .0665548
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.478356_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.508167keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.508167  
 par 1 8 f     v  .0667889
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.508167_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.538083keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.538083  
 par 1 8 f     v  .0670237
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.538083_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.568104keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.568104  
 par 1 8 f     v  .0672595
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.568104_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.598231keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.598231  
 par 1 8 f     v  .0674959
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.598231_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.628463keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.628463  
 par 1 8 f     v  .0677333
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.628463_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.658802keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.658802  
 par 1 8 f     v  .0679714
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.658802_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.689248keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.689248  
 par 1 8 f     v  .0682104
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.689248_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.719800keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.719800  
 par 1 8 f     v  .0684504
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.719800_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.750460keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.750460  
 par 1 8 f     v  .0686911
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.750460_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.781228keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.781228  
 par 1 8 f     v  .0689324
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.781228_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.812104keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.812104  
 par 1 8 f     v  .0691748
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.812104_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.843089keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.843089  
 par 1 8 f     v  .0694180
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.843089_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.874182keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.874182  
 par 1 8 f     v  .0696623
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.874182_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.905385keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.905385  
 par 1 8 f     v  .0699072
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.905385_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.936698keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.936698  
 par 1 8 f     v  .0701528
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.936698_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.968120keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.968120  
 par 1 8 f     v  .0703996
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.968120_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=8.999653keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  8.999653  
 par 1 8 f     v  .0706471
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_8.999653_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.031297keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.031297  
 par 1 8 f     v  .0708956
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.031297_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.063053keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.063053  
 par 1 8 f     v  .0711447
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.063053_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.094919keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.094919  
 par 1 8 f     v  .0713948
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.094919_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.126898keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.126898  
 par 1 8 f     v  .0716459
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.126898_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.158990keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.158990  
 par 1 8 f     v  .0718979
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.158990_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.191194keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.191194  
 par 1 8 f     v  .0721508
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.191194_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.223512keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.223512  
 par 1 8 f     v  .0724044
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.223512_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.255943keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.255943  
 par 1 8 f     v  .0726590
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.255943_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.288488keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.288488  
 par 1 8 f     v  .0729145
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.288488_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.321147keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.321147  
 par 1 8 f     v  .0731707
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.321147_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.353922keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.353922  
 par 1 8 f     v  .0734281
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.353922_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.386811keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.386811  
 par 1 8 f     v  .0736863
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.386811_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.419817keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.419817  
 par 1 8 f     v  .0739453
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.419817_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.452938keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.452938  
 par 1 8 f     v  .0742053
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.452938_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.486176keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.486176  
 par 1 8 f     v  .0744662
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.486176_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.519531keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.519531  
 par 1 8 f     v  .0747281
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.519531_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.553003keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.553003  
 par 1 8 f     v  .0749909
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.553003_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.586592keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.586592  
 par 1 8 f     v  .0752547
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.586592_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.620300keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.620300  
 par 1 8 f     v  .0755191
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.620300_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.654126keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.654126  
 par 1 8 f     v  .0757848
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.654126_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.688071keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.688071  
 par 1 8 f     v  .0760511
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.688071_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.722136keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.722136  
 par 1 8 f     v  .0763187
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.722136_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.756320keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.756320  
 par 1 8 f     v  .0765869
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.756320_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.790625keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.790625  
 par 1 8 f     v  .0768563
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.790625_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.825050keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.825050  
 par 1 8 f     v  .0771264
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.825050_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.859596keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.859596  
 par 1 8 f     v  .0773977
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.859596_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.894264keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.894264  
 par 1 8 f     v  .0776697
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.894264_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.929053keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.929053  
 par 1 8 f     v  .0779429
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.929053_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.963965keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.963965  
 par 1 8 f     v  .0782170
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.963965_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
 
##################################################
 
 p cap lt text " Gaussian E0=9.999000keV LW=1000km/s " 
 
 l e /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/spex_model_RHPBD2LG 
 
 par 1 8 n     v  1e3   
 par 1 8 e     v  9.999000  
 par 1 8 f     v  .0784921
 c   
 p   
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
 err 1 8 no                            
 l e spex_lower_stat                   
 par 1 8 no s t                        
 c                                     
 p                                     
 fit 
 fit 
 fit 
 par sh fr 
 
 system exe "rm spex_lower_stat.com" 
 
log out /Users/ciropinto/Work/Codes_backup/GitHug_stuff/SPEX-line-detection/linegrid/line_1000kms_9.999000_keV o
par sh fr
log close out
 
system exe "rm spex_lower_stat.com"  
 
