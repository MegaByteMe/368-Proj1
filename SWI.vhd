----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:36:53 03/18/2015 
-- Design Name: 
-- Module Name:    SWI - Combinational 
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

entity SWI is
	port(
			SEL : IN STD_LOGIC;
			ZIN : IN STD_LOGIC_VECTOR(15 downto 0);
			XOUT : OUT STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
			YOUT : OUT STD_LOGIC_VECTOR(15 downto 0) := (others => '0')
			);
end SWI;

architecture Combinational of SWI is

begin

XOUT <= ZIN when SEL = '0' else (others => '0');
YOUT <= ZIN when SEL = '1' else (others => '0');

end Combinational;

