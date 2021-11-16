library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Partial_Half_Adder is
	Port (A : in STD_LOGIC;
			B : in STD_LOGIC;
			S : out STD_LOGIC;
			P : out STD_LOGIC;
			G : out STD_LOGIC);
end Partial_Half_Adder;

architecture Behavioral of Partial_Half_Adder is

begin
	S <= A xor B;
	P <= A xor B;
	G <= A and B;
end Behavioral;