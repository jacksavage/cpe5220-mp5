library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display is
	port(
		en : in std_logic;
		item_num : in unsigned(3 downto 0);
		item_display : out string(1 to 2)
	);
end entity display;

architecture combinational of display is
	signal item_num_int : integer;
	signal letter, number : character;
begin
	item_num_int <= to_integer(item_num);
	
	with item_num_int select letter <=
		'A' when 0 to 3,
		'B' when 4 to 7,
		'C' when 8 to 11,
		'D' when 12 to 15,
		'-' when others;
	
	with item_num_int select number <=
		'1' when 0 | 4 | 8  | 12,
		'2' when 1 | 5 | 9  | 13,
		'3' when 2 | 6 | 10 | 14,
		'4' when 3 | 7 | 11 | 15,
		'-' when others;
		
	with en select item_display <=
		letter & number when '1',
		"--" when others;
end architecture combinational;
