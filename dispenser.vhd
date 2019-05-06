library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dispenser is
    port(
        clk, dispense, lightscreen_n, reset : in  std_logic;
        item_num                            : in  unsigned(3 downto 0);
        motors                              : out std_logic_vector(15 downto 0);
        done, failed                        : out std_logic
    );
end entity dispenser;

architecture behavioral of dispenser is
    type fsm_state is (idle, vending);
    signal state : fsm_state := idle;

    constant init_drive_count : integer := 10;
    signal drive_count        : integer;

    signal ls_mon_rst, ls_mon : std_logic;
begin
    ls_monitor : entity work.rs_latch
        port map(
            r => ls_mon_rst,
            s => lightscreen_n,
            q => ls_mon
        );

    -- fsm
    process(clk) is
    begin
        if rising_edge(clk) then
            case state is
                when idle =>
                    motors     <= (others => '0'); -- motors should not be driven in idle state
                    ls_mon_rst <= '1';  -- hold the lightscreen monitor in reset

                    -- should an item be dispensed?
                    if dispense = '1' then -- yes
                        state                        <= vending; -- set next state 
                        drive_count                  <= init_drive_count; -- load the drive counter
                        motors(to_integer(item_num)) <= '1'; -- start driving the selected motor
                        ls_mon_rst                   <= '0'; -- release ls_mon latch reset
                        failed                       <= '0'; -- reset failed flag
                    end if;

                    if (dispense = '1' or reset = '1') then
                        done <= '0';    -- reset done signal
                    end if;
                when vending =>
                    -- has the drive counter expired? 
                    if drive_count /= 0 then -- no
                        drive_count <= drive_count - 1; -- decrement the drive counter
                    else                -- yes
                        state                        <= idle; -- set next state
                        motors(to_integer(item_num)) <= '0'; -- stop driving the motor
                        done                         <= '1'; -- indicate that the vend is complete
                        --failed 							<= not ls_mon;	-- set the failed flag if no lightscreen interrupt observed
                    end if;
            end case;
        end if;
    end process;
end architecture behavioral;
