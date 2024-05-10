----------------------------------------------------------------------------------
-- Filename : data_register.vhdl
-- Author : Shyama Gandhi
-- Date : 06-Sep-2023
-- Design Name: DATA REGISTER
-- Description : In this file we will implement a simple 8-bit register to store
-- values coming from the switches and load them to the upper or lower nibble
-- Copyright : University of Alberta, 2023
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD;

ENTITY data_register IS
    PORT (
        clock      : IN STD_LOGIC;
        data_in    : IN STD_LOGIC_VECTOR(3 DOWNTO 0)  := (OTHERS => '0');
        data_out   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
        load_lower : IN STD_LOGIC                     := '0';
        load_upper : IN STD_LOGIC                     := '0'
    );
END;

ARCHITECTURE Behavioral OF data_register IS
    SIGNAL aux, out_signal : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL clock_signal    : STD_LOGIC;
BEGIN
    clock_div : ENTITY work.clock_divider(Behavioral) GENERIC MAP (freq_out => 100) PORT MAP(clock => clock, clock_div => clock_signal);

    data_out <= out_signal;

    PROCESS (clock_signal)
    BEGIN
        IF rising_edge(clock_signal) THEN
            IF load_lower = '1' AND load_upper = '0' THEN
                out_signal <= ("0000" & data_in) OR ("11110000" AND out_signal);
            ELSIF load_lower = '0' AND load_upper = '1' THEN
                out_signal <= (data_in & "0000") OR ("00001111" AND out_signal);
            END IF;
        END IF;
    END PROCESS;

END Behavioral;
