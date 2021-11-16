
library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
	Port(
	in1, in2: in std_logic;
	sum, carry : out std_logic
	);
end entity half_adder;


architecture structure of half_adder is
	component xor_gate is
		Port(
			A, B: in std_logic;
			C : out std_logic
		);
	End component xor_gate;

	component and_gate is
		Port(
			A, B: in std_logic;
			C : out std_logic
		);
	End component and_gate;

	begin
		xor_gate_instance0: xor_gate port map ( A => in1, B => in2, C=>sum );
		and_gate_instance0: and_gate port map ( A => in1, B => in2, C=>carry );
	end structure;