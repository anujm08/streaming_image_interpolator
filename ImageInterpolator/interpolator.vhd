----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:26:45 03/22/2016 
-- Design Name: 
-- Module Name:    interpolator - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity interpolator is
    Port ( clk : in STD_LOGIC;
			  calc : in STD_LOGIC;
			  currentPixel : in  STD_LOGIC_VECTOR (15 downto 0):="0100000000000000";
           leftPixel : in  STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";
           rightPixel : in  STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";
           upperPixel : in  STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";
           lowerPixel : in  STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";
           K : in  STD_LOGIC_VECTOR (15 downto 0):="1111111111111111";
           outputPixel : out  STD_LOGIC_VECTOR (15 downto 0));
end interpolator;

architecture Behavioral of interpolator is
signal pow2_16 : STD_LOGIC_VECTOR (16 downto 0) :=(16=>'1',others=>'0');
signal pixel : STD_LOGIC_VECTOR(33 downto 0);
signal calcPixel : STD_LOGIC_VECTOR(15 downto 0) :=(others =>'0');
begin
process(clk,currentPixel,leftPixel,rightPixel,upperPixel,lowerPixel,K)
variable temp : integer;
begin
	outputPixel <= calcPixel;
	if(calc = '1') then
		temp := 4*to_integer(unsigned(K))*to_integer(unsigned(currentPixel))
				+ to_integer(unsigned(pow2_16 - K))*
				  to_integer(unsigned(leftPixel + rightPixel + upperPixel + lowerPixel));
				  
		pixel <= std_logic_vector(to_unsigned(temp,34));
		if(pixel(17)='1') then
			calcPixel <= pixel(33 downto 18)+ '1';
		else
			calcPixel <= pixel(33 downto 18);
		end if;
	else
		calcPixel <= (others=>'0');
	end if;
end process;
end Behavioral;