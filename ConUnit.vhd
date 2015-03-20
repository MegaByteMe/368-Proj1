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
		
		RB_WEA : OUT STD_LOGIC_VECTOR(0 downto 0);
		RB_WEB : OUT STD_LOGIC_VECTOR(0 downto 0);
		RB_ADDRA : OUT STD_LOGIC_VECTOR(3 downto 0);
		RB_ADDRB : OUT STD_LOGIC_VECTOR(3 downto 0);
		
		AMUXSEL : OUT STD_LOGIC;
		BMUXSEL : OUT STD_LOGIC_VECTOR(1 downto 0)
		);
end ConUnit;

architecture Behavioral of ConUnit is
--signals
	  -- Finite State Machine Setup
    type fsm_state is
		(
       idle,
		 fetch,
		 decode,
		 opa,
		 execute,
		 writeb
		 );
	 
    signal state : fsm_state := idle; -- set FSM init state
	 signal bclk : STD_LOGIC := '1';
	 signal flag : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	 
begin

	bizarro: process( CLK )
		begin
		case CLK is
			when '0' => bclk <= '0';
			when '1' => bclk <= '1';
			when others => bclk <= '1';
		end case;
	end process;

    ---------------------------------------------------
    -- FINITE STATE MACHINE
    ---------------------------------------------------
  fsm: process( state, clk, imdout, bclk )
	 
    begin
 -- Process through States
            --State Case - process through each state
            case state is
                when IDLE =>								--default state
						STATE <= FETCH;

                when fetch =>
						pcCLKen <= '1';
						STATE <= DECODE;

                when DECODE =>
						pcCLKen <= '0';
						
						case imdout(15 downto 12) is
								--add reg a and b
							when "0000" =>
								RB_ADDRA <= imdout(11 downto 8);
								RB_ADDRB <= imdout(7 downto 4);
								--sub reg a and b
							when "0001" =>
								RB_ADDRA <= imdout(11 downto 8);
								RB_ADDRB <= imdout(7 downto 4);
								--and reg a and b
							when "0010" =>
								RB_ADDRA <= imdout(11 downto 8);
								RB_ADDRB <= imdout(7 downto 4);
								--or reg a and b
							when "0011" =>								
								RB_ADDRA <= imdout(11 downto 8);
								RB_ADDRB <= imdout(7 downto 4);
								--move reg b to a
							when "0100" =>
								RB_ADDRA <= imdout(11 downto 8);
								RB_ADDRB <= imdout(7 downto 4);							
								--addi reg a I
							when "0101" =>
								RB_ADDRA <= imdout(11 downto 8);
								--andi reg a I
							when "0110" =>
								RB_ADDRA <= imdout(11 downto 8);
								--shift left reg a I
							when "0111" =>
								RB_ADDRA <= imdout(11 downto 8);
								--shift right reg a I
							when "1000" =>
								RB_ADDRA <= imdout(11 downto 8);
								--load word reg a I
							when "1001" =>
								RB_ADDRA <= imdout(11 downto 8);
								--store word reg a -> mem
							when "1010" =>
								RB_ADDRA <= imdout(11 downto 8);
							when others => STATE <= DECODE;
						end case;		
								
						STATE <= OPA;
						
					 when OPA =>
							STATE <= WRITEB;
							
					 when WRITEB =>
							STATE <= IDLE;

                when OTHERS =>
                     STATE <= IDLE;
       
             end case;
    end process fsm;

end Behavioral;

