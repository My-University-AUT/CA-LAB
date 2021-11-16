

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


--use IEEE.STD_LOGIC_UNSIGNED.ALL;

--USE ieee.std_logic_arith.ALL;

entity Cache is 
	port (
	clk : in std_logic;
	address: in std_logic_vector (3 downto 0);
	read_en : in std_logic;--to know read address or not
	write_en : in std_logic;--to know write data or not
	data_in : in std_logic_vector(7 downto 0);
	data : out std_logic_vector (7 downto 0);
	hit : out std_logic
	);
end entity;


architecture behavioral of Cache is
	type RAM_Array is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
	--it is broken into 4 block that each block have 4 word(data)
	signal ram : RAM_Array := ( "10101000",
											"01001000",
											"00010101",
											"10111010",
											-----------
											"10101000",
											"01001011",
											"00010101",
											"10111010",
											-----------
											"10101100",
											"01101000",
											"11011101",
											"10101110",
											-----------
											"01111001",
											"01101110",
											"11010101",
											"10111010");
											
	
	--number of ram blocks
	constant size: std_logic_vector(3 downto 0):="0100";

	
	type Way_arr is array (0 to 3) of STD_LOGIC_VECTOR(7 downto 0);
	signal way0 : Way_arr;
	signal Way1 : Way_arr;
	
	signal way0_valid : std_logic := '0';
	signal way1_valid : std_logic := '0';
	signal way0_tag : std_logic_vector(3 downto 0) := "0000";
	signal way1_tag : std_logic_vector(3 downto 0) := "0000";


	begin

	process(clk, read_en, write_en)
		variable tag : std_logic_vector(3 downto 0);
		variable modd: integer;
		
		begin
			if( rising_edge(clk)) then
			
				if(read_en = '1') then
					
					tag := STD_LOGIC_VECTOR( (unsigned(address))/unsigned(size) );
				
					if ( tag=way0_tag and way0_valid='1') then
						modd := to_integer(unsigned(address)) mod to_integer(unsigned(size));
						data <= way0(modd);
						hit <= '1';

					elsif (tag=way1_tag and way1_valid='1') then
						modd := to_integer(unsigned(address)) mod to_integer(unsigned(size));
						data <= way1(modd);
						hit <= '1';

					else
						
						--check that way 0 is empty or not
						if(way0_valid='0') then
							way0_tag <= tag;
							way0(0) <= ram(   to_integer( unsigned(tag)) * to_integer(unsigned(size))   );
							way0(1) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size))) + 1 );
							way0(2) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+2 );
							way0(3) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+3 );
							
							way0_valid <='1';
						elsif (way1_valid='0') then
							way1_tag <= tag;
							way1(0) <= ram(   to_integer( unsigned(tag)) * to_integer(unsigned(size)) );
							way1(1) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+1 );
							way1(2) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+2 );
							way1(3) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+3 );
						
						
							way1_valid <='1';

						else --means 2 ways are full and we should replace block of ram on a cache way
							
							--FIFO policy
							
							--shift way0 to right and way1 is replaced with way0
							way1(0) <= way0(0);
							way1(1) <= way0(1);
							way1(2) <= way0(2);
							way1(3) <= way0(3);
							way1_tag <= way0_tag;
							
							
							--insert new data on ram block into way0 of cache
							way0(0) <= ram(   to_integer( unsigned(tag)) * to_integer(unsigned(size))   );
							way0(1) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+1 );
							way0(2) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+2 );
							way0(3) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+3);
							way0_tag <= tag;

						end if;
						
						hit <='0';
						
					end if;
				
				
				elsif(write_en = '1') then
				
					tag := STD_LOGIC_VECTOR( (unsigned(address))/unsigned(size) );
				
					if ( tag=way0_tag and way0_valid='1') then
						modd := to_integer(unsigned(address)) mod to_integer(unsigned(size));
						
						--update cache block with new data
						way0(modd) <= data_in;
						
						--write back new data from cache into the ram
						ram(to_integer(unsigned(address))) <= way0(modd);

						data <= way0(modd);
						--means data is exist in cache
						hit <= '1';

					elsif (tag=way1_tag and way1_valid='1') then
						modd := to_integer(unsigned(address)) mod to_integer(unsigned(size));
						
						--update cache block with new data
						way1(modd) <= data_in;
						
						--write back new data from cache into the ram
						ram(to_integer(unsigned(address))) <= way1(modd);

						data <= way1(modd);
						
						--means data is exist in cache
						hit <= '1';

					else
						
						--check that way 0 is empty or not
						if(way0_valid='0') then
							way0_tag <= tag;
							way0(0) <= ram(   to_integer( unsigned(tag)) * to_integer(unsigned(size))   );
							way0(1) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size))) + 1 );
							way0(2) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+2 );
							way0(3) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+3 );
							
							
							modd := to_integer(unsigned(address)) mod to_integer(unsigned(size));
							
							
							--update cache block with new data
							way0(modd) <= data_in;
							
							--write back new data from cache into the ram
							ram(to_integer(unsigned(address))) <= way0(modd);

							data <= way0(modd);
							
							way0_valid <='1';
						elsif (way1_valid='0') then
							way1_tag <= tag;
							way1(0) <= ram(   to_integer( unsigned(tag)) * to_integer(unsigned(size)) );
							way1(1) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+1 );
							way1(2) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+2 );
							way1(3) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+3 );
						
						
							modd := to_integer(unsigned(address)) mod to_integer(unsigned(size));
						
							--update cache block with new data
							way1(modd) <= data_in;
							
							--write back new data from cache into the ram
							ram(to_integer(unsigned(address))) <= way1(modd);

							data <= way1(modd);
							
							way1_valid <='1';

						else --means 2 ways are full and we should replace block of ram on a cache way
							
							--FIFO policy
							
							--shift way0 to right and way1 is replaced with way0
							way1(0) <= way0(0);
							way1(1) <= way0(1);
							way1(2) <= way0(2);
							way1(3) <= way0(3);
							way1_tag <= way0_tag;
							
							
							--insert new data on ram block into way0 of cache
							way0(0) <= ram(   to_integer( unsigned(tag)) * to_integer(unsigned(size))   );
							way0(1) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+1 );
							way0(2) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+2 );
							way0(3) <= ram(  (to_integer( unsigned(tag)) * to_integer(unsigned(size)))+3);
							way0_tag <= tag;
							
							
							modd := to_integer(unsigned(address)) mod to_integer(unsigned(size));
						
							--update cache block with new data
							way0(modd) <= data_in;
							
							--write back new data from cache into the ram
							ram(to_integer(unsigned(address))) <= way0(modd);

							data <= way0(modd);

						end if;
						
						hit <='0';
						
					end if;
				
				end if;
				
			end if;
			
		end process;

end behavioral;