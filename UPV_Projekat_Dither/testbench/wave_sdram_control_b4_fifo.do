onerror {resume}
quietly virtual signal -install /sdram_control_b4_fifo_vhd_tst { (context /sdram_control_b4_fifo_vhd_tst )(read_q & rdreq & rdclk & rd_reset & i1/read_state & i1/r_busy )} READ_GROUP
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group WRITE_GROUP /sdram_control_b4_fifo_vhd_tst/i1/fifo_write_rdreq
add wave -noupdate -expand -group WRITE_GROUP /sdram_control_b4_fifo_vhd_tst/i1/fifo_write_q
add wave -noupdate -expand -group WRITE_GROUP -radix unsigned /sdram_control_b4_fifo_vhd_tst/i1/fifo_write_usedw
add wave -noupdate -expand -group WRITE_GROUP -label WRCLK /sdram_control_b4_fifo_vhd_tst/wrclk
add wave -noupdate -expand -group WRITE_GROUP -label WR_USED -radix unsigned /sdram_control_b4_fifo_vhd_tst/write_usedw
add wave -noupdate -expand -group WRITE_GROUP -label WR_REQ /sdram_control_b4_fifo_vhd_tst/wrreq
add wave -noupdate -expand -group WRITE_GROUP -label WR_BUSY /sdram_control_b4_fifo_vhd_tst/i1/w_busy
add wave -noupdate -expand -group WRITE_GROUP -label WR_D /sdram_control_b4_fifo_vhd_tst/write_d
add wave -noupdate -expand -group WRITE_GROUP -label WR_RESET /sdram_control_b4_fifo_vhd_tst/wr_reset
add wave -noupdate -expand -group WRITE_GROUP -label WE_ADDR -radix unsigned /sdram_control_b4_fifo_vhd_tst/i1/a_write
add wave -noupdate -expand -group WRITE_GROUP -label WR_CLK /sdram_control_b4_fifo_vhd_tst/wrclk
add wave -noupdate -expand -group WRITE_GROUP -label WR_STATE /sdram_control_b4_fifo_vhd_tst/i1/write_state
add wave -noupdate -expand -group READ_GROUP -label RD_USED -radix unsigned /sdram_control_b4_fifo_vhd_tst/read_usedw
add wave -noupdate -expand -group READ_GROUP -label RD_Q /sdram_control_b4_fifo_vhd_tst/read_q
add wave -noupdate -expand -group READ_GROUP -label RD_REQ /sdram_control_b4_fifo_vhd_tst/rdreq
add wave -noupdate -expand -group READ_GROUP -label RD_CLK /sdram_control_b4_fifo_vhd_tst/rdclk
add wave -noupdate -expand -group READ_GROUP -label RD_BUSY /sdram_control_b4_fifo_vhd_tst/i1/r_busy
add wave -noupdate -expand -group READ_GROUP -label RD_RESET /sdram_control_b4_fifo_vhd_tst/rd_reset
add wave -noupdate /sdram_control_b4_fifo_vhd_tst/dq_sdram
add wave -noupdate /sdram_control_b4_fifo_vhd_tst/clk
add wave -noupdate -radix binary /sdram_control_b4_fifo_vhd_tst/a_sdram
add wave -noupdate /sdram_control_b4_fifo_vhd_tst/i1/read_state
add wave -noupdate -radix unsigned /sdram_control_b4_fifo_vhd_tst/i1/a_read
add wave -noupdate /sdram_control_b4_fifo_vhd_tst/i1/current_state
add wave -noupdate /sdram_control_b4_fifo_vhd_tst/reset
add wave -noupdate -radix unsigned /sdram_control_b4_fifo_vhd_tst/i1/next_a_write
add wave -noupdate -radix unsigned /sdram_control_b4_fifo_vhd_tst/i1/next_a_read
add wave -noupdate /sdram_control_b4_fifo_vhd_tst/i1/d_read
add wave -noupdate /sdram_control_b4_fifo_vhd_tst/i1/d_write
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5763860 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 313
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
WaveRestoreZoom {461874 ps} {10508896 ps}
