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
		RST : IN STD_LOGIC;
		);
end ConUnit;

architecture Behavioral of ConUnit is
--signals
begin
	  -- Finite State Machine Setup
    type fsm_state is
		(
       idle,
		 fetch,
		 decode,
		 opa,
		 execute,
		 writeb,
		 strobe
		 );
	 
    signal state: fsm_state := idle; -- set FSM init state
	 signal flag : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	 signal tri : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	 
	 SIGNAL FET : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	 SIGNAL DEC : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	 SIGNAL OP : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	 SIGNAL EX : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	 SIGNAL WB : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	 
--	 signal OP : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
--	 signal op1 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
--	 signal op2 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
--	 signal nonsense : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
	 
begin

	PC: process( rst, CLK )
		begin
		


    ---------------------------------------------------
    -- FINITE STATE MACHINE
    ---------------------------------------------------
  fsm: process( rst, state, clk )
	 
    begin
        if(rst = '1') then -- Reset state, goto idle mode
            state <= idle;
				
        else -- Process through States
            --State Case - process through each state
            case state is
                when idle =>								--default state
						STATE <= FETCH;

                when fetch =>								--store everytime and key is pressed

                when decode =>							--translate our data into something useful and prep for offloading
								
								if(flag = "00") then			--keep track of where we are in this process
								
										if(tri = "00") then
										REN <= '1';
											nonsense(23 downto 16) <= FIFOLOAD;
											go(7) <= '1';
											tri <= "01";
											state <= strobe;
										elsif(tri = "01") then
										ren <= '1';
											nonsense(15 downto 8) <= FIFOLOAD;
											go(6) <= '1';
											tri <= "10";
											state <= strobe;
										elsif(tri = "10") then
										ren <= '1';
											nonsense(7 downto 0) <= FIFOLOAD;
											go(5) <= '1';
											state <= idle;
										end if;
									
									case nonsense is					--detect opcodes
										when x"535542" => --SUB
											OP <= "0001";
											flag <= "01";
											state <= idle;
										when x"737562" => --sub
										go(3) <= '1';
											OP <= "0001";
											flag <= "01";
											state <= idle;
										when x"616464" => --add
											OP <= "0000";
											flag <= "01";
										go(3) <= '1';
											state <= idle;
										when x"414444" => --ADD
											OP <= "0000";
											flag <= "01";
											state <= idle;
										when x"414E44" => --AND
											OP <= "0010";
											flag <= "01";
											state <= idle;
										when x"616E64" => --and
											OP <= "0010";
											flag <= "01";
											state <= idle;
										when x"4F5200" => --OR
											OP <= "0011";
											flag <= "01";
											state <= idle;
										when x"6F7200" => --or
											OP <= "0011";
											flag <= "01";
											state <= idle;											
										when others =>
											OP <= x"0";
											state <= idle;
									end case;
																		
								elsif(flag = "01") then
									op1 <= FIFOLOAD - x"30";
									flag <= "10";
									state <= idle;
									
								elsif(flag = "10") then
									op2 <= FIFOLOAD - x"30";
									state <= idle;
								end if;
						
					 when opa =>						--return detected load operands and opcode

												 
					 when writeb =>					--return detected load operands and opcode
							if(clk'event and clk = '0') then		--wait for falling clock edge for writeback
								
							end if;

					 when strobe =>					--FIFO read enable strobe
							REN <= '0';
							REN <= '1';
							state <= translate;

                when others =>
                     state <= idle;
       
             end case;
        end if;
    end process fsm;

end Behavioral;

