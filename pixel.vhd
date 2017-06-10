library ieee;
use ieee.std_logic_1164.all;

entity pixel is
	port (
		clk 	: in 	std_logic;
		video : in 	std_logic;
		col 	: in 	integer range 0 to 799;
		row 	: in 	integer range 0 to 524;
		r 		: out std_logic_vector(3 downto 0);
		g 		: out std_logic_vector(3 downto 0);
		b 		: out std_logic_vector(3 downto 0)
	);
end pixel;

architecture behave of pixel is
begin

	border : process (clk)
	begin
		if clk'event and clk = '1' then
			if video = '1' then
				if (col = 1 or col = 640) or (row = 0 or row = 479) then
					r <= "1111";
					g <= "1111";
					b <= "1111";
				else
					r <= "0000";
					g <= "0000";
					b <= "0000";
				end if;
			else
				r <= "0000";
				g <= "0000";
				b <= "0000";
			end if;
		end if;
	end process;
end behave;
