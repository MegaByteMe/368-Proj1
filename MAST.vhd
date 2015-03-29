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
				ALU_OUT : OUT STD_LOGIC_VECTOR(15 downto 0)				
				);
end MAST;

architecture Structural of MAST is
	
	--FPU
	signal CCR : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal LDSTO : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
	--INSTRUCTION STATE REGISTERS
	signal IR1, IR2, IR3, IR4, IR5 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');	
	
	--REGISTER ENABLES
	signal RAWen, RBWen, FPRWen : STD_LOGIC;	
	signal RB_WEA : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	signal RB_WEB : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	
	--MUX ENABLES
	signal AMUXSEL : STD_LOGIC := '0';
	signal BMUXSEL : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal SW1SEL : STD_LOGIC := '0';
	signal FOSWSEL : STD_LOGIC := '0';
	
	--EXTERNAL MEMORY SIGNALS
	signal EXTMI, EXTMO : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal EXTMADDR : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal EMEN : STD_LOGIC := '0';
	signal EMWEA : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	
	--LOCAL MEMORY SIGNALS
	signal LOCMI, LOCMO : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');	
	signal LOCMADDR : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal LMEN : STD_LOGIC := '0';
	signal LMWEA : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');

begin
--entities
	ConUnit : entity work.ConUnit_toplevel
		port map(
					CLK => CLK,
					RST => RST,
					AMUXSEL => AMUXSEL,
					BMUXSEL => BMUXSEL,
					
					RB_WEA => RB_WEA,
					RB_WEB => RB_WEB,
					
					RAWen => RAWen,
					RBWen => RBWen,
					FPRWen => FPRWen,
					
					EXTRAMADR => EXTMADDR,
					EXTRAMEN => EMEN,
					EXTRAMWEA => EMWEA,
					
					LOCRAMADR => LOCMADDR,
					LOCRAMEN => LMEN,
					LOCRAMWEA => LMWEA,
					
					IR1 => IR1,
					IR2 => IR2,
					IR3 => IR3,
					IR4 => IR4,
					IR5 => IR5,
					
					FOSWSEL => FOSWSEL
					);

	FPU : entity work.FPUnit_toplevel
		port map(
					CLK => CLK,
					RST => RST,
						
					CCR => CCR,
					ALU_OUT => ALU_OUT,
					LDST => LDSTO,
					IM_FEED => IR1,
					
					RB_ENA => '1',
					RB_ENB => '1',
					RB_WEA => RB_WEA,
					RB_WEB => RB_WEB,
					RB_ADDRA => IR1(11 downto 8),
					RB_ADDRB => IR1(7 downto 4),
					
					RAWen => RAWen,
					RBWen => RBWen,
					FPRWen => FPRWen,
					
					AMUXSEL => AMUXSEL,
					BMUXSEL => BMUXSEL,
					
					EXTRAMI => EXTMI,
					EXTRAMO => EXTMO,
					
					LOCMADDR => LOCMADDR,
					LMEN => LMEN,
					LMWEA => LMWEA,
					
					FOSWSEL => FOSWSEL
					);
					
	EXT_RAM : entity work.general_ram
		port map(
					CLKA => CLK,
					DINA => EXTMI,
					DOUTA => EXTMO,
					ADDRA => EXTMADDR,
					ENA => EMEN,
					WEA => EMWEA
					);

end Structural;

