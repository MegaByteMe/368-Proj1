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
				LED : OUT STD_LOGIC_VECTOR(7 downto 0);
				ALU_OUT : OUT STD_LOGIC_VECTOR(15 downto 0)				
				);
end MAST;

architecture Structural of MAST is
	
	--FPU
	signal CCR : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal LDSTO : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
	signal IM_FEED : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
	signal RB_WEA : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	signal RB_WEB : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	signal RB_ADDRA : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal RB_ADDRB : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	
	signal AMUXSEL : STD_LOGIC := '0';
	signal BMUXSEL : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal SW1SEL : STD_LOGIC := '0';
	
	signal GRAMI : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal GRAMO : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal GADD : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal GEN : STD_LOGIC := '0';
	signal GWEA : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	
	signal FOSWSEL : STD_LOGIC;

begin
--entities
	ConUnit : entity work.ConUnit_toplevel
		port map(
					CLK => CLK,
					RST => RST,
					im_dataout => IM_FEED,
					AMUXSEL => AMUXSEL,
					BMUXSEL => BMUXSEL,
					
					LED => LED,
					
					RB_WEA => RB_WEA,
					RB_WEB => RB_WEB,
					RB_ADDRA => RB_ADDRA,
					RB_ADDRB => RB_ADDRB,
					
					EXTRAMADR => GADD,
					EXTRAMEN => GEN,
					EXTRAMWEA => GWEA,
					
					FOSWSEL => FOSWSEL
					);

	FPU : entity work.FPUnit_toplevel
		port map(
					CLK => CLK,
					RST => RST,
						
					CCR => CCR,
					ALU_OUT => ALU_OUT,
					LDST => LDSTO,
					IM_FEED => IM_FEED,
					
					RB_ENA => '1',
					RB_ENB => '1',
					RB_WEA => RB_WEA,
					RB_WEB => RB_WEB,
					RB_ADDRA => RB_ADDRA,
					RB_ADDRB => RB_ADDRB,
					
					AMUXSEL => AMUXSEL,
					BMUXSEL => BMUXSEL,
					
					EXTRAMI => GRAMI,
					EXTRAMO => GRAMO,
					
					FOSESEL => FOSWSEL
					);
					
	Gen_RAM : entity work.general_ram
		port map(
					CLKA => CLK,
					DINA => GRAMI,
					DOUTA => GRAMO,
					ADDRA => GADD,
					ENA => GEN,
					WEA => GWEA
					);

end Structural;

