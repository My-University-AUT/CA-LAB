library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity half_adder is
  port (
    A  : in std_logic;
    B  : in std_logic;
    sum   : out std_logic;
    Cout : out std_logic
    );
end half_adder;

architecture rtl of half_adder is
begin 
  sum  <= A xor B;
  Cout <= A and B;
end rtl;
