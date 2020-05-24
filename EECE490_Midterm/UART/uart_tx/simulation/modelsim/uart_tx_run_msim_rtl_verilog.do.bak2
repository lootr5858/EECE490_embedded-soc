transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Verilog/common {D:/Verilog/common/REGISTER.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_tx {D:/Verilog/EECE490_Midterm/UART/uart_tx/uart_tx.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_tx {D:/Verilog/EECE490_Midterm/UART/uart_tx/tx_cp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_tx {D:/Verilog/EECE490_Midterm/UART/uart_tx/tx_dp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_tx {D:/Verilog/EECE490_Midterm/UART/uart_tx/baud_counter.v}

vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_tx {D:/Verilog/EECE490_Midterm/UART/uart_tx/tx_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tx_tb

add wave *
view structure
view signals
run -all
