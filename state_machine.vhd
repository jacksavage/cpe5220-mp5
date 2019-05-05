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
		inventory_quantity     : out unsigned(3 downto 0);
		price_ready	       : in  std_logic
	);
end entity state_machine;

architecture behavioral of state_machine is
	type state_type is (idle, input, payment, dispursement, maintenance);
	signal state : state_type := idle;
begin
	process(clock, state) is
	begin
		if rising_edge(clock) then
			case state is
				when idle =>
					reset_keypad <= '0';
					inventory_quantity <= to_unsigned(0, inventory_quantity'length);
					state <= input;
				when input =>
					if (enter_maintenance_mode = '1') then
						state <= maintenance;
					elsif( valid_item_requested = '1' ) then
						state <= payment;
						inventory_quantity <= to_unsigned(1, inventory_quantity'length);
					end if;
				when payment =>
					if (price_ready = '1') then
						state <= dispursement;
					end if;
				when dispursement =>
					reset_keypad <= '1';
					state <= idle;
				when maintenance =>
					state <= idle;
			end case;
		end if;
	end process;
end architecture behavioral;
