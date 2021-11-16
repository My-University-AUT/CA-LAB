
library ieee;
use ieee.std_logic_1164.all;


entity full_adder_tb is
end full_adder_tb;

architecture test_bench of full_adder_tb is
    signal a, b, cin: std_logic;
    signal sum, carry : std_logic;
begin

    UUT : entity work.full_adder port map (i0 => a, i1 => b, cin => cin, s => sum, cout => carry);

    tb_1 : process
        constant period: time := 10 ns;
        begin
            a <= '0';
            b <= '0';
	    cin <= '0';
            wait for period;
            assert ((sum = '0') and (carry = '0'))  --check validation of output
            report "Error in 000 input" severity error;

            a <= '0';
            b <= '1';
	    cin <= '0';
            wait for period;
            assert ((sum = '1') and (carry = '0'))  --check validation of output
            report "Error in 010 input" severity error;

	    a <= '0';
            b <= '0';
	    cin <= '1';
            wait for period;
            assert ((sum = '1') and (carry = '0'))  --check validation of output
            report "Error in 001 input" severity error;

	    a <= '1';
            b <= '0';
	    cin <= '1';
            wait for period;
            assert ((sum = '0') and (carry = '1'))  --check validation of output
            report "Error in 101 input" severity error;


	    a <= '1';
            b <= '1';
	    cin <= '1';
            wait for period;
            assert ((sum = '1') and (carry = '1'))  --check validation of output
            report "Error in 111 input" severity error;


	    a <= '1';
            b <= '1';
	    cin <= '0';
            wait for period;
            assert ((sum = '0') and (carry = '1'))  --check validation of output
            report "Error in 110 input" severity error;


            wait;
        end process;
end test_bench;