library ieee;
use ieee.std_logic_1164.all;

--DIVIDE CLK BY 2
entity clk50M_to_clk25M is
	port(
		clk50: in std_logic;
		clk25: out std_logic
	);
end clk50M_to_clk25M;

architecture arch_clk50M_to_clk25M of clk50M_to_clk25M is
	signal compt: std_logic;
	begin
		process(clk50)
		begin	
			if rising_edge(clk50) then
				compt <= not(compt);
			end if;
		end process;
			
		clk25 <= compt;
end arch_clk50M_to_clk25M;