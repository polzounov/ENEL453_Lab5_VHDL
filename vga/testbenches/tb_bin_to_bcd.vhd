library ieee;
use ieee.std_logic_1164.all;

entity tb_bin_to_bcd is
end tb_bin_to_bcd;

architecture tb of tb_bin_to_bcd is

    component binary_to_bcd
        port (
                i_Clock  : in std_logic;
                i_Start  : in std_logic;
                i_Binary : in std_logic_vector (9-1 downto 0); -- Set g_input_width to 9
                o_BCD    : out std_logic_vector (3*4-1 downto 0); -- Set g_decimal_digits to 3
                o_DV     : out std_logic
        );
    end component;

    signal i_Clock  : std_logic;
    signal i_Start  : std_logic;
    signal i_Binary : std_logic_vector (9-1 downto 0); -- Set g_input_width to 9
    signal o_BCD    : std_logic_vector (3*4-1 downto 0); -- Set g_decimal_digits to 3
    signal o_DV     : std_logic;

    constant TbPeriod : time := 10 ns; -- Period of clock
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin
-- Module to test
    dut : binary_to_bcd
    port map (i_Clock  => i_Clock,
              i_Start  => i_Start,
              i_Binary => i_Binary,
              o_BCD    => o_BCD,
              o_DV     => o_DV);

-- Testbench processes
    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- Counter input (eg distance)
    input_counter: process(TbClock)
    begin
        if (rising_edge(TbClock)) then
            input_counter <= input_counter + 1;
        end if;
    end process ; -- input_counter

    -- Test Bench process
    stimuli : process
    begin
        i_Start <= '1';
        i_Binary <= (others => '0');
        wait for 1000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
