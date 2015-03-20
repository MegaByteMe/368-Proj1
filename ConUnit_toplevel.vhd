----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:34:04 03/17/2015 
-- Design Name: 
-- Module Name:    ConUnit_toplevel - Structural 
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

entity ConUnit_toplevel is
		port(
				CLK : IN STD_LOGIC;
				RST : IN STD_LOGIC;
				
				LED : OUT STD_LOGIC_VECTOR(7 downto 0);
				
				im_dataout : OUT STD_LOGIC_VECTOR(15 downto 0);
				
				RB_WEA : OUT STD_LOGIC_VECTOR(0 downto 0);
				RB_WEB : OUT STD_LOGIC_VECTOR(0 downto 0);
				RB_ADDRA : OUT STD_LOGIC_VECTOR(3 downto 0);
				RB_ADDRB : OUT STD_LOGIC_VECTOR(3 downto 0);
				
				AMUXSEL : OUT STD_LOGIC;
				BMUXSEL : OUT STD_LOGIC_VECTOR(1 downto 0);
				
				EXTRAMADR : OUT STD_LOGIC_VECTOR(3 downto 0);
				EXTRAMEN : OUT STD_LOGIC;
				EXTRAMWEA : OUT STD_LOGIC_VECTOR(0 downto 0);
				
				FOSWSEL : OUT STD_LOGIC
				);
end ConUnit_toplevel;

architecture Structural of ConUnit_toplevel is

	--PC signals
	signal ldcount : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
	signal lena		: STD_LOGIC := '0';
	signal hCLKena	: STD_LOGIC := '1';
	
	--IM signals
	signal imwea : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	signal imdout : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

	--SHARED signals
	signal PCadrs	: STD_LOGIC_VECTOR(4 downto 0) :=(others => '0');

begin

im_dataout <= imdout;

	ConUnit : entity work.ConUnit
		port map(
					CLK => CLK,
					RST => RST,
					
					pcCLKen => hCLKena,
					imdout => imdout,
					
					RB_WEA => RB_WEA,
					RB_WEB => RB_WEB,
					RB_ADDRA => RB_ADDRA,
					RB_ADDRB => RB_ADDRB,
					
					AMUXSEL => AMUXSEL,
					BMUXSEL => BMUXSEL
					);

	PC: entity pc
		port map(
					clk => clk,
					l => ldcount,
					load => lena,
					q => PCadrs,
					ce => hclkena
					);
					
	IM: entity instruct_mem
		port map(
					clka => clk,
					addra => PCadrs,
					douta => imdout
					);

end Structural;

