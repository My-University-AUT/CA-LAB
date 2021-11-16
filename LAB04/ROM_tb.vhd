
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ROM_tb IS
END ROM_tb;
 
ARCHITECTURE behavior OF ROM_tb IS 
 
   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal enable : std_logic := '0';
   signal read_en : std_logic := '0';
   signal address : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal dout : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.ROM PORT MAP (
          clk => clk,
          rst => rst,
          enable => enable,
          read_en => read_en,
          address => address,
          dout => dout
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '0';
		
      wait for clk_period/2;
		rst <= '1';
		enable<='0';
		read_en<='1';
		address<="00";
		wait for clk_period;
		enable<='1';
		wait for clk_period;
		address<="00";
		
		wait for clk_period;
		address<="01";
		
		wait for clk_period;
		address<="10";
		
		wait for clk_period;
		address<="11";

      wait;
   end process;

END;
