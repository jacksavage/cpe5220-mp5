library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is
	port(
		clk : in std_logic;
		rst : in std_logic
	);
end entity state_machine;

architecture behavioral of state_machine is
	type state_type is (user_selection, payment, dispursement);
begin
	process(clk, rst) is
		variable state : state_type := user_selection;
	begin
		if rst = '1' then
			state := user_selection;
		elsif rising_edge(clk) then
			case state is
				when user_selection =>
					state := payment;
				when payment =>
					state := dispursement;
				when dispursement =>
					state := user_selection;
			end case;
		end if;
	end process;
end architecture behavioral;
