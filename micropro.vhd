----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:20:57 04/30/2018 
-- Design Name: 
-- Module Name:    micropro - Behavioral 
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
use work.common.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity micropro is
port(
	clk : in STD_LOGIC;
   mas_clk: in STD_LOGIC;
	rst : in STD_LOGIC;
	opcode_out : out STD_LOGIC_VECTOR ((opcode_width -1) downto 0);
	sRegister1_data_out : out STD_LOGIC_VECTOR ((data_width - 1) downto 0);
	sRegister2_data_out : out STD_LOGIC_VECTOR ((data_width - 1) downto 0);
	dRegister_data_out : out STD_LOGIC_VECTOR ((data_width - 1) downto 0);
	dig0 : out  STD_LOGIC;
   dig1 : out  STD_LOGIC;
   dig :  out std_logic_vector (7 downto 0);
   dig2 : out  STD_LOGIC;
   dig3 : out  STD_LOGIC);
end micropro;

architecture Behavioral of micropro is

component ALU is
    Port ( opcode : in  STD_LOGIC_VECTOR ((opcode_width -1) downto 0);
           dregister_data : out  STD_LOGIC_VECTOR ((data_width - 1) downto 0);
           sregister1_data : in  STD_LOGIC_VECTOR ((data_width - 1) downto 0);
			  pregisterIN : in STD_LOGIC_VECTOR((address_width - 1) downto 0);
			  pregisterOUT : out STD_LOGIC_VECTOR((address_width - 1) downto 0);
           sregister2_data : in  STD_LOGIC_VECTOR ((data_width - 1) downto 0);
           tail_data : in  STD_LOGIC_VECTOR ((data_width - 1) downto 0));
end component;

component Instructions_ROM is
	port (
		rst : in STD_LOGIC;
		address_in : in STD_LOGIC_VECTOR ((address_width - 1) downto 0);
		data_out : out STD_LOGIC_VECTOR ((instruction_width - 1) downto 0)
	     );
end component Instructions_ROM;

component decoder_unit is
    Port ( clk : in STD_LOGIC;
	 	     rst : in STD_LOGIC;
			  instructions : in  STD_LOGIC_VECTOR ((instruction_width-1) downto 0);
			  dregister_data : in  STD_LOGIC_VECTOR ((data_width - 1) downto 0);
           sregister1_data : out  STD_LOGIC_VECTOR ((data_width - 1) downto 0);
           sregister2_data : out  STD_LOGIC_VECTOR ((data_width - 1) downto 0);
           tail_data : out  STD_LOGIC_VECTOR ((data_width - 1) downto 0);
			  operation_ext : out STD_LOGIC_VECTOR ((opcode_width-1) downto 0);
			  PC_address_in : in STD_LOGIC_VECTOR ((address_width - 1) downto 0);
			  PC_address_out : out STD_LOGIC_VECTOR ((address_width - 1) downto 0));
end component;

component ALUdisplay is
		Port (clk : in std_logic;
			  opCCode : in STD_LOGIC_VECTOR ((opcode_width-1) downto 0);
			  value1 : in STD_LOGIC_VECTOR ((data_width - 1) downto 0);
			  value2 : in STD_LOGIC_VECTOR ((data_width - 1) downto 0);
			  answer : in STD_LOGIC_VECTOR ((data_width - 1) downto 0);
           dig0 : out  STD_LOGIC;
           dig1 : out  STD_LOGIC;
			  dig : out std_logic_vector (7 downto 0);
           dig2 : out  STD_LOGIC;
           dig3 : out  STD_LOGIC);
end component;

signal instruction : STD_LOGIC_VECTOR((instruction_width - 1) downto 0);
signal opCode : STD_LOGIC_VECTOR ((opcode_width - 1) downto 0);
signal dRegister_data : STD_LOGIC_VECTOR ((data_width - 1) downto 0);
signal sRegister1_data : STD_LOGIC_VECTOR ((data_width - 1) downto 0);
signal sRegister2_data : STD_LOGIC_VECTOR ((data_width - 1) downto 0);
signal tAAil_data : STD_LOGIC_VECTOR ((data_width - 1) downto 0);
signal pcc_address_in: STD_LOGIC_VECTOR ((address_width - 1) downto 0);
signal pcc_address_out: STD_LOGIC_VECTOR ((address_width - 1) downto 0);
begin

ALU_inst: ALU
			port map(opcode=>opCode,dregister_data=>dRegister_data,sregister1_data=>sRegister1_data,sregister2_data=>sRegister2_data,tail_data=>tAAil_data,pregisterIN=>pcc_address_out, pregisterOUT=>pcc_address_in); 

DECCON: decoder_unit
			port map(operation_ext=>opCode, clk=>mas_clk, rst=>rst, instructions=>instruction, dregister_data=>dRegister_data, sregister1_data=>sRegister1_data, sregister2_data=>sRegister2_data, tail_data=>tAAil_data, PC_address_in=>pcc_address_in, PC_address_out=>pcc_address_out);

Instructions_ROM_inst: Instructions_ROM
			port map(rst=>rst, address_in=>pcc_address_out, data_out=>instruction);

ALU_DOG : ALUdisplay
			port map(clk=>clk,opCCode=>opCode,value1=>sRegister1_data,value2=>sRegister2_data,answer=>dRegister_data,dig=>dig,dig0=>dig0,dig1=>dig1,dig2=>dig2,dig3=>dig3);

process(opCode, mas_clk, sRegister1_data, sRegister2_data, dRegister_data)
begin
opcode_out <= opCode;
sRegister1_data_out <= sRegister1_data;
sRegister2_data_out <= sRegister2_data;
dRegister_data_out <= dRegister_data;
end process;

end Behavioral;

