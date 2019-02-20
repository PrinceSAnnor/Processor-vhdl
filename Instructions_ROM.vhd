----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:55:21 04/26/2018 
-- Design Name: 
-- Module Name:    Instructions_ROM - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use work.common.all;

entity Instructions_ROM is
	port (	rst : in STD_LOGIC;

		address_in : in STD_LOGIC_VECTOR ((address_width - 1) downto 0);
		data_out : out STD_LOGIC_VECTOR ((instruction_width - 1) downto 0)
	     );
end Instructions_ROM;

architecture Behavioral of Instructions_ROM is

type ROM_type is array (0 to (rom_size - 1)) of STD_LOGIC_VECTOR ((instruction_width - 1) downto 0);
signal rom : ROM_type;

begin
	data_out <= rom ( to_integer(unsigned(address_in)) );

	rom_process : process (rst)
	begin
		-- asynchronous reset
		if (rst = '1') then

			-- first, reset ROM content completely with HAL operations
			-- note that loop will be unrolled during synthesis
			for i in 0 to (rom_size - 1) loop 
				rom(i) <=
					-- HAL opcode
					b"1010"
					-- remaining bits after opcode; filled with rst (1) just to avoid optimizing out of rst signal
					& ((instruction_width - opcode_width - 1) downto 0 => rst); 
			end loop;

			-- for Task 1
--			rom(0) <= b"0001_001_000_000_111";
--		   rom(1) <= b"0001_010_000_001_000"; 
--			rom(2) <= b"0000_011_001_010_000"; 

			-- for Task 2
--			rom(0) <= b"0001_001_000_000_111";
--		   rom(1) <= b"0001_010_000_001_000"; 
--			rom(2) <= b"0000_011_001_010_000"; 

			-- for Task 3
--			rom(0) <= b"0001_001_000_000_101";
--			rom(1) <= b"0001_010_000_000_000";
--			rom(2) <= b"0001_010_010_000_010";
--			rom(3) <= b"0011_001_001_000_001";
--			rom(4) <= b"1111_111_001_000_110";

	-- for Task 4
			rom(0) <= b"0001_001_000_000_001";
			rom(1) <= b"0001_010_000_000_010";
			rom(2) <= b"0000_011_001_010_000";
			rom(3) <= b"0000_001_010_011_000";
			rom(4) <= b"0000_010_001_011_000";
			rom(5) <= b"1110_111_000_000_101";			
			

			-- Please keep this code! It helps to infer all 7 registers (R1--R7) in the register file, without short-cuts into
			-- combinatorial logic due to optimization
			--
			rom(249) <= b"0000_001_001_000_000";
			rom(250) <= b"0000_010_010_001_000";
			rom(251) <= b"0000_011_011_010_000";
			rom(252) <= b"0000_100_100_011_000";
			rom(253) <= b"0000_101_101_100_000";
			rom(254) <= b"0000_110_110_101_000";
			rom(255) <= b"0000_111_111_110_000";

		end if;

	end process;

end Behavioral;

