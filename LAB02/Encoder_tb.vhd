LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Encoder_tb IS
END Encoder_tb;
 
ARCHITECTURE behavior OF Encoder_tb IS 
    
   --Inputs
   signal I_0 : std_logic := '0';
   signal I_1 : std_logic := '0';
   signal I_2 : std_logic := '0';
   signal I_3 : std_logic := '0';

   --Outputs
   signal O_0 : std_logic;
   signal O_1 : std_logic;
   
 
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: entity work.Encoder4to2 PORT MAP (
          I_0 => I_0,
          I_1 => I_1,
          I_2 => I_2,
          I_3 => I_3,
          O_0 => O_0,
          O_1 => O_1
        );
 
     
	  
  tb_1 : process
	  constant period: time := 10 ns;
	  begin
			I_0 <= '0';
			I_1 <= '0';
			I_2 <= '0';
			I_3 <= '1';

			wait for period;
			assert ((O_0 = '1') and (O_1 = '1'))  --check validation of output
			report "Error in 1000 input" severity error;
			
			I_0 <= '0';
			I_1 <= '0';
			I_2 <= '1';
			I_3 <= '0';

			wait for period;
			assert ((O_0 = '0') and (O_1 = '1'))  --check validation of output
			report "Error in 0100 input" severity error;
			
			
			I_0 <= '0';
			I_1 <= '1';
			I_2 <= '1';
			I_3 <= '0';

			wait for period;
			assert ((O_0 = '0') and (O_1 = '1'))  --check validation of output
			report "Error in 0110 input" severity error;
			
			
			I_0 <= '0';
			I_1 <= '1';
			I_2 <= '0';
			I_3 <= '0';

			wait for period;
			assert ((O_0 = '1') and (O_1 = '0'))  --check validation of output
			report "Error in 0010 input" severity error;
			
			
			
			I_0 <= '1';
			I_1 <= '0';
			I_2 <= '0';
			I_3 <= '0';

			wait for period;
			assert ((O_0 = '0') and (O_1 = '0'))  --check validation of output
			report "Error in 0001 input" severity error;
			
      wait;
   end process;

END;


