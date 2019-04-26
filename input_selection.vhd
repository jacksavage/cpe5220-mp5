-- Input Selection Manager
-- Function: Decode buttons pressed by keypad and send data to state machine

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity input_selection is
	port(sel_button : in std_logic_vector(7 downto 0);
	     return_btn, cancel_btn, reset : in std_logic;
	     item_num : out unsigned(3 downto 0); -- 16 different items
	     maintenance_signal : out std_logic; -- signal to state machine to go to maintenance mode
	     valid : out std_logic -- input valid signal
	     );
end entity input_selection;

architecture behavioral of input_selection is

begin

-- convert sel_button input to item_num

-- detect button combo for maintenance mode and set signal

end architecture behavioral;