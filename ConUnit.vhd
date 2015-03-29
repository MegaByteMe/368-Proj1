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
		
		pcCLKen : OUT STD_LOGIC;
		imdout : IN STD_LOGIC_VECTOR(15 downto 0);
		
		RB_WEA, RB_WEB : OUT STD_LOGIC_VECTOR(0 downto 0);
		RAWen, RBWen, FPRWen : OUT STD_LOGIC;
		
		IRWen, T2IRen, T3IRen, T4IRen, T5IRen : OUT STD_LOGIC;
		AMUXSEL : OUT STD_LOGIC;
		BMUXSEL : OUT STD_LOGIC_VECTOR(1 downto 0);
		RAMrst : OUT STD_LOGIC;
		
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
		 IDLE,
		 T1,
		 T2,
		 T3,
		 T4,
		 T5
		 );
	 
    signal Cstate, Nstate, Lstate : fsm_state := idle; -- set FSM init state
	 
begin

    ---------------------------------------------------
    -- FINITE STATE MACHINE
    ---------------------------------------------------
	fsm: process( CLK, RST, Nstate )
	begin
		if(RST = '1' ) then
			Cstate <= IDLE;
		elsif(rising_edge(CLK)) then
			if(Nstate = idle) then
				Cstate <= T1;
			else
				Cstate <= Nstate;
			end if;
		end if;
	end process fsm;
	 
  crank: process(Cstate, imdout)	 
    begin	
            case Cstate is
                when IDLE =>								--default state
						pcclken <= '0';
						IRWen <= '1';
						AMUXSEL <= '0';
						BMUXSEL <= "00";
						RB_WEA <= "0";
						RB_WEB <= "0";
						
						EXTRAMADR <= X"00";
						EXTRAMEN <= '0';
						EXTRAMWEA <= "0";
				
						LOCRAMADR <= X"00";
						LOCRAMEN <= '0';
						LOCRAMWEA <= "0";
						
                when T1 =>
					 	pcclken <= '1';
						T2IRen <= '1';
						NSTATE <= T2;

                when T2 =>						
						case imdout(15 downto 12) is
								--add reg a and b
							when "0000" =>
									AMUXSEL <= '0';
									BMUXSEL <= "00";
									RAWen <= '1';
									RBWen <= '1';
									NSTATE <= T3;
								--sub reg a and b
							when "0001" =>
									AMUXSEL <= '0';
									BMUXSEL <= "00";
									RAWen <= '1';
									RBWen <= '1';
									NSTATE <= T3;
								--and reg a and b
							when "0010" =>
									AMUXSEL <= '0';
									BMUXSEL <= "00";
									RAWen <= '1';
									RBWen <= '1';									
									NSTATE <= T3;
								--or reg a and b
							when "0011" =>	
									AMUXSEL <= '0';
									BMUXSEL <= "00";
									RAWen <= '1';
									RBWen <= '1';
									NSTATE <= T3;
								--move reg b to a
							when "0100" =>
									NSTATE <= T3;
								--addi reg a I
							when "0101" =>
									AMUXSEL <= '0';
									BMUXSEL <= "01";
									RAWen <= '1';
									RBWen <= '0';
									NSTATE <= T3;
								--andi reg a I
							when "0110" =>
									AMUXSEL <= '0';
									BMUXSEL <= "01";
									RAWen <= '1';
									RBWen <= '0';
									NSTATE <= T3;
								--shift left reg a I
							when "0111" =>
									RAWen <= '1';
									RBWen <= '0';
									NSTATE <= T3;
								--shift right reg a I
							when "1000" =>
									RAWen <= '1';
									RBWen <= '0';
									NSTATE <= T3;
								--load word reg a I
							when "1001" =>
									RAWen <= '1';
									RBWen <= '0';
									NSTATE <= T3;
								--store word reg a -> mem
							when "1010" =>
									RAWen <= '1';
									RBWen <= '0';
									NSTATE <= T3;
								--LMV load word vector
							when "1011" =>
									NSTATE <= T3;
								--SMV store word vector
							when "1100" =>
									RAWen <= '1';
									RBWen <= '0';
									NSTATE <= T3;
								--Jump 16bit IMMED
							when "1101" =>
									RAWen <= '1';
									RBWen <= '0';
									NSTATE <= T3;
								--RTL return
							when "1110" =>
									RAWen <= '1';
									RBWen <= '0';
									NSTATE <= T3;
								--BRA branch
							when "1111" =>
									RAWen <= '1';
									RBWen <= '0';
									NSTATE <= T3;
							when others => NSTATE <= T2;
						
							T3IRen <= '1';
						end case;		
						
					 when T3 =>
							T4IRen <= '1';
							NSTATE <= T4;
							
					 when T4 =>
							FPRWen <= '1';
							T5IRen <= '1';
							NSTATE <= T5;
							
					 when T5 =>
							NSTATE <= T1;

                when OTHERS =>
                     NSTATE <= IDLE;
             end case;
				 Lstate <= Cstate;
    end process crank;
end Behavioral;

