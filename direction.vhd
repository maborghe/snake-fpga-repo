library ieee;
use ieee.std_logic_1164.all;

entity direction is
	port(
		slow_clk : in std_logic;
		up			: in std_logic;
		down		: in std_logic;
		left		: in std_logic;
		right		: in std_logic;
		dir : out std_logic_vector(1 downto 0)
	);
end direction;


architecture behavioral of direction is
	signal last_direction : std_logic_vector(1 downto 0):= "10";
	signal horizontal : std_logic:= '1';
begin

determine_next_position : process(slow_clk)
	begin
		if slow_clk'event and slow_clk = '1' then
			if(horizontal = '1') then 
				--horizontal move -> up or down
				if up = '1' and down = '0' and left = '0' and right = '0' then
					horizontal <= '0';
					last_direction <= "01";
				elsif up = '0' and down = '1' and left = '0' and right = '0' then
					horizontal <= '0';
					last_direction <= "11";
				end if;
			else	
				--vertival move -> left or right
				if up = '0' and down = '0' and left = '1' and right = '0' then
					horizontal <= '1';
					last_direction <= "00";
				elsif up = '0' and down = '0' and left = '0' and right = '1' then
					horizontal <= '1';
					last_direction <= "10";
				end if;
			end if;
		end if;
	end process;
	
	dir <= last_direction;

end behavioral;