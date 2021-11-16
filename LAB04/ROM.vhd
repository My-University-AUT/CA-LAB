library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    Port ( clk     : in STD_LOGIC;
			  rst     : in STD_LOGIC;
			  enable  : in STD_LOGIC;
			  read_en : in STD_LOGIC;
			  address : in STD_LOGIC_VECTOR(1 downto 0);
           dout    : out STD_LOGIC_VECTOR(7 downto 0));
end ROM;

architecture behavioral of ROM is
	
	type ROM_Array is array (0 to 3) of STD_LOGIC_VECTOR(7 downto 0);
	constant rom : ROM_Array := ( "10101000",
											"01001000",
											"00010101",
											"10100010");										
begin
	
	process(clk)
		begin
			if(rst='0') then
				dout <= "ZZZZZZZZ";
			elsif(clk'event and clk='1') then
				if( enable = '1') then
					if(read_en = '1') then
						dout <= rom( to_integer(unsigned(address) ));
					else 
						dout <= "ZZZZZZZZ";
					
					end if;
				end if;
			end if;
	end process;		
end behavioral;