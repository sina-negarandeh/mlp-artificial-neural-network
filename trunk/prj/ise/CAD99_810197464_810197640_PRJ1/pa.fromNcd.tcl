
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name CAD99_810197464_810197640_PRJ1 -dir "F:/amin/CAD99_810197464_810197640_PRJ1/CAD99_810197464_810197640_PRJ1/planAhead_run_3" -part xa7a100tcsg324-2I
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "F:/amin/CAD99_810197464_810197640_PRJ1/CAD99_810197464_810197640_PRJ1/Neuron.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {F:/amin/CAD99_810197464_810197640_PRJ1/CAD99_810197464_810197640_PRJ1} {ipcore_dir} }
add_files [list {ipcore_dir/Multiplier8_2.ncf}] -fileset [get_property constrset [current_run]]
set_property target_constrs_file "Neuron.ucf" [current_fileset -constrset]
add_files [list {Neuron.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "F:/amin/CAD99_810197464_810197640_PRJ1/CAD99_810197464_810197640_PRJ1/Neuron.xdl"
if {[catch {read_twx -name results_1 -file "F:/amin/CAD99_810197464_810197640_PRJ1/CAD99_810197464_810197640_PRJ1/Neuron.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"F:/amin/CAD99_810197464_810197640_PRJ1/CAD99_810197464_810197640_PRJ1/Neuron.twx\": $eInfo"
}
