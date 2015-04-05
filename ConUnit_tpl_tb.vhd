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
				CCR : IN STD_LOGIC_VECTOR(3 downto 0);								
				RB_WEA : OUT STD_LOGIC_VECTOR(0 downto 0);
				RB_WEB : OUT STD_LOGIC_VECTOR(0 downto 0);
				
				RAWen, RBWen, FPRWen : OUT STD_LOGIC;
				AMUXSEL, BMUXSEL : OUT STD_LOGIC;
				
				EXTRAMADR : OUT STD_LOGIC_VECTOR(7 downto 0);
				EXTRAMEN : OUT STD_LOGIC;
				EXTRAMWEA : OUT STD_LOGIC_VECTOR(0 downto 0);
				
				LOCRAMADR : OUT STD_LOGIC_VECTOR(7 downto 0);
				LOCRAMEN : OUT STD_LOGIC;
				LOCRAMWEA : OUT STD_LOGIC_VECTOR(0 downto 0);
				
				FOSWSEL : OUT STD_LOGIC;
				
				IR1, IR2, IR3, IR4, IR5 : OUT STD_LOGIC_VECTOR(15 downto 0)
			  );
    END COMPONENT;
	 
	--FPU
	signal CCR : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal LDSTO : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
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
	
	--EXTERNAL MEMORY SIGNALS
	signal EXTMI, EXTMO : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal EXTMADDR : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal EMEN : STD_LOGIC := '0';
	signal EMWEA : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	
	--LOCAL MEMORY SIGNALS
	signal LOCMI, LOCMO : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');	
	signal LOCMADDR : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal LMEN : STD_LOGIC := '0';
	signal LMWEA : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	
		--IM signals
	signal imwea : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
	signal imdout : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal IRout : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal T1IRout, T2IRout, T3IRout, T4IRout, T5IRout : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal T1IRen, T2IRen, T3IRen, T4IRen, T5IRen : STD_LOGIC := '0';

	--PC signals
	signal PCadrs	: STD_LOGIC_VECTOR(7 downto 0) :=(others => '0');
	signal LDEN : STD_LOGIC := '0';
	signal PCLOAD : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	
	signal ramrst : STD_LOGIC := '0';
	
	signal CLK : STD_LOGIC := '0';
	signal RST : STD_LOGIC := '1';

constant period : time := 20 ns;

begin

    uut: ConUnit_toplevel
			PORT MAP( 
					CLK => CLK,
					RST => RST,
					AMUXSEL => AMUXSEL,
					BMUXSEL => BMUXSEL,
					CCR => CCR,
					RB_WEA => RB_WEA,
					RB_WEB => RB_WEB,
					
					RAWen => RAWen,
					RBWen => RBWen,
					FPRWen => FPRWen,
					
					EXTRAMADR => EXTMADDR,
					EXTRAMEN => EMEN,
					EXTRAMWEA => EMWEA,
					
					LOCRAMADR => LOCMADDR,
					LOCRAMEN => LMEN,
					LOCRAMWEA => LMWEA,
					
					IR1 => IR1,
					IR2 => IR2,
					IR3 => IR3,
					IR4 => IR4,
					IR5 => IR5,
					
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
	 	wait for 100 ns;
		RST <= '0';

        report "Start Test Bench" severity NOTE;
		  
	wait; -- wait forever
	end process;
end;

