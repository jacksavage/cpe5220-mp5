library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_dispenser is
end entity tb_dispenser;

architecture tb of tb_dispenser is
    signal clk                                          : std_logic := '0';
    signal dispense, done, failed, lightscreen_n, reset : std_logic;
    signal item_num                                     : unsigned(3 downto 0);
    signal motors                                       : std_logic_vector(15 downto 0);
    signal T                                            : time      := 1 ms;
begin
    clk <= not clk after T / 2;

    uut : entity work.dispenser
        port map(
            clk           => clk,
            dispense      => dispense,
            lightscreen_n => lightscreen_n,
            reset         => reset,
            item_num      => item_num,
            motors        => motors,
            done          => done,
            failed        => failed
        );

    process is
        procedure test(num : integer; successful_vend : boolean) is
        begin
            -- select an item
            item_num <= to_unsigned(num, item_num'length);

            -- tell the UUT to dispense
            dispense <= '1';
            wait for T;
            dispense <= '0';

            -- interrupt lightscreen (indicating successful vend)
            if successful_vend then
                wait for 4 * T;
                lightscreen_n <= '1';
                wait for T;
                lightscreen_n <= '0';
            end if;

            -- wait until a bit after the UUT says it is done
            wait until rising_edge(done);
            wait for T;
        end procedure;
    begin
        lightscreen_n <= '0';

        test(3, true);
        test(12, true);
        test(6, false);
        test(8, true);
        test(4, false);
        test(5, false);

        wait;
    end process;
end architecture tb;
