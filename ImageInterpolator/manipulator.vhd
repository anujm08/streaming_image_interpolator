----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:30:06 03/30/2016 
-- Design Name: 
-- Module Name:    manipulator - Behavioral 
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
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.MATH_REAL.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity manipulator is
    Port ( clk : in STD_LOGIC;
			  inpixel : in  STD_LOGIC_VECTOR (15 downto 0);
			  i : in  STD_LOGIC_VECTOR (0 downto 0);
           j : in  STD_LOGIC_VECTOR (0 downto 0);
           reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           centralpixel : out  STD_LOGIC_VECTOR (15 downto 0);
           leftpixel : out  STD_LOGIC_VECTOR (15 downto 0);
           rightpixel : out  STD_LOGIC_VECTOR (15 downto 0);
           upperpixel : out  STD_LOGIC_VECTOR (15 downto 0);
           lowerpixel : out  STD_LOGIC_VECTOR (15 downto 0));
           
end manipulator;

architecture Behavioral of manipulator is
signal pixels: STD_LOGIC_VECTOR(6399 downto 0) := (others => '0');
begin
process(clk)
variable k: integer:=0;
variable k_c: integer:=0;
variable k_d: integer:=0;
variable k_u: integer:=0;
variable i_t: integer:=0;
variable j_t: integer:=0;
begin
	if(clk'event and clk = '1') then
		
		-- reset
		
		if(reset='1') then
			pixels <= (others =>'0');
		end if;
		
		-- indexing
		
		i_t := to_integer(unsigned(i));
		j_t := to_integer(unsigned(j));
		k := 16*((i_t mod 4)*100+j_t);
		k_c := 16*(((i_t-2) mod 4)*100+j_t);
		k_u := 16*(((i_t-3) mod 4)*100+j_t);
		k_d := 16*(((i_t-1) mod 4)*100+j_t);
		
		-- loading input pixels
		
		if(load='1') then	
			pixels(k+15 downto k)<=inpixel;
		else
			pixels(k+15 downto k)<=(others=>'0');
		end if;
		
		-- assigning output pixels
		
		centralpixel <= pixels(k_c+15 downto k_c);
		upperpixel <= pixels(k_u+15 downto k_u);
		lowerpixel <= pixels(k_d+15 downto k_d);
		if(j_t = 0) then
			leftpixel <= (others=>'0');
		else
			leftpixel <= pixels(k_c-1 downto k_c-16);
		end if;
		
		if(j_t = 99) then
			rightpixel <= (others=>'0');
		else
			rightpixel <= pixels(k_c+31 downto k_c+16);
		end if;

	end if;
end process;

end Behavioral;

