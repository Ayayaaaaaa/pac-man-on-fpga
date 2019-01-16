library ieee;
use ieee.std_logic_1164.all;

entity count_h is
	port(
		CLOCK_25: in std_logic;
		COL: out integer range 0 to 799
	);
end count_h;

architecture arch_count_h of count_h is
signal compt: integer range 0 to 799 := 0;
begin
	process(CLOCK_25)
	begin
		if(rising_edge(CLOCK_25)) then
			if compt = 799 then
				compt <= 0;
			else
				compt <= compt + 1;
			end if;
		end if;
		
		COL <= compt;
	end process;
end arch_count_h;