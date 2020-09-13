-- Quartus Prime VHDL Template
-- Simple Dual-Port RAM with different read/write addresses but
-- single read/write clock

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dither_engine is
	generic
	(
		CAM_WIDTH : integer := 15
	);
	port 
	(
		reset : in std_logic;
		clk	: in std_logic;
		valid	: in std_logic;
		Vsync	: in std_logic;
		rin, gin, bin	: in std_logic_vector(4 downto 0);
		rgb_out	: out std_logic_vector(2 downto 0) := "000"; --rgb
		w_e	: out std_logic := '0';
		adr	: out std_logic_vector(18 downto 0)
	);
end dither_engine;

architecture dither_engine_arch of dither_engine is

	subtype word_t is signed(4 downto 0);	--5o bitni podaci
	type memory_t is array(CAM_WIDTH-1 downto 0) of word_t;
	type state_type is ( WAIT_FRAME, WAIT_ROW, WAIT_PIXEL, PROCESS_PIXEL );
	
	signal count : integer range 0 to 307200 := 0; --max br piksela, jbg da ne komplikujem
	signal r_row, g_row, b_row : memory_t := (others => "00000");
	signal r_acum_error, r_current_value, r_current_error, r_back, r_error : signed(5 downto 0) := "000000";
	signal g_acum_error, g_current_value, g_current_error, g_back, g_error : signed(5 downto 0) := "000000";
	signal b_acum_error, b_current_value, b_current_error, b_back, b_error : signed(5 downto 0) := "000000";
	signal position : integer range 0 to CAM_WIDTH-1 :=0;
	signal current_state, next_state : state_type;

begin
	
	adr <= (others => '0') when (count = 0) else std_logic_vector(to_unsigned(count - 1,19)) ;

	r_acum_error <= r_row(position) + r_error; --6 bitna stvar za racun, 5 bita nadalje
	g_acum_error <= g_row(position) + g_error; 
	b_acum_error <= b_row(position) + b_error; 
	
	r_current_value <= signed('0' & rin) + r_acum_error(5 downto 1) - "010000";	--pitam se dal to moze tako /2, also signed, unsigned?, 6 bitni, oduzmemo 16 da ofsetujemo din, pazi duzinu reci
	g_current_value <= signed('0' & gin) + g_acum_error(5 downto 1) - "010000";
	b_current_value <= signed('0' & bin) + b_acum_error(5 downto 1) - "010000";
	
	r_back <= r_error + r_current_error(4 downto 0); --ovo se obavlja na 5+5 => 6 bita zbog lsb 
	g_back <= g_error + g_current_error(4 downto 0); 
	b_back <= b_error + b_current_error(4 downto 0); 
	
next_state_logic:
	process(r_current_value,g_current_value,b_current_value,current_state,Vsync,valid) is
	begin
		--ok fora sa current r_error je sto je 6-bitni ali koristi samo donjih 5 bitova jer se ovde efektivno skracuje
		case r_current_value(5) is
			when '0' =>			--pozitivan i 0
				r_current_error <= r_current_value - "001111"; --oduzme se gornja crta(15)
			when '1' =>			--negativan
				r_current_error <= r_current_value + "010000"; --oduzme se donja crta(tj doda 16)
			when others =>		--nije kriticno, samo da se ne lecuje, idealno dont care
				r_current_error <= "000000";
		end case;	--pazi sa ovim, current r_error ne treba da koristi msb, 
		case g_current_value(5) is
			when '0' =>	
				g_current_error <= g_current_value - "001111";
			when '1' =>
				g_current_error <= g_current_value + "010000";
			when others =>	
				g_current_error <= "000000";
		end case; 	
		case b_current_value(5) is
			when '0' =>	
				b_current_error <= b_current_value - "001111";
			when '1' =>	
				b_current_error <= b_current_value + "010000";
			when others =>		
				b_current_error <= "000000";
		end case; 	
		case current_state is
			when WAIT_FRAME =>
				if (Vsync = '1') then
					next_state <= WAIT_FRAME;
				else
					next_state <= WAIT_ROW;
				end if;
			when WAIT_ROW =>
				if (Vsync = '1') then
					next_state <= WAIT_FRAME;
				elsif (valid = '1') then
					next_state <= PROCESS_PIXEL;
				else
					next_state <=WAIT_ROW;
				end if;
			when PROCESS_PIXEL =>
				next_state <= WAIT_PIXEL;
			when WAIT_PIXEL =>
				if (valid = '1') then
					next_state <= PROCESS_PIXEL;
				else
					next_state <= WAIT_ROW;
				end if;
		end case;
	end process;

state_transition:	
	process(reset, clk) is
	begin
		if (reset = '1') then
			w_e <= '0';
			r_error <= (others => '0');
			g_error <= (others => '0');
			b_error <= (others => '0');
			rgb_out <= "000";
			position <= 0;
			r_row <= (others => (others => '0')); --reset na 0
			g_row <= (others => (others => '0'));
			b_row <= (others => (others => '0'));
			current_state <= WAIT_FRAME;
			count <= 0;
		elsif (falling_edge(clk)) then
			w_e <= valid;
			current_state <= next_state;
			case next_state is
				when WAIT_FRAME =>
					--ovde bi mozda trebalo da resetujemo row, ali mislim da bi mu taj dodatni randomness pomogao
					count <= 0;
				when WAIT_ROW =>
					position <= 0;  --reset value
					if (current_state = WAIT_PIXEL) then  
						r_row(CAM_WIDTH-1) <= r_error(4 downto 0);
						g_row(CAM_WIDTH-1) <= g_error(4 downto 0);
						b_row(CAM_WIDTH-1) <= b_error(4 downto 0);
					end if;
				when PROCESS_PIXEL =>
					r_error <= r_current_error;  --nebitno, cuvamo 6 bita ipak
					g_error <= g_current_error; 
					b_error <= b_current_error; 
					if (current_state = WAIT_PIXEL) then
						r_row(position - 1) <= r_back(5 downto 1); --pazi na duzine,nizi bit je bitan za racun ali ne i za 
						g_row(position - 1) <= g_back(5 downto 1);
						b_row(position - 1) <= b_back(5 downto 1);
					end if;
					rgb_out <= NOT (r_current_value(5) & g_current_value(5) & b_current_value(5));
						count <= count + 1;
				when WAIT_PIXEL =>
					if NOT (position = CAM_WIDTH-1) then
						position <= position + 1;
					else
						position <= CAM_WIDTH-1;
					end if;
				--dont need anything here either, could be we only need the 2 states :/
			end case;
		end if;
	end process;

end dither_engine_arch;
