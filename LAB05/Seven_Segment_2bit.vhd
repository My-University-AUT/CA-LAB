
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Seven_Segment_2bit is
Port ( BCDin_1 : STD_LOGIC_VECTOR (3 downto 0);
		 BCDin_0 : STD_LOGIC_VECTOR (3 downto 0);
		 Seven_Segment_1 : out STD_LOGIC_VECTOR (6 downto 0);
		 Seven_Segment_0 : out STD_LOGIC_VECTOR (6 downto 0));

end Seven_Segment_2bit;

architecture Behavioral of Seven_Segment_2bit is

begin

	process(BCDin_1)
	begin

		case BCDin_1 is
			when "0000" =>
			Seven_Segment_1 <= "0000001"; --0
			when "0001" =>
			Seven_Segment_1 <= "1001111"; --1
			when "0010" =>
			Seven_Segment_1 <= "0010010"; --2
			when "0011" =>
			Seven_Segment_1 <= "0000110"; --3
			when "0100" =>
			Seven_Segment_1 <= "1001100"; --4
			when "0101" =>
			Seven_Segment_1 <= "0100100"; --5
			when "0110" =>
			Seven_Segment_1 <= "0100000"; --6
			when "0111" =>
			Seven_Segment_1 <= "0001111"; --7
			when "1000" =>
			Seven_Segment_1 <= "0000000"; --8
			when "1001" =>
			Seven_Segment_1 <= "0000100"; --9
			when others =>
			Seven_Segment_1 <= "1111111"; --null
			end case;

	end process;


	process(BCDin_0)
	begin

		case BCDin_0 is
			when "0000" =>
			Seven_Segment_0 <= "0000001"; --0
			when "0001" =>
			Seven_Segment_0 <= "1001111"; --1
			when "0010" =>
			Seven_Segment_0 <= "0010010"; --2
			when "0011" =>
			Seven_Segment_0 <= "0000110"; --3
			when "0100" =>
			Seven_Segment_0 <= "1001100"; --4
			when "0101" =>
			Seven_Segment_0 <= "0100100"; --5
			when "0110" =>
			Seven_Segment_0 <= "0100000"; --6
			when "0111" =>
			Seven_Segment_0 <= "0001111"; --7
			when "1000" =>
			Seven_Segment_0 <= "0000000"; --8
			when "1001" =>
			Seven_Segment_0 <= "0000100"; --9
			when others =>
			Seven_Segment_0 <= "1111111"; --null
			end case;

	end process;

end Behavioral;
