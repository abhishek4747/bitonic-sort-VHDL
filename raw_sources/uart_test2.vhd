----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:29:02 10/24/2009 
-- Design Name: 
-- Module Name:    uart_test2 - Behavioral 
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
entity uart_test2 is
   port(
      clk, reset: in std_logic;
      btn:  std_logic;
      rx: in std_logic;
      tx: out std_logic
      --led: out std_logic_vector(7 downto 0)
   );
end uart_test2;

architecture arch of uart_test2 is
   signal tx_full, rx_empty: std_logic;
   signal rec_data, send_data: std_logic_vector(7 downto 0);
   signal btn_tick: std_logic;
	signal tx_en: std_logic;
	signal c_count: std_logic_vector(3 downto 0);
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
   
	tx_en <= btn_tick;
	
	-- send "Hello" + crlf" to terminal 
	process(btn_tick, c_count)
	 begin
	   if btn_tick = '1' then 
          case c_count is 		
			   when "0000" => send_data <= X"48";  -- "H"
			   when "0001" => send_data <= X"65";  -- "e"
				when "0010" => send_data <= X"6C";   -- "l"
				when "0011" => send_data <= X"6C";   -- "l"
				when "0100" => send_data <= X"6F";   -- "o"
				when "0101" => send_data <= X"0D";   -- CR
				when "0110" => send_data <= X"0A";   -- LF
				when others => send_data <= X"20";  -- space	
			end case;	
		 end if;
	 end process;	
	
    process(btn_tick)
    begin
       if btn_tick'event and btn_tick='1' then
          if c_count = "0110" then
			    c_count <= "0000";
			 else
				 c_count <= c_count + 1;
			 end if;
       end if;			 
    end process;	 
	
		
   --  led display
   --led <= rec_data;
   
end arch;
