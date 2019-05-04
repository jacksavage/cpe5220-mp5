library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is
	port(
		reset_keypad           : out std_logic;
		clock                  : in  std_logic;
		vend_request           : in  std_logic;
		enter_maintenance_mode : in  std_logic;
		valid_item_requested   : in  std_logic;
		cancel_signal          : in  std_logic;
		refund_all_money       : out std_logic;
		refund_change          : out std_logic;
		funds_available        : in  std_logic;
		dispense               : out std_logic;
		done_dispensing        : in  std_logic;
		dispensing_failed      : in  std_logic;
		item_sold_out          : in  std_logic;
		remove_inventory       : out std_logic;
		add_inventory          : out std_logic;
		inventory_quantity     : out unsigned(3 downto 0)
	);
end entity state_machine;

architecture behavioral of state_machine is
	type state_type is (idle, payment, dispursement);
begin
	process(clock) is
		variable state : state_type := idle;
	begin
		if rising_edge(clock) then
			case state is
				when idle =>
					state := payment;
				when payment =>
					state := dispursement;
				when dispursement =>
					state := idle;
			end case;
		end if;
	end process;
end architecture behavioral;
