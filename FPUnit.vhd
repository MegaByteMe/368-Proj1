----------------------------------------------------------------------------------
-- Company: 		ECE368
-- Engineer: 		MR - Group7
-- 
-- Create Date:    11:28:58 03/11/2015 
-- Design Name: 	
-- Module Name:    FPUnit - Combinational 
-- Project Name: 	 Project1
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

entity FPUnit is
		port(
			ALU_OUT : OUT STD_LOGIC_VECTOR(15 downto 0);
			DATA_OUT : OUT STD_LOGIC_VECTOR(15 downto 0);
			NZVC : OUT STD_LOGIC_VECTOR(3 downto 0)
			);
end FPUnit;

architecture Combinational of FPUnit is
--signals
begin


end Combinational;

