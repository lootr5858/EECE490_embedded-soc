transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Verilog/common {D:/Verilog/common/REGISTER.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART_SG/apb_uart {D:/Verilog/EECE490_Midterm/UART_SG/apb_uart/uart_tx.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART_SG/apb_uart {D:/Verilog/EECE490_Midterm/UART_SG/apb_uart/uart_rx.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART_SG/apb_uart {D:/Verilog/EECE490_Midterm/UART_SG/apb_uart/uart_b_dp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART_SG/apb_uart {D:/Verilog/EECE490_Midterm/UART_SG/apb_uart/uart_b_cp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART_SG/apb_uart {D:/Verilog/EECE490_Midterm/UART_SG/apb_uart/tx_dp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART_SG/apb_uart {D:/Verilog/EECE490_Midterm/UART_SG/apb_uart/tx_cp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART_SG/apb_uart {D:/Verilog/EECE490_Midterm/UART_SG/apb_uart/rx_dp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART_SG/apb_uart {D:/Verilog/EECE490_Midterm/UART_SG/apb_uart/rx_cp.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART_SG/apb_uart {D:/Verilog/EECE490_Midterm/UART_SG/apb_uart/cmsdk_apb_uart.v}
vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART_SG/apb_uart {D:/Verilog/EECE490_Midterm/UART_SG/apb_uart/baud_counter.v}

vlog -vlog01compat -work work +incdir+D:/Verilog/EECE490_Midterm/UART_SG/apb_uart {D:/Verilog/EECE490_Midterm/UART_SG/apb_uart/tb_uart_tx.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_uart_tx

add wave *
view structure
view signals
run -all
