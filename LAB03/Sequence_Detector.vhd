library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sequence_Detector is
port(
	clk: in std_logic;
	rst: in std_logic;
	input: in std_logic;
	output: out std_logic 
);
end Sequence_Detector;

architecture Behavioral of Sequence_Detector is
	type states is (S0, S1, S2, S3, S4, S5, S6, S7, S8);
	signal ps_state, nxt_state : states;

begin


	-- sequential memory of our Moore machine
	process(clk,rst)
	begin
		if(rst='0') then
			ps_state <= S0;
		elsif(rising_edge(clk)) then
			ps_state <= nxt_state;
		end if;
	end process;
	
	-- next state combinational logic
	process(ps_state ,input)
	begin
		case(ps_state) is
			when S0 =>
				if(input='1') then
					nxt_state <= S0;
				else
					nxt_state <= S1;
				end if;
			when S1 =>
				if(input='1') then
					nxt_state <= S0;
				else
					nxt_state <= S2;
				end if;
			when S2 =>
				if(input='1') then
					nxt_state <= S3;
				else
					nxt_state <= S2;
				end if;
			when S3 =>
				if(input='1') then
					nxt_state <= S4;
				else
					nxt_state <= S1;
				end if;
			when S4 =>
				if(input='1') then
					nxt_state <= S5;
				else
					nxt_state <= S1;
				end if;
			when S5 =>
				if(input='1') then
					nxt_state <= S6;
				else
					nxt_state <= S1;
				end if;
			when S6 =>
				if(input='1') then
					nxt_state <= S0;
				else
					nxt_state <= S7;
				end if;
			when S7 =>
				if(input='1') then
					nxt_state <= S0;
				else
					nxt_state <= S8;
				end if;
			when S8 =>
				if(input='1') then
					nxt_state <= S3;
				else
					nxt_state <= S2;
				end if;
			
		 end case;
	end process;
		
	-- evaluate output
	process(ps_state)
	begin 
		if(ps_state=s8) then
			output <= '1';
		else
			output <= '0';
		end if;
		--output <= ((ps_state == S8)? '1' : '0');
	end process;

end Behavioral;

