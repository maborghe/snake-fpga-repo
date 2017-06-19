----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:10:04 06/13/2017 
-- Design Name: 
-- Module Name:    graphic_unit - Behavioral 
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

entity graphic_unit is
	port (
		clk : in std_logic;
		value : in integer range -1 to 4;
		r : out std_logic_vector(3 downto 0);
		g : out std_logic_vector(3 downto 0);
		b : out std_logic_vector(3 downto 0)
	);
end graphic_unit;

architecture Behavioral of graphic_unit is

begin
	process (clk)
	begin
		if clk'event and clk = '1' then
			if value = 0 then
				r <= "0000";
				g <= "0000";
				b <= "0000";
			else
				r <= "1111";
				g <= "1111";
				b <= "1111";
			end if;
		end if;
	end process;

end Behavioral;

