-- Input Selection Manager
-- Function: Decode buttons pressed by keypad and send data to state machine

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity input_selection is
	port(sel_button : in std_logic_vector(7 downto 0);
	     return_btn, cancel_btn, reset, clk : in std_logic;
	     item_num : out unsigned(3 downto 0); -- 16 different items
	     maintenance_signal, return_signal, cancel_signal : out std_logic; -- signal to state machine to go to maintenance mode, return or cancel
	     valid : out std_logic -- input valid signal
	     );
end entity input_selection;

architecture behavioral of input_selection is
signal button_letter : integer;
signal button_number : integer;

begin
-- convert sel_button input to item_num

button_letter <= 0  when sel_button(7) = '1' else
		 4  when sel_button(6) = '1' else
		 8  when sel_button(5) = '1' else
		 12 when sel_button(4) = '1';

button_number <= 0 when sel_button(3) = '1' else
		 1 when sel_button(2) = '1' else
		 2 when sel_button(1) = '1' else
		 3 when sel_button(0) = '1';

item_num <= resize(to_unsigned(button_letter, item_num'length) + to_unsigned(button_number, item_num'length), item_num'length);

process_buttons : process(clk)
begin
if reset = '0' then
	-- detect button combo for maintenance mode and set signal
	if sel_button = "11111111" then -- Hold down all buttons
		maintenance_signal <= '1';
	else
		maintenance_signal <= '0';
	end if;

	-- process return_btn
	if return_btn = '1' then
		valid <= '1';
		return_signal <= '1';
	else
		valid <= '0';
		return_signal <= '0';
	end if;
	
	-- process cancel_btn
	if cancel_btn = '1' then
		cancel_signal <= '1';
	else
		cancel_signal <= '0';
	end if;
end if;
end process process_buttons;


end architecture behavioral;