library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

entity vend_machine_controller is
	port(
		-- display
		item_display              : out string(1 to 2);
		
		-- keypad
		sel_button                : in  std_logic_vector(7 downto 0);
		vend_btn                  : in  std_logic;
		cancel_btn                : in  std_logic;
		
		-- coin & bill manager
		num_dollars               : inout unsigned(3 downto 0);
		num_quarters              : inout unsigned(3 downto 0);
		num_dimes                 : inout unsigned(3 downto 0);
		num_nickels               : inout  unsigned(3 downto 0);
		new_currency_interrupt    : inout  std_logic;
		return_currency_interrupt : out std_logic;
		return_dollars            : inout unsigned(3 downto 0);
		return_quarters           : inout unsigned(3 downto 0);
		return_dimes              : inout unsigned(3 downto 0);
		return_nickels            : inout unsigned(3 downto 0);
		
		-- motors/lightscreen
		motors                    : out std_logic_vector(15 downto 0);
		lightscreen               : in  std_logic
	);
end entity vend_machine_controller;

architecture components of vend_machine_controller is
	signal T     : time      := 1 ns;
	signal clock : std_logic := '1';

	signal valid_item_requested                                              : std_logic;
	signal item_num, inventory_quantity                                      : unsigned(3 downto 0);
	signal item_sold_out, remove_inventory, add_inventory                    : std_logic;
	signal dispense, done_dispensing, dispensing_failed                      : std_logic;
	signal refund_all_money, refund_change, insufficient_funds               : std_logic;
	signal reset_keypad, vend_request, enter_maintenance_mode, cancel_signal : std_logic;
	signal not_insufficient_funds, not_lightscreen				 : std_logic;
	signal item_price                                                        : ufixed(4 downto -5);
begin
	clock_process: process is
	begin
		clock <= not clock after T / 2;
	end process;

	not_insufficient_funds <= not insufficient_funds;
	not_lightscreen <= not lightscreen;

	display1 : entity work.display
		port map(
			en           => valid_item_requested,
			item_num     => item_num,
			item_display => item_display
		);

	input_selection1 : entity work.input_selection
		port map(
			sel_button         => sel_button,
			vend_btn           => vend_btn,
			cancel_btn         => cancel_btn,
			reset              => reset_keypad,
			clk                => clock,
			item_num           => item_num,
			maintenance_signal => enter_maintenance_mode,
			vend_signal        => vend_request,
			cancel_signal      => cancel_signal,
			valid              => valid_item_requested
		);

	balance_manager1 : entity work.balance_manager
		port map(
			num_dollars               => num_dollars,
			num_quarters              => num_quarters,
			num_dimes                 => num_dimes,
			num_nickles               => num_nickels,
			new_currency_interrupt    => new_currency_interrupt,
			order_cost                => item_price,
			vend                      => refund_change,
			return_balance            => refund_all_money,
			reset                     => '0',
			clk                       => clock,
			insufficient_funds        => insufficient_funds,
			return_currency_interrupt => return_currency_interrupt,
			return_dollars            => return_dollars,
			return_quarters           => return_quarters,
			return_dimes              => return_dimes,
			return_nickles            => return_nickels
		);

	state_machine1 : entity work.state_machine
		port map(
			reset_keypad           => reset_keypad,
			clock                  => clock,
			vend_request           => vend_request,
			enter_maintenance_mode => enter_maintenance_mode,
			valid_item_requested   => valid_item_requested,
			cancel_signal          => cancel_signal,
			refund_all_money       => refund_all_money,
			refund_change          => refund_change,
			funds_available        => not_insufficient_funds,
			dispense               => dispense,
			done_dispensing        => done_dispensing,
			dispensing_failed      => dispensing_failed,
			item_sold_out          => item_sold_out,
			remove_inventory       => remove_inventory,
			add_inventory          => add_inventory,
			inventory_quantity     => inventory_quantity
		);

	dispenser1 : entity work.dispenser
		port map(
			clk           => clock,
			dispense      => dispense,
			lightscreen_n => not_lightscreen,
			item_num      => item_num,
			motors        => motors,
			done          => done_dispensing,
			failed        => dispensing_failed
		);

	inventory_memory1 : entity work.inventory_memory
		port map(
			item_num   => item_num,
			add        => add_inventory,
			remove     => remove_inventory,
			clk        => clock,
			reset      => '0',
			quantity   => inventory_quantity,
			sold_out   => item_sold_out,
			item_price => item_price
		);
end architecture components;
