library ieee;
use ieee.std_logic_1164.all;

entity VGA is
	port(
		CLOCK_50: in std_logic;
		ROW: out integer range 0 to 523;
		COL: out integer range 0 to 799;
		VGA_HS, VGA_VS: out std_logic
	);
end VGA;

architecture arch_VGA of VGA is
	--SYNC SIGNAL
	signal VGA_H_ON, VGA_V_ON: std_logic;
	component sync_signal_gen is
		port(
			CLOCK_50: in std_logic;
			ROW: out integer range 0 to 523;
			COL: out integer range 0 to 799;
			VGA_HS, VGA_VS: out std_logic;
			VGA_H_ON, VGA_V_ON: out std_logic
		);
	end component;
	
	--
	
begin
	--SYNC SIGNAL
	sync_gen: sync_signal_gen
	port map(CLOCK_50, ROW, COL, VGA_HS, VGA_VS, VGA_H_ON, VGA_V_ON);
	
end arch_VGA;