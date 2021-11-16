
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.arr_pack.all;

 
ENTITY Selection_sort_tb IS
END Selection_sort_tb;
 
ARCHITECTURE behavior OF Selection_sort_tb IS 
 

   signal Arr : my_array(0 to 9);
   signal sorted :  my_array(0 to 9);

  
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.Selection_sort PORT MAP (
          Arr => Arr,
          sorted => sorted
        );
		  
	process
	
   begin
			
			Arr(0) <= "1111";
			Arr(1) <= "1110";
			Arr(2) <= "1101";
			Arr(3) <= "0100";
			Arr(4) <= "1011";
			Arr(5) <= "1010";
			Arr(6) <= "1001";
			Arr(7) <= "1000";			
			Arr(8) <= "0011";
			Arr(9) <= "0110";
			
      wait for 200 ns;	
			Arr(0) <= "0101";
			Arr(1) <= "1110";
			Arr(2) <= "1101";
			Arr(3) <= "1101";
			Arr(4) <= "1001";
			Arr(5) <= "1110";
			Arr(6) <= "0001";
			Arr(7) <= "0100";			
			Arr(8) <= "0001";
			Arr(9) <= "0110";


      wait;
   end process;

END;
