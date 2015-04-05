----------------------------------------------------------------------------------
-- Company: 		ECE368
-- Engineer: 		MR - Group7
-- 
-- Create Date:    11:27:09 03/11/2015 
-- Design Name: 
-- Module Name:    MAST - Structural 
-- Project Name: 	 Project1 - Lab2
-- Target Devices: Spartan 3
-- Tool versions: Xilinx 14.7
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
			--	SW : IN STD_LOGIC;
				
				JA : OUT STD_LOGIC_VECTOR(7 downto 0);
				JB : OUT STD_LOGIC_VECTOR(7 downto 0);
				
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
	
	signal debug : STD_LOGIC_VECTOR(9 downto 0);
	signal debug2 : STD_LOGIC_VECTOR(4 downto 0);

begin
--entities
JA <= CLK & debug2 & debug(9 downto 8);
JB <= debug(7 downto 0);

	ConUnit : entity work.ConUnit_toplevel
		port map(
					CLK => CLK,
					RST => RST,
					
					RB_WEA => RB_WEA,
					RB_WEB => RB_WEB,
					
					RAWen => RAWen,
					RBWen => RBWen,
					FPRWen => FPRWen,
					
					IR1 => IR1,
					IR2 => IR2,
					IR3 => IR3,
					IR4 => IR4,
					IR5 => IR5,
					
					EXTRAMADR => EXTMADDR,
					EXTRAMEN => EMEN,
					EXTRAMWEA => EMWEA,
					
					LOCRAMADR => LOCMADDR,
					LOCRAMEN => LMEN,
					LOCRAMWEA => LMWEA,

					debug2 => debug2,

					CCR => CCR
					);

	FPU : entity work.FPUnit_toplevel
		port map(
					CLK => CLK,
					RST => RST,
						
					CCR => CCR,
					ALU_OUT => ALU_OUT,
					LDST => LDSTO,
					
					RB_ENA => '1',
					RB_ENB => '1',
					RB_WEA => RB_WEA,
					RB_WEB => RB_WEB,

					IR1 => IR1,
					IR2 => IR2,
					IR3 => IR3,
					IR4 => IR4,
					IR5 => IR5,
					
					RAWen => RAWen,
					RBWen => RBWen,
					FPRWen => FPRWen,
					
					EXTRAMI => EXTMI,
					EXTRAMO => EXTMO,
					
					LOCMADDR => LOCMADDR,
					LMEN => LMEN,
					LMWEA => LMWEA,
					
					debug => debug
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

