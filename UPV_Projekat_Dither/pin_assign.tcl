#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF


#RESET
set_location_assignment	PIN_25	-to reset_n

#CLK 50MHz
set_location_assignment	PIN_23	-to clk_50

#SDRAM
set_location_assignment	PIN_28	-to sd_data[0]
set_location_assignment	PIN_30	-to sd_data[1]
set_location_assignment	PIN_31 -to sd_data[2]
set_location_assignment	PIN_32	-to sd_data[3]
set_location_assignment	PIN_33	-to sd_data[4]
set_location_assignment	PIN_34	-to sd_data[5]
set_location_assignment	PIN_38	-to sd_data[6]
set_location_assignment	PIN_39	-to sd_data[7]
set_location_assignment	PIN_54	-to sd_data[8]
set_location_assignment	PIN_53  -to sd_data[9]
set_location_assignment	PIN_52	-to sd_data[10]
set_location_assignment	PIN_51	-to sd_data[11]
set_location_assignment	PIN_50	-to sd_data[12]
set_location_assignment	PIN_49	-to sd_data[13]
set_location_assignment	PIN_46	-to sd_data[14]
set_location_assignment	PIN_44	-to sd_data[15]

set_location_assignment	PIN_76	-to sd_address[0]
set_location_assignment	PIN_77	-to sd_address[1]
set_location_assignment	PIN_80	-to sd_address[2]
set_location_assignment	PIN_83	-to sd_address[3]
set_location_assignment	PIN_68	-to sd_address[4]
set_location_assignment	PIN_67	-to sd_address[5]
set_location_assignment	PIN_66	-to sd_address[6]
set_location_assignment	PIN_65	-to sd_address[7]
set_location_assignment	PIN_64	-to sd_address[8]
set_location_assignment	PIN_60	-to sd_address[9]
set_location_assignment	PIN_75	-to sd_address[10]
set_location_assignment	PIN_59	-to sd_address[11]
set_location_assignment	PIN_73	-to sd_address[12]
set_location_assignment	PIN_74	-to sd_address[13]

set_location_assignment	PIN_43	-to c_sdram
set_location_assignment	PIN_70	-to sd_cas
set_location_assignment	PIN_58	-to sd_cen
set_location_assignment	PIN_71	-to sd_ras
set_location_assignment	PIN_69	-to sd_we
set_location_assignment	PIN_72	-to sd_cs
set_location_assignment	PIN_55	-to sd_dqmh
set_location_assignment	PIN_42	-to sd_dqml

#VGA Builtin
set_location_assignment	PIN_106	-to vga_r
set_location_assignment	PIN_105	-to vga_g
set_location_assignment	PIN_104	-to vga_b

set_location_assignment	PIN_101	-to vga_hsync
set_location_assignment	PIN_103	-to vga_vsync


#OV7670 - Ja ih koristim za kameru, mogu kao GPIO
set_location_assignment	PIN_136	-to cam_data[0] 
set_location_assignment	PIN_137	-to cam_data[1] 
set_location_assignment	PIN_138	-to cam_data[2] 
set_location_assignment	PIN_141	-to cam_data[3] 
set_location_assignment	PIN_142	-to cam_data[4] 
set_location_assignment	PIN_143	-to cam_data[5]  
set_location_assignment	PIN_144	-to cam_data[6]  
set_location_assignment	PIN_1	-to cam_data[7]  
set_location_assignment	PIN_2	-to c_cam
set_location_assignment	PIN_3	-to pclk
set_location_assignment	PIN_10	-to cam_vsync
set_location_assignment	PIN_7	-to cam_href
set_location_assignment	PIN_135	-to S_C
set_location_assignment	PIN_11	-to S_D


# 135  11
# 10  7
# 3   2
# 1   144
# 143 142
# 141 138
# 137 136

# sc    sd
# vsync href
# pclk  xclk
# d7    d6
# d5    d4
# d3    d2
# d1    d0





