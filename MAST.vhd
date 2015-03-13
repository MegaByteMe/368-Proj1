----------------------------------------------------------------------------------
-- Company: 		ECE368
-- Engineer: 		MR - Group7
-- 
-- Create Date:    11:27:09 03/11/2015 
-- Design Name: 
-- Module Name:    MAST - Behavioral 
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

entity MAST is
		port (
				CLK : IN STD_LOGIC;
				RST : IN STD_LOGIC;
				LED : OUT STD_LOGIC_VECTOR(7 downto 0)
				);
end MAST;

architecture Structural of MAST is
--signals

begin
--entities
	FPU : entity work.FPUnit_toplevel
		port map(
					CLK <= CLK,
					ALU_OUT <= ALU_OUT,
					DATA_OUT <= DATA_OUT,
					NZVC <= NZVC
					);
				
	ConUnit : entity work.ConUnit
		port map(
					RST <= RST,
					);

end Structural;

