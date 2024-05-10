----------------------------------------------------------------------------------
-- Filename : priority_scrambler.vhd
-- Author : Shyama Gandhi
-- Date : 06-Sep-2023
-- Design Name: priority scrambler
-- Description : In this file we will implement a priority scrambler system
-- Additional Comments: Solution for lab 1
-- Copyright : University of Alberta, 2023
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity priority_scrambler is
  Port (
    clock : IN STD_LOGIC;
    data_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0)  := (OTHERS => '0');
    load_lower : IN STD_LOGIC := '0';
    load_upper : IN STD_LOGIC := '0';
    display_values: IN STD_LOGIC := '0';
    scramble: IN STD_LOGIC := '0';
    segments : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    led : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
    RGB : OUT STD_LOGIC;
    display_select : OUT STD_LOGIC := '0'    
  );
end priority_scrambler;

architecture Structural of priority_scrambler is

signal data_out, data_aux: STD_LOGIC_VECTOR(7 downto 0);
signal clock_signal, clock_aux: STD_LOGIC;

begin
    clock_div: entity work.clock_divider(Behavioral)
        generic map (freq_out => 50)
        port map( clock=>clock
                , clock_div=>clock_signal
                );
  
    data_register: entity work.data_register(Behavioral) 
        port map( clock=>clock
                , data_in=>data_in
                , data_out=>data_out
                , load_lower=>load_lower
                , load_upper=>load_upper
                ); 
  
    display_controller: entity work.display_controller(Behavioral)
        port map( clock=>clock_signal
                , display_values=>display_values
                , digits=>data_out
                , display_select=>display_select
                , segments=>segments
                );
 
    scrambler: entity work.scrambler(Behavioral)
        port map( data_in=>data_out
                , data_out=>data_aux
                , scramble=>scramble
                );

    priority_encoder: entity work.priority_encoder(Behavioral)
        port map( D=>data_aux
                , Q=>led
                , GS=>RGB
                );
end Structural;
