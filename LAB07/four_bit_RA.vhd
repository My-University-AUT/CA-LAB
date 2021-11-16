library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity four_bit_RA is
    PORT ( X :  in  STD_LOGIC_VECTOR(3 downto 0);
           Y :  in  STD_LOGIC_VECTOR(3 downto 0);
           Cin: in  STD_LOGIC;
           Cout : out  STD_LOGIC;
           sum : out  STD_LOGIC_VECTOR(3 downto 0));
end four_bit_RA;

architecture Behav of four_bit_RA is

	signal carries : std_logic_VECTOR(2 downto 0);
	
	component FA
			PORT ( X :   in  STD_LOGIC;
					 Y :   in  STD_LOGIC;
					 Cin : in  STD_LOGIC;
					 sum : out STD_LOGIC;
					 Cout: out STD_LOGIC);
	end component;
	
begin
	
	FA_1: FA PORT MAP ( X(0), Y(0), Cin, sum(0), carries(0) );
	FA_2: FA PORT MAP ( X(1), Y(1), carries(0), sum(1), carries(1) );
	FA_3: FA PORT MAP ( X(2), Y(2), carries(1), sum(2), carries(2) );
	FA_4: FA PORT MAP ( X(3), Y(3), carries(2), sum(3), Cout);

end Behav;