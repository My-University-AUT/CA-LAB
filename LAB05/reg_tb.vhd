
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY reg_tb IS
END reg_tb;
 
ARCHITECTURE behavior OF reg_tb IS 
     

   --Inputs
   signal Input : std_logic_vector(2 downto 0) := (others => '0');
   signal clock : std_logic := '0';
   signal load : std_logic := '0';
   signal clear : std_logic := '0';

 	--Outputs
   signal Qout : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clock_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.reg PORT MAP (
          Input => Input,
          clock => clock,
          load => load,
          clear => clear,
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
		clear <= '0';
		load <= '0';
      wait for 20 ns;	
		
		load <= '1';
      wait for clock_period;

		clear <= '1';
		
		Input <= "010";
      wait for clock_period*2;
		
		Input <= "011";
      wait for clock_period*2;
		
		clear <= '0';		
      wait for clock_period;
		
		clear <= '1';
		Input <= "110";

      wait;
   end process;

END;
