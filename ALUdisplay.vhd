----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:53:10 04/04/2018 
-- Design Name: 
-- Module Name:    ALUdisplay - Behavioral 
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
use ieee.numeric_std.all;
use work.common.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
           
entity ALUdisplay is
		Port(clk : in std_logic;
			  opCCode : in STD_LOGIC_VECTOR ((opcode_width-1) downto 0);
			  value2 : in STD_LOGIC_VECTOR ((data_width - 1) downto 0);
           value1 : in STD_LOGIC_VECTOR ((data_width - 1) downto 0);
			  answer : in STD_LOGIC_VECTOR ((data_width - 1) downto 0);
           dig0 : out  STD_LOGIC;
           dig1 : out  STD_LOGIC;
			  dig : out std_logic_vector (7 downto 0);
           dig2 : out  STD_LOGIC;
           dig3 : out  STD_LOGIC);
end ALUdisplay;

architecture Behavioral of ALUdisplay is

constant cnt_max : integer := 1e5;
signal clk_cnt : integer range 0 to cnt_max;
signal seg_mode, seg_mode_new: integer range 0 to 3;
signal dig_result,dig_b,dig_a,dig_c  :  std_logic_vector (7 downto 0);
begin

clock_divider : process (clk)

begin
if rising_edge(clk) then
	if (clk_cnt = cnt_max) then
		seg_mode <= seg_mode_new;
		clk_cnt <= 0;
	else
		clk_cnt <= clk_cnt + 1;
		
	end if;
end if;
end process clock_divider;


display_all : process(value2,opCCode,value1,answer,clk,seg_mode)
begin

if (answer(4 downto 0)="11111") then
	dig_result<="10011110";
elsif (answer(4 downto 0)="11110") then
	dig_result<="00100100";
elsif (answer(4 downto 0)="11101") then
	dig_result<="00001100";
elsif (answer(4 downto 0)="11100") then
	dig_result<="10011000";
elsif (answer(4 downto 0)="11011") then
	dig_result<="01001000";
elsif (answer(4 downto 0)="11010") then
	dig_result<="01000000";
elsif (answer(4 downto 0)="11001") then
	dig_result<="00011010";
elsif (answer(4 downto 0)="11000") then
	dig_result<="00000000";
elsif (answer(4 downto 0)="10111") then
	dig_result<="00001000";
elsif (answer(4 downto 0)="10110") then
	dig_result<="00010000";
elsif (answer(4 downto 0)="10101") then
	dig_result<="11000000";
elsif (answer(4 downto 0)="10100") then
	dig_result<="01100010";
elsif (answer(4 downto 0)="10011") then
	dig_result<="10000100";
elsif (answer(4 downto 0)="10010") then
	dig_result<="01100000";
elsif (answer(4 downto 0)="10001") then
	dig_result<="01110000";	
	
elsif (answer(4 downto 0)="00000") then
	dig_result<="00000011";
elsif (answer(4 downto 0)="00001") then
	dig_result<="10011111";
elsif (answer(4 downto 0)="00010") then
	dig_result<="00100101";
elsif (answer(4 downto 0)="00011") then
	dig_result<="00001101";
elsif (answer(4 downto 0)="00100") then
	dig_result<="10011001";
elsif (answer(4 downto 0)="00101") then
	dig_result<="01001001";
elsif (answer(4 downto 0)="00110") then
	dig_result<="01000001";
elsif (answer(4 downto 0)="00111") then
	dig_result<="00011011";
elsif (answer(4 downto 0)="01000") then
	dig_result<="00000001";
elsif (answer(4 downto 0)="01001") then
	dig_result<="00001001";
elsif (answer(4 downto 0)="01010") then
	dig_result<="00010001";
elsif (answer(4 downto 0)="01011") then
	dig_result<="11000001";
elsif (answer(4 downto 0)="01100") then
	dig_result<="01100011";
elsif (answer(4 downto 0)="01101") then
	dig_result<="10000101";
elsif (answer(4 downto 0)="01110") then
	dig_result<="01100001";
elsif (answer(4 downto 0)="01111") then
	dig_result<="01110001";	
else dig_result<="11111111";	
end if;

if (value1(4 downto 0)="11111") then
	dig_a<="10011110";
elsif (value1(4 downto 0)="11110") then
	dig_a<="00100100";
elsif (value1(4 downto 0)="11101") then
	dig_a<="00001100";
elsif (value1(4 downto 0)="11100") then
	dig_a<="10011000";
elsif (value1(4 downto 0)="11011") then
	dig_a<="01001000";
elsif (value1(4 downto 0)="11010") then
	dig_a<="01000000";
elsif (value1(4 downto 0)="11001") then
	dig_a<="00011010";
elsif (value1(4 downto 0)="11000") then
	dig_a<="00000000";
elsif (value1(4 downto 0)="10111") then
	dig_a<="00001000";
elsif (value1(4 downto 0)="10110") then
	dig_a<="00010000";
elsif (value1(4 downto 0)="10101") then
	dig_a<="11000000";
elsif (value1(4 downto 0)="10100") then
	dig_a<="01100010";
elsif (value1(4 downto 0)="10011") then
	dig_a<="10000100";
elsif (value1(4 downto 0)="10010") then
	dig_a<="01100000";
elsif (value1(4 downto 0)="10001") then
	dig_a<="01110000";	
	
elsif (value1(4 downto 0)="00000") then
	dig_a<="00000011";
elsif (value1(4 downto 0)="00001") then
	dig_a<="10011111";
elsif (value1(4 downto 0)="00010") then
	dig_a<="00100101";
elsif (value1(4 downto 0)="00011") then
	dig_a<="00001101";
elsif (value1(4 downto 0)="00100") then
	dig_a<="10011001";
elsif (value1(4 downto 0)="00101") then
	dig_a<="01001001";
elsif (value1(4 downto 0)="00110") then
	dig_a<="01000001";
elsif (value1(4 downto 0)="00111") then
	dig_a<="00011011";
elsif (value1(4 downto 0)="01000") then
	dig_a<="00000001";
elsif (value1(4 downto 0)="01001") then
	dig_a<="00001001";
elsif (value1(4 downto 0)="01010") then
	dig_a<="00010001";
elsif (value1(4 downto 0)="01011") then
	dig_a<="11000001";
elsif (value1(4 downto 0)="01100") then
	dig_a<="01100011";
elsif (value1(4 downto 0)="01101") then
	dig_a<="10000101";
elsif (value1(4 downto 0)="01110") then
	dig_a<="01100001";
elsif (value1(4 downto 0)="01111") then
	dig_a<="01110001";	
else dig_a<="11111111";	
end if;

if (value2(4 downto 0)="11111") then
	dig_b<="10011110";
elsif (value2(4 downto 0)="11110") then
	dig_b<="00100100";
elsif (value2(4 downto 0)="11101") then
	dig_b<="00001100";
elsif (value2(4 downto 0)="11100") then
	dig_b<="10011000";
elsif (value2(4 downto 0)="11011") then
	dig_b<="01001000";
elsif (value2(4 downto 0)="11010") then
	dig_b<="01000000";
elsif (value2(4 downto 0)="11001") then
	dig_b<="00011010";
elsif (value2(4 downto 0)="11000") then
	dig_b<="00000000";
elsif (value2(4 downto 0)="10111") then
	dig_b<="00001000";
elsif (value2(4 downto 0)="10110") then
	dig_b<="00010000";
elsif (value2(4 downto 0)="10101") then
	dig_b<="11000000";
elsif (value2(4 downto 0)="10100") then
	dig_b<="01100010";
elsif (value2(4 downto 0)="10011") then
	dig_b<="10000100";
elsif (value2(4 downto 0)="10010") then
	dig_b<="01100000";
elsif (value2(4 downto 0)="10001") then
	dig_b<="01110000";	
	
elsif (value2(4 downto 0)="00000") then
	dig_b<="00000011";
elsif (value2(4 downto 0)="00001") then
	dig_b<="10011111";
elsif (value2(4 downto 0)="00010") then
	dig_b<="00100101";
elsif (value2(4 downto 0)="00011") then
	dig_b<="00001101";
elsif (value2(4 downto 0)="00100") then
	dig_b<="10011001";
elsif (value2(4 downto 0)="00101") then
	dig_b<="01001001";
elsif (value2(4 downto 0)="00110") then
	dig_b<="01000001";
elsif (value2(4 downto 0)="00111") then
	dig_b<="00011011";
elsif (value2(4 downto 0)="01000") then
	dig_b<="00000001";
elsif (value2(4 downto 0)="01001") then
	dig_b<="00001001";
elsif (value2(4 downto 0)="01010") then
	dig_b<="00010001";
elsif (value2(4 downto 0)="01011") then
	dig_b<="11000001";
elsif (value2(4 downto 0)="01100") then
	dig_b<="01100011";
elsif (value2(4 downto 0)="01101") then
	dig_b<="10000101";
elsif (value2(4 downto 0)="01110") then
	dig_b<="01100001";
elsif (value2(4 downto 0)="01111") then
	dig_b<="01110001";	
else dig_b<="11111111";	
end if;


	
if (opCCode="0000") then
	dig_c<="00000011";
elsif (opCCode="0001") then
	dig_c<="10011111";
elsif (opCCode="0010") then
	dig_c<="00100101";
elsif (opCCode="0011") then
	dig_c<="00001101";
elsif (opCCode="0100") then
	dig_c<="10011001";
elsif (opCCode="0101") then
	dig_c<="01001001";
elsif (opCCode="0110") then
	dig_c<="01000001";
elsif (opCCode="0111") then
	dig_c<="00011011";
elsif (opCCode="1000") then
	dig_c<="00000001";
elsif (opCCode="1001") then
	dig_c<="00001001";	
elsif (opCCode="1010") then
	dig_c<="00010001";
elsif (opCCode="1011") then
	dig_c<="11000001";
elsif (opCCode="1100") then
	dig_c<="01100011";
elsif (opCCode="1101") then
	dig_c<="10000101";
elsif (opCCode="1110") then
	dig_c<="01100001";
elsif (opCCode="1111") then
	dig_c<="01110001";	
else dig_c<="11111111";	
end if;	


if(seg_mode=0) then
		dig0<='0';
		dig1<='1';
		dig2<='1';
		dig3<='1';
		dig<=dig_result;
		seg_mode_new<=1;
end if;
if (seg_mode=1) then
		dig0<='1';
		dig1<='1';
		dig2<='1';
		dig3<='0';
		dig<=dig_a;
		seg_mode_new<=2;
end if;
if (seg_mode=2) then
		dig0<='1';
		dig1<='1';
		dig2<='0';
		dig3<='1';
		dig<=dig_b;
		seg_mode_new<=3;
end if;
if (seg_mode=3) then
		dig0<='1';
		dig1<='0';
		dig2<='1';
		dig3<='1';
		dig<=dig_c;
		seg_mode_new<=0;
end if;

		
end process display_all;

end Behavioral;

