library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_sync_subframe is
	generic (
		-- Default display mode is 1024x768@60Hz -- 65MHz clk
		-- Horizontal line
		H_SYNC	: integer := 136;		-- sync pulse in pixels
		H_BP		: integer := 160;		-- back porch in pixels
		H_FP		: integer := 24;		-- front porch in pixels
		H_DISPLAY: integer := 1024;	-- visible pixels
		-- Vertical line
		V_SYNC	: integer := 6;		-- sync pulse in pixels
		V_BP		: integer := 29;		-- back porch in pixels
		V_FP		: integer := 3;		-- front porch in pixels
		V_DISPLAY: integer := 768;		-- visible pixels
		--Active display area:
		H_ACTIVE_DISP : integer := 640;
		V_ACTIVE_DISP : integer := 480
	);
	port (
		clk : in std_logic;
		reset : in std_logic;
		hsync, vsync : out std_logic;
		sync_n, blank_n : out std_logic;
		xpos : out integer range 0 to H_DISPLAY - 1;
		ypos : out integer range 0 to V_DISPLAY - 1;
		valid : out std_logic;
		Rin, Gin, Bin : in std_logic;
		Rout, Gout, Bout : out std_logic
	);
end vga_sync_subframe;

architecture behavioral of vga_sync_subframe is
	constant X_OFFSET : integer := (H_DISPLAY - H_ACTIVE_DISP) / 2;
	constant Y_OFFSET : integer := (V_DISPLAY - V_ACTIVE_DISP) / 2;

	constant H_PERIOD : integer := H_SYNC + H_BP + H_DISPLAY + H_FP;
	constant V_PERIOD : integer := V_SYNC + V_BP + V_DISPLAY + V_FP;

	signal h_count : integer range 0 to H_PERIOD - 1;
	signal v_count : integer range 0 to V_PERIOD - 1;
	signal disp_ena : std_logic;
	signal next_disp_ena : std_logic;

begin

	sync_n <= '0';		-- no sync on green
	blank_n <= '1';	-- no direct blanking
	
	process (clk, reset) is
	begin
		if (reset = '1') then
			h_count <= 0;
			v_count <= 0;
			hsync <= '1';
			vsync <= '1';
			disp_ena <= '0';
			xpos <= 0;
			ypos <= 0;
			next_disp_ena <= '0';
		elsif (rising_edge(clk)) then
			if (h_count < H_PERIOD - 1) then
				h_count <= h_count + 1;
			else
				h_count <= 0;
				if (v_count < V_PERIOD - 1) then
					v_count <= v_count + 1;
				else
					v_count <= 0;
				end if;
			end if;
			
			-- horizontal sync
			if (h_count < H_DISPLAY + H_FP or h_count > H_DISPLAY + H_FP + H_SYNC) then
				hsync <= '1';
			else
				hsync <= '0';
			end if;
			
			-- vertical sync
			if (v_count < V_DISPLAY + V_FP or v_count > V_DISPLAY + V_FP + V_SYNC) then
				vsync <= '1';
			else
				vsync <= '0';
			end if;
			
			-- set pixel coordinates
			if (h_count < H_ACTIVE_DISP + X_OFFSET and h_count >= X_OFFSET and v_count < V_ACTIVE_DISP + Y_OFFSET and v_count >= Y_OFFSET) then
				xpos <= h_count - X_OFFSET;
				ypos <= v_count - Y_OFFSET;
				valid <= '1';
				next_disp_ena <= '1';
			else 
				valid <= '0';
				next_disp_ena <= '0';
			end if;
			
			-- set disp_ena
			disp_ena <= next_disp_ena;
		end if;
	end process;
	
	Rout <= Rin when disp_ena = '1' else '0';
	Gout <= Gin when disp_ena = '1' else '0';
	Bout <= Bin when disp_ena = '1' else '0';
	
end behavioral;