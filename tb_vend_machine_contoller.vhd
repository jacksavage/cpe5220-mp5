-- Vending Machine Controller Testbench
-- Function: Test vending machine controller
-- Test bench for input selection

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_vend_machine_controller is
end entity tb_vend_machine_controller;

architecture test of tb_vend_machine_controller is

	-- display
	signal item_display              : string(1 to 2);
		
	-- keypad
	signal sel_button                : std_logic_vector(7 downto 0);
	signal vend_btn                  : std_logic;
	signal cancel_btn                : std_logic;
		
	-- coin & bill manager
	signal num_dollars               : unsigned(3 downto 0);
	signal num_quarters              : unsigned(3 downto 0);
	signal num_dimes                 : unsigned(3 downto 0);
	signal num_nickels               : unsigned(3 downto 0);
	signal new_currency_interrupt    : std_logic;
	signal return_currency_interrupt : std_logic;
	signal return_dollars            : unsigned(3 downto 0);
	signal return_quarters           : unsigned(3 downto 0);
	signal return_dimes              : unsigned(3 downto 0);
	signal return_nickels            : unsigned(3 downto 0);
		
	-- motors/lightscreen
	signal motors                    : std_logic_vector(15 downto 0);
	signal lightscreen               : std_logic;

	-- clock
	constant t_c : time := 50 ns;
	signal clk : std_logic;

	-- test bench variables
	signal temp_sel_button : std_logic_vector(7 downto 0);

begin
	-- instantiate DUV
	duv_vend_machine_controller: entity work.vend_machine_controller(components)
		port map (
			  --display
			  item_display=>item_display, 
			  -- keypad
			  sel_button=>sel_button, vend_btn=>vend_btn, cancel_btn=>cancel_btn, 
			  -- coin & bill manager
			  num_dollars=>num_dollars, num_quarters=>num_quarters, num_dimes=>num_dimes, 
		          num_nickels=>num_nickels, new_currency_interrupt=>new_currency_interrupt,
			  return_dollars=>return_dollars, return_quarters=>return_quarters, return_dimes=>return_dimes, 
			  return_nickels=>return_nickels, return_currency_interrupt=>return_currency_interrupt,
			  -- motors/lightscreen
			  motors=>motors, lightscreen=>lightscreen
			);


	clk_gen : process is
	begin
		wait for t_c / 2;
		clk <= '1';
		wait for t_c - t_c / 2;
		clk <= '0';
	end process clk_gen;

--	-- reset
--	reset_process : process is
--	procedure reset_controller;
--	begin
--		reset <= '1', '0' after 2*t_c;
--	end procedure reset_controller;



	apply_test_cases : process is

	-- select item
	procedure select_item (letter_test, number_test : character) is
	begin
		case(letter_test) is
			when 'A' => 
				sel_button(7 downto 4) <= "1000"; 
			when 'B' =>
				sel_button(7 downto 4) <= "0100"; 
			when 'C' =>
				sel_button(7 downto 4) <= "0010"; 
			when 'D' =>
				sel_button(7 downto 4) <= "0001";
			when others =>
		end case;
		case(number_test) is
			when '1' =>
				sel_button(3 downto 0) <= "1000"; 
			when '2' =>
				sel_button(3 downto 0) <= "0100"; 
			when '3' =>
				sel_button(3 downto 0) <= "0010"; 
			when '4' =>
				sel_button(3 downto 0) <= "0001"; 
			when others =>
		end case;
		--sel_button <= temp_sel_button;
		wait until rising_edge(clk);
	end procedure select_item;
	begin
		
		select_item('A','1');
		select_item('A','2');
		select_item('B','1');
		select_item('C','3');
		select_item('D','4');

	end process apply_test_cases;
	
end architecture test;


