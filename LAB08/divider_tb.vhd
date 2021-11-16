
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY divider_tb IS
END divider_tb;
 
ARCHITECTURE behavior OF divider_tb IS 
 
 
   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal quotient : std_logic_vector(3 downto 0);
   signal reminder : std_logic_vector(3 downto 0);
   signal overflow : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
   uut: entity work.Divider PORT MAP (
          A => A,
          B => B,
          rst => rst,
          clk => clk,
          quotient => quotient,
          reminder => reminder,
          overflow => overflow
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   tb_code: process
   begin		
      rst <= '0';
		
      wait for 30 ns;	

		rst <= '1';
		A <= "10101100";
		B <= "1100";
      -- insert stimulus here 

		
		wait for 250 ns;
		rst <= '0';
		wait for 20 ns;
		rst <= '1';

		rst <= '1';
		A <= "01100101";
		B <= "1011";
		
		
		wait for 250 ns;
		rst <= '0';
		wait for 20 ns;
		rst <= '1';
		
		A <= "11011001";
		B <= "1110";
		
		wait for 250 ns;
		rst <= '0';
		wait for 20 ns;
		rst <= '1';
		--test for overflow

		A <= "11011001";
		B <= "1010";
      wait;
   end process;

END;
