
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SevenSegment_tb IS
END SevenSegment_tb;
 
ARCHITECTURE behavior OF SevenSegment_tb IS 
 
   --Inputs
   signal BCDin_1 : std_logic_vector(3 downto 0) := (others => '0');
   signal BCDin_0 : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Seven_Segment_1 : std_logic_vector(6 downto 0);
   signal Seven_Segment_0 : std_logic_vector(6 downto 0);
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.Seven_Segment_2bit PORT MAP (
          BCDin_1 => BCDin_1,
          BCDin_0 => BCDin_0,
          Seven_Segment_1 => Seven_Segment_1,
          Seven_Segment_0 => Seven_Segment_0
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
	
      wait for 50 ns;	
		BCDin_1 <= "0010";
		BCDin_0 <= "1001";
		assert Seven_Segment_1 /= "0010010" or Seven_Segment_0 /= "0000100" report "error in showing 29" severity warning;


		wait for 50 ns;	
		BCDin_1 <= "0100";
		BCDin_0 <= "0101";
		assert Seven_Segment_1 /= "1001100" or Seven_Segment_0 /= "0100100" report "error in showing 45" severity warning;

		wait for 50 ns;	
		BCDin_1 <= "0000";
		BCDin_0 <= "0010";
		assert Seven_Segment_1 /= "0000001" or Seven_Segment_0 /= "0010010" report "error in showing 02" severity warning;


      wait;
   end process;

END;
