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
			
			RB_ENA, RB_ENB : IN STD_LOGIC;
			RB_WEA, RB_WEB : IN STD_LOGIC_VECTOR(0 downto 0);
			
			RAWen, RBWen, FPRWen : IN STD_LOGIC;
			IR1, IR2, IR3, IR4, IR5 : IN STD_LOGIC_VECTOR(15 downto 0);			
			
			EXTRAMI : OUT STD_LOGIC_VECTOR(15 downto 0);
			EXTRAMO : IN STD_LOGIC_VECTOR(15 downto 0);
			
			LOCMADDR : IN STD_LOGIC_VECTOR(7 downto 0);
			LMEN : IN STD_LOGIC;
			LMWEA : IN STD_LOGIC_VECTOR(0 downto 0);
			
			debug : OUT STD_LOGIC_VECTOR(9 downto 0)
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
		
	signal RB_ADDRA : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal INRBAen : STD_LOGIC_VECTOR(0 downto 0) := "0";
	
begin
ALU_OUT <= ALUtoSW;
EXTRAMI <= ALUtoSW;
IMMED <= X"00" & IR3(7 downto 0);
debug <= IR1(15 downto 14) & IR2(15 downto 14) & IR3(15 downto 14) & IR4(15 downto 14) & IR5(15 downto 14);				
					
	--REG A INPUT MUX
	INA_Mux: entity work.MUXX2
		port map(
					SEL => "0000",
					XIN => OUTA_REG,
					YIN => EXTRAMO,
					ZOUT => AStorreg
					);
	--REG B INPUT MUX				
	INB_Mux: entity work.MUXX2
		port map(
					SEL => IR3(15 downto 12),
					XIN => OUTB_REG,
					YIN => IMMED,
					ZOUT => BStorreg
					);
	--OPERAND A REGISTER
	RAReg: entity work.SoloReg
		port map(
					clk => CLK,
					xin => AStorreg,
					yout => OPA,
					wen => RAWen,
					rst => rst
					);
	--OPERAND B REGISTER				
	RBReg: entity work.SoloReg
		port map(
					clk => CLK,
					xin => BStorreg,
					yout => OPB,
					wen => RBWen,
					rst => rst
					);
	--FPU/ALU
	FPU: entity work.alu
		port map(
					CLK => CLK,					
					RA => OPA,
					RB => OPB,
					OPCODE => IR4(15 downto 12),
					CCR => CCR,
					ALU_OUT => ALU_FRESH,
					LDST_OUT => LDST
					);
	--FPU RESULT REGISTER				
	FPUReg: entity work.SoloReg
		port map(
					CLK => CLK,
					RST => RST,
					XIN => ALU_FRESH,
					YOUT => ALUtoSW,
					WEN => FPRWEN
					);
	--GENERAL PURPOSE REGISTER BANK				
	GP_REG: entity work.GP_Reg_Bank
		port map(
					--reg bank A side
					CLKA => CLK,
					DINA => INA_REG,
					DOUTA => OUTA_REG,
					ADDRA => RB_ADDRA,
					ENA => RB_ENA,
					WEA => INRBAen,
					
					--reg bank B side
					CLKB => CLK,
					DINB => INB_REG,
					DOUTB => OUTB_REG,
					ADDRB => IR2(7 downto 4),
					ENB => RB_ENB,
					WEB => RB_WEB
					);
	--REGISTER BANK A INPUT MUX				
	IN_RBA_Mux: entity work.MMUXX2
		port map(
					SEL => CLK,
					ADDR1 => IR2(11 downto 8),
					ADDR2 => IR5(11 downto 8),
					YIN => ALUtoSW,
					XIN => RBA_IN_MUX,		-- THIS IS JUNK
					ZOUT => INA_REG,
					AOUT => RB_ADDRA,
					IEN => RB_WEA,
					EOUT => INRBAen
					);
	--LOCAL MEMORY				
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

