---------------------------------------------------
-- n-bit Register
-- concurrent, generic and range
---------------------------------------------------
	
library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

---------------------------------------------------

entity reg is

generic(n: natural :=3);

port(	Input:	in std_logic_vector(n-1 downto 0);
		clock:	in std_logic;
		load:		in std_logic;
		clear:	in std_logic;
		Qout:		out std_logic_vector(n-1 downto 0)
);
end reg;

----------------------------------------------------

architecture behv of reg is

    signal Q_tmp: std_logic_vector(n-1 downto 0);

begin

    process(Input, clock, load, clear)
    begin

	if clear = '0' then
            -- use 'range in signal assigment 
            Q_tmp <= (Q_tmp'range => '0');
	elsif (clock='1' and clock'event) then
	    if load = '1' then
			 Q_tmp <= Input;
	    end if;
	end if;

    end process;

    -- concurrent statement
    Qout <= Q_tmp;

end behv;

---------------------------------------------------