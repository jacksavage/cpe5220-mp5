-- Test bench for inventory memory

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

entity tb_inventory_memory is
end entity tb_inventory_memory;

architecture test of tb_inventory_memory is
	signal item_num : unsigned(3 downto 0);
	signal add, remove, clk : std_logic;
	signal quantity : unsigned(3 downto 0);
	signal sold_out : std_logic;
	signal item_price : ufixed(4 downto -5);

	constant t_c : time := 50 ns;

begin
	-- instantiate DUV
	duv_inventory_memory: entity work.inventory_memory(behavioral)
		port map (item_num=>item_num, add=>add, remove=>remove, clk=>clk, quantity=>quantity, sold_out=>sold_out, item_price=>item_price);


	clk_gen : process is
	begin
		wait for t_c / 2;
		clk <= '1';
		wait for t_c - t_c / 2;
		clk <= '0';
	end process clk_gen;

	-- reset
	-- reset <= '1', '0' after 2*t_c;

	-- test case procedure
	apply_test_cases : process is
	procedure apply_test (item_num_test : integer) is
	begin
		item_num <= to_unsigned(item_num_test, item_num'length);
		wait until rising_edge(clk);

	end procedure apply_test;

	begin
		apply_test(0);


	end process apply_test_cases;
	
end architecture test;

