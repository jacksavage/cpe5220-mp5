library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rs_latch is
	port(r, s : in std_logic; q : out std_logic);
end entity rs_latch;

architecture behavioral of rs_latch is
begin
	process (r, s) is
	begin
		if r = '1' then
			q <= '0';
		elsif s = '1' then
			q <= '1';
		end if;
	end process;
end architecture behavioral;

-- vector version
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rs_latch_vec is
	generic(n : natural);
	port(
		r : in std_logic;
		s : in std_logic_vector(n-1 downto 0); 
		q : out std_logic_vector(n-1 downto 0)
	);
end entity rs_latch_vec;

architecture behavioral of rs_latch_vec is
begin
	gen_latch : for i in q'range generate
		latch : entity work.rs_latch
			port map(
				r => r,
				s => s(i),
				q => q(i)
			);
	end generate;
end architecture behavioral;