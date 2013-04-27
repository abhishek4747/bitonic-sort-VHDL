
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:04:37 04/26/2013
-- Design Name:   bitonic_sort
-- Module Name:   C:/Xilinx92i/prject1/btest.vhd
-- Project Name:  prject1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bitonic_sort
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
use work.array1.ALL;
ENTITY btest_vhd IS
END btest_vhd;

ARCHITECTURE behavior OF btest_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT bitonic_sort
	PORT(
		input : IN arr;         
		output : OUT arr
		);
	END COMPONENT;

	--Inputs
	SIGNAL input :  arr:=(others=>0);

	--Outputs
	SIGNAL output :  arr:=(others=>0);

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: bitonic_sort PORT MAP(
		input => input,
		output => output
	);

	tb : PROCESS
	BEGIN
	wait for 100 ns;
--input(0) <= "00001010";
--input(1) <= "00010100";
--input(2) <= "00000101";
--input(3) <= "00001001";
--input(4) <= "00000011";
--input(5) <= "00001000";
--input(6) <= "00001100";
--input(7) <= "00001110";
--input(8) <= "01011010";
--input(9) <= "00000000";
--input(10) <= "00111100";
--input(11) <= "00101000";
--input(12) <= "00010111";
--input(13) <= "00100011";
--input(14) <= "01011111";
--input(15) <= "00010010";
--n <= 16;
--low <= 0;
input(0) <= 10;
input(1) <= 20;
--input(2) <= 5;
--input(3) <= 9;
--input(4) <= -3;
--input(5) <= 8;
--input(6) <= 12;
--input(7) <= 14;
--input(8) <= 90;
--input(9) <= 0;
--input(10) <= 60;
--input(11) <= 40;
input(12) <= 23;
--input(13) <= 35;
--input(14) <= 95;
--input(15) <= 18;
wait;

		
	END PROCESS;

END;
