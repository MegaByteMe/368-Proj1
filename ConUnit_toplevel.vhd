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
				CCR : IN STD_LOGIC_VECTOR(3 downto 0);								
				RB_WEA : OUT STD_LOGIC_VECTOR(0 downto 0);
				RB_WEB : OUT STD_LOGIC_VECTOR(0 downto 0);
				
				RAWen, RBWen, FPRWen : OUT STD_LOGIC;
				IR1, IR2, IR3, IR4, IR5 : OUT STD_LOGIC_VECTOR(15 downto 0);
				
				EXTRAMADR : OUT STD_LOGIC_VECTOR(7 downto 0);
				EXTRAMEN : OUT STD_LOGIC;
				EXTRAMWEA : OUT STD_LOGIC_VECTOR(0 downto 0);
				
				LOCRAMADR : OUT STD_LOGIC_VECTOR(7 downto 0);
				LOCRAMEN : OUT STD_LOGIC;
				LOCRAMWEA : OUT STD_LOGIC_VECTOR(0 downto 0);
								
				debug2 : OUT STD_LOGIC_VECTOR(4 downto 0)
				);
end ConUnit_toplevel;


architecture Structural of ConUnit_toplevel is
	
	--IM signals
	signal imwea : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	signal imdout : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal IRout : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal IMIN : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

	--PC signals
	signal PCadrs	: STD_LOGIC_VECTOR(7 downto 0) :=(others => '0');
	signal PCclken : STD_LOGIC := '0';
	signal LDEN : STD_LOGIC := '0';
	signal PCLOAD : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
	--STACK signals
	signal STKEN : STD_LOGIC := '0';
	signal STKRD : STD_LOGIC := '0';
	signal STKOUT : STD_LOGIC_VECTOR(15 downto 0) :=  (others => '0');
		
	--STATE REGISTER SIGNALS
	signal IR1S, IR2S, IR3S, IR4S, IR5S : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal flush : STD_LOGIC := '0';
	signal IRens : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
	signal FRSTcombo : STD_LOGIC := '0';


begin

FRSTcombo <= RST or flush;
debug2 <= PCadrs(4 downto 0);

IR1 <= IR1S;
IR2 <= IR2S;
IR3 <= IR3S;
IR4 <= IR4S;
IR5 <= IR5S;

	ConUnit : entity work.ConUnit
		port map(
					CLK => CLK,
					RST => RST,
					CCR => CCR,
					STKEN => STKEN,
					STKRD => STKRD,
					pcclken => pcclken,
					RB_WEA => RB_WEA,
					RB_WEB => RB_WEB,
					RAWen => RAWen,
					RBWen => RBWen,
					FPRWen => FPRWen,
					IRens => IRens,
					IR1 => IR1S,
					IR2 => IR2S,
					IR3 => IR3S,
					IR4 => IR4S,
					IR5 => IR5s,
					STKOUT => STKOUT,
					LDEN => LDEN,
					PCLOAD => PCLOAD(7 downto 0),
					flush => flush					
					);							
					
	PC: entity work.pc
		port map(
					clk => clk,
					Trig => pcclken,
					count => PCadrs,
					sclr => rst,
					LDEN => LDEN,
					LOAD => PCLOAD(7 downto 0)
					);
					
	IM: entity work.instruct_mem
		port map(
					clka => clk,
					addra => PCadrs(4 downto 0),
					DINA => IMIN,
					douta => imdout,
					wea => imwea
					);
					
	STACK: entity work.STACK
		port map(
					CLK => CLK,
					DIN => imdout,
					DOUT => STKOUT,
					WR_EN => STKEN,
					RD_EN => STKRD
					);
					
	--STATE REGISTERS BEGIN
	T1SR: entity work.SoloReg
		port map(
					clk => CLK,
					xin => imdout,
					yout => IR1S,
					wen => IRens(4),
					rst => rst
					);
					
	T2SR: entity work.SoloReg
		port map(
					clk => CLK,
					xin => IR1S,
					yout => IR2S,
					wen => IRens(3),
					rst => FRSTcombo
					);
					
	T3SR: entity work.SoloReg
		port map(
					clk => CLK,
					xin => IR2S,
					yout => IR3S,
					wen => IRens(2),
					rst => FRSTcombo
					);
					
	T4SR: entity work.SoloReg
		port map(
					clk => CLK,
					xin => IR3S,
					yout => IR4S,
					wen => IRens(1),
					rst => FRSTcombo
					);
					
	T5SR: entity work.SoloReg
		port map(
					clk => CLK,
					xin => IR4S,
					yout => IR5S,
					wen => IRens(0),
					rst => rst
					);
	--STATE REGISTERS END

end Structural;

