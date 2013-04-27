library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.All;

package array1 is 
	type arr is array (15 downto 0 ) of integer;
end array1;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.array1.ALL;

entity bitonic_sort is
	port(
		input: in arr;
		output: out arr
	);
end bitonic_sort;

architecture Behavioral of bitonic_sort is

function bitonicmerge (input:arr; low:integer; n:integer;dir:boolean) return arr is
	variable inputf:arr := (others=>0);
	variable outputf:arr := (others=>0);
	variable temp : integer := 0;
	variable k:integer := n/2; 
begin
	inputf:=input;
	if (n> 1) then
		for i in low to low+k-1 loop
			 if (dir xor (inputf(i) > inputf(i+k))) then
				 temp:=inputf(i);
				 inputf(i):=inputf(i+k);
				 inputf(i+k):=temp;
			 end if;
		end loop;
		inputf := bitonicmerge(inputf,low,k,dir);
		inputf := bitonicmerge(inputf,low+k,k,dir);
	end if;
	return inputf; 
end bitonicmerge;

function bitonicsort(input:arr;low:integer;n:integer;dir:boolean) return arr is
	variable k:integer := n/2;
	variable inputf2:arr := (others=>0);
begin
	inputf2 := input;
	if (n>1) then
		inputf2 := bitonicsort(inputf2,low,k,true);
		inputf2 := bitonicsort(inputf2,low+k,k,false);
		inputf2 := bitonicmerge(inputf2,low,n,dir);
	end if;
	return inputf2;
end bitonicsort;

begin
--false is descending
--true is asscending
output <= bitonicsort(input,0,16,true);
end Behavioral;

