
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY GCD_tb IS
END GCD_tb;
 
ARCHITECTURE behavior OF GCD_tb IS 
 
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');

   signal output : std_logic_vector(3 downto 0);
   
begin
 
   uut: entity work.GCD PORT MAP (
          A => A,
          B => B,
          output => output
        );

   process
		begin		
			A <= "1000";
			B <= "0100";
			wait for 50ns;
			
			
			A <= "1010";
			B <= "0110";
			wait for 50ns;
			
			
			A <= "1011";
			B <= "1110";
			wait for 50ns;
			
			
			A <= "1001";
			B <= "0101";
			wait for 50ns;
			
			
			A <= "1110";
			B <= "1010";
			wait for 50ns;
			
			
			A <= "0111";
			B <= "1110";
			wait for 50ns;
			
			wait;
   end process;

END;
