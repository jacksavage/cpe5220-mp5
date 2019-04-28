-- Test bench for inventory memory

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

entity tb_inventory_memory is
end entity tb_inventory_memory;

architecture test of tb_inventory_memory is
	signal item_num : unsigned(3 downto 0);
	signal add, remove, clk, reset : std_logic;
	signal quantity : unsigned(3 downto 0);
	signal sold_out : std_logic;
	signal item_price : ufixed(4 downto -5);
	signal logic_size : std_logic_vector(0 downto 0);

	constant t_c : time := 50 ns;

begin
	-- instantiate DUV
	duv_inventory_memory: entity work.inventory_memory(behavioral)
		port map (item_num=>item_num, add=>add, remove=>remove, clk=>clk, reset=>reset, quantity=>quantity, sold_out=>sold_out, item_price=>item_price);


	clk_gen : process is
	begin
		wait for t_c / 2;
		clk <= '1';
		wait for t_c - t_c / 2;
		clk <= '0';
	end process clk_gen;

	-- reset
	reset <= '1', '0' after 2*t_c;

	-- test case procedure
	apply_test_cases : process is
	procedure apply_test (item_num_test, quantity_test, add_or_remove_test : integer) is
	begin
		item_num <= to_unsigned(item_num_test, item_num'length);
		quantity <= to_unsigned(quantity_test, quantity'length);
		if (add_or_remove_test = 1) then
			add <= '1';
			remove <= '0';
		else
			add <= '0';
			remove <= '1';
		end if;
		wait until rising_edge(clk);
	end procedure apply_test;

	begin
        	wait until rising_edge(clk) and reset = '0';
		apply_test(0, 1, 1); -- add 1 to item_num 0
		apply_test(0, 1, 0); -- remove 1 from item_num 0
		apply_test(0, 2, 0); -- remove 2 from item_num 0
		apply_test(1, 1, 0); -- remove 1 from item_num 1
		apply_test(2, 1, 0); -- remove 1 from item_num 2
		apply_test(3, 1, 0); -- remove 1 from item_num 3
		apply_test(4, 1, 0); -- remove 1 from item_num 4
		apply_test(5, 1, 0); -- remove 1 from item_num 5
		apply_test(6, 1, 0); -- remove 1 from item_num 6
		apply_test(7, 1, 0); -- remove 1 from item_num 7
		apply_test(8, 1, 0); -- remove 1 from item_num 8
		apply_test(9, 1, 0); -- remove 1 from item_num 9
		apply_test(10, 1, 0); -- remove 1 from item_num 10
		apply_test(11, 1, 0); -- remove 1 from item_num 11
		apply_test(12, 1, 0); -- remove 1 from item_num 12
		apply_test(13, 1, 0); -- remove 1 from item_num 13
		apply_test(14, 1, 0); -- remove 1 from item_num 14
		apply_test(15, 1, 0); -- remove 1 from item_num 15

	end process apply_test_cases;
	
end architecture test;

