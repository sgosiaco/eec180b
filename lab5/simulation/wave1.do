onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pulse_tb/clock
add wave -noupdate /pulse_tb/reset
add wave -noupdate /pulse_tb/enable
add wave -noupdate /pulse_tb/divideby
add wave -noupdate /pulse_tb/go
add wave -noupdate /pulse_tb/LEDR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3501 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {254 ps} {1254 ps}
