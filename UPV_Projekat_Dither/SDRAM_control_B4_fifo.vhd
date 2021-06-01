library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--BURST 4!!
--Also redo for state machine

--When given a new address on read or write it will read/ write the date on the data line
--into memory and output a 1 on the complete line
--must give it at least 5% of unused time for refreshing, continuous use no more than 60ms
--read has priority over write
--after reset cannot read 0 address initially. lol, doesn't need to be perfect :)
--FOR USE WITH 64Mbit SDRAM at 100MHz , cas 2, 2B output

entity SDRAM_control_B4_fifo is
	port
	(
		reset 	: in	std_logic;
		clk		: in	std_logic;
		--Control signals
		wrclk, rdclk : in std_logic;
		wrreq, rdreq, wr_reset, rd_reset: in std_logic;
		write_d	:	in std_logic_vector(63 downto 0);
		read_q	:	out std_logic_vector(63 downto 0);
		read_usedw, write_usedw : out std_logic_vector(5 downto 0);
		--Interface with SDRAM
		a_sdram 	: 	out std_logic_vector(13 downto 0);	--top 2 bits bank select
		dq_sdram : 	inout std_logic_vector(15 downto 0);
		cs_n		:	out std_logic;
		ras_n		:	out std_logic;
		cas_n 	:	out std_logic;
		dqmh,dqml:	out std_logic;
		we_n		:	out std_logic;
		clk_en	:	out std_logic
	);
end SDRAM_control_B4_fifo;

--TODO!!!

architecture SDRAM_control_arch of SDRAM_control_B4_fifo is


	component sdram_fifo is
		port
		(
			aclr		: in std_logic  := '0';
			data		: in std_logic_vector (63 downto 0);
			rdclk		: in std_logic ;
			rdreq		: in std_logic ;
			wrclk		: in std_logic ;
			wrreq		: in std_logic ;
			q			: out std_logic_vector (63 downto 0);
			rdusedw		: out std_logic_vector (5 downto 0);
			wrusedw		: out std_logic_vector (5 downto 0)
		);
	end component;
	
	constant MAX_USEDW : integer := 4;
	constant SETUP_CYCLES:integer := 5; --32768;
	constant INIT_CYCLES :integer :=  SETUP_CYCLES + 2 + 8*8 + 2;
	
	type state_type is ( IDLE, INIT, READ_CYCLE, WRITE_CYCLE, REFRESH_CYCLE );
	type data_machine is ( WAIT_DATA, LATCH_DATA );
	
	signal state_cnt, next_state_cnt : integer range 0 to 15 := 0;
	signal init_cnt, next_init_cnt : integer range 0 to INIT_CYCLES := 0;
	signal current_state, next_state : state_type := INIT;
	signal p_a_read, p_a_write : std_logic_vector(21 downto 0);
	signal a_sdram_l :std_logic_vector(13 downto 0);
	signal read_req, write_req, cs_n_l, ras_n_l, cas_n_l, dqmh_l, dqml_l, we_n_l: std_logic;
	signal d_sdram_l, q_sdram_l, d_sdram :std_logic_vector(15 downto 0);
	signal output_en, next_output_en : std_logic;
	
	signal read_state, next_read_state, write_state, next_write_state : data_machine;
	signal next_d_write, d_write, d_read, next_fifo_read_data, fifo_read_data, fifo_write_q : std_logic_vector(63 downto 0);
	signal next_a_write, a_write, next_a_read, a_read : std_logic_vector(21 downto 0);
	signal next_fifo_write_rdreq, fifo_write_rdreq, next_fifo_read_wrreq, fifo_read_wrreq : std_logic;
	signal fifo_read_usedw, fifo_write_usedw : std_logic_vector(5 downto 0);
	
	signal w_busy, r_busy : std_logic;
	
	
	
begin

fifo_machine_next_state: process (read_state, write_state, d_write, a_write, fifo_read_data, a_read, wr_reset, rd_reset, w_busy, r_busy, fifo_write_usedw, fifo_read_usedw, fifo_write_q, d_read) is
	begin
			next_read_state <= read_state; 
			next_write_state <= write_state;
			
			next_d_write <= d_write;
			next_a_write <= a_write;
			next_fifo_write_rdreq <= '0';
			
			next_fifo_read_data <= fifo_read_data;
			next_a_read <= a_read;
			next_fifo_read_wrreq <= '0';
			
			if (wr_reset = '1') then
				next_a_write <= std_logic_vector(to_unsigned(2**22-4,22));
				next_write_state <= WAIT_DATA;
			else
				case (write_state) is
					when WAIT_DATA =>
						if (w_busy = '0' and unsigned(fifo_write_usedw) > 0) then
							next_write_state <= LATCH_DATA;
							next_d_write <= fifo_write_q;
							next_a_write <= std_logic_vector(unsigned(a_write) + 4);
							next_fifo_write_rdreq <= '1';
						else
							next_write_state <= WAIT_DATA;
						end if;
					when LATCH_DATA =>
						next_write_state <= WAIT_DATA;
				end case;
			end if;
			
			if (rd_reset = '1') then
				next_a_read <=  std_logic_vector(to_unsigned(2**22-4,22));
				next_read_state <= WAIT_DATA;
			else
				case (read_state) is
					when WAIT_DATA =>
						if (r_busy = '0' and unsigned(fifo_read_usedw) < MAX_USEDW - 1) then
							next_read_state <= LATCH_DATA;
							next_a_read <= std_logic_vector(unsigned(a_read) + 4);
						else
							next_read_state <= WAIT_DATA;
						end if;
					when LATCH_DATA =>
						if (r_busy = '1') then
							next_read_state <= LATCH_DATA;
						else
							next_fifo_read_data <= d_read;
							next_fifo_read_wrreq <= '1';
							if ( unsigned(fifo_read_usedw) < MAX_USEDW - 2) then
								next_read_state <= LATCH_DATA; --RELATCH with 0 delay
								next_a_read <= std_logic_vector(unsigned(a_read) + 4);
							else
								next_read_state <= WAIT_DATA;
							end if;
						end if;
				end case;
			end if;
	end process;
	
	fifo_transition_process:process (reset, clk) is
	begin
		if (reset = '1') then
			read_state <= WAIT_DATA;
			write_state <= WAIT_DATA;
			d_write <= (others => '0');
			a_write <= (others => '1');
			a_read <= (others => '1');
			fifo_read_wrreq <= '0';
			fifo_write_rdreq <= '0';
			fifo_read_data <= (others => '0');
		elsif (rising_edge(clk)) then
			read_state <= next_read_state;
			write_state <= next_write_state;
			d_write <= next_d_write;
			a_write <= next_a_write;
			a_read <= next_a_read;
			fifo_read_wrreq <= next_fifo_read_wrreq;
			fifo_write_rdreq <= next_fifo_write_rdreq;
			fifo_read_data <= next_fifo_read_data;
		end if;
	end process;

write_fifo_inst:sdram_fifo
		port map
		(
			aclr 	=> wr_reset,
			data	=> write_d,
			rdclk	=> clk,
			rdreq	=> fifo_write_rdreq,
			wrclk	=> wrclk,
			wrreq	=> wrreq,
			q		=> fifo_write_q,
			rdusedw	=> fifo_write_usedw,
			wrusedw	=> write_usedw
		);
		
read_fifo_inst:sdram_fifo
		port map
		(
			aclr 	=> rd_reset,
			data	=> fifo_read_data,
			rdclk	=> rdclk,
			rdreq	=> rdreq,
			wrclk	=> clk,
			wrreq	=> fifo_read_wrreq,
			q		=> read_q,
			rdusedw	=> read_usedw,
			wrusedw	=> fifo_read_usedw
		);

	




	clk_en <= '1';
	read_req <= '0' when (a_read = p_a_read) else '1';
	write_req <= '0' when (a_write = p_a_write) else '1';
	w_busy <= '1' when write_req = '1' or current_state = INIT else '0';
	r_busy <= '1' when read_req = '1' or current_state = INIT else '0';
	
--	done <= '1' when ((current_state = IDLE) or (current_state = REFRESH_CYCLE)) else '0';
	

next_state_logic:
	process (current_state, write_req, read_req, init_cnt, state_cnt) is
	begin
		next_init_cnt <= 0;
		case (current_state) is
			when INIT =>
				next_state_cnt <= 0;
				if not(init_cnt = INIT_CYCLES) then
					next_state <= INIT;
					next_init_cnt <= init_cnt + 1;
				else
					next_state <= IDLE;
					next_init_cnt <= 0;
				end if;
			when IDLE =>
				next_state_cnt <= 1;
				if (read_req = '1') then			--Used to be read_req_l but was causing redundant reads/ writes
					next_state <= READ_CYCLE;
				elsif (write_req = '1') then
					next_state <= WRITE_CYCLE;
				else
					next_state <= REFRESH_CYCLE;
				end if;
			when REFRESH_CYCLE =>
			--This is according to Trc = 70ns -> 7 cycles between two ACT/REFR
				if (state_cnt = 6) then
					next_state_cnt <= 0;
					next_state <= IDLE;
				else
					next_state_cnt <= state_cnt + 1;
					next_state <= current_state;
				end if;
			when OTHERS =>
				if (state_cnt = 9) then
					next_state_cnt <= 0;
					next_state <= IDLE;
				else
					next_state_cnt <= state_cnt + 1;
					next_state <= current_state;
				end if;
		end case;
	end process;
	
state_transition:
	process (reset, clk) is
	begin
		if (reset = '1') then
			current_state <= INIT;
			p_a_read <= (others => '0');
			p_a_write <= (others => '0');
			state_cnt <= 0;
			init_cnt <= 0;
		elsif (falling_edge(clk)) then
--			read_req_l <= read_req;
--			write_req_l <= write_req;
			current_state <= next_state;
			state_cnt <= next_state_cnt;
			init_cnt <= next_init_cnt;
			case (current_state) is
				when READ_CYCLE =>
					if (state_cnt = 8) then
						p_a_read <= a_read;
					end if;
				when WRITE_CYCLE =>
					if (state_cnt = 8) then 
						p_a_write <= a_write;
					end if;
				when OTHERS =>
			end case;
		end if;
	end process;
	
	
--read_latch_process:


--There is a parameter of minimum hold time for data out of 2.5ns, so we should probably sample on the rising edge
Q_latch_process:
	process(reset, clk) is 
	begin 
		if(reset = '1') then
			q_sdram_l <= (others => '1');
		elsif(rising_edge(clk)) then
			q_sdram_l <=  dq_sdram;
		end if;
	end process; 


--read_latch_process:
--	process (clk) is
--	begin
--		if (rising_edge(clk)) then		--bilo_falling TODO
--			if (current_state = READ_CYCLE) then
--				if (state_cnt = 7) then			--bilo 6 TODO
--					d_read(15 downto 0) <= dq_sdram;
--				elsif (state_cnt = 8) then
--					d_read(31 downto 16) <= dq_sdram;
--				end if;
--			end if;
--		end if;
--	end process;
	
	
--Made according to current state and then latched to output on falling edge of same state!
output_logic:
	process(a_read, a_write, d_write, next_state, next_state_cnt, next_init_cnt) is
	begin
		cs_n_l <= '1';
		ras_n_l <= '1';
		cas_n_l <= '1';
		dqmh_l <= '1';
		dqml_l <= '1';
		a_sdram_l <= (others => '1');
		we_n_l <= '1';
		d_sdram_l <= (others => '0');
		next_output_en <= '0';
		case (next_state) is
			when INIT =>
				case (next_init_cnt) is
					when SETUP_CYCLES =>
						cs_n_l <= '0';
						ras_n_l <= '0';
						we_n_l <= '0';
						a_sdram_l(10) <= '1'; --nepotrebno
					when SETUP_CYCLES+2 | SETUP_CYCLES+2+8 | SETUP_CYCLES+2+8*2 | SETUP_CYCLES+2+8*3 | SETUP_CYCLES+2+8*4 | SETUP_CYCLES+2+8*5 | SETUP_CYCLES+2+8*6 | SETUP_CYCLES+2+8*7 =>
						cs_n_l <= '0';
						cas_n_l <= '0';
						ras_n_l <= '0';
					when SETUP_CYCLES+2+8*8 -1 => 
						a_sdram_l(12 downto 0) <= "0000000100010"; --burst from low bits, cas 2, serial read, burst 2  for security one before TODO
					when SETUP_CYCLES+2+8*8 => 
						cs_n_l <= '0';
						cas_n_l <= '0';
						ras_n_l <= '0';
						we_n_l <= '0';
						a_sdram_l(12 downto 0) <= "0000000100010"; --burst from low bits, cas 2, serial read, burst 2
					when others =>
				end case;
			when IDLE =>
			when READ_CYCLE =>
				case (next_state_cnt) is
					when 1 =>
						--activate row command
						cs_n_l <= '0';
						ras_n_l <= '0';
						we_n_l <= '1';
						a_sdram_l <= a_read(21 downto 8);
					when 3 =>
						--read collumn +PC command
						cs_n_l <= '0';
						cas_n_l <= '0';    
						a_sdram_l(7 downto 0) <= a_read(7 downto 0);
						a_sdram_l(13 downto 12) <= a_read(21 downto 20); --ovo je bank
						a_sdram_l(10) <= '1';	--znaci odradi PC
						dqmh_l <= '0';
						dqml_l <= '0';
					when 4 =>
						dqmh_l <= '0';	--Burst 2/4
						dqml_l <= '0';
					when 5 =>
						dqmh_l <= '0';	--Burst 3/4
						dqml_l <= '0';
					when 6 =>
						dqmh_l <= '0';	--Burst 4/4
						dqml_l <= '0';
					when others =>
				end case;
			when WRITE_CYCLE =>
				case (next_state_cnt) is
					when 1 =>
						--activate row command
						cs_n_l <= '0';
						ras_n_l <= '0';
						we_n_l <= '1';	
						a_sdram_l <= a_write(21 downto 8);
					when 3 =>
						--write collumn +PC command
						cs_n_l <= '0';
						cas_n_l <= '0';    
						we_n_l <= '0';
						a_sdram_l(7 downto 0) <= a_write(7 downto 0);
						a_sdram_l(13 downto 12) <= a_write(21 downto 20); --ovo je bank
						a_sdram_l(10) <= '1';	--znaci da odradi PC
						dqmh_l <= '0';
						dqml_l <= '0';
						d_sdram_l <= d_write(15 downto 0);
						next_output_en <= '1';
					when 4 =>
						dqmh_l <= '0';			--BURST 2/4
						dqml_l <= '0';
						d_sdram_l <= d_write(31 downto 16);
						next_output_en <= '1';
					when 5 =>
						dqmh_l <= '0';			--BURST 3/4
						dqml_l <= '0';
						d_sdram_l <= d_write(47 downto 32);
						next_output_en <= '1';
					when 6 =>
						dqmh_l <= '0';			--BURST 4/4
						dqml_l <= '0';
						d_sdram_l <= d_write(63 downto 48);
						next_output_en <= '1';
					when others =>
				end case;
			when REFRESH_CYCLE =>
				if (next_state_cnt = 1) then
					cs_n_l <= '0';
					cas_n_l <= '0';
					ras_n_l <= '0';
					we_n_l <= '1';
				end if;
		end case;
		--These can just always be on since it's only one IC
		--cs_n_l <= '0';
		--dqml_l <= '0';
		--dqmh_l <= '0';
	end process;
	
output_latch_process:
	process (reset, clk) is
	begin
		if (reset = '1') then
			cs_n <= '1';
			ras_n <= '1';
			cas_n <= '1';
			dqmh <= '1';
			dqml <= '1';
			a_sdram <= (others => '1');
			we_n <= '1';
			d_sdram <= (others => '0');
			output_en <= '0';
		elsif (falling_edge(clk)) then
			cs_n 	<= cs_n_l;
			ras_n <= ras_n_l;
			cas_n <= cas_n_l;
			dqmh <= dqmh_l;
			dqml <= dqml_l;
			a_sdram <= a_sdram_l;
			we_n 	<= we_n_l;	
			d_sdram <= d_sdram_l;
			output_en <= next_output_en;
		end if;
	end process;
	
dq_sdram <= d_sdram when (output_en = '1') else (others => 'Z');	
	
input_latch_process:
	process (reset, clk)
	begin
		if (reset = '1') then
			d_read <= (others => '0');
		elsif (falling_edge(clk)) then
			if (current_state = READ_CYCLE) then
				case (state_cnt) is
					when 5 =>
						d_read(15 downto 0) <= q_sdram_l;
					when 6 =>
						d_read(31 downto 16) <= q_sdram_l;
					when 7 =>
						d_read(47 downto 32) <= q_sdram_l;
					when 8 =>
						d_read(63 downto 48) <= q_sdram_l;
					when others =>
				end case;
			end if;
		end if;
	end process;
	
	
end SDRAM_control_arch;
