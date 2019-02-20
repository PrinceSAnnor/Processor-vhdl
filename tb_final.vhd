--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:28:08 05/05/2018
-- Design Name:   
-- Module Name:   D:/Downloads/FinalProject/tb_final.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: micropro
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_final IS
END tb_final;
 
ARCHITECTURE behavior OF tb_final IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT micropro
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         opcode_out : OUT  std_logic_vector(3 downto 0);
         sRegister1_data_out : OUT  std_logic_vector(7 downto 0);
         sRegister2_data_out : OUT  std_logic_vector(7 downto 0);
         dRegister_data_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal opcode_out : std_logic_vector(3 downto 0);
   signal sRegister1_data_out : std_logic_vector(7 downto 0);
   signal sRegister2_data_out : std_logic_vector(7 downto 0);
   signal dRegister_data_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 15	ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: micropro PORT MAP (
          clk => clk,
          rst => rst,
          opcode_out => opcode_out,
          sRegister1_data_out => sRegister1_data_out,
          sRegister2_data_out => sRegister2_data_out,
          dRegister_data_out => dRegister_data_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
      -- insert stimulus here 
		rst <= '1';
		wait for 100ns;
		rst <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
