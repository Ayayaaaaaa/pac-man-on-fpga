library ieee;
use ieee.std_logic_1164.all;

entity count_v is
	port(
		VGA_HS: in std_logic;
		ROW: out integer range 0 to 523
	);
end count_v;

architecture arch_count_v of count_v is
signal compt: integer range 0 to 523 := 0;
begin
	process(VGA_HS)
	begin
		if rising_edge(VGA_HS) then
			if compt = 523 then
				compt <= 0;
			else
				compt <= compt + 1;
			end if;
		end if;
		
		ROW <= compt;
	end process;
end arch_count_v;