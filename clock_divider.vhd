----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:11:49 04/25/2018 
-- Design Name: 
-- Module Name:    clock_divider - Behavioral 
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
use IEEE.STD_LOGIC_unsigned.all; 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_divider is
	port(
	 masclk : in STD_LOGIC;
	 clear : in STD_LOGIC;
	 fastclk : out STD_LOGIC
	 );
end clock_divider;

architecture Behavioral of clock_divider is
signal divider:STD_LOGIC_VECTOR(24 downto 0);
begin
 -- clock divider
 process(masclk, clear)
 begin
 if clear = '1' then
 divider <= X"000000" & '0';
 elsif masclk'event and masclk='1' then
 divider <= divider + 1;
end if;

end process;
 fastclk <= divider(18); -- 190 H LCD
end Behavioral;

