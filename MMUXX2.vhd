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

entity MMUXX2 is
	port(
		ADDR1 : IN STD_LOGIC_VECTOR(3 downto 0);
		ADDR2 : IN STD_LOGIC_VECTOR(3 downto 0);
		XIN : IN STD_LOGIC_VECTOR(15 downto 0);
		YIN : IN STD_LOGIC_VECTOR(15 downto 0);
		ZOUT : OUT STD_LOGIC_VECTOR(15 downto 0);
		AOUT : OUT STD_LOGIC_VECTOR(3 downto 0);
		SEL : IN STD_LOGIC;
		IEN : IN STD_LOGIC_VECTOR(0 downto 0);
		EOUT : OUT STD_LOGIC_VECTOR(0 downto 0)
		);
end MMUXX2;

architecture Combinational of MMUXX2 is
begin	  

	with SEL select
			AOUT <= ADDR1 when '1',
						ADDR2 when '0',
						ADDR1 when others;
						
	with SEL select					
			ZOUT <= XIN when '1',
						YIN when '0',
						XIN when others;
						
	with SEL select
			EOUT <= "0" when '1',
						IEN when '0',
						"0" when others;
			
end Combinational;

