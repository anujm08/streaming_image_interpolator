----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:43:40 03/23/2016 
-- Design Name: 
-- Module Name:    updateIndex - Behavioral 
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
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity updateIndex is
    Port ( clk : in STD_LOGIC;
			  update : in STD_LOGIC;
			  i : inout  STD_LOGIC_VECTOR (6 downto 0);
           j : inout  STD_LOGIC_VECTOR (6 downto 0));
end updateIndex;

architecture Behavioral of updateIndex is
signal yinc : STD_LOGIC := '1';
signal size : STD_LOGIC_VECTOR(6 downto 0) := "1100011";
begin
process(clk)
begin
	if(update = '1') then
		if((yinc = '1' AND j = size) OR (yinc = '0' AND j = "0000000")) then
			yinc <= NOT yinc;
			i <= i + '1';
		elsif(yinc = '1') then
			j <= j + '1';
		else
			j <= j - '1';
		end if;
	end if;
end process;

end Behavioral;

