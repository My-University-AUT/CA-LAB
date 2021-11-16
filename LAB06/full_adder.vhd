library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity full_adder is
  port (
    A  : in std_logic;
    B  : in std_logic;
    Cin : in std_logic;
    sum   : out std_logic;
    Cout : out std_logic
    );
end full_adder;
 
 
architecture rtl of full_adder is
	
	
	component half_adder
			Port (A : in STD_LOGIC;
					B : in STD_LOGIC;
					sum : out STD_LOGIC;
					Cout : out STD_LOGIC);
	end component;
	
   signal w_WIRE_1 : std_logic;
   signal w_WIRE_2 : std_logic;
   signal w_WIRE_3 : std_logic;
   
begin
 
 
 
  	HA1: half_adder PORT MAP(A, B, w_WIRE_1, w_WIRE_2);
  	HA2: half_adder PORT MAP(Cin, w_WIRE_1, sum, w_WIRE_3);

   Cout <= w_WIRE_3 xor w_WIRE_2;
 
 
 
end rtl;