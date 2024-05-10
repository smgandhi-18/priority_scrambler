----------------------------------------------------------------------------------
-- Filename : priority_encoder.vhdl
-- Author : Shyama Gandhi
-- Date : 06-Sep-2023
-- Design Name: priority encoder
-- Description : In this file we will implement a 4:2 priority encoder with a 
-- "group select" signal
-- Additional Comments:
-- Copyright : University of Alberta, 2023
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY priority_encoder IS
    PORT (
        D  : IN STD_LOGIC_VECTOR(7 DOWNTO 0)  := (OTHERS => '0');
        Q  : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
        GS : OUT STD_LOGIC                    := '0'
    );
END priority_encoder;

ARCHITECTURE Behavioral OF priority_encoder IS

    SIGNAL aux, aux1, aux2 : STD_LOGIC;
BEGIN
    -- outputs are negated so they follow positive logic
    aux  <= D(7) AND D(6) AND D(5) AND D(4);
    aux1 <= D(7) AND D(6);
    Q(2) <= NOT (aux AND ((NOT D(0)) OR (NOT D(1)) OR (NOT D(2)) OR (NOT D(3))));
    Q(1) <= NOT ((aux AND D(3) AND D(2) AND D(1) AND (NOT D(0))) OR (aux AND D(3) AND D(2) AND (NOT D(1))) OR (D(7) AND D(6) AND D(5) AND (NOT D(4))) OR (D(7) AND D(6) AND (NOT D(5))));
    Q(0) <= NOT ((aux AND D(3) AND D(2) AND D(1) AND (NOT D(0))) OR (aux AND D(3) AND (NOT D(2))) OR (D(7) AND D(6) AND D(5) AND (NOT D(4))) OR (D(7) AND (NOT D(6))));
    GS   <= NOT (D(0) AND D(1) AND D(2) AND D(3) AND D(4) AND D(5) AND D(6) AND D(7));

END Behavioral;
