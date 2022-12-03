vlog pp_gen.sv
vlog booth_encoder.sv
vlog booth_encoder_unit.sv
vlog booth_selector_4bit.sv
vlog booth_selector.sv
vlog booth_selector_unit.sv
vlog pp_resize_unit.sv
vlog ha.sv
vlog fa.sv
vlog ca.sv
vlog dadda_tree.sv
vlog tb_pp.sv
vsim -c work.tb_pp -voptargs=+acc

add wave -position insertpoint sim:/tb_pp/*
add wave -position insertpoint sim:/tb_pp/dadda0/*
run 1000 ns
