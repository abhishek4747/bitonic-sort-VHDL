library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity interface is
  generic(
      Total : integer := 16
  );
  port(
      clk, resetNot, go: in std_logic;
      rx: in std_logic;
      tx: out std_logic;
      led: inout std_logic_vector(3 downto 0) := "1111"
  );
end interface;

architecture arch of interface is
  signal tx_full, rx_empty: std_logic;
  signal rec_data, send_data: std_logic_vector(7 downto 0);
  signal tx_en: std_logic;
  signal reset: std_logic;
  signal rx_db: std_logic := '0';
  signal rx_nonempty: std_logic;
  signal txSig: std_logic;
    
  signal n : integer := 0;
  
  type int_array is array(natural range <>) of integer;
  signal nums : int_array(Total-1 downto 0) := (others => 2147483647);
  signal outnums : int_array(Total-1 downto 0) := (others => 2147483647);
  signal reading : std_logic := '1';
  
  type state is (stateNext, printnum, idle, start);
  signal outState, nextState : state := idle;
  signal started: std_logic := '0';

  component uart
    generic(
     -- Default setting:
     -- 38,400 baud, 8 data bits, 1 stop bits, 2^2 FIFO
      DBIT: integer:=8;     -- # data bits
      SB_TICK: integer:=16; -- # ticks for stop bits, 16/24/32
                            --   for 1/1.5/2 stop bits
      DVSR: integer:= 163;  -- baud rate divisor
                            -- DVSR = 100M/(16*baud rate)
      DVSR_BIT: integer:=8; -- # bits of DVSR
      FIFO_TW: integer:=8;  -- # addr bits of FIFO
      FIFO_RW: integer:=8   -- # words in FIFO=2^FIFO_W
    );
    port(
      clk, reset: in std_logic;
      rd_uart, wr_uart: in std_logic;
      rx: in std_logic;
      w_data: in std_logic_vector(7 downto 0);
      tx_full, rx_empty: out std_logic;
      r_data: out std_logic_vector(7 downto 0);
      tx: out std_logic
    );
  end component;

  component debounce_modified
    port(
      clk, reset: in std_logic;
      sw: in std_logic;
      db_level, db_tick: out std_logic
    );
  end component ;

  component Sorter_Implementor
    generic (
          N : integer := Total
        );
    port (
          Input : IN  int_array (Total-1 downto 0);
          Output : OUT  int_array (Total-1 downto 0)
        );
  end component;


begin

  reset <= not resetNot;
  rx_nonempty <= not rx_empty;
   -- instantiate uart
    uart_unit: uart
      port map(clk=>clk, reset=>reset, rd_uart=>rx_db,
               wr_uart=>tx_en, rx=>rx, w_data=>send_data,
               tx_full=>tx_full, rx_empty=>rx_empty,
               r_data=>rec_data, tx=>txSig);
    tx <= txSig;
   -- instantiate debounce_modified circuit
    rx_db_unit: debounce_modified
        port map(clk=>clk, reset=>reset, sw=>rx_nonempty,
            db_level=>open, db_tick=>rx_db);
  
   -- instantiate sorter
    sorting_wrapper: Sorter_Implementor
        port map(Input=>nums, Output=>outnums);

  process(rx_db,reset)
  variable i : integer := 0;
  variable current : std_logic_vector(0 to 31) := (others => '0');
  begin
   if(reset='1') then
    current := (others => '0');
    i := 0;
    n <= 0;
    nums <= (others => 2147483647);
    led(1) <= '1';
    elsif(rx_db'event and rx_db='1') then
      if(reading='1') then
        current(i to i+7) := rec_data;
        i := i+8;
        if(i > 31) then
          i := 0;
          nums(n) <= conv_integer(signed(current));
          n <= n+1;
          current := (others => '0');
       led(1) <= not led(1);
        end if;
      end if;
    end if;
  end process;

  process(go,reset)
  begin
  if(reset='1') then
    reading <= '1';
  elsif(go'event and go='0') then
      reading <= '0';
  end if;
  end process;
  
  led(0) <= rx;
  led(2) <= reading;
  led(3) <= txSig;

  process(clk,reset)
  begin
   if(reset='1') then
    outState <= idle;
    started <= '0';
    elsif(clk'event and clk='1') then
      outState <= nextState;
      if(reading ='0' and started = '0') then
        outState <= start;
        started <= '1';
      end if;
    end if;
  end process;
  
  process(clk,reset)

  variable itr: integer := 0;
  variable c: integer := 1;
  variable tmp: std_logic_vector(1 to 32);

  begin
    if(reset='1') then
      nextState <= idle;
      tx_en <= '0';
      send_data <= (others => '0');
      itr := 0;
      c := 1;
      tmp := (others => '0');
    elsif(clk'event and clk = '0') then
      nextState <= outState;
      tx_en <= '0';
      
      if(outState=start) then
        itr := -1;
        nextState <= stateNext;
      
      elsif(outState=printnum) then
        if(c > 32) then
          nextState <= stateNext;
        else
          send_data <= tmp(c to (c+7));
          tx_en <= '1';
          c := c+8;
        end if;
      
      elsif(outState=stateNext) then
        c := 1;
        itr := itr + 1;
        nextState <= printnum;
        tmp := conv_std_logic_vector(outnums(itr),32);

        if(itr >= Total) then
          nextState <= idle;
        elsif(outnums(itr) = 2147483647) then
          nextState <= idle;
        else
          nextState <= printnum;
        end if;

      else
        nextState <= idle;
      end if;

    end if;
  end process;
  
end arch;