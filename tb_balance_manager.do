onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radixshowbase 0 /tb_balance_manager/duv_balance_manager/reset
add wave -noupdate -radixshowbase 0 /tb_balance_manager/duv_balance_manager/clk
add wave -noupdate -expand -group {money provided} -radix unsigned -radixshowbase 0 /tb_balance_manager/duv_balance_manager/num_dollars
add wave -noupdate -expand -group {money provided} -radix unsigned -radixshowbase 0 /tb_balance_manager/duv_balance_manager/num_quarters
add wave -noupdate -expand -group {money provided} -radix unsigned -radixshowbase 0 /tb_balance_manager/duv_balance_manager/num_dimes
add wave -noupdate -expand -group {money provided} -radix unsigned -radixshowbase 0 /tb_balance_manager/duv_balance_manager/num_nickles
add wave -noupdate -radixshowbase 0 /tb_balance_manager/duv_balance_manager/new_currency_interrupt
add wave -noupdate -radix sfixed /tb_balance_manager/duv_balance_manager/loaded_balance
add wave -noupdate -radix ufixed -radixshowbase 0 /tb_balance_manager/duv_balance_manager/order_cost
add wave -noupdate -radixshowbase 0 /tb_balance_manager/duv_balance_manager/insufficient_funds
add wave -noupdate -radixshowbase 0 /tb_balance_manager/duv_balance_manager/dispensed
add wave -noupdate -radixshowbase 0 /tb_balance_manager/duv_balance_manager/return_balance
add wave -noupdate -expand -group {returned money} -radix unsigned -radixshowbase 0 /tb_balance_manager/duv_balance_manager/return_dollars
add wave -noupdate -expand -group {returned money} -radix unsigned -radixshowbase 0 /tb_balance_manager/duv_balance_manager/return_quarters
add wave -noupdate -expand -group {returned money} -radix unsigned -radixshowbase 0 /tb_balance_manager/duv_balance_manager/return_dimes
add wave -noupdate -expand -group {returned money} -radix unsigned -radixshowbase 0 /tb_balance_manager/duv_balance_manager/return_nickles
add wave -noupdate -radixshowbase 0 /tb_balance_manager/duv_balance_manager/return_currency_interrupt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {507 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 195
configure wave -valuecolwidth 94
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {6300 ns}
