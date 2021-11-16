library ieee ;
use ieee.std_logic_1164.all;

---------------------------------------------------

entity shift_reg is
port(	Input:		in std_logic;
		clock:		in std_logic;
		shift:		in std_logic;
		Qout:			out std_logic
);
end shift_reg;

---------------------------------------------------

architecture Behavioral of shift_reg is

    -- initialize the declared signal
    signal S: std_logic_vector(2 downto 0):="111";

begin
    
    process(Input, clock, shift, S)
    begin

	-- everything happens upon the clock changing
	if clock'event and clock='1' then
	    if shift = '1' then
			S <= Input & S(2 downto 1);
	    end if;
	end if;

end process;

	
    -- concurrent assignment
    Qout <= S(0);

end Behavioral;
