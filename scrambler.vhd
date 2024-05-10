----------------------------------------------------------------------------------
-- Filename : scrambler.vhdl
-- Author : Shyama Gandhi
-- Date : 06-Sep-2023
-- Design Name: PRIORITY SCRAMBLER
-- Description : In this file we will implement a priority scrambler
-- this entity is connected to the input of a priority encoder
-- and when the scramble input is active '1' the priority lines change
-- reassigning the priorities of the encoder inputs
-- Additional Comments:
-- Copyright : University of Alberta, 2023
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY scrambler IS
    PORT (
        data_in  : IN STD_LOGIC_VECTOR(7 DOWNTO 0)  := (OTHERS => '0');
        data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
        scramble      : IN STD_LOGIC                     := '0'
    );
END scrambler;

ARCHITECTURE Behavioral OF scrambler IS

BEGIN
    WITH scramble SELECT data_out <=
        data_in WHEN '0',
        data_in(5) & data_in(2) & data_in(7) & data_in(3) & data_in(1) & data_in(0) & data_in(4) & data_in(6) WHEN '1';
END Behavioral;
