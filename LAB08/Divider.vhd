library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Divider is
    Port ( A :   in  STD_LOGIC_VECTOR(7 downto 0);
           B :   in  STD_LOGIC_VECTOR(3 downto 0);
			  rst : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
           quotient : out  STD_LOGIC_VECTOR(3 downto 0);
			  reminder : out  STD_LOGIC_VECTOR(3 downto 0);
           overflow : out  STD_LOGIC);
end Divider;

architecture Behav of Divider is

	type state is (init_state,
						overflow_check,
						operation, 
						sc_check);
	
	--Present state and Next state
	signal Prstate, Nxtstate: state := init_state; 
	
begin

	process(clk, rst)
	begin
		if(rst = '0') then 
			Prstate <= init_state;
		elsif( rising_edge(clk) ) then 
			Prstate <= Nxtstate;
		end if;
	end process; 
	
	process(Prstate, A, B)
	
		--1 bit for E and 4 bit for R and 4 bit for A
		variable ERA: STD_LOGIC_VECTOR(8 downto 0);
		--sequence counter
		variable sc: unsigned(2 downto 0);
		
		begin
			case Prstate is
				when init_state => 
					ERA(8) := '0';
					ERA(7 downto 0) := A(7 downto 0);
					
					--set sequence counter to number of B digits
					sc := "100";
					Nxtstate <= overflow_check;
					
				when overflow_check =>
					
					if (ERA(7 downto 4) >= B ) then
						overflow <= '1';
						Nxtstate <= init_state;
					else
						overflow <= '0';
						Nxtstate <= operation;
					end if;
				when operation =>
				
					ERA := STD_LOGIC_VECTOR(shift_left(unsigned(ERA), 1));
					
					if (ERA(8) = '1') then
						ERA(8 downto 4) := STD_LOGIC_VECTOR( ('0' & unsigned(ERA(7 downto 4))) / unsigned('0' & not( B(3 downto 0)) ) + 1);
						--set A0 signal to 1 
						ERA(0) := '1';
					else 
						ERA(8 downto 4) := STD_LOGIC_VECTOR( ('0' & unsigned(ERA(7 downto 4))) + unsigned('0' & not( B(3 downto 0)) ) + 1);

						if ( ERA(8) = '1') then
							ERA(0) := '1';
						else
							--undo the subtraction
							ERA(7 downto 4) := STD_LOGIC_VECTOR(unsigned(ERA(7 downto 4)) + unsigned(B(3 downto 0)));
							ERA(0) := '0';
						end if;
					end if;
					sc := sc - 1;
					Nxtstate <= sc_check;
					
				--check value of sequence counter 
				when sc_check =>
					if (sc = "000") then
						quotient(3 downto 0) <= ERA(3 downto 0);
						reminder(3 downto 0) <= ERA(7 downto 4);

						Nxtstate <= init_state;
					else
						Nxtstate <= operation;					
					end if;
			end case;
		end process;

end Behav;