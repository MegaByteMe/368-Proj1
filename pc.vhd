----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:11:15 03/25/2015 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

entity PC is
	port(
			CLK : IN STD_LOGIC;
			Trig : IN STD_LOGIC;
			Count : OUT STD_LOGIC_VECTOR(7 downto 0);
			SCLR : IN STD_LOGIC;
			LDEN : IN STD_LOGIC;
			LOAD : IN STD_LOGIC_VECTOR(7 downto 0)
			);
end PC;

architecture Behavioral of PC is
	signal C : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal A : STD_LOGIC_VECTOR(7 downto 0) := "00000001";

begin
	process(CLK, SCLR, Trig)
		begin
		if(SCLR = '1') then
			C <= "00000000";
		elsif(rising_edge(CLK) and Trig = '1') then
			C <= std_logic_vector(unsigned(C) + unsigned(A));
			if(LDEN = '1') then
				C <= LOAD;
			end if;
		end if;
		end process;
		Count <= C;
end Behavioral;

