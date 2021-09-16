transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project/ECE550/addsub-56-base-master {E:/ECE 550D/Project/ECE550/addsub-56-base-master/alu.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project/ECE550/addsub-56-base-master {E:/ECE 550D/Project/ECE550/addsub-56-base-master/CLA_4.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project/ECE550/addsub-56-base-master {E:/ECE 550D/Project/ECE550/addsub-56-base-master/CLA_16.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project/ECE550/addsub-56-base-master {E:/ECE 550D/Project/ECE550/addsub-56-base-master/CLA_32.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project/ECE550/addsub-56-base-master {E:/ECE 550D/Project/ECE550/addsub-56-base-master/add_sub.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project/ECE550/addsub-56-base-master {E:/ECE 550D/Project/ECE550/addsub-56-base-master/and_op.v}
vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project/ECE550/addsub-56-base-master {E:/ECE 550D/Project/ECE550/addsub-56-base-master/or_op.v}

vlog -vlog01compat -work work +incdir+E:/ECE\ 550D/Project/ECE550/addsub-56-base-master {E:/ECE 550D/Project/ECE550/addsub-56-base-master/alu_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  alu_tb

add wave *
view structure
view signals
run -all
