library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity frame_sync is
	port (
		clk : in std_logic;
		reset : in std_logic;
		vsync_cam : in std_logic;
		vsync_vga : in std_logic;
		frame_write : out std_logic_vector(1 downto 0);
		frame_read : out std_logic_vector(1 downto 0)
	);
end frame_sync;

architecture frame_sync_arch of frame_sync is
signal next_frame_read, tmp_frame_read, next_frame_write, tmp_frame_write: std_logic_vector(1 downto 0);
signal vsync_cam_l1, vsync_cam_l2, vsync_vga_l1, vsync_vga_l2: std_logic;
begin

next_state_process:
	process (tmp_frame_read, tmp_frame_write, vsync_cam_l1, vsync_cam_l2, vsync_vga_l1, vsync_vga_l2) is
	begin
		next_frame_read <= tmp_frame_read;
		next_frame_write <= tmp_frame_write;
		if (vsync_cam_l1 = '1' and vsync_cam_l2 = '0') then	--Rising edge
			next_frame_write <= std_logic_vector(unsigned(tmp_frame_write) + 1);
		end if;
		if (vsync_vga_l1 = '1' and vsync_vga_l2 = '0') then 	--Rising edge
			next_frame_read <= std_logic_vector(unsigned(tmp_frame_read) - 1);
		end if;
	end process;

transition_process:
	process (clk, reset) is
	begin
		if (reset = '1') then
			tmp_frame_write <= "01";
			tmp_frame_read <= "00";
			vsync_cam_l2 <= '0';
			vsync_cam_l1 <= '0';
		elsif (rising_edge(clk)) then
			tmp_frame_read <= next_frame_read;
			tmp_frame_write <= next_frame_write;
			vsync_cam_l2 <= vsync_cam_l1;
			vsync_cam_l1 <= vsync_cam;
			vsync_vga_l2 <= vsync_vga_l1;
			vsync_vga_l1 <= vsync_vga;
		end if;
	end process;
	
	frame_write <= tmp_frame_write;
	frame_read <= tmp_frame_read;

	
end frame_sync_arch;