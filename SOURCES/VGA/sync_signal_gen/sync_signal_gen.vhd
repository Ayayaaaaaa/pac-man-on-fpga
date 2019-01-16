library ieee;
use ieee.std_logic_1164.all;

entity sync_signal_gen is 
	port(
		CLOCK_50: in std_logic;
		ROW: out integer range 0 to 523;
		COL: out integer range 0 to 799;
		VGA_HS, VGA_VS: out std_logic;
		VGA_H_ON, VGA_V_ON: out std_logic
	);
end sync_signal_gen;

architecture arch_sync_signal_gen of sync_signal_gen is
	--CLK
	signal CLOCK_25: std_logic;
	component clk50M_to_clk25M is
		port(
			clk50: in std_logic;
			clk25: out std_logic
		);
	end component;
	
	--COUNT H
	signal S_COL: integer range 0 to 799;
	component count_h is
		port(
			CLOCK_25: in std_logic;
			COL: out integer range 0 to 799
		);
	end component;
	
	--SEQ_H
	signal S_VGA_HS: std_logic;
	
	--COUNT V
	signal S_ROW: integer range 0 to 523;
	component count_v is
		port(
			VGA_HS: in std_logic;
			ROW: out integer range 0 to 523
		);
	end component;
	
begin
	--CLK
	clk_div2: clk50M_to_clk25M
	port map(CLOCK_50, CLOCK_25);
	
	--COUNT H
	counter_h: count_h
	port map(CLOCK_25, S_COL);
	COL <= S_COL;
	
	SEQ_H: process(CLOCK_50)
		begin
			if rising_edge (CLOCK_50)then	
				if (S_COL > 655) and (S_COL <= 751) then
					S_VGA_HS <= '0';
				else
					S_VGA_HS <= '1';
				end if;
				
				if (S_COL > 639) then
					VGA_H_ON <= '0';
				else
					VGA_H_ON <= '1';
				end if;
			end if;
		end process;
	VGA_HS <= S_VGA_HS;
	
	--COUNT V
	counter_v: count_v
	port map(S_VGA_HS, S_ROW);
	ROW <= S_ROW;
	
	SEQ_V: process(CLOCK_50)
		begin
			if rising_edge (CLOCK_50)then	
				if (S_ROW > 490) and (S_ROW <= 492) then
					VGA_VS <= '0';
				else
					VGA_VS <= '1';
				end if;
				
				if (S_ROW > 479) then
					VGA_V_ON <= '0';
				else
					VGA_V_ON <= '1';
				end if;
			end if;
		end process;
	
end arch_sync_signal_gen;