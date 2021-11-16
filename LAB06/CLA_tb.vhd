
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY CLA_tb IS
END CLA_tb;
 
ARCHITECTURE behavior OF CLA_tb IS 
 
   

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal Cin : std_logic := '0';

 	--Outputs
   signal S : std_logic_vector(3 downto 0);
   signal Cout : std_logic;
    
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.Carry_Look_Ahead PORT MAP (
          A => A,
          B => B,
          S => S,
          Cout => Cout
        );

   -- Stimulus process
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
