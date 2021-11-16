library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_multiplier is
		PORT (X : in   STD_LOGIC_VECTOR(3 downto 0);
				Y : in   STD_LOGIC_VECTOR(3 downto 0);
			   Product : out  STD_LOGIC_VECTOR(7 downto 0));
end array_multiplier;

architecture Behav of array_multiplier is

	component four_bit_RA is
		 PORT ( X   : in  STD_LOGIC_VECTOR(3 downto 0);
				  Y   : in  STD_LOGIC_VECTOR(3 downto 0);
				  Cin : in  STD_LOGIC;
				  Cout: out STD_LOGIC;
				  sum : out STD_LOGIC_VECTOR(3 downto 0));

	end component;

	type product_terms is array (0 to 3) of std_logic_vector(0 to 3);
   signal XY : product_terms;
	
	type row_terms is array (0 to 5) of std_logic_vector(3 downto 0);
   signal r_terms : row_terms;
	
	signal RA_output_0: std_logic_vector(3 downto 0);
	signal RA_output_1: std_logic_vector(3 downto 0);
	signal RA_output_2: std_logic_vector(3 downto 0);
	
	signal Carries: std_logic_vector(2 downto 0);
		
begin

	--calculate product_terms
	process (X, Y)
	begin
	  for i in 0 to 3 loop
	    for j in 0 to 3 loop
		   XY(j)(i) <= X(j) and Y(i);
		 end loop;
	  end loop;
	end process;
	
	
	r_terms(0) <= '0' & XY(3)(0) & XY(2)(0) & XY(1)(0);
	r_terms(1) <= XY(3)(1) & XY(2)(1) & XY(1)(1) & XY(0)(1);
	
	RA_0: four_bit_RA PORT MAP (r_terms(0), r_terms(1), '0', Carries(0), RA_output_0 );
	
	r_terms(2) <= Carries(0) & RA_output_0(3 downto 1);
	r_terms(3) <= XY(3)(2) & XY(2)(2) & XY(1)(2) & XY(0)(2);
	
	RA_1: four_bit_RA PORT MAP (r_terms(2), r_terms(3), '0', Carries(1), RA_output_1 );
	
	r_terms(4) <= Carries(1) & RA_output_1(3 downto 1);
	r_terms(5) <= XY(3)(3) & XY(2)(3) & XY(1)(3) & XY(0)(3);
	
	RA_2: four_bit_RA PORT MAP (r_terms(4), r_terms(5), '0', Carries(2), RA_output_2 );
	
	Product(0) <= XY(0)(0);
	Product(1) <= RA_output_0(0);
	Product(2) <= RA_output_1(0);
	Product(3) <= RA_output_2(0);
	Product(4) <= RA_output_2(1);
	Product(5) <= RA_output_2(2);
	Product(6) <= RA_output_2(3);
	Product(7) <= Carries(2);
	
end Behav;
