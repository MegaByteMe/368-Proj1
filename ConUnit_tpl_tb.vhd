----------------------------------------------------------------------------------
-- Company: Group 7
-- Engineer: MR
-- 
-- Create Date:    16:43:04 02/19/2015 
-- Design Name: 
-- Module Name:    buffit_tb - Behavioral 
-- Project Name: Finite State Machine Test Bench
-- Target Devices: Spartan 3
-- Tool versions: Xilinx 14.7
-- Description: Practice to evaluate operation of Finite State Machine Principles and test bench
--
-- Dependencies: 
--
-- Revision 0.01 - File Created
-- Additional Comments: This is all test code!
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
USE ieee.STD_LOGIC_unsigned.all;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE unisim.Vcomponents.ALL;
USE work.all;

entity ConUnit_toplevel_tb is
end ConUnit_toplevel_tb;

architecture Behavioral of ConUnit_toplevel_tb is

    COMPONENT ConUnit_toplevel
    Port ( 
				CLK : IN STD_LOGIC;
				RST : IN STD_LOGIC;
				
				LED : OUT STD_LOGIC_VECTOR(7 downto 0);
				
				im_dataout : OUT STD_LOGIC_VECTOR(15 downto 0);
				
				RB_WEA : OUT STD_LOGIC_VECTOR(0 downto 0);
				RB_WEB : OUT STD_LOGIC_VECTOR(0 downto 0);
				RB_ADDRA : OUT STD_LOGIC_VECTOR(3 downto 0);
				RB_ADDRB : OUT STD_LOGIC_VECTOR(3 downto 0);
				
				RAWen, RBWen, FPRWen : OUT STD_LOGIC;
				
				AMUXSEL : OUT STD_LOGIC;
				BMUXSEL : OUT STD_LOGIC_VECTOR(1 downto 0);
				
				EXTRAMADR : OUT STD_LOGIC_VECTOR(7 downto 0);
				EXTRAMEN : OUT STD_LOGIC;
				EXTRAMWEA : OUT STD_LOGIC_VECTOR(0 downto 0);
				
				FOSWSEL : OUT STD_LOGIC
			  );
    END COMPONENT;
	 
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
	
	signal GRAMI : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal GRAMO : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal GADD : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal GEN : STD_LOGIC := '0';
	signal GWEA : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	
	signal FOSWSEL : STD_LOGIC;
	
	signal CLK : STD_LOGIC;
	signal RST : STD_LOGIC := '1';
	signal PCCLKEN : STD_LOGIC := '0';
	
	signal RAWen, RBWen, FPRWen : STD_LOGIC := '0';

constant period : time := 1 us;

begin

    uut: ConUnit_toplevel
			PORT MAP( 
					CLK => CLK,
					RST => RST,
					im_dataout => IM_FEED,
					AMUXSEL => AMUXSEL,
					BMUXSEL => BMUXSEL,
										
					RB_WEA => RB_WEA,
					RB_WEB => RB_WEB,
					RB_ADDRA => RB_ADDRA,
					RB_ADDRB => RB_ADDRB,
					
					RAWen => RAWen,
					RBWen => RBWen,
					FPRWen => FPRWen,
					
					EXTRAMADR => GADD,
					EXTRAMEN => GEN,
					EXTRAMWEA => GWEA,
					
					FOSWSEL => FOSWSEL
						);

    gen_Clock : process
    begin
        CLK <= '0'; wait for period;
        CLK <= '1'; wait for period;
    end process;

	 test : PROCESS	 
    BEGIN    
	 -- Gloabl wait
	 	wait for 50 us;
		RST <= '0';
		PCCLKEN <= '1';

        report "Start Test Bench" severity NOTE;
		  
	wait; -- wait forever
	end process;
end;

