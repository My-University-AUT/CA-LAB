LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY CarrySaveAdder_tb IS
END CarrySaveAdder_tb;
 
ARCHITECTURE behavior OF CarrySaveAdder_tb IS 

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal C : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(4 downto 0);
   signal Cout : std_logic;
   
BEGIN
 
   uut: entity work.carry_save_adder PORT MAP (
          A => A,
          B => B,
          C => C,
          S => S,
          Cout => Cout
        );

   -- Stimulus process
   stim_proc: process
   begin		
      A <= "1011";
		B <= "1100";
		C <= "1101";
		wait for 50 ns;
		
		A <= "0001";
		B <= "1001";
		C <= "0011";

		wait for 50 ns;
		
		A <= "0110";
		B <= "0010";
		C <= "1001";

		wait for 50 ns;
		
		A <= "1010";
		B <= "0101";
		C <= "1101";

		wait for 50 ns;
		
		A <= "1110";
		B <= "0001";
		C <= "1101";

		wait for 50 ns;

      wait;
   end process;

END;
