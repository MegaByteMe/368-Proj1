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

entity MUXX3 is
	port(
		WIN : IN STD_LOGIC_VECTOR(15 downto 0);
		XIN : IN STD_LOGIC_VECTOR(15 downto 0);
		YIN : IN STD_LOGIC_VECTOR(15 downto 0);
		ZOUT : OUT STD_LOGIC_VECTOR(15 downto 0);
		SEL : IN STD_LOGIC_VECTOR(1 downto 0)
		);
end MUXX3;

architecture Combinational of MUXX3 is

begin
	with SEL select
	ZOUT <= WIN when "00",
			  XIN when "01",
			  YIN when "10",
			  WIN when others;

end Combinational;

