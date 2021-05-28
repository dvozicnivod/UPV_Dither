library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cam_sim_tst is
	port
	(
		pclk :out std_logic;
        clk_cam : in std_logic;
        S_C : in std_logic;    
        S_D : in std_logic;    
        cam_href : out std_logic;    
        cam_vsync : out std_logic;   
        cam_data : out std_logic_vector (7 downto 0)
	);
end cam_sim_tst;

architecture testbench of cam_sim_tst is
CONSTANT RED : std_logic_vector(4 downto 0) := "10101";
CONSTANT GREEN : std_logic_vector(4 downto 0)  := "10101";
CONSTANT BLUE : std_logic_vector(4 downto 0)  := "10101";
constant TP : time := 83 ns;
constant TLINE : time := TP * 784;
signal cam_href_cont, cam_href_ctr, href_int : std_logic;
signal clk_tmp : std_logic := '0';
signal data_cont : std_logic_vector(7 downto 0);
begin

pclk <= clk_tmp;

clk_tmp <= not clk_tmp after TP/4;

vsync_proc:
	process is
	begin
		cam_vsync <= '1';
		wait for 3 * TLINE;
		cam_vsync <= '0';
		wait for 507 * TLINE;
	end process;
	
href_proc:
	process is
	begin
		cam_href_cont <= '1';
		wait for 640 * TP;
		cam_href_cont <= '0';
		wait for 144 * TP;
	end process;
	
href_ctr_proc:
	process is
	begin
		cam_href_ctr <= '0';
		wait for 20 * TLINE;
		cam_href_ctr <= '1';
		wait for 480 * TLINE;
		cam_href_ctr <= '0';
		wait for 10 * TLINE;
	end process;
	
data_proc:
	process is
	begin
		data_cont <= "0" & (RED(4 downto 0)) & (GREEN(4 downto 3));
		wait for TP/2;
		data_cont <= GREEN(2 downto 0) & BLUE(4 downto 0);
		wait for TP/2;
	end process;
	
	href_int <= cam_href_cont when (cam_href_ctr = '1') else '0';
	cam_href <= href_int;
	cam_data <= data_cont when (href_int = '1') else (others => '0');

END testbench;