library ieee;
use ieee.std_logic_1164.all;


entity half_adder_tb is
end half_adder_tb;

architecture test_bench of half_adder_tb is
    signal a, b : std_logic;
    signal sum, carry : std_logic;
begin

    UUT : entity work.half_adder port map (in1 => a, in2 => b, sum => sum, carry => carry);

    tb_1 : process
        constant period: time := 10 ns;
        begin
            a <= '0';
            b <= '0';
            wait for period;
            assert ((sum = '0') and (carry = '0'))  --check validation of output
            report "Error in 00 input" severity error;

            a <= '0';
            b <= '1';
            wait for period;
            assert ((sum = '1') and (carry = '0'))  --check validation of output
            report "Error in 01 input" severity error;

            a <= '1';
            b <= '0';
            wait for period;
            assert ((sum = '1') and (carry = '0'))
            report "Error in 10 input" severity error;

            a <= '1';
            b <= '1';
            wait for period;
            assert ((sum = '0') and (carry = '1'))
            report "Error in 11 input" severity error;

            wait;
        end process;
end test_bench;
