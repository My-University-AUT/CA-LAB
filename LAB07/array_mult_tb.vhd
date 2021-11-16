LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY array_mult_tb IS
END array_mult_tb;
 
ARCHITECTURE behavior OF array_mult_tb IS 
 
 
   --Inputs
   signal X : std_logic_vector(3 downto 0) := (others => '0');
   signal Y : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Product : std_logic_vector(7 downto 0);
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.array_multiplier PORT MAP (
          X => X,
          Y => Y,
          Product => Product
        );
 

   tb_proc: process
   begin		
      
		X <= "1011";
		Y <= "0101";
		
		wait for 80 ns;
		
		X <= "1100";
		Y <= "0110";
		
		wait for 80 ns;
		
		X <= "0100";
		Y <= "1110";
		
		wait for 80 ns;
		
		X <= "1111";
		Y <= "1111";
		
		wait for 80 ns;
		
		X <= "1001";
		Y <= "1001";
		
		wait for 80 ns;
		
		X <= "0101";
		Y <= "0010";
		
      wait;
   end process;

END;
