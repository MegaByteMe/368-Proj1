--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:40:53 03/24/2015
-- Design Name:   
-- Module Name:   E:/Proj1 - InState/MAST_TB.vhd
-- Project Name:  Proj1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MAST
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY MAST_TB IS
END MAST_TB;
 
ARCHITECTURE behavioral OF MAST_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MAST
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
		--	SW : in STD_LOGIC;
         ALU_OUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 
	 	--INSTRUCTION STATE REGISTERS
	signal IR1, IR2, IR3, IR4, IR5 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');	
	
	--REGISTER ENABLES
	signal RAWen, RBWen, FPRWen : STD_LOGIC;	
	signal RB_WEA : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	signal RB_WEB : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	
	--MUX ENABLES
	signal AMUXSEL, BMUXSEL : STD_LOGIC := '0';
	signal SW1SEL : STD_LOGIC := '0';
	signal FOSWSEL : STD_LOGIC := '0';


	signal CLK : STD_LOGIC := '0'; 
	signal RST : STD_LOGIC := '1';
   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MAST PORT MAP (
          CLK => CLK,
          RST => RST
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	rst <= '1';
      -- hold reset state for 100 ns.
      wait for 40 ns;	
		rst <= '0';
      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
