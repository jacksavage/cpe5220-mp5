-- Inventory Memory
-- Function: Keeps track of quantity and price of items in machine

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

entity inventory_memory is
	port(item_num : in unsigned(3 downto 0); -- Selects Item
	     add, remove, clk, reset : in std_logic; -- signal to add or remove quantity
	     quantity : in unsigned(3 downto 0);
	     sold_out : out std_logic; -- signal to indicate item is out of stock
	     item_price : out ufixed(4 downto -5) -- Outputs price of selected item
	     );
end entity inventory_memory;

architecture behavioral of inventory_memory is

type inventory is array (0 to 15) of unsigned(3 downto 0);
type price is array (0 to 15) of ufixed(4 downto -5);
type state is (LOAD, RUN);
signal current_state : state;

signal inventory_mem : inventory;
signal price_mem : price;
signal price_size : ufixed(4 downto -5);

begin

state_reg : process (clk, reset) is 
begin
if reset = '1' then
	current_state <= LOAD;
elsif rising_edge(clk) then
	current_state <= RUN;
end if;
end process state_reg;

control_logic : process (clk, current_state)
begin

case current_state is
when RUN =>
	item_price <= resize(price_mem(to_integer(item_num))*to_ufixed(quantity, price_size), price_size);

	if rising_edge(clk) then
	if add = '1' then
		inventory_mem(to_integer(item_num)) <= inventory_mem(to_integer(item_num)) + quantity;
	elsif remove = '1' then
		if (inventory_mem(to_integer(item_num)) > "0000") then
			if (inventory_mem(to_integer(item_num)) < quantity) then
				sold_out <= '1';
			else
				inventory_mem(to_integer(item_num)) <= inventory_mem(to_integer(item_num)) - quantity;
				sold_out <= '0';
			end if;
		else
			sold_out <= '1';
		end if;
	end if;
	end if;

when LOAD =>
	inventory_mem(0) <= "0110"; -- Item_num 0, qty 6
	price_mem(0) <= resize(to_ufixed(1.75, price_mem(0)),price_mem(0)); -- $1.75
	inventory_mem(1) <= "0110"; -- Item_num 1, qty 6
	price_mem(1) <= resize(to_ufixed(1.00, price_mem(1)),price_mem(1)); -- $1.00
	inventory_mem(2) <= "0011"; -- Item_num 2, qty 3
	price_mem(2) <= resize(to_ufixed(2.15, price_mem(2)),price_mem(2)); -- $2.15
	inventory_mem(3) <= "1000"; -- Item_num 3, qty 8
	price_mem(3) <= resize(to_ufixed(0.50, price_mem(3)),price_mem(3)); -- $0.50
	inventory_mem(4) <= "0100"; -- Item_num 4, qty 4
	price_mem(4) <= resize(to_ufixed(0.75, price_mem(4)),price_mem(4)); -- $0.75
	inventory_mem(5) <= "0100"; -- Item_num 5, qty 4
	price_mem(5) <= resize(to_ufixed(1.15, price_mem(5)),price_mem(5)); -- $1.15
	inventory_mem(6) <= "0100"; -- Item_num 6, qty 4
	price_mem(6) <= resize(to_ufixed(1.75, price_mem(6)),price_mem(6)); -- $1.75
	inventory_mem(7) <= "0110"; -- Item_num 7, qty 6
	price_mem(7) <= resize(to_ufixed(1.25, price_mem(7)),price_mem(7)); -- $1.25
	inventory_mem(8) <= "0100"; -- Item_num 8, qty 4
	price_mem(8) <= resize(to_ufixed(1.05, price_mem(8)),price_mem(8)); -- $1.05
	inventory_mem(9) <= "0101"; -- Item_num 9, qty 5
	price_mem(9) <= resize(to_ufixed(0.55, price_mem(9)),price_mem(9)); -- $0.55
	inventory_mem(10) <= "1000"; -- Item_num 10, qty 8
	price_mem(10) <= resize(to_ufixed(1.90, price_mem(10)),price_mem(10)); -- $1.90
	inventory_mem(11) <= "0110"; -- Item_num 11, qty 6
	price_mem(11) <= resize(to_ufixed(0.95, price_mem(11)),price_mem(11)); -- $0.95
	inventory_mem(12) <= "0100"; -- Item_num 12, qty 4
	price_mem(12) <= resize(to_ufixed(1.75, price_mem(12)),price_mem(12)); -- $1.75
	inventory_mem(13) <= "0010"; -- Item_num 13, qty 2
	price_mem(13) <= resize(to_ufixed(3.05, price_mem(13)),price_mem(13)); -- $3.05
	inventory_mem(14) <= "0100"; -- Item_num 14, qty 4
	price_mem(14) <= resize(to_ufixed(2.10, price_mem(14)),price_mem(14)); -- $2.10
	inventory_mem(15) <= "0100"; -- Item_num 15, qty 4
	price_mem(15) <= resize(to_ufixed(1.20, price_mem(15)),price_mem(15)); -- $1.20
end case;
end process;
end architecture behavioral;