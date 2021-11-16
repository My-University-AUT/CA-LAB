
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY detector_tb IS
END detector_tb;
 
ARCHITECTURE behavior OF detector_tb IS 
  
   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal input : std_logic := '0';

 	--Output
   signal output : std_logic;

   -- period of clock
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate Unit Under Test(uut)
   uut: entity work.Sequence_Detector PORT MAP (
          clk => clk,
          rst => rst,
          input => input,
          output => output
        );

   -- generate clock
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   tb_process: process
   begin		
      -- hold reset state for 5 ns(half of clouck perioud).
		rst <= '0';
      wait for clk_period/2;
      rst <= '1';
		input <= '1';
		
      wait for clk_period;
		input <= '0';
		
		wait for clk_period;
		input <= '0';
		
		wait for clk_period;
		input <= '1';
		
		wait for clk_period;
		input <= '1';
		
		wait for clk_period;
		input <= '1';
		
		wait for clk_period;
		input <= '1';
		
		wait for clk_period;
		input <= '0';
		
		wait for clk_period;
		input <= '0';
		
		wait for clk_period;
		input <= '1';
		
		wait for clk_period;
		input <= '1';
		
		wait for clk_period;
		input <= '1';
		
		wait for clk_period;
		input <= '1';
		
		wait for clk_period;
		input <= '0';
		
		wait for clk_period;
		input <= '0';
		
		wait for clk_period;
		input <= '1';
		
		
      wait;
   end process;

END;
