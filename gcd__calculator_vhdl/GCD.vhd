
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;


entity GCD is
port(
	A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	output: out std_logic_vector(3 downto 0)
	);
end GCD;

architecture Behavioral of GCD is
 
begin
	process(A,B)
		variable temp_A : integer;
		variable temp_B : integer;
		--maximum means 1111 and it means 15
		variable maximum: integer:=15;
		begin
		
			temp_A := to_integer(unsigned(A));
			temp_B := to_integer(unsigned(B));
			
			gcd_loop : for k in 1 to maximum loop
								if (temp_A mod k = 0 and temp_B mod k = 0 and k<=temp_B) then
									 output <= std_logic_vector(to_unsigned(k, 4));
								end if;
							end loop gcd_loop;
		end process;

end Behavioral;

