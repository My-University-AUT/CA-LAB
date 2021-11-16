LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY subtractor_tb IS
END subtractor_tb;
 
ARCHITECTURE behavior OF subtractor_tb IS 
    

   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');

   signal output : std_logic_vector(31 downto 0);
   signal ready : std_logic;
   signal over_flow : std_logic;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.Subtractor PORT MAP (
          A => A,
          B => B,
			 ready => ready,
			 over_flow => over_flow,
          output => output
        );


   stim_proc: process
   begin		
      A <= "10111110100011010000000000000000";
		B <= "01000011010101011000000000000000";
		wait for 200 ns;

		A <= "01000001011001010000000000000000";
		B <= "01000010010111010000000000000000";
		wait for 200 ns;

		A <= "10111110100111010000000000000000";
		B <= "10111110000111001000000000000000";
		wait for 200 ns;

		A <= "00111111100110110000000000000000";
		B <= "10111110110010101000000000000000";
		wait for 200 ns;
		
		A <= "00111111100110110000000000000000";
		B <= "00111111100110110000000000000000";
		
		
		
		
      wait;
   end process;

END;
