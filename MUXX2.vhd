----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:21:40 03/18/2015 
-- Design Name: 
-- Module Name:    MUXX - Combinational 
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

entity MUXX2 is
	port(
		XIN : IN STD_LOGIC_VECTOR(15 downto 0);
		YIN : IN STD_LOGIC_VECTOR(15 downto 0);
		ZOUT : OUT STD_LOGIC_VECTOR(15 downto 0);
		SEL : IN STD_LOGIC
		);
end MUXX2;

architecture Combinational of MUXX2 is

begin
	with SEL select
	ZOUT <= XIN when '0',
			  YIN when '1',
			  XIN when others;

end Combinational;

