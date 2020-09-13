ENTITY pll IS
	PORT
	(
		inclk0	: IN STD_LOGIC  := '0';
		c_vga		: OUT STD_LOGIC := '0'; --65MHz
		c_sdram	: OUT STD_LOGIC := '0';	--100MHz
		c_cam		: OUT STD_LOGIC := '0'	--24.074MHz
	);
END pll;


ARCHITECTURE syn OF pll IS
begin
	c_vga <= not c_vga after 8 ns;
	c_sdram <= not c_sdram after 5 ns;
	c_cam <= not c_cam after 20 ns;
end syn;