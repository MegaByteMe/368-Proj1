----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:34:23 03/21/2015 
-- Design Name: 
-- Module Name:    SoloReg - Behavioral 
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

entity SoloReg is
    Port ( 
			  CLK : in STD_LOGIC;
			  xin : in  STD_LOGIC_VECTOR(15 downto 0);
           yout : out  STD_LOGIC_VECTOR(15 downto 0);
           wen : in  STD_LOGIC;
           rst : in  STD_LOGIC
			  );
end SoloReg;

architecture Behavioral of SoloReg is
	
begin		
	process(CLK, RST)
		begin
			if(RST = '1') then
				yout <= X"0000";
			elsif(falling_edge(CLK) and WEN = '1') then
				YOUT <= XIN;
			end if;
	end process;
end Behavioral;

