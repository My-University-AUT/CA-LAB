library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Ripple_Adder is
	Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
	B : in STD_LOGIC_VECTOR (3 downto 0);
	S : out STD_LOGIC_VECTOR (3 downto 0);
	Cout : out STD_LOGIC);
end Ripple_Adder;

architecture Behavioral of Ripple_Adder is

 -- full adder made by 2 half-adder
	 component full_adder
		Port (A : in STD_LOGIC;
				B : in STD_LOGIC;
				Cin : in STD_LOGIC;
				sum : out STD_LOGIC;
				Cout : out STD_LOGIC);
	 end component full_adder;

	 component half_adder
		Port (A : in STD_LOGIC;
				B : in STD_LOGIC;
				sum : out STD_LOGIC;
				Cout : out STD_LOGIC);
	 end component half_adder;
	 
signal c1,c2,c3: STD_LOGIC;

begin

	-- Port Mapping Full Adder 4 times
	HA1: half_adder port map( A(0), B(0), S(0), c1);
	FA2: full_adder port map( A(1), B(1), c1, S(1), c2);
	FA3: full_adder port map( A(2), B(2), c2, S(2), c3);
	FA4: full_adder port map( A(3), B(3), c3, S(3), Cout);

end Behavioral;