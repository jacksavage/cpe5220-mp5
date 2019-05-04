-- Test bench for balance manager

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

entity tb_balance_manager is
end entity tb_balance_manager;

architecture test of tb_balance_manager is

	signal num_dollars, num_quarters, num_dimes, num_nickles : unsigned(3 downto 0);
	signal new_currency_interrupt : std_logic;
	signal order_cost : ufixed(4 downto -5);
	signal vend, return_balance, reset, clk : std_logic;
	signal insufficient_funds, return_currency_interrupt : std_logic; 	
	signal return_dollars, return_quarters, return_dimes, return_nickles : unsigned(3 downto 0); 
	constant t_c : time := 50 ns;

begin
	-- instantiate DUV
	duv_balance_manager: entity work.balance_manager(behavioral)
		port map (num_dollars=>num_dollars, num_quarters=>num_quarters, num_dimes=>num_dimes, num_nickles=>num_nickles,
			  new_currency_interrupt=>new_currency_interrupt, order_cost=>order_cost, vend=>vend,
			  return_balance=>return_balance, reset=>reset, clk=>clk, insufficient_funds=>insufficient_funds, 
			  return_currency_interrupt=>return_currency_interrupt,
			  return_dollars=>return_dollars, return_quarters=>return_quarters, return_dimes=>return_dimes, return_nickles=>return_nickles);


	clk_gen : process is
	begin
		wait for t_c / 2;
		clk <= '1';
		wait for t_c - t_c / 2;
		clk <= '0';
	end process clk_gen;

	-- reset
	reset <= '1', '0' after 2*t_c;

	-- test case procedure
	apply_test_cases : process is
	procedure apply_test (num_dollars_in,num_quarters_in,num_dimes_in,num_nickles_in : integer) is
	begin
		num_dollars <= to_unsigned(num_dollars_in,num_dollars'length);
		num_quarters <= to_unsigned(num_quarters_in,num_quarters'length);
		num_dimes <= to_unsigned(num_dimes_in,num_dimes'length);
		num_nickles <= to_unsigned(num_nickles_in,num_nickles'length);
		new_currency_interrupt <= '1';
		vend <= '1';
		return_balance <= '1';
		for i in 1 to 7 loop
		wait until rising_edge(clk);
		new_currency_interrupt <= '0';
		end loop;
		vend <= '0';
		return_balance <= '0';
	end procedure apply_test;

	begin
	return_balance <= '0';
	vend <= '0';
        wait until rising_edge(clk) and reset = '0';
	order_cost <= to_ufixed(1.00, order_cost); -- Order $1.00
	apply_test(1,2,1,1); -- Load $1.65


	order_cost <= to_ufixed(1.75, order_cost); -- Order $1.75
	apply_test(5,3,2,1); -- Load $6.00

	order_cost <= to_ufixed(6.50, order_cost); -- Order $6.50
	apply_test(5,3,2,1); -- Load $6.00

	end process apply_test_cases;
	
end architecture test;


