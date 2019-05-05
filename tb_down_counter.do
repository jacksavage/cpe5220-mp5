onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group dc1 -radix unsigned -radixshowbase 0 /tb_down_counter/dc1/start_count
add wave -noupdate -expand -group dc1 /tb_down_counter/dc1/clk
add wave -noupdate -expand -group dc1 /tb_down_counter/dc1/rst
add wave -noupdate -expand -group dc1 /tb_down_counter/dc1/flag
add wave -noupdate -expand -group dc1 -radix unsigned -radixshowbase 0 /tb_down_counter/dc1/counter
add wave -noupdate -expand -group dc2 -radix unsigned -radixshowbase 0 /tb_down_counter/dc2/start_count
add wave -noupdate -expand -group dc2 /tb_down_counter/dc2/clk
add wave -noupdate -expand -group dc2 /tb_down_counter/dc2/rst
add wave -noupdate -expand -group dc2 /tb_down_counter/dc2/flag
add wave -noupdate -expand -group dc2 -radix unsigned -radixshowbase 0 /tb_down_counter/dc2/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {57953157 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {105 ms}
