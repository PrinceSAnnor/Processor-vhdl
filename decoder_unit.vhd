----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:27:51 04/30/2018 
-- Design Name: 
-- Module Name:    decoder_unit - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned tail_datas
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder_unit is
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
end decoder_unit;

architecture Behavioral of decoder_unit is
  signal operation : STD_LOGIC_VECTOR ((opcode_width-1) downto 0);
  signal dregister : STD_LOGIC_VECTOR (2 downto 0);
  signal sregister1 : STD_LOGIC_VECTOR (2 downto 0);
  signal sregister2 : STD_LOGIC_VECTOR (2 downto 0);
  signal tail : STD_LOGIC_VECTOR (2 downto 0);
  signal rd_we : STD_LOGIC := '1';
  signal pc_we: STD_LOGIC := '0';
  signal pc_incr: STD_LOGIC  := '1';
  signal sRRegister1_data : STD_LOGIC_VECTOR ((data_width - 1) downto 0);
  signal sRRegister2_data : STD_LOGIC_VECTOR ((data_width - 1) downto 0);
  
	component Registers is
	port ( 	clk : in STD_LOGIC;
		rst: in STD_LOGIC;

		Rs1_addr_in : in STD_LOGIC_VECTOR ((reg_addr_width - 1) downto 0);
		Rs1_data_out : out STD_LOGIC_VECTOR ((data_width - 1) downto 0);

		Rs2_addr_in : in STD_LOGIC_VECTOR ((reg_addr_width - 1) downto 0);
		Rs2_data_out : out STD_LOGIC_VECTOR ((data_width - 1) downto 0);

		Rd_addr_in : in STD_LOGIC_VECTOR ((reg_addr_width - 1) downto 0);
		Rd_data_in : in STD_LOGIC_VECTOR ((data_width - 1) downto 0);
		Rd_we : in STD_LOGIC
	     );
end component;

component PC is
	port ( 	clk : in STD_LOGIC;
		rst: in STD_LOGIC;

		PC_in : in STD_LOGIC_VECTOR ((address_width - 1) downto 0);
		PC_out : out STD_LOGIC_VECTOR ((address_width - 1) downto 0);

		PC_we : in STD_LOGIC;
		PC_incr : in STD_LOGIC
	     );
end component;

	begin
		RSD: Registers
			port map(clk=>clk, rst=>rst,Rs1_addr_in=>sregister1,Rs2_addr_in=>sregister2,Rd_addr_in=>dregister,Rs1_data_out=>sRRegister1_data,Rs2_data_out=>sRRegister2_data,Rd_data_in=>dregister_data, Rd_we=>rd_we);  
				
		PC_inst: PC
			port map(clk=>clk, rst=>rst, PC_in=>PC_address_in, PC_out=>PC_address_out, PC_we=>pc_we, PC_incr=>pc_incr);


			operation<=instructions(15 downto 12);
			dregister<=instructions(11 downto 9);
			sregister1<=instructions(8 downto 6);
			sregister2<=instructions(5 downto 3);
			tail<=instructions(2 downto 0);
			operation_ext<=instructions(15 downto 12);

			sregister1_data <= sRRegister1_data;
			sregister2_data <= sRRegister2_data;

		SplitData: process(instructions, sregister2, dregister, tail, operation)

		begin
			if (operation = "0001") then
				tail_data<=sregister2(2)&sregister2(2)&sregister2&tail; 
			elsif (operation="0011") then
				tail_data<=sregister2(2)&sregister2(2)&sregister2&tail; 
			elsif (operation="0101") then
				tail_data<="00"&sregister2&tail;
			elsif (operation="0111") then
				tail_data<="00"&sregister2&tail;
			elsif (operation="1000") then
				tail_data<="00000"&tail;
			elsif (operation="1001") then
				tail_data<="00000"&tail;
			elsif (operation="1100") then
				tail_data<="00"&sregister2&tail;
			elsif (operation="1101") then
				tail_data<=dregister(2)&dregister(2)&dregister&tail; 
			elsif (operation="1110") then
				tail_data<=dregister(2)&dregister(2)&dregister&tail; 
			elsif (operation="1111") then
				tail_data<=dregister(2)&dregister(2)&dregister&tail;
			else
				tail_data<="00000000";
			end if;
			

		end process SplitData;

		ReadWrite: process(operation)
		begin
			if (operation(3 downto 0)="1010") then
				rd_we <= '0';
			elsif (operation(3 downto 0)="1100") then
				rd_we <= '0';
			elsif (operation(3 downto 0)="1101") then
				rd_we <= '0';
			elsif (operation(3 downto 0)="1110") then
				rd_we <= '0';
			elsif (operation(3 downto 0)="1111") then
				rd_we <= '0';
			else
				rd_we <= '1';
			end if;
			end process ReadWrite;
			
		MainControl: process(operation,sRRegister1_data,sRRegister2_data)
		begin
		if (operation(3 downto 0)="0000") then
			pc_incr<='1';
			pc_we<='0';
		elsif (operation(3 downto 0)="0001") then
			pc_incr<='1';
			pc_we<='0';
		elsif (operation(3 downto 0)="0010") then
			pc_incr<='1';
			pc_we<='0';
		elsif (operation(3 downto 0)="0011") then
			pc_incr<='1';
			pc_we<='0';
		elsif (operation(3 downto 0)="0100") then
			pc_incr<='1';
			pc_we<='0';
		elsif (operation(3 downto 0)="0101") then
			pc_incr<='1';
			pc_we<='0';
		elsif (operation(3 downto 0)="0110") then
			pc_incr<='1';
			pc_we<='0';
		elsif (operation(3 downto 0)="0111") then
			pc_incr<='1';
			pc_we<='0';
		elsif (operation(3 downto 0)="1000") then
			pc_incr<='1';
			pc_we<='0';
		elsif (operation(3 downto 0)="1001") then
			pc_incr<='1';
			pc_we<='0';
		elsif (operation(3 downto 0)="1010") then
			pc_incr<='0';
			pc_we<='0';
		elsif (operation(3 downto 0)="1100") then
			pc_incr<='1';
			pc_we<='0';
		elsif (operation(3 downto 0)="1101") then
			if(sRRegister1_data<sRRegister2_data) then
				pc_we<='1';
				pc_incr<='0';
			else 
				pc_incr<='1';
				pc_we<='0';
			end if;
		elsif (operation(3 downto 0)="1110") then
			if(sRRegister1_data=sRRegister2_data) then
				pc_we<='1';
				pc_incr<='0';
			else 
				pc_incr<='1';
				pc_we<='0';
			end if;
		elsif (operation(3 downto 0)="1111") then
			if(sRRegister1_data/=sRRegister2_data) then
				pc_we<='1';
				pc_incr<='0';
			else 
				pc_incr<='1';
				pc_we<='0';
			end if;
		else
			pc_incr<='0';
			pc_we<='0';
		end if;
		end process MainControl;	


end Behavioral;

