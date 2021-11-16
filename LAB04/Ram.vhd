library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Ram is
    Port ( clk : in  STD_LOGIC;
	        rst : in  STD_LOGIC;
		     write_en : in  STD_LOGIC;
           read_en : in  STD_LOGIC;
           address : in  STD_LOGIC_VECTOR(4 downto 0);
           dout : out  STD_LOGIC_VECTOR(4 downto 0);
			  din : in  STD_LOGIC_VECTOR(4 downto 0));
end Ram;

architecture behavioral of Ram is

	
	-- Depth of memory: 32
	-- Width of memory: 5bit
	-- Address bits: 5
	Type Ram_Array is array (31 downto 0) of STD_LOGIC_VECTOR(4 downto 0);
	
	Signal Memory: Ram_Array;

begin
	
	process(clk, rst)
	begin
		if (rst = '0') then
			for i in 0 to 31 loop
				Memory(i) <= std_logic_vector(to_unsigned(i,5));
			end loop;
		elsif (clk'event and clk = '1') then
			if (write_en = '1' and read_en = '0') then
			
				Memory(to_integer(unsigned(address))) <= din;
			elsif ( read_en = '1' and write_en = '0') then
			
				dout <= Memory( to_integer( unsigned(address) ));
			end if;
		end if;
	end process;


end behavioral;