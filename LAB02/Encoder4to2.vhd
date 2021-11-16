
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Encoder4to2 is
    Port ( I_0 : in  STD_LOGIC;
           I_1 : in  STD_LOGIC;
           I_2 : in  STD_LOGIC;
           I_3 : in  STD_LOGIC;
           O_0 : out  STD_LOGIC;
           O_1 : out  STD_LOGIC);
end Encoder4to2;

architecture Behav of Encoder4to2 is

begin

	O_0 <= (I_1 and (not I_2)) or I_3;
	O_1 <= I_2 or I_3;

end Behav;


