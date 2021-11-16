library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity FA is
  port (
    X  : in std_logic;
    Y  : in std_logic;
    Cin : in std_logic;
    sum   : out std_logic;
    Cout : out std_logic
    );
end FA;
 
 
architecture RTL of FA is

begin
 
  	sum <= X xor Y xor Cin;
   Cout <= (X and Y) or (X and Cin) or (Y and Cin) ;

end RTL;