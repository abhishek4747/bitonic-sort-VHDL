----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:31:26 10/25/2009 
-- Design Name: 
-- Module Name:    uart_test1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
entity uart_test1 is
   port(
      clk, reset: in std_logic;
      btn:  std_logic;
      rx: in std_logic;
      tx: out std_logic
      --led: out std_logic_vector(7 downto 0)
   );
end uart_test1;

-- This code sends the received character (key) back to the terminal 
-- when the button is pressed.
architecture arch of uart_test1 is
   signal tx_full, rx_empty: std_logic;
   signal rec_data, send_data: std_logic_vector(7 downto 0);
   signal btn_tick: std_logic;
	signal tx_en: std_logic;
begin
   -- instantiate uart
   uart_unit: entity work.uart(str_arch)
      port map(clk=>clk, reset=>reset, rd_uart=>btn_tick,
               wr_uart=>tx_en, rx=>rx, w_data=>send_data,
               tx_full=>tx_full, rx_empty=>rx_empty,
               r_data=>rec_data, tx=>tx);
   -- instantiate debounce circuit
   btn_db_unit: entity work.debounce(fsmd_arch)
      port map(clk=>clk, reset=>reset, sw=>btn,
               db_level=>open, db_tick=>btn_tick);
   
	tx_en <= btn_tick; -- use the debounced button signal as wr_uart
	
	-- recycle the characters 
	send_data <= rec_data; 
	
		
   --  led display
   --led <= rec_data;
   
end arch;

