----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:57:56 12/09/2020 
-- Design Name: 
-- Module Name:    adder - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
    Port ( a1 : in  STD_LOGIC;
           a2 : in  STD_LOGIC;
           b1 : in  STD_LOGIC;
           b2 : in  STD_LOGIC;
           sum1 : out  STD_LOGIC;
           sum2 : out  STD_LOGIC;
           sum_carry : out  STD_LOGIC);
end adder;

architecture Behavioral of adder is
signal bufCarry : STD_LOGIC;
begin
	sum1 <= a1 xor b1;
	bufCarry <= (a1 and b1);
	sum2 <= a2 xor b2 xor bufCarry;
	sum_carry <= (a2 and b2) or (a2 and bufCarry) or (b2 and bufCarry);

end Behavioral;

