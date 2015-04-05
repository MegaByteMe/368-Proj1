----------------------------------------------------------------------------------
-- Company: 		ECE368
-- Engineer: 		MR - Group 7
-- 
-- Create Date:    11:28:18 03/11/2015 
-- Design Name: 
-- Module Name:    ConUnit - Behavioral 
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

entity ConUnit is
	port(
		CLK : IN STD_LOGIC;		
		RST : IN STD_LOGIC;
		CCR : IN STD_LOGIC_VECTOR(3 downto 0);
		pcCLKen : OUT STD_LOGIC;
		STKEN : OUT STD_LOGIC;
		STKRD : OUT STD_LOGIC;
		RB_WEA, RB_WEB : OUT STD_LOGIC_VECTOR(0 downto 0);
		RAWen, RBWen, FPRWen : OUT STD_LOGIC;
		flush : OUT STD_LOGIC;
		IRens : OUT STD_LOGIC_VECTOR(4 downto 0);
		IR1, IR2, IR3, IR4, IR5 : IN STD_LOGIC_VECTOR(15 downto 0);
		STKOUT : IN STD_LOGIC_VECTOR(15 downto 0);
		PCLOAD : OUT STD_LOGIC_VECTOR(7 downto 0);
		LDEN : OUT STD_LOGIC;
						
		EXTRAMADR : OUT STD_LOGIC_VECTOR(7 downto 0);
		EXTRAMEN : OUT STD_LOGIC;
		EXTRAMWEA : OUT STD_LOGIC_VECTOR(0 downto 0);
				
		LOCRAMADR : OUT STD_LOGIC_VECTOR(7 downto 0);
		LOCRAMEN : OUT STD_LOGIC;
		LOCRAMWEA : OUT STD_LOGIC_VECTOR(0 downto 0)
		);
end ConUnit;

architecture Behavioral of ConUnit is
--signals
	  -- Finite State Machine Setup
    type fsm_state is
		(
		 BRAN,
		 FRZ,
		 UNFRZ,
		 RESET,
		 IDLE,
		 T1,
		 T2,
		 T3,
		 T4,
		 T5
		 );
	 
    signal Cstate, Nstate, Lstate : fsm_state := idle; -- set FSM init state
	 signal T1IRen, T2IRen, T3IRen, T4IRen, T5IRen : STD_LOGIC := '0';
	 
begin

IRens(4 downto 0) <= T1IRen & T2IRen & T3IRen & T4IRen & T5IRen;

    ---------------------------------------------------
    -- FINITE STATE MACHINE
    ---------------------------------------------------
	fsm: process( CLK, RST, Nstate, Lstate, IR1, IR5, CCR )
	begin
		if(RST = '1' ) then
			Cstate <= RESET;
		elsif(rising_edge(CLK)) then
			if(Nstate = IDLE and LSTATE = IDLE) then
				Cstate <= T1;
			elsif(IR5(15 downto 12) = "1111" and IR5(11 downto 8) = CCR) then
				--BRANCH
				CSTATE <= BRAN;
			elsif(IR1(15 downto 12) = "1101") then
				--Jump 16bit IMMED
				CSTATE <= FRZ;
			elsif(IR1(15 downto 12) = "1110") then
				--RTL return
				CSTATE <= UNFRZ;
			else
				Cstate <= Nstate;
			end if;			
		end if;
	end process fsm;
	 
  crank: process(Cstate)	 
    begin	
            case Cstate is
					 when RESET => 
						pcclken <= '0';
						flush <= '1';
						RB_WEA <= "0";
						RB_WEB <= "0";
						
						EXTRAMADR <= X"00";
						EXTRAMEN <= '0';
						EXTRAMWEA <= "0";
				
						LOCRAMADR <= X"00";
						LOCRAMEN <= '0';
						LOCRAMWEA <= "0";
						
						T1IRen <= '0';
						T2IRen <= '0';
						T3IRen <= '0';
						T4IRen <= '0';
						T5IRen <= '0';
						LSTATE <= RESET;
						NSTATE <= IDLE;
						
                when IDLE =>								--default state
						pcclken <= '0';
						flush <= '0';
						LSTATE <= IDLE;
						NSTATE <= IDLE;
						STKRD <= '0';
						LDEN <= '0';
						STKEN <= '0';
					
					 when BRAN =>
						flush <= '1';
						LDEN <= '1';
						PCLOAD <= IR5(7 downto 0);
					
					 when FRZ =>
						LSTATE <= FRZ;
						PCLOAD <= IR1(7 downto 0);
						STKen <= '1';
						LDEN <= '1';
						NSTATE <= idle;
						
					 when UNFRZ =>
						LSTATE <= UNFRZ;
						NSTATE <= idle;
						STKRD <= '1';
						LDEN <= '1';
						PCLOAD <= STKOUT(7 downto 0);
						
                when T1 =>						 
						T1IRen <= '1';
						pcclken <= '1';
						NSTATE <= T2;

                when T2 =>	
						T2IRen <= '1';
						RAWen <= '1';
						RBWen <= '1';
						NSTATE <= T3;
						
					 when T3 =>
						T3IRen <= '1';
						NSTATE <= T4;
							
					 when T4 =>
						T4IRen <= '1';
						FPRWen <= '1';
						NSTATE <= T5;
						
					 when T5 =>
						T5IRen <= '1';
						RB_WEA <= "1";
						NSTATE <= T1;

                when OTHERS =>
                  NSTATE <= IDLE;
             end case;
				 Lstate <= Cstate;
    end process crank;
end Behavioral;

