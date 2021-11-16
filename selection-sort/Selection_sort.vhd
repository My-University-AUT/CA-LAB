library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


package arr_pack is
  type my_array is array (natural range <>) of std_logic_vector(3 downto 0);
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
use work.arr_pack.all;

entity Selection_Sort is
	 generic (SIZE : integer := 10);

	port(
			Arr: in my_array(0 to SIZE-1);
			sorted: out my_array(0 to SIZE-1)
	);


end entity;

architecture Behavioral of Selection_Sort is

begin

	process(Arr)
	
	variable temp: std_logic_vector(3 downto 0);
	variable min_index: integer;
	variable tempRes: my_array(0 to SIZE-1);
	
	begin
		
		tempRes := Arr;
		for i in 0 to (SIZE-2) loop
		
			min_index := i;
			
			for j in i+1 to (SIZE - 1) loop
			
				if unsigned(tempRes(j)) < unsigned(tempRes(min_index)) then
					min_index := j;
					
				end if;
			end loop;
			--swap i with min_index
			temp := tempRes(i);
			tempRes(i) := tempRes(min_index);
			tempRes(min_index) := temp;
		
		end loop;
		
		sorted <= tempRes;			
	end process;
	
	
end Behavioral;

