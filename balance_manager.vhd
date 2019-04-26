-- Balance Manager
-- Function: Accepts dollars, quarters, dimes, and nickles
--           Calculates total balance of currency loaded into machine
--           Calculates total cost of items selected to be vended
--           Subtracts cost from balance or indicates insufficient funds
--           Remaining balance is calculated and returned to user

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

entity balance_manager is
	port( num_dollars, num_quarters, num_dimes, num_nickles : in unsigned(3 downto 0); -- Max 16 of each type, totals $22.40
	      new_currency_interrupt : in std_logic; -- interrupt when dollar/coin manager gets new currency
		  order_cost : in ufixed(4 downto -5); -- $32.00 with 0.03125 resolution, max order cost < $22.40
		  vend, return_balance, reset : in std_logic; -- vend and return balance commands from state machine, vend subtracts order cost from balance, and return_balance returns money to dollar/coin manager
	      insufficient_funds, return_currency_interrupt : out std_logic; -- insufficient_funds signal to state machine, return_currency_interrupt to dollar/coin manager when return_balance outputs are ready
	      return_dollars, return_quarters, return_dimes, return_nickles : out unsigned(3 downto 0)); -- return balance quantity to dollar/coin manager
end entity balance_manager;

architecture behavioral of balance_manager is

signal loaded_balance, remaining_balance : ufixed(4 downto -5);

begin

	reset_manager: process(reset)
	begin
	if reset = '1' then
	begin
		insufficient_funds <= '1';
		return_currency_interrupt <= '0';
		loaded_balance <= "0000000000";
		remaining_balance <= "0000000000";
		return_dollars <= "0000"; return_quarters <= "0000"; return_dimes <= "0000"; return_nickles <= "0000";
	end
	end if;
	end process;

	load_currency: process(new_currency_interrupt) is -- load balance from dollar/coin manager
	begin
		insufficient_funds <= '0';
	-- load currency from dollar/coin manager input
	-- calculate loaded_balance
	end process;
	
	calculate_balance: process(vend) is -- when state machine sends vend command, calculate remaining_balance or insufficient_funds
	begin
	if vend = '1' then
	begin
		if (loaded_balance > order_cost) then
			begin
			remaining_balance = loaded_balance - order_cost;
			end
		else if (loaded_balance < order_cost) then
			begin
			insufficient_funds <= '1';
			end
		end if;
	end if;
	end process;
	
	return_balance: process(return_balance) -- return remaining_balance if vend action occurs or loaded_balance if order is canceled
	begin
	end process;
	
end architecture behavioral;