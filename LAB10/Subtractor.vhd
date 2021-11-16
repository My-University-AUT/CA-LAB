
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

use IEEE.NUMERIC_STD.ALL;



entity Subtractor is
	port(
		--bit31 is for sign of number
		--(30 downto 23) is for exponent(in bias 1)
		--(22 downto 0) is for fraction
		A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		ready: out std_logic;
		over_flow: out std_logic;

		output: out std_logic_vector(31 downto 0)
	);
end entity;

architecture Behavioral of Subtractor is
	
begin
	
	process(A,B)
		variable tempA: std_logic_vector(23 downto 0);
		variable tempB: std_logic_vector(23 downto 0);
		variable tempResSum: std_logic_vector(24 downto 0);
		variable tempResSub: std_logic_vector(23 downto 0);
		variable op_is_sum: boolean;

		--variable shift_num : integer;
		variable exp_A_is_min: boolean;
		
		variable first_1_counter: integer;
		variable first_1_flag: boolean;
	begin
		tempA := "1" & A(22 downto 0);
		tempB := "1" & B(22 downto 0);
		tempResSum := "0000000000000000000000000";
		tempResSub := "000000000000000000000000";
		ready <= '0';
		over_flow <= '0';
		
		if( unsigned(A)=unsigned(B)) then--if A=B then result equals to zero. in zero display, exponent should be all zero because of bias1. fraction also should be all zero.
			output <= "00000000000000000000000000000000";
			ready <= '1';

		elsif(unsigned(A(30 downto 0)) = 0) then --if A be zero then output= -B (sign of A isn't important)
			output <= (not(B(31))) & B(30 downto 0);
			ready <= '1';

		elsif(unsigned(B(30 downto 0)) = 0) then --if B be zero then output= A (sign of B isn't important)
			output <=  A(31 downto 0);
			ready <= '1';

		else
		
			if( unsigned(A(30 downto 23)) > unsigned(B(30 downto 23)) )   then
				
				exp_A_is_min := false;
			else
				exp_A_is_min := true;

			end if;
			
			if(exp_A_is_min) then
				tempA := STD_LOGIC_VECTOR(shift_right( unsigned(tempA), to_integer(  unsigned(B(30 downto 23)) - unsigned(A(30 downto 23))    )));
			else
				tempB := STD_LOGIC_VECTOR(shift_right( unsigned(tempB), to_integer(  unsigned(A(30 downto 23)) - unsigned(B(30 downto 23))    )));

			end if;
			
			
			if( A(31)='1' and B(31)='1') then
							
				if(unsigned(tempA)>unsigned(tempB))then
					tempResSub := STD_LOGIC_VECTOR(unsigned(tempA) - unsigned(tempB) );

				else
					tempResSub := STD_LOGIC_VECTOR(unsigned(tempB) - unsigned(tempA) );
				end if;
				op_is_sum := false;

				if( unsigned(tempA)>unsigned(tempB) )then
					output(31) <= '1';
				else
					output(31) <= '0';

				end if;
				

			elsif( A(31)='0' and B(31)='0') then
				if(unsigned(tempA)>unsigned(tempB))then
					tempResSub := STD_LOGIC_VECTOR(unsigned(tempA) - unsigned(tempB) );

				else
					tempResSub := STD_LOGIC_VECTOR(unsigned(tempB) - unsigned(tempA) );

				end if;
				op_is_sum := false;
				
				if( unsigned(tempA)>unsigned(tempB) )then
					output(31) <= '0';
				else
					output(31) <= '1';

				end if;
				
			else
				--when signA != sign B
				tempResSum := STD_LOGIC_VECTOR(unsigned('0' & tempA) + unsigned('0' & tempB) );
				op_is_sum := true;

				output(31) <= A(31);
			end if;
		
			--overflow and underflow check
			
			if (op_is_sum)
			then
			
				if(tempResSum(24) = '1') then
					
					output(22 downto 0) <= tempResSum(23 downto 1);
					
					--overflow occured
					over_flow <= '1';
					
					--increae exponent by 1 beacause shift to right
					if(exp_A_is_min) then
						output(30 downto 23) <= std_logic_vector(unsigned(B(30 downto 23) + '1') );

					else
						output(30 downto 23) <= std_logic_vector(unsigned(A(30 downto 23) + '1') );

					end if;
					ready <= '1';

				elsif(tempResSum(23) = '1') then
					output(22 downto 0) <= tempResSum(22 downto 0);
					
					if(exp_A_is_min) then
						output(30 downto 23) <= B(30 downto 23);
					else
						output(30 downto 23) <= A(30 downto 23);
					end if;
					ready <= '1';

				else 
					first_1_counter := 1;
					first_1_flag := false;
					for i in 22 downto 0 loop
						if(first_1_flag=false) then
							if (tempResSum(i) = '1' ) then
								first_1_flag := true;
							else
								first_1_counter := first_1_counter + 1;

							end if;
						end if;
					end loop;
					
					tempResSum := STD_LOGIC_VECTOR(shift_left( unsigned(tempResSum), first_1_counter) );
					output(22 downto 0) <= tempResSum(22 downto 0);

					if(exp_A_is_min) then
						output(30 downto 23) <= std_logic_vector( unsigned(B(30 downto 23)) + unsigned( not( to_unsigned(first_1_counter,8))) + 1);

					else
						output(30 downto 23) <= std_logic_vector( unsigned(A(30 downto 23)) + unsigned( not( to_unsigned(first_1_counter,8))) + 1);

					end if;
					ready <= '1';

					
				end if;
				
			else
			
				if(tempResSub(23) = '1') then
						output(22 downto 0) <= tempResSub(22 downto 0);
						
						if(exp_A_is_min) then
							output(30 downto 23) <= B(30 downto 23);
						else 
							output(30 downto 23) <= A(30 downto 23);
						end if;
						ready <= '1';

				 else
					first_1_counter := 1;
					first_1_flag := false;
					for i in 22 downto 0 loop
						if(first_1_flag=false) then
							if (tempResSub(i) = '1' ) then
								first_1_flag := true;
							else
								first_1_counter := first_1_counter + 1;

							end if;
						end if;
					end loop;
					
					tempResSub := STD_LOGIC_VECTOR(shift_left( unsigned(tempResSub), first_1_counter) );
					output(22 downto 0) <= tempResSub(22 downto 0);
					if(exp_A_is_min) then
						output(30 downto 23) <= std_logic_vector( unsigned(B(30 downto 23)) + unsigned( not( to_unsigned(first_1_counter,8))) + 1);

					else
						output(30 downto 23) <= std_logic_vector( unsigned(A(30 downto 23)) + unsigned( not( to_unsigned(first_1_counter,8))) + 1);

					end if;
					
					ready <= '1';

				end if;
			
			end if;
		end if;
	 
	end process;

end Behavioral;

