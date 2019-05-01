library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_rs_latch is
end entity tb_rs_latch;

architecture tb of tb_rs_latch is
	signal r, s, q : std_logic;
	signal rv      : std_logic;
	signal sv, qv  : std_logic_vector(3 downto 0);
begin
	-- rs_latch
	rsl : entity work.rs_latch
		port map(
			r => r,
			s => s,
			q => q
		);

	process
		procedure test(rs : std_logic_vector(1 downto 0)) is
		begin
			r <= rs(1);
			s <= rs(0);
			wait for 1 ms;
		end procedure;
	begin
		test("10");                     -- reset
		test("00");                     -- hold
		test("01");                     -- set
		test("00");                     -- hold
		test("10");                     -- reset
		test("01");                     -- set
		test("00");                     -- hold
		test("11");                     -- give reset priorty

		wait;
	end process;

	-- rs_latch_vec
	rslv : entity work.rs_latch_vec
		generic map(
			n => 4
		)
		port map(
			r => rv,
			s => sv,
			q => qv
		);

	process
		procedure test(r : std_logic; s : std_logic_vector(3 downto 0)) is
		begin
			rv <= r;
			sv <= s;
			wait for 1 ms;
		end procedure;
	begin
		test('1', "0000");
		test('0', "1001");
		test('0', "1010");
		test('0', "0000");
		test('1', "0000");
		test('0', "1100");
		test('1', "0011");              -- reset override

		wait;
	end process;
end architecture tb;
