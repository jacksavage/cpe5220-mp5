-- Inventory Memory
-- Function: Keeps track of quantity and price of items in machine

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

entity inventory_memory is
	port(item_num : in unsigned(3 downto 0); -- Selects Item
	     add, remove, clk : in std_logic; -- signal to add or remove quantity
	     quantity : in unsigned(3 downto 0);
	     sold_out : out std_logic; -- signal to indicate item is out of stock
	     item_price : out ufixed(4 downto -5) -- Outputs price of selected item
	     );
end entity inventory_memory;

architecture behavioral of inventory_memory is
begin
-- store quantity and cost data for each item_num 0-15
end architecture behavioral;