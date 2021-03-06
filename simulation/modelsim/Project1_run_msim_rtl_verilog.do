transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project {E:/ECE 550D/Project/alu.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project {E:/ECE 550D/Project/CLA_4.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project {E:/ECE 550D/Project/CLA_16.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project {E:/ECE 550D/Project/CLA_32.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project {E:/ECE 550D/Project/add_sub.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project {E:/ECE 550D/Project/and_op.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project {E:/ECE 550D/Project/or_op.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project {E:/ECE 550D/Project/equal.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project {E:/ECE 550D/Project/mux_2.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project {E:/ECE 550D/Project/left_shift.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project {E:/ECE 550D/Project/right_shift.v}

vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project {E:/ECE 550D/Project/alu_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  alu_tb

add wave *
view structure
view signals
run -all
