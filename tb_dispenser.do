onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radixshowbase 0 /tb_dispenser/uut/clk
add wave -noupdate -radix unsigned -radixshowbase 0 /tb_dispenser/uut/item_num
add wave -noupdate -radixshowbase 0 /tb_dispenser/uut/dispense
add wave -noupdate -radix binary -childformat {{/tb_dispenser/uut/motors(15) -radix binary} {/tb_dispenser/uut/motors(14) -radix binary} {/tb_dispenser/uut/motors(13) -radix binary} {/tb_dispenser/uut/motors(12) -radix binary} {/tb_dispenser/uut/motors(11) -radix binary} {/tb_dispenser/uut/motors(10) -radix binary} {/tb_dispenser/uut/motors(9) -radix binary} {/tb_dispenser/uut/motors(8) -radix binary} {/tb_dispenser/uut/motors(7) -radix binary} {/tb_dispenser/uut/motors(6) -radix binary} {/tb_dispenser/uut/motors(5) -radix binary} {/tb_dispenser/uut/motors(4) -radix binary} {/tb_dispenser/uut/motors(3) -radix binary} {/tb_dispenser/uut/motors(2) -radix binary} {/tb_dispenser/uut/motors(1) -radix binary} {/tb_dispenser/uut/motors(0) -radix binary}} -radixshowbase 0 -expand -subitemconfig {/tb_dispenser/uut/motors(15) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(14) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(13) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(12) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(11) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(10) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(9) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(8) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(7) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(6) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(5) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(4) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(3) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(2) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(1) {-height 15 -radix binary -radixshowbase 0} /tb_dispenser/uut/motors(0) {-height 15 -radix binary -radixshowbase 0}} /tb_dispenser/uut/motors
add wave -noupdate /tb_dispenser/uut/lightscreen_n
add wave -noupdate -radixshowbase 0 /tb_dispenser/uut/done
add wave -noupdate -radixshowbase 0 /tb_dispenser/uut/failed
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {68101110 ns} 0}
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
