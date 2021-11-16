
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ripple_adder_tb IS
END ripple_adder_tb;
 
ARCHITECTURE behavior OF ripple_adder_tb IS 
 
   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(3 downto 0);
   signal Cout : std_logic;
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.Ripple_Adder PORT MAP (
          A => A,
          B => B,
          S => S,
          Cout => Cout
        );

  
   stim_proc: process
   begin		
      
		A <= "1011";
		B <= "1100";

		wait for 50 ns;
		
		A <= "0001";
		B <= "1001";
		wait for 50 ns;
		
		A <= "0110";
		B <= "0010";
		wait for 50 ns;
		
		A <= "1010";
		B <= "0101";
		wait for 50 ns;
		
		A <= "1110";
		B <= "0001";
		wait for 50 ns;
		
      wait;
   end process;

END;
