library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity down_counter is
	port(
		start_count : in integer;
		clk, rst : in std_logic;
		flag : out std_logic
	);
end entity down_counter;

architecture behavioral of down_counter is
	signal counter : integer;
begin
	process (clk) is
	begin
		if rising_edge(clk) then
			if rst = '1' then
				flag <= '0';
				counter <= start_count;
			else
				if counter = 0 then
					flag <= '1';
				else
					counter <= counter - 1;
				end if;
			end if;
		end if;
	end process;
end architecture behavioral;
