
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY shift_reg_tb IS
END shift_reg_tb;
 
ARCHITECTURE behavior OF shift_reg_tb IS 
 
   --Inputs
   signal Input : std_logic := '0';
   signal clock : std_logic := '0';
   signal shift : std_logic := '0';

 	--Outputs
   signal Qout : std_logic;

   -- Clock period definitions
   constant clock_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.shift_reg PORT MAP (
          Input => Input,
          clock => clock,
          shift => shift,
          Qout => Qout
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		shift <= '0';
      wait for 20 ns;	
		
		Input <= '1';
		wait for clock_period;
		shift <= '1';
		
      wait for clock_period;
		Input <= '0';
		
      wait for clock_period;
		Input <= '0';

		
      wait for clock_period;
		Input <= '1';


      wait;
   end process;

END;
