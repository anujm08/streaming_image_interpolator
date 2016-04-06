--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:03:31 04/06/2016
-- Design Name:   
-- Module Name:   /home/anuj/DLDProject/ImageInterpolator/test2.vhd
-- Project Name:  ImageInterpolator
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: interpolator_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test2 IS
	GENERIC (
			  in_file : string := "inputImage.txt"
			  );
END test2;
 
ARCHITECTURE behavior OF test2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	 file i_file: TEXT open read_mode is in_file;
    COMPONENT interpolator_top
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic;
         RPixel : IN  std_logic_vector(15 downto 0);
         GPixel : IN  std_logic_vector(15 downto 0);
         BPixel : IN  std_logic_vector(15 downto 0);
         outRPixel : INOUT  std_logic_vector(15 downto 0);
         outGPixel : INOUT  std_logic_vector(15 downto 0);
         outBPixel : INOUT  std_logic_vector(15 downto 0);
         outputReady : INOUT  std_logic
        );
    END COMPONENT;
    
	--Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal start : std_logic := '0';
   signal RPixel : std_logic_vector(15 downto 0) := (others => '0');
   signal GPixel : std_logic_vector(15 downto 0) := (others => '0');
   signal BPixel : std_logic_vector(15 downto 0) := (others => '0');

	--BiDirs
   signal outRPixel : std_logic_vector(15 downto 0);
   signal outGPixel : std_logic_vector(15 downto 0);
   signal outBPixel : std_logic_vector(15 downto 0);
   signal outputReady : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: interpolator_top PORT MAP (
          clk => clk,
          reset => reset,
          start => start,
          RPixel => RPixel,
          GPixel => GPixel,
          BPixel => BPixel,
          outRPixel => outRPixel,
          outGPixel => outGPixel,
          outBPixel => outBPixel,
          outputReady => outputReady
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
	variable l    : line; --line number declaration
	variable s    : string(1 to 48);
	variable s2   : string(1 to 16);
	variable c    : character := '0';
	variable j    : integer := 0;
   begin		
      -- hold reset state for 100 ns.
		reset<='1';
		wait for clk_period*5;
		reset<='0';
		start<='1';
		
		-- READ A
		readline(i_file, l);
		read(l, s2);
		for j in 1 to 16 loop
			c:= s2(j);
			if(c='0') then
				RPixel(16-j) <= '0';
			else
				RPixel(16-j) <= '1';
			end if;
		end loop;
		
		--READ B
		readline(i_file, l);
		read(l, s2);
		for j in 1 to 16 loop
			c:= s2(j);
			if(c='0') then
				GPixel(16-j) <= '0';
			else
				GPixel(16-j) <= '1';
			end if;
		end loop;
		
		--READ C
		readline(i_file, l);
		read(l, s2);
		for j in 1 to 16 loop
			c:= s2(j);
			if(c='0') then
				BPixel(16-j) <= '0';
			else
				BPixel(16-j) <= '1';
			end if;
		end loop;
			
		wait for clk_period*2;
		start<='0';
		-- start Reading Pixels
		while (not endfile(i_file)) loop 
			readline(i_file, l);
			read(l, s);
			for j in 1 to 16 loop
				c:= s(j);
				if(c='0') then
					RPixel(16-j) <= '0';
				else
					RPixel(16-j) <= '1';
				end if;
			end loop;
			
			for j in 1 to 16 loop
				c:= s(16+j);
				if(c='0') then
					GPixel(16-j) <= '0';
				else
					GPixel(16-j) <= '1';
				end if;
			end loop;
			
			for j in 1 to 16 loop
				c:= s(32+j);
				if(c='0') then
					BPixel(16-j) <= '0';
				else
					BPixel(16-j) <= '1';
				end if;
			end loop;
			
			wait for clk_period;
		end loop;
    
		RPixel<=(others=>'0');
		GPixel<=(others=>'0');
		BPixel<=(others=>'0');
		
      wait;
   end process;

END;
