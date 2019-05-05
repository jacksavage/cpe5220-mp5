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
	signal input_ready		 : std_logic;
		
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

	-- reset
	signal reset			 : std_logic;

	-- clock
	constant t_c : time := 1 ns;
	signal clk : std_logic;

	-- test bench variables
	signal select_test, load_test, vend_test : integer;

begin
	-- instantiate DUV
	duv_vend_machine_controller: entity work.vend_machine_controller(components)
		port map (
			  --display
			  item_display=>item_display, 
			  -- keypad
			  sel_button=>sel_button, vend_btn=>vend_btn, cancel_btn=>cancel_btn, input_ready=>input_ready, 
			  -- coin & bill manager
			  num_dollars=>num_dollars, num_quarters=>num_quarters, num_dimes=>num_dimes, 
		          num_nickels=>num_nickels, new_currency_interrupt=>new_currency_interrupt,
			  return_dollars=>return_dollars, return_quarters=>return_quarters, return_dimes=>return_dimes, 
			  return_nickels=>return_nickels,
			  -- motors/lightscreen
			  motors=>motors, lightscreen=>lightscreen,
			  -- reset
			  reset=>reset
			);


	clk_gen : process is
	begin
		wait for t_c / 2;
		clk <= '1';
		wait for t_c - t_c / 2;
		clk <= '0';
	end process clk_gen;

	reset <= '1', '0' after 2*t_c;
	
	run_tests : process is

--		for i in 0 to 5 loop
--			wait until rising_edge(clk);
--		end loop;		

	procedure select_item (letter_test, number_test : character) is
	begin
		case(letter_test) is
		when 'A' => sel_button(7 downto 4) <= "1000"; 
		when 'B' =>sel_button(7 downto 4) <= "0100"; 
		when 'C' =>sel_button(7 downto 4) <= "0010"; 
		when 'D' =>sel_button(7 downto 4) <= "0001";
		when others =>
		end case;
		case(number_test) is
		when '1' =>sel_button(3 downto 0) <= "1000"; 
		when '2' =>sel_button(3 downto 0) <= "0100"; 
		when '3' =>sel_button(3 downto 0) <= "0010"; 
		when '4' =>sel_button(3 downto 0) <= "0001"; 
		when others =>
		end case;
	end procedure select_item;

	procedure load_currency(num_dollars_in,num_quarters_in,num_dimes_in,num_nickels_in : integer) is
	begin
		num_dollars <= to_unsigned(num_dollars_in,num_dollars'length);
		num_quarters <= to_unsigned(num_quarters_in,num_quarters'length);
		num_dimes <= to_unsigned(num_dimes_in,num_dimes'length);
		num_nickels <= to_unsigned(num_nickels_in,num_nickels'length);
		new_currency_interrupt <= '1', '0' after 2*t_c;
	end procedure load_currency;

	procedure vend(vend_btn_test, cancel_btn_test : std_logic) is
	begin
		vend_btn   <= vend_btn_test;
		if (vend_btn_test = '1') then
		        wait for 2*t_c;
			lightscreen <= '0';
			wait for 2*t_c;
			lightscreen <= '1';
		end if;
		cancel_btn <= cancel_btn_test;
		wait for 2*t_c;
		vend_btn <= '0';
		cancel_btn <='0';
	end procedure vend;

	begin
		wait until reset = '0';
		select_item('A','1'); -- $1.75
		load_currency(2,0,0,0); -- $2.00
		vend('1','0');

		wait until input_ready = '1';
		select_item('A','2'); -- $1.00
		load_currency(1,2,1,1); -- $1.65
		vend('1','0');

		wait until input_ready = '1';
		select_item('B','1'); -- $0.75
		load_currency(0,3,0,0); -- $0.75
		vend('1','0');

		wait until input_ready = '1';
		select_item('C','3'); -- $1.90
		load_currency(0,7,0,1); -- $1.80, insufficient_funds
		vend('1','0');
		vend('0','1');

		wait until input_ready = '1';
		select_item('D','4'); -- $1.20
		load_currency(2,0,0,0); -- $2.00
		wait for 2*t_c;
		vend('0','1'); -- cancel
		
	end process run_tests;


--	select_item_process : process(select_test) is
--	-- select item
--	procedure select_item (letter_test, number_test : character) is
--	begin
--		case(letter_test) is
--		when 'A' => sel_button(7 downto 4) <= "1000"; 
--		when 'B' =>sel_button(7 downto 4) <= "0100"; 
--		when 'C' =>sel_button(7 downto 4) <= "0010"; 
--		when 'D' =>sel_button(7 downto 4) <= "0001";
--		when others =>
--		end case;
--		case(number_test) is
--		when '1' =>sel_button(3 downto 0) <= "1000"; 
--		when '2' =>sel_button(3 downto 0) <= "0100"; 
--		when '3' =>sel_button(3 downto 0) <= "0010"; 
--		when '4' =>sel_button(3 downto 0) <= "0001"; 
--		when others =>
--		end case;
--	end procedure select_item;
--	begin
--		case(select_test) is
--		when 1 =>select_item('A','1'); -- $1.75
--		when 2 =>select_item('A','2'); -- $1.00
--		when 3 =>select_item('B','1'); -- $0.75
--		when 4 =>select_item('C','3'); -- $1.90
--		when 5 =>select_item('D','4'); -- $1.20
--		when others =>
--		end case;
--	end process select_item_process;
--
--	load_currency_process : process(load_test) is
--	procedure load_currency(num_dollars_in,num_quarters_in,num_dimes_in,num_nickels_in : integer) is
--	begin
--		num_dollars <= to_unsigned(num_dollars_in,num_dollars'length);
--		num_quarters <= to_unsigned(num_quarters_in,num_quarters'length);
--		num_dimes <= to_unsigned(num_dimes_in,num_dimes'length);
--		num_nickels <= to_unsigned(num_nickels_in,num_nickels'length);
--		new_currency_interrupt <= '1', '0' after 2*t_c;
--	end procedure load_currency;
--	begin
--		case(load_test) is
--		when 1 =>load_currency(2,0,0,0); -- $2.00
--		when 2 =>load_currency(1,2,1,1); -- $1.65
--		when 3 =>load_currency(0,3,0,0); -- $0.75
--		when 4 =>load_currency(0,7,0,1); -- $1.80, insufficient_funds
--		when 5 =>load_currency(2,0,0,0); -- $2.00
--		when others =>
--		end case;
--	end process load_currency_process;

--	vend_process : process(vend_test) is
--	procedure vend(vend_btn_test, cancel_btn_test : std_logic) is
--	begin
--		vend_btn   <= vend_btn_test;
--		cancel_btn <= cancel_btn_test;
--	end procedure vend;
--	begin
--		case(vend_test) is
--		when 1 =>vend('1','0');
--		when 2 =>vend('1','0');
--		when 3 =>vend('1','0');
--		when 4 =>vend('1','0');
--		when 5 =>vend('0','1'); -- cancel
--		when others =>
--		end case;
--	end process vend_process;


	
end architecture test;


