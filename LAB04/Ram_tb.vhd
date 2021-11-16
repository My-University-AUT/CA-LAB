
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Ram_tb IS
END Ram_tb;
 
ARCHITECTURE behavior OF Ram_tb IS 
 
   --Inputs
   signal write_en : std_logic := '0';
   signal read_en : std_logic := '0';
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal address : std_logic_vector(4 downto 0) := (others => '0');
   signal din : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal dout : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.Ram PORT MAP (
          write_en => write_en,
          read_en => read_en,
          rst => rst,
          clk => clk,
          address => address,
          dout => dout,
          din => din
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
		
		read_en <= '1';
		address <= "00100";
		
		wait for clk_period;

		address <= "00110";
		
		wait for clk_period;

		address <= "10110";
		
		
		wait for clk_period;
		read_en <= '0';
		write_en <= '1';
		address <= "10010";
		din <= "11111";
		
		wait for clk_period;
		address <= "10001";
		din <= "01110";
		
		
		wait for clk_period;
		address <= "11001";
		din <= "10111";
		
		wait for clk_period;
		read_en <= '1';
		write_en <= '0';
		address <= "10010";
		assert dout="11111" report "error in 10010 address" severity warning;

		
		wait for clk_period;
		address <= "10001";
		assert dout="01110" report "error in 10001 address" severity warning;

		wait for clk_period;
		address <= "11001";
		assert dout="10111" report "error in 11001 address" severity warning;


      wait;
   end process;

END;
