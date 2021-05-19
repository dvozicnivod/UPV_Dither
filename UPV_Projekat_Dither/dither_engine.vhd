library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--
-- A[     ] B[ 1/4 ] C[ 1/4 ] D[ ERROR_MEMORY[i+2] ]
-- E[ 1/2 ] F[ PXi ] G[     ] H[     ] 
--
-- CURRENT_PIXEL_VALUE[5] - Comes from outside, value at position i
-- CURRENT_ACCUMULATED_VALUE[6] = CURRENT_PIXEL_VALUE + B/4 + C/4 + E/2 
-- CURRENT_DITHERED_OUTPUT[1] = CURRENT_ACCUMULATED_VALUE > 0.5
-- CURRENT_ERROR[5] = CURRENT_ACCUMULATED_VALUE - CURRENT_DITHERED_OUTPUT
-- 
-- ON CLK:
-- B <= C
-- C <= ERROR_MEMORY(i+2), so that at point (i) the memory that is used is MEMORY(i+1)
-- E <= CURRENT_ERROR
-- ERROR_MEMORY(i) <= CURRENT_ERROR
-- i <= i+1 
-- OUTPUT_LATCH <= CURRENT_DITHERED_OUTPUT
-- OUTPUT_X_ADDRESS <= i
-- OUTPUT_Y_ADDRESS <= j
-- 
-- ON LAST ROW (j == HEIGHT-1) LOG 0 into ERROR_MEMORY instead of  CURRENT_ERROR - this resets the memory for the next row!, potentially fill with noise if it helps
-- 
-- ON ENTRY:
-- B <= 0
-- C <= 0
-- E <= 0
-- 
-- 
-- B = TOP_ERROR
-- E = LEFT_ERROR
-- C = RIGHT_ERROR
--
-- current_value_x
-- current_accumulated_value_x <= current_value_x + top_error_x/4 + right_error_x/4 + left_error_x/2;
-- current_dithered_out_x <= '1' when (current_accumulated_value_x > THRESHOLD) else '0';
-- current_error_x <= current_accumulated_value_x - THRESHOLD when (current_dithered_out_x = '1') else current_accumulated_value_x;
	

entity dither_engine is
	generic
	(
		CAM_WIDTH : integer := 8
	);
	port 
	(
		reset : in std_logic;
		clk	: in std_logic;
		valid	: in std_logic;
		v_sync	: in std_logic;
		h_ref	: in std_logic;
		rin, gin, bin	: in std_logic_vector(4 downto 0);
		dither_out : out std_logic;
		xpos_out : out std_logic_vector(9 downto 0); 
		ypos_out : out std_logic_vector(8 downto 0)
	);
end dither_engine;

architecture dither_engine_arch of dither_engine is

	component error_memory IS
		port
		(
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			rdaddress		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			wraddress		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			wren		: IN STD_LOGIC  := '0';
			q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	end component;

	constant THRESHOLD : unsigned(5 downto 0) := to_unsigned(32, 6);
	
	type state_type is ( WAIT_FRAME, WAIT_ROW, WAIT_PIXEL, PROCESS_PIXEL, PRELOAD_1, PRELOAD_2, CLEAR_MEM );
	
	signal current_accumulated_value, current_error : unsigned(5 downto 0);
	signal current_dithered : std_logic;
	signal current_state, next_state : state_type;
	signal next_i, i, next_j, j, next_xpos_out, next_ypos_out, tmp_xpos_out, tmp_ypos_out: unsigned(9 downto 0);
	signal next_B, B, next_C, C, next_E, E : unsigned(5 downto 0);
	signal tmp_dither_out, next_dither_out : std_logic;
	signal mem_write_data, mem_read_data : std_logic_vector(15 downto 0);
	signal mem_write_adr, mem_read_adr : std_logic_vector(9 downto 0);
	signal mem_WE : std_logic;
	
begin

error_memory_instance:	
	error_memory
	port map
	(
		clock => clk,
		data	=> mem_write_data,
		rdaddress => mem_read_adr,
		wraddress => mem_write_adr,
		wren => mem_WE,
		q => mem_read_data
	);

	current_accumulated_value <= unsigned(rin) + B/4 + C/4 + E/2;
	current_dithered <= '1' when (current_accumulated_value >= THRESHOLD) else '0'; --Ili samo top bit!
	current_error <= current_accumulated_value when (current_dithered = '0') else current_accumulated_value - THRESHOLD; --Ili samo skini top bit!
	
next_state_logic:
	process(current_state, v_sync, h_ref, valid, i, j, B, E, C, current_error, mem_read_data, tmp_dither_out, tmp_xpos_out, tmp_ypos_out, current_dithered) is
	begin
		next_state <= current_state;
		next_i <= i;
		next_j <= j;
		next_B <= B;
		next_E <= E;
		next_C <= C;
		next_dither_out <= tmp_dither_out;
		next_xpos_out <= tmp_xpos_out;
		next_ypos_out <= tmp_ypos_out;
		case current_state is
			when WAIT_FRAME =>
				next_i <= to_unsigned(0,10);
				if (v_sync = '0') then
					next_state <= WAIT_ROW;
				else
					next_state <= WAIT_FRAME;
				end if;
			when WAIT_ROW =>
				next_i <= to_unsigned(0,10);
				if (v_sync = '0') then 
					if (h_ref = '1') then 
						next_B <= C;
						next_C <= unsigned('0' & mem_read_data(4 downto 0));
						next_E <= to_unsigned(0,6);
						next_state <= WAIT_PIXEL;
					else
						next_state <= WAIT_ROW;
					end if;
				else
					next_j <= to_unsigned(0,10);
					next_state <= CLEAR_MEM;
				end if;
			when WAIT_PIXEL =>
				if (h_ref = '1') then
					if (valid = '1') then
						next_state <= PROCESS_PIXEL;
					else
						next_state <= WAIT_PIXEL;
					end if;
				else
					next_state <= PRELOAD_1;
				end if;
			when PROCESS_PIXEL =>
				if (h_ref = '1') then
					if (valid = '0') then
						next_i <= i + 1;
						next_B <= C;
						next_C <=  unsigned('0' & mem_read_data(4 downto 0));
						next_E <= current_error;
						next_dither_out <= current_dithered;
						next_xpos_out <= i;
						next_ypos_out <= j;
						next_state <= WAIT_PIXEL;
					else
						next_state <= PROCESS_PIXEL;
					end if;
				else
					next_dither_out <= current_dithered;
					next_xpos_out <= i;
					next_ypos_out <= j;
					next_state <= PRELOAD_1;
				end if;
			when PRELOAD_1 =>
				next_state <= PRELOAD_2;
				next_j <= j + to_unsigned(1,10);
			when PRELOAD_2 =>
				next_state <= WAIT_ROW;
				next_C <= unsigned('0' & mem_read_data(4 downto 0));
			when CLEAR_MEM =>
				if (i = to_unsigned(CAM_WIDTH,10)) then
					next_C <= unsigned('0' & mem_read_data(4 downto 0));			--Kad si vec ovde ocisti i C
					next_state <= WAIT_FRAME;
				else
					next_state <= CLEAR_MEM;
					next_i <= i + to_unsigned(1,10);
				end if;
		end case;
	end process;
	
signal_logic:
	process(current_state, v_sync, h_ref, valid, i, j, B, E, C, current_error, mem_read_data) is
	begin
		mem_read_adr <= std_logic_vector(i + 2);--to_unsigned(2,10);
		mem_write_adr <= std_logic_vector(i);
		mem_write_data <= "00000000000" & (std_logic_vector((current_error(4 downto 0)))); 
		mem_WE <= '0';
		case current_state is
			when WAIT_FRAME =>
				mem_read_adr <= std_logic_vector(to_unsigned(1,10));
			when WAIT_ROW =>
				mem_read_adr <= std_logic_vector(to_unsigned(1,10));
			when WAIT_PIXEL =>
			when PROCESS_PIXEL =>
				mem_WE <= '1';
			when PRELOAD_1 =>
				mem_read_adr <= std_logic_vector(to_unsigned(0,10));
			when PRELOAD_2 =>
				mem_read_adr <= std_logic_vector(to_unsigned(1,10));
			when CLEAR_MEM =>
				mem_WE <= '1';
				mem_write_data <= std_logic_vector(to_unsigned(0,16));
		end case;
	end process;

	
state_transition:
	process(reset, clk) is
	begin
		if (reset = '1') then
			current_state <= WAIT_ROW;
			i <= to_unsigned(0,10);
			j <= to_unsigned(0,10);
			B <= to_unsigned(0,6);
			C <= to_unsigned(0,6);
			E <= to_unsigned(0,6);
			tmp_dither_out <= '0';
			tmp_xpos_out <= to_unsigned(0,10);
			tmp_ypos_out <= to_unsigned(0,10);
		elsif (rising_edge(clk)) then
			current_state <= next_state;
			i <= next_i;
			j <= next_j;
			B <= next_B;
			C <= next_C;
			E <= next_E;
			tmp_dither_out <= next_dither_out;
			tmp_xpos_out <= next_xpos_out;  
			tmp_ypos_out <= next_ypos_out;  
		end if;
	end process;
	dither_out <= tmp_dither_out;
	xpos_out <= std_logic_vector(tmp_xpos_out);  
	ypos_out <= std_logic_vector((tmp_ypos_out(8 downto 0)));  


end dither_engine_arch;
