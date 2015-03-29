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
 
ARCHITECTURE behavior OF MAST_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MAST
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         LED : OUT  std_logic_vector(7 downto 0);
         ALU_OUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal LED : std_logic_vector(7 downto 0);
   signal ALU_OUT : std_logic_vector(15 downto 0);
	
		--FPU
	signal CCR : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal LDSTO : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
	signal IM_FEED : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
	signal RB_WEA : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	signal RB_WEB : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	signal RB_ADDRA : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal RB_ADDRB : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	
	signal AMUXSEL : STD_LOGIC := '0';
	signal BMUXSEL : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal SW1SEL : STD_LOGIC := '0';
	
	signal RAWen, RBWen, FPRWen : STD_LOGIC;
	
	signal GRAMI : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal GRAMO : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal GADD : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal GEN : STD_LOGIC := '0';
	signal GWEA : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	
	signal FOSWSEL : STD_LOGIC;

   -- Clock period definitions
   constant CLK_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MAST PORT MAP (
          CLK => CLK,
          RST => RST,
          LED => LED,
          ALU_OUT => ALU_OUT
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
      wait for 100 ns;	
		rst <= '0';
      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
