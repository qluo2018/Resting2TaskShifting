Please run the main*.m file follow this order:

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
direction:   './'

main100_1stLevel_batch.m            
main101_GCArest_Normal.m         
main102_GCArest_Patient.m        
main103_regress_block_info.m     
main104_unitRoot_task.m          
main105_GCAtask_2back.m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
direction:   './GCA_analysis/'

main101_rest_collect_files.m             
main102_task_collect_files.m             
main103_rest_classify_patient_healthy.m  
main104_task_classify_patient_healthy.m  
main105_pair_copyfile_task_rest.m        
main106_pair_measure_CPC.m               
main107_pair_classify_patient_healthy.m  
main108_mkdir_T_spm.m                    
main109_mkdir_T_dpabi.m                  
main200_SecondLevel_t1_batch.m                 
main201_seconlevel_t2_batch.m                 
main202_Corr_VoxelCPC_Score.m            
main203_Corr_Score_ClusterLevel_Pat.m    
main204_Corr_Score_ClusterLevel_Nor.m 
=================================================

phenotype data, fMRI data, and covariance data are avilable upon request to Peter Liddle