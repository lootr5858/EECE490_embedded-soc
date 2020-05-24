transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_binary {D:/Verilog/EECE490_Midterm/UART/uart_binary/baud_counter.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_binary {D:/Verilog/EECE490_Midterm/UART/uart_binary/uart_tx.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_binary {D:/Verilog/EECE490_Midterm/UART/uart_binary/uart_rx.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_binary {D:/Verilog/EECE490_Midterm/UART/uart_binary/tx_dp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_binary {D:/Verilog/EECE490_Midterm/UART/uart_binary/tx_cp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_binary {D:/Verilog/EECE490_Midterm/UART/uart_binary/rx_dp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_binary {D:/Verilog/EECE490_Midterm/UART/uart_binary/rx_cp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/common {D:/Verilog/common/REGISTER.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_binary {D:/Verilog/EECE490_Midterm/UART/uart_binary/uart_binary.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_binary {D:/Verilog/EECE490_Midterm/UART/uart_binary/uart_b_cp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_binary {D:/Verilog/EECE490_Midterm/UART/uart_binary/uart_b_dp.v}

vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART/uart_binary {D:/Verilog/EECE490_Midterm/UART/uart_binary/binary_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  binary_tb

add wave *
view structure
view signals
run -all
