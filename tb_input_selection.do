onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radixshowbase 0 /tb_input_selection/duv_input_selection/reset
add wave -noupdate -radixshowbase 0 /tb_input_selection/duv_input_selection/clk
add wave -noupdate -radix binary -childformat {{/tb_input_selection/duv_input_selection/sel_button(7) -radix binary} {/tb_input_selection/duv_input_selection/sel_button(6) -radix binary} {/tb_input_selection/duv_input_selection/sel_button(5) -radix binary} {/tb_input_selection/duv_input_selection/sel_button(4) -radix binary} {/tb_input_selection/duv_input_selection/sel_button(3) -radix binary} {/tb_input_selection/duv_input_selection/sel_button(2) -radix binary} {/tb_input_selection/duv_input_selection/sel_button(1) -radix binary} {/tb_input_selection/duv_input_selection/sel_button(0) -radix binary}} -radixshowbase 0 -subitemconfig {/tb_input_selection/duv_input_selection/sel_button(7) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button(6) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button(5) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button(4) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button(3) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button(2) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button(1) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button(0) {-height 15 -radix binary -radixshowbase 0}} /tb_input_selection/duv_input_selection/sel_button
add wave -noupdate -radix binary -childformat {{/tb_input_selection/duv_input_selection/sel_button_buff(7) -radix binary} {/tb_input_selection/duv_input_selection/sel_button_buff(6) -radix binary} {/tb_input_selection/duv_input_selection/sel_button_buff(5) -radix binary} {/tb_input_selection/duv_input_selection/sel_button_buff(4) -radix binary} {/tb_input_selection/duv_input_selection/sel_button_buff(3) -radix binary} {/tb_input_selection/duv_input_selection/sel_button_buff(2) -radix binary} {/tb_input_selection/duv_input_selection/sel_button_buff(1) -radix binary} {/tb_input_selection/duv_input_selection/sel_button_buff(0) -radix binary}} -radixshowbase 0 -expand -subitemconfig {/tb_input_selection/duv_input_selection/sel_button_buff(7) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button_buff(6) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button_buff(5) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button_buff(4) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button_buff(3) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button_buff(2) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button_buff(1) {-height 15 -radix binary -radixshowbase 0} /tb_input_selection/duv_input_selection/sel_button_buff(0) {-height 15 -radix binary -radixshowbase 0}} /tb_input_selection/duv_input_selection/sel_button_buff
add wave -noupdate -radixshowbase 0 /tb_input_selection/duv_input_selection/return_btn
add wave -noupdate -radixshowbase 0 /tb_input_selection/duv_input_selection/cancel_btn
add wave -noupdate -radix unsigned -radixshowbase 0 /tb_input_selection/duv_input_selection/item_num
add wave -noupdate -radixshowbase 0 /tb_input_selection/duv_input_selection/maintenance_signal
add wave -noupdate -radixshowbase 0 /tb_input_selection/duv_input_selection/return_signal
add wave -noupdate -radixshowbase 0 /tb_input_selection/duv_input_selection/cancel_signal
add wave -noupdate -radixshowbase 0 /tb_input_selection/duv_input_selection/valid
add wave -noupdate -radixshowbase 0 /tb_input_selection/duv_input_selection/single_letter_sel
add wave -noupdate -radixshowbase 0 /tb_input_selection/duv_input_selection/single_num_sel
add wave -noupdate -radixshowbase 0 /tb_input_selection/display1/item_display
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {93 ns} 0}
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
WaveRestoreZoom {0 ns} {1 us}
