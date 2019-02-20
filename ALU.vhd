----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:25:05 04/30/2018 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned tail_datas
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use IEEE.NUMERIC_STD.ALL;
use work.common.all;

entity ALU is
    Port ( opcode : in  STD_LOGIC_VECTOR ((opcode_width - 1) downto 0);
           dregister_data : out  STD_LOGIC_VECTOR ((data_width - 1) downto 0);
           sregister1_data : in  STD_LOGIC_VECTOR ((data_width - 1) downto 0);
			  pregisterIN : in STD_LOGIC_VECTOR((address_width - 1) downto 0);
			  pregisterOUT : out STD_LOGIC_VECTOR((address_width - 1) downto 0);
           sregister2_data : in  STD_LOGIC_VECTOR ((data_width - 1) downto 0);
           tail_data : in  STD_LOGIC_VECTOR ((data_width - 1) downto 0));
end ALU;


architecture Behavioral of ALU is

	begin

	ComposeControl: process(opcode,sregister1_data,sregister2_data,tail_data,pregisterIN)
	
	begin
	if (opcode(3 downto 0)="0000") then
		dregister_data<=sregister1_data+sregister2_data;
		pregisterOUT<="00000000";
	elsif (opcode(3 downto 0)="0001") then
		dregister_data<=sregister1_data+tail_data;
		pregisterOUT<="00000000";
	elsif (opcode(3 downto 0)="0010") then
		dregister_data<=sregister1_data-sregister2_data;
		pregisterOUT<="00000000";
	elsif (opcode(3 downto 0)="0011") then
		dregister_data<=sregister1_data-tail_data;
		pregisterOUT<="00000000";
	elsif (opcode(3 downto 0)="0100") then
		dregister_data<=sregister1_data and sregister2_data;
		pregisterOUT<="00000000";
	elsif (opcode(3 downto 0)="0101") then
		dregister_data<=sregister1_data and tail_data;
		pregisterOUT<="00000000";
	elsif (opcode(3 downto 0)="0110") then
		dregister_data<=sregister1_data or sregister2_data;
		pregisterOUT<="00000000";
	elsif (opcode(3 downto 0)="0111") then
		dregister_data<=sregister1_data or tail_data;
		pregisterOUT<="00000000";
	elsif (opcode(3 downto 0)="1000") then
		dregister_data <= std_logic_vector(shift_left(unsigned(sregister1_data), to_integer(unsigned(tail_data))));
		pregisterOUT<="00000000";
	elsif (opcode(3 downto 0)="1001") then
		dregister_data <= std_logic_vector(shift_right(unsigned(tail_data), to_integer(unsigned(sregister1_data))));
		pregisterOUT<="00000000";
	elsif (opcode(3 downto 0)="1010") then
		pregisterOUT<=pregisterIN;
		dregister_data<="00000000";
	elsif (opcode(3 downto 0)="1100") then
		pregisterOUT<=pregisterIN + tail_data;
		dregister_data<="00000000";
	elsif (opcode(3 downto 0)="1101") then
		if(sregister1_data<sregister2_data) then
			pregisterOUT<=pregisterIN + tail_data;
			dregister_data<="00000000";
		else 
			pregisterOUT<=pregisterIN+1;
			dregister_data<="00000000";
		end if;
	elsif (opcode(3 downto 0)="1110") then
		if(sregister1_data=sregister2_data) then
			pregisterOUT<=pregisterIN + tail_data;
			dregister_data<="00000000";
		else 
			pregisterOUT<=pregisterIN+1;
			dregister_data<="00000000";
		end if;
	elsif (opcode(3 downto 0)="1111") then
		if(sregister1_data/=sregister2_data) then
			pregisterOUT<=pregisterIN + tail_data;
			dregister_data<="00000000";
		else 
			pregisterOUT<=pregisterIN+1;
			dregister_data<="00000000";
		end if;
	else
		pregisterOUT<=pregisterIN+1; 
		dregister_data<="00000000";
	end if;
	end process ComposeControl;	


end Behavioral;

