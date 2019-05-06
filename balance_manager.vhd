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
    port(
        num_dollars, num_quarters, num_dimes, num_nickles             : in  unsigned(3 downto 0); -- Max 16 of each type, totals $22.40
        new_currency_interrupt                                        : in  std_logic; -- interrupt when dollar/coin manager gets new currency
        order_cost                                                    : in  ufixed(4 downto -5); -- $32.00 with 0.03125 resolution, max order cost < $22.40
        dispensed, return_balance, reset, clk                         : in  std_logic; -- vend and return balance commands from state machine, vend subtracts order cost from balance, and return_balance returns money to dollar/coin manager
        insufficient_funds, return_currency_interrupt                 : out std_logic; -- insufficient_funds signal to state machine, return_currency_interrupt to dollar/coin manager when return_balance outputs are ready
        return_dollars, return_quarters, return_dimes, return_nickles : out unsigned(3 downto 0) -- return balance quantity to dollar/coin manager
    );
end entity balance_manager;

architecture behavioral of balance_manager is
    signal previous_balance, loaded_balance, vended_balance, remaining_balance                                                : ufixed(4 downto -5);
    signal temp_balance1, temp_balance2, temp_balance3, remainder1, remainder2, remainder3, dollars, quarters, dimes, nickles : ufixed(4 downto -5);
    signal rdollars, rquarters, rdimes, rnickles                                                                              : unsigned(3 downto 0);
begin
    load_currency : process(clk) is     -- load balance from dollar/coin manager
    begin
        if (new_currency_interrupt = '1' and reset = '0') then
            -- load currency from dollar/coin manager input and calculate loaded_balance
            dollars          <= resize(1.00 * to_ufixed(num_dollars, dollars), dollars);
            quarters         <= resize(0.25 * to_ufixed(num_quarters, quarters), quarters);
            dimes            <= resize(0.10 * to_ufixed(num_dimes, dimes), dimes);
            nickles          <= resize(0.05 * to_ufixed(num_nickles, dimes), nickles);
            loaded_balance   <= resize(dollars + quarters + dimes + nickles, loaded_balance);
            previous_balance <= loaded_balance;
        end if;
    end process;

    calculate_balance : process(order_cost) is -- when state machine sends vend command, calculate remaining_balance or insufficient_funds
    begin
        if (reset = '0') then
            if (loaded_balance >= order_cost) then
                vended_balance     <= resize(loaded_balance - order_cost, remaining_balance);
                previous_balance   <= vended_balance; -- in case user loads more money
                insufficient_funds <= '0';
            elsif (loaded_balance < order_cost) then
                insufficient_funds <= '1';
            end if;
        end if;
    end process;

    return_currency : process(clk, dispensed, return_balance) is -- return remaining_balance if vend action occurs or loaded_balance if order is canceled
    begin
        if (dispensed = '1') then
            remaining_balance <= vended_balance;
        else
            remaining_balance <= loaded_balance;
        end if;

        if (return_balance = '1' and reset = '0') then
            -- calculate and set number of returned dollars, quarters, dimes, and nickles from remaining_balance

            if (remaining_balance < to_ufixed(1, remaining_balance)) then
                return_dollars <= to_unsigned(0, return_dollars'length);
                rdollars       <= to_unsigned(0, return_dollars'length);
            elsif (remaining_balance < to_ufixed(2, remaining_balance)) then
                return_dollars <= to_unsigned(1, return_dollars'length);
                rdollars       <= to_unsigned(1, return_dollars'length);
            elsif (remaining_balance < to_ufixed(3, remaining_balance)) then
                return_dollars <= to_unsigned(2, return_dollars'length);
                rdollars       <= to_unsigned(2, return_dollars'length);
            elsif (remaining_balance < to_ufixed(4, remaining_balance)) then
                return_dollars <= to_unsigned(3, return_dollars'length);
                rdollars       <= to_unsigned(3, return_dollars'length);
            elsif (remaining_balance < to_ufixed(5, remaining_balance)) then
                return_dollars <= to_unsigned(4, return_dollars'length);
                rdollars       <= to_unsigned(4, return_dollars'length);
            elsif (remaining_balance < to_ufixed(6, remaining_balance)) then
                return_dollars <= to_unsigned(5, return_dollars'length);
                rdollars       <= to_unsigned(5, return_dollars'length);
            elsif (remaining_balance < to_ufixed(7, remaining_balance)) then
                return_dollars <= to_unsigned(6, return_dollars'length);
                rdollars       <= to_unsigned(6, return_dollars'length);
            elsif (remaining_balance < to_ufixed(8, remaining_balance)) then
                return_dollars <= to_unsigned(7, return_dollars'length);
                rdollars       <= to_unsigned(7, return_dollars'length);
            elsif (remaining_balance < to_ufixed(9, remaining_balance)) then
                return_dollars <= to_unsigned(8, return_dollars'length);
                rdollars       <= to_unsigned(8, return_dollars'length);
            elsif (remaining_balance >= to_ufixed(9, remaining_balance)) then
                return_dollars <= to_unsigned(remaining_balance, return_dollars'length);
                rdollars       <= to_unsigned(remaining_balance, return_dollars'length);
            end if;

            temp_balance1 <= resize(remaining_balance - (to_ufixed(rdollars, temp_balance1) * 1.0), temp_balance1);
            remainder1    <= resize(temp_balance1 / to_ufixed(0.25, temp_balance1), remainder1);

            if (remainder1 < to_ufixed(1, temp_balance1)) then
                return_quarters <= to_unsigned(0, return_quarters'length);
                rquarters       <= to_unsigned(0, return_quarters'length);
            elsif (remainder1 < to_ufixed(2, temp_balance1)) then
                return_quarters <= to_unsigned(1, return_quarters'length);
                rquarters       <= to_unsigned(1, return_quarters'length);
            elsif (remainder1 < to_ufixed(3, temp_balance1)) then
                return_quarters <= to_unsigned(2, return_quarters'length);
                rquarters       <= to_unsigned(2, return_quarters'length);
            elsif (remainder1 < to_ufixed(4, temp_balance1)) then
                return_quarters <= to_unsigned(3, return_quarters'length);
                rquarters       <= to_unsigned(3, return_quarters'length);
            end if;

            temp_balance2 <= resize(temp_balance1 - (to_ufixed(rquarters, temp_balance2) * 0.25), temp_balance2);
            remainder2    <= resize(temp_balance2 / to_ufixed(0.10, temp_balance2), remainder2);

            if (remainder2 < to_ufixed(1, temp_balance2)) then
                return_dimes <= to_unsigned(0, return_dimes'length);
                rdimes       <= to_unsigned(0, return_dimes'length);
            elsif (remainder2 < to_ufixed(2, temp_balance2)) then
                return_dimes <= to_unsigned(1, return_dimes'length);
                rdimes       <= to_unsigned(1, return_dimes'length);
            elsif (remainder2 < to_ufixed(3, temp_balance2)) then
                return_dimes <= to_unsigned(2, return_dimes'length);
                rdimes       <= to_unsigned(2, return_dimes'length);
            end if;

            temp_balance3 <= resize(temp_balance2 - (to_ufixed(rdimes, temp_balance3) * 0.10), temp_balance3);
            remainder3    <= resize(temp_balance3 / to_ufixed(0.05, temp_balance3), remainder3);

            if (remainder3 < to_ufixed(1, temp_balance3)) then
                return_nickles <= to_unsigned(0, return_nickles'length);
                rnickles       <= to_unsigned(0, return_nickles'length);
            elsif (remainder3 < to_ufixed(2, temp_balance3)) then
                return_nickles <= to_unsigned(1, return_nickles'length);
                rnickles       <= to_unsigned(1, return_nickles'length);
            end if;

            return_currency_interrupt <= '1';
        else
            return_currency_interrupt <= '0';
        end if;
    end process;
end architecture behavioral;
