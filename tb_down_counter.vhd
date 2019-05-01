library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_down_counter is
end entity tb_down_counter;

architecture tb of tb_down_counter is
	signal clk, rst : std_logic := '1';
	signal flag1, flag2 : std_logic;
	signal start_count : integer;
	constant t : time := 1 ms;
begin
	clk <= not clk after t / 2; 
	
	dc1 : entity work.down_counter
		port map(
			start_count => 324,
			clk         => clk,
			rst         => rst,
			flag        => flag1
		);
		
	dc2 : entity work.down_counter
		port map(
			start_count => start_count,
			clk         => clk,
			rst         => rst,
			flag        => flag2
		);
	
	process is
		procedure test(c : integer) is
		begin
			start_count <= c;
			wait for 2 * t;
			rst <= '0';
			wait until rising_edge(flag2);
			wait for 2 * t;
			rst <= '1';
		end procedure;
	begin
		wait for 3 * t;
		test(13);
		test(26);
		
		wait;
	end process;
end architecture tb;
