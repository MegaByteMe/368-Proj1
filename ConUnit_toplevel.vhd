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
												
				RB_WEA : OUT STD_LOGIC_VECTOR(0 downto 0);
				RB_WEB : OUT STD_LOGIC_VECTOR(0 downto 0);
				
				RAWen, RBWen, FPRWen : OUT STD_LOGIC;
				
				AMUXSEL : OUT STD_LOGIC;
				BMUXSEL : OUT STD_LOGIC_VECTOR(1 downto 0);
				
				EXTRAMADR : OUT STD_LOGIC_VECTOR(7 downto 0);
				EXTRAMEN : OUT STD_LOGIC;
				EXTRAMWEA : OUT STD_LOGIC_VECTOR(0 downto 0);
				
				LOCRAMADR : OUT STD_LOGIC_VECTOR(7 downto 0);
				LOCRAMEN : OUT STD_LOGIC;
				LOCRAMWEA : OUT STD_LOGIC_VECTOR(0 downto 0);
				
				FOSWSEL : OUT STD_LOGIC;
				
				IR1, IR2, IR3, IR4, IR5 : OUT STD_LOGIC_VECTOR(15 downto 0)
				);
end ConUnit_toplevel;


architecture Structural of ConUnit_toplevel is
	
	--IM signals
	signal imwea : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	signal imdout : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal IRout : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal T1IRout, T2IRout, T3IRout, T4IRout, T5IRout : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal IRwen, T2IRen, T3IRen, T4IRen, T5IRen : STD_LOGIC := '0';

	--PC signals
	signal PCadrs	: STD_LOGIC_VECTOR(7 downto 0) :=(others => '0');
	signal PCclken : STD_LOGIC := '0';
	signal LDEN : STD_LOGIC := '0';
	signal PCLOAD : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	
	signal ramrst : STD_LOGIC := '0';

begin

IR1 <= T1IRout;
IR2 <= T2IRout;
IR3 <= T3IRout;
IR4 <= T4IRout;
IR5 <= T5IRout;

	ConUnit : entity work.ConUnit
		port map(
					CLK => CLK,
					RST => RST,
					pcclken => pcclken,
					imdout => t1irout,
					RB_WEA => RB_WEA,
					RB_WEB => RB_WEB,
					RAWen => RAWen,
					RBWen => RBWen,
					FPRWen => FPRWen,
					AMUXSEL => AMUXSEL,
					BMUXSEL => BMUXSEL,
					IRwen => IRWen,
					T2IRen => T2IRen,
					T3IRen => T3IRen,
					T4IRen => T5IRen,
					ramrst => ramrst
					);							
					
	PC: entity work.pc
		port map(
					clk => clk,
					Trig => pcclken,
					count => PCadrs,
					sclr => rst,
					LDEN => LDEN,
					LOAD => PCLOAD
					);
					
	IM: entity work.instruct_mem
		port map(
					clka => clk,
					addra => PCadrs(4 downto 0),
					douta => imdout,
					ena => not rst
					);
					
	IR: entity work.SoloReg
		port map(
					clk => CLK,
					xin => imdout,
					yout => t1IRout,
					wen => IRWen,
					rst => rst
					);
					
	T2SM: entity work.SoloReg
		port map(
					clk => CLK,
					xin => t1irout,
					yout => t2IRout,
					wen => t2IRen,
					rst => rst
					);
					
	T3SM: entity work.SoloReg
		port map(
					clk => CLK,
					xin => t2irout,
					yout => t3IRout,
					wen => t3IRen,
					rst => rst
					);
					
	T4SM: entity work.SoloReg
		port map(
					clk => CLK,
					xin => t3IRout,
					yout => t4IRout,
					wen => t3IRen,
					rst => rst
					);
					
	T5SM: entity work.SoloReg
		port map(
					clk => CLK,
					xin => T4IRout,
					yout => T5IRout,
					wen => t5IRen,
					rst => rst
					);

end Structural;

