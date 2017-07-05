library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pixel is
	port (
		clk, video : in std_logic;
		data : in std_logic_vector(2 downto 0);
		r, g, b : out std_logic_vector(3 downto 0)
	);
end pixel;

architecture behave of pixel is
	
begin
	process(clk)
	begin
		if clk'event and clk = '1' then
			if video = '0' or data = "000" then
				r <= "0000";
				g <= "0000";
				b <= "0000";
			elsif data = "101" then -- fruit
				r <= "1111";
				g <= "0000";
				b <= "0000";
			elsif data = "110" then -- obstacle / Huerde
				r <= "1111";
				g <= "1111";
				b <= "1111";
			else
				r <= "0000";
				g <= "1111";
				b <= "0000";
			end if;
		end if;
	end process;
	
end behave;

