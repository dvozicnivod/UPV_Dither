onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label VGA_Y /upv_projekat_dither_vhd_tst/i1/vga_y_int
add wave -noupdate -label VGA_X /upv_projekat_dither_vhd_tst/i1/vga_x_int
add wave -noupdate -label VGA_VSYNC /upv_projekat_dither_vhd_tst/i1/vga_vsync
add wave -noupdate -label VGA_VALID /upv_projekat_dither_vhd_tst/i1/vga_valid
add wave -noupdate -label VGA_R /upv_projekat_dither_vhd_tst/i1/vga_r
add wave -noupdate -label VGA_G /upv_projekat_dither_vhd_tst/i1/vga_g
add wave -noupdate -label VGA_B /upv_projekat_dither_vhd_tst/i1/vga_b
add wave -noupdate -label VGA_HSYNC /upv_projekat_dither_vhd_tst/i1/vga_hsync
add wave -noupdate -label VGA_DATA /upv_projekat_dither_vhd_tst/i1/vga_data
add wave -noupdate -label VGA_ALL /upv_projekat_dither_vhd_tst/i1/vga_all
add wave -noupdate -label SDRAM_WRREQ /upv_projekat_dither_vhd_tst/i1/sd_wr_req
add wave -noupdate -label SDRAM_RDREQ /upv_projekat_dither_vhd_tst/i1/sd_rd_req
add wave -noupdate -label SDRAM_WE /upv_projekat_dither_vhd_tst/i1/sd_we
add wave -noupdate -label SDRAM_RAS /upv_projekat_dither_vhd_tst/i1/sd_ras
add wave -noupdate -label SDRAM_DQM /upv_projekat_dither_vhd_tst/i1/sd_dqml
add wave -noupdate -label SDRAM_WR_DATA /upv_projekat_dither_vhd_tst/i1/sd_data_wr
add wave -noupdate -label SDRAM_RD_DATA /upv_projekat_dither_vhd_tst/i1/sd_data_rd
add wave -noupdate -label SDRAM_DQ /upv_projekat_dither_vhd_tst/i1/sd_data
add wave -noupdate -label SDRAM_CS /upv_projekat_dither_vhd_tst/i1/sd_cs
add wave -noupdate -label SDRAM_CEN /upv_projekat_dither_vhd_tst/i1/sd_cen
add wave -noupdate -label SDRAM_CAS /upv_projekat_dither_vhd_tst/i1/sd_cas
add wave -noupdate -label SDRAM_WR_ADR /upv_projekat_dither_vhd_tst/i1/sd_adr_wr
add wave -noupdate -label SDRAM_RD_ADR /upv_projekat_dither_vhd_tst/i1/sd_adr_rd
add wave -noupdate -label SDRAM_ADDRESS /upv_projekat_dither_vhd_tst/i1/sd_address
add wave -noupdate -label SCCB_DATA /upv_projekat_dither_vhd_tst/i1/S_D
add wave -noupdate -label SCCB_CLK /upv_projekat_dither_vhd_tst/i1/S_C
add wave -noupdate -label RESET /upv_projekat_dither_vhd_tst/i1/reset
add wave -noupdate -label PCLK /upv_projekat_dither_vhd_tst/i1/pclk
add wave -noupdate -label DITHER_Y /upv_projekat_dither_vhd_tst/i1/dither_y
add wave -noupdate -label DITHER_X /upv_projekat_dither_vhd_tst/i1/dither_x
add wave -noupdate -label DITHER_VALID /upv_projekat_dither_vhd_tst/i1/dither_valid
add wave -noupdate -label DITHER_OUT /upv_projekat_dither_vhd_tst/i1/dither_out
add wave -noupdate -label CLK_VGA /upv_projekat_dither_vhd_tst/i1/clk_vga
add wave -noupdate -label CLK_SDRAM /upv_projekat_dither_vhd_tst/i1/clk_sdram
add wave -noupdate -label CLK_CAMCTR /upv_projekat_dither_vhd_tst/i1/clk_cam_ctrl
add wave -noupdate -label CLK_CAM /upv_projekat_dither_vhd_tst/i1/clk_cam
add wave -noupdate -label CLK_50MHZ /upv_projekat_dither_vhd_tst/i1/clk_50
add wave -noupdate -label CAM_VSYNC /upv_projekat_dither_vhd_tst/i1/cam_vsync
add wave -noupdate -label CAM_READ_Y /upv_projekat_dither_vhd_tst/i1/cam_read_y
add wave -noupdate -label CAM_READ_X /upv_projekat_dither_vhd_tst/i1/cam_read_x
add wave -noupdate -label CAM_READ_VALID /upv_projekat_dither_vhd_tst/i1/cam_read_valid
add wave -noupdate -label CAM_READ_R /upv_projekat_dither_vhd_tst/i1/cam_read_R
add wave -noupdate -label CAM_READ_HREF /upv_projekat_dither_vhd_tst/i1/cam_read_href
add wave -noupdate -label CAM_READ_G /upv_projekat_dither_vhd_tst/i1/cam_read_G
add wave -noupdate -label CAM_READ_B /upv_projekat_dither_vhd_tst/i1/cam_read_B
add wave -noupdate -label CAM_HREF /upv_projekat_dither_vhd_tst/i1/cam_href
add wave -noupdate -label CAM_DATA /upv_projekat_dither_vhd_tst/i1/cam_data
add wave -noupdate -label CAM_READ_STATE /upv_projekat_dither_vhd_tst/i1/cam_read_inst/current_state
add wave -noupdate -label DITHER_STATE /upv_projekat_dither_vhd_tst/i1/dither_engine_inst/current_state
add wave -noupdate -label WRITE_LOCAL_ADR /upv_projekat_dither_vhd_tst/i1/write_interface_inst/local_adr
add wave -noupdate -label WRITE_STATE /upv_projekat_dither_vhd_tst/i1/write_interface_inst/current_state
add wave -noupdate -label WRITE_USEDW /upv_projekat_dither_vhd_tst/i1/SDRAM_control_inst/write_usedw
add wave -noupdate -label WR_BUSY /upv_projekat_dither_vhd_tst/i1/SDRAM_control_inst/w_busy
add wave -noupdate -label SDRAM_STATE_CNT /upv_projekat_dither_vhd_tst/i1/SDRAM_control_inst/state_cnt
add wave -noupdate -label READ_USEDW /upv_projekat_dither_vhd_tst/i1/SDRAM_control_inst/read_usedw
add wave -noupdate -label R_BUSY /upv_projekat_dither_vhd_tst/i1/SDRAM_control_inst/r_busy
add wave -noupdate /upv_projekat_dither_vhd_tst/i1/SDRAM_control_inst/fifo_write_usedw
add wave -noupdate /upv_projekat_dither_vhd_tst/i1/SDRAM_control_inst/fifo_write_rdreq
add wave -noupdate /upv_projekat_dither_vhd_tst/i1/SDRAM_control_inst/fifo_write_q
add wave -noupdate /upv_projekat_dither_vhd_tst/i1/SDRAM_control_inst/fifo_read_wrreq
add wave -noupdate /upv_projekat_dither_vhd_tst/i1/SDRAM_control_inst/fifo_read_usedw
add wave -noupdate /upv_projekat_dither_vhd_tst/i1/SDRAM_control_inst/fifo_read_data
add wave -noupdate -label SDRAM_STATE /upv_projekat_dither_vhd_tst/i1/SDRAM_control_inst/current_state
add wave -noupdate -label READ_LOCAL_ADR /upv_projekat_dither_vhd_tst/i1/read_interface_inst/local_adr
add wave -noupdate -label READ_DATA_BUF /upv_projekat_dither_vhd_tst/i1/read_interface_inst/data_buffer
add wave -noupdate -label READ_STATE /upv_projekat_dither_vhd_tst/i1/read_interface_inst/current_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8247720574 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 379
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
WaveRestoreZoom {0 ps} {56814319355 ps}
