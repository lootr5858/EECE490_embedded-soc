transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/rx_ten_eight {D:/Verilog/EECE490_Midterm/UART/rx_ten_eight/baud_counter.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/common {D:/Verilog/common/REGISTER.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/rx_ten_eight {D:/Verilog/EECE490_Midterm/UART/rx_ten_eight/rx_ten_eight.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/rx_ten_eight {D:/Verilog/EECE490_Midterm/UART/rx_ten_eight/rx_ten_eight_cp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/rx_ten_eight {D:/Verilog/EECE490_Midterm/UART/rx_ten_eight/rx_ten_eight_dp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/rx_ten_eight {D:/Verilog/EECE490_Midterm/UART/rx_ten_eight/ten_eight.v}

vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/rx_ten_eight {D:/Verilog/EECE490_Midterm/UART/rx_ten_eight/rx_ten_eight_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  rx_ten_eight_tb

add wave *
view structure
view signals
run -all
