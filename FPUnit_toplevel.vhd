----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:33:25 03/11/2015 
-- Design Name: 
-- Module Name:    FPUnit_toplevel - Structural 
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

entity FPUnit_toplevel is
	port(
			CLK : IN STD_LOGIC;
			RST : IN STD_LOGIC;			
			CCR : OUT STD_LOGIC_VECTOR(3 downto 0);
			ALU_OUT : OUT STD_LOGIC_VECTOR(15 downto 0);
			LDST : OUT STD_LOGIC_VECTOR(15 downto 0);
			IM_FEED : IN STD_LOGIC_VECTOR(15 downto 0);
			
			RB_ENA, RB_ENB : IN STD_LOGIC;
			RB_WEA, RB_WEB : IN STD_LOGIC_VECTOR(0 downto 0);
			RB_ADDRA, RB_ADDRB : IN STD_LOGIC_VECTOR(3 downto 0);
			
			AMUXSEL : IN STD_LOGIC;
			BMUXSEL : IN STD_LOGIC_VECTOR(1 downto 0);
			
			RAWen, RBWen, FPRWen : IN STD_LOGIC;
			
			EXTRAMI : OUT STD_LOGIC_VECTOR(15 downto 0);
			EXTRAMO : IN STD_LOGIC_VECTOR(15 downto 0);
			
			LOCMADDR : IN STD_LOGIC_VECTOR(7 downto 0);
			LMEN : IN STD_LOGIC;
			LMWEA : IN STD_LOGIC_VECTOR(0 downto 0);
						
			FOSWSEL : IN STD_LOGIC
		);
end FPUnit_toplevel;

architecture Structural of FPUnit_toplevel is

   --signals
	signal OPA : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal OPB : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
	signal INA_REG, INB_REG : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal OUTA_REG, OUTB_REG : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal AStorreg, BStorreg : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
		
	signal RBA_IN_MUX, RBB_IN_MUX : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
	signal IMMED : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal ALU_FRESH, ALUtoSW, ALU_DIVERT : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
	signal locmemIN : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal locmemOUT : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
begin
ALU_OUT <= ALUtoSW;
EXTRAMI <= ALUtoSW;
IMMED <= X"00" & IM_FEED(7 downto 0);

	INA_Mux: entity work.MUXX2
		port map(
					SEL => AMUXSEL,
					XIN => OUTA_REG,
					YIN => EXTRAMO,
					ZOUT => AStorreg
					);
					
	INB_Mux: entity work.MUXX3
		port map(
					SEL => BMUXSEL,
					WIN => OUTB_REG,
					XIN => IMMED,
					YIN => EXTRAMO,
					ZOUT => BStorreg
					);

	RAReg: entity work.SoloReg
		port map(
					clk => CLK,
					xin => AStorreg,
					yout => OPA,
					wen => RAWen,
					rst => rst
					);
					
	RBReg: entity work.SoloReg
		port map(
					clk => CLK,
					xin => BStorreg,
					yout => OPB,
					wen => RBWen,
					rst => rst
					);

	FPU: entity work.alu
		port map(
					CLK => CLK,					
					RA => OPA,
					RB => OPB,
					OPCODE => IM_FEED(15 downto 12),
					CCR => CCR,
					ALU_OUT => ALU_FRESH,
					LDST_OUT => LDST
					);
					
	FPUReg: entity work.SoloReg
		port map(
					CLK => CLK,
					RST => RST,
					XIN => ALU_FRESH,
					YOUT => ALUtoSW,
					WEN => FPRWEN
					);
					
	GP_REG: entity work.GP_Reg_Bank
		port map(
					--reg bank A side
					CLKA => CLK,
					DINA => INA_REG,
					DOUTA => OUTA_REG,
					ADDRA => RB_ADDRA,
					ENA => RB_ENA,
					WEA => RB_WEA,
					
					--reg bank B side
					CLKB => CLK,
					DINB => INB_REG,
					DOUTB => OUTB_REG,
					ADDRB => RB_ADDRB,
					ENB => RB_ENB,
					WEB => RB_WEB
					);
					
	INA_REG_Mux: entity work.MUXX2
		port map(
					SEL => FOSWSEL,
					XIN => ALUtoSW,
					YIN => RBA_IN_MUX,
					ZOUT => INA_REG
					);
					
	LOC_RAM : entity work.general_ram
		port map(
					CLKA => CLK,
					DINA => locmemIN,
					DOUTA => locmemOUT,
					ADDRA => locmADDR,
					ENA => LMEN,
					WEA => LMWEA
					);
					
end Structural;

