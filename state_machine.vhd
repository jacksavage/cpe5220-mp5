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
		inventory_quantity     : inout unsigned(3 downto 0);
		price_ready            : in  std_logic
	);
end entity state_machine;

architecture behavioral of state_machine is
	type state_type is (idle, payment, inventory, vend, maintenance);
	signal message : string(1 to 18);   -- todo route out to display
begin
	process(clock) is
		variable state : state_type := idle;
	begin
		if rising_edge(clock) then
			-- default control signal states
			reset_keypad       <= '0';
			refund_all_money   <= '0';
			refund_change      <= '0';
			dispense           <= '0';
			remove_inventory   <= '0';
			add_inventory      <= '0';
			inventory_quantity <= to_unsigned(0, inventory_quantity'length);

			-- handle current state
			case state is
				when idle =>
					if cancel_signal = '1' then
						refund_all_money <= '1';
					elsif enter_maintenance_mode = '1' then
						state := maintenance;
					elsif vend_request = '1' and valid_item_requested = '1' then
						-- todo latch the item number?
						state := payment;
					end if;

				when payment =>
					if cancel_signal = '1' then
						refund_all_money <= '1';
						state            := idle;
					elsif price_ready = '1' and funds_available = '1' then
						message <= "                  ";
						state   := inventory;
					else
						message <= "Insufficient funds";
					end if;

				when inventory =>
					if item_sold_out = '0' then
						state    := vend;
						dispense <= '1';
					else
						message <= "      Out of stock";
						state   := idle;
					end if;

				when vend =>
					if done_dispensing = '1' then
						if dispensing_failed = '1' then
							message <= "  Please try again";
						else
							message       <= "    Item dispensed";
							refund_change <= '1';
						end if;

						state := idle;
					else
						message <= "           Vending";
					end if;

				when maintenance =>
					message <= "  Maintenance mode";

					if cancel_signal = '1' then
						message <= "                  ";
					else
						-- todo handle inventory mods
					end if;
			end case;
		end if;
	end process;
end architecture behavioral;
