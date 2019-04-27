-- Test bench for input selection

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_input_selection is
end entity tb_input_selection;

architecture test of tb_input_selection is

	signal sel_button : std_logic_vector(7 downto 0);
	signal return_btn, cancel_btn, reset, clk : std_logic;
	signal item_num : unsigned(3 downto 0); 
	signal maintenance_signal, return_signal, cancel_signal : std_logic;
	signal valid : std_logic;
	constant t_c : time := 50 ns;

begin
	-- instantiate DUV
	duv_input_selection: entity work.input_selection(behavioral)
		port map (sel_button=>sel_button, return_btn=>return_btn, cancel_btn=>cancel_btn, reset=>reset, clk=>clk,
			  item_num=>item_num, maintenance_signal=>maintenance_signal, return_signal=>return_signal, 
			  cancel_signal=>cancel_signal, valid=>valid);


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
	procedure apply_test (sel_button_test : std_logic_vector(7 downto 0)) is
	begin
		sel_button <= sel_button_test;
		return_btn <= '1';
		wait until rising_edge(clk);
		return_btn <= '1';
	end procedure apply_test;

	begin
		apply_test("10001000"); --A1 - item_num 0
		apply_test("10000100"); --A2 - item_num 1
		apply_test("10000010"); --A3 - item_num 2
		apply_test("10000001"); --A4 - item_num 3

		apply_test("01001000"); --B1 - item_num 4
		apply_test("01000100"); --B2 - item_num 5
		apply_test("01000010"); --B3 - item_num 6
		apply_test("01000001"); --B4 - item_num 7

		apply_test("00101000"); --C1 - item_num 8
		apply_test("00100100"); --C2 - item_num 9
		apply_test("00100010"); --C3 - item_num 10
		apply_test("00100001"); --C4 - item_num 11

		apply_test("00011000"); --D1 - item_num 12
		apply_test("00010100"); --D2 - item_num 13
		apply_test("00010010"); --D3 - item_num 14
		apply_test("00010001"); --D4 - item_num 15

		apply_test("11111111"); -- Maintenance Mode

		cancel_btn <= '1';
		wait until rising_edge(clk);
		cancel_btn <= '0';

	end process apply_test_cases;
	
end architecture test;


