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
	signal tmp_direction : std_logic_vector(1 downto 0) := "10";
	signal last_direction : std_logic_vector(1 downto 0):= "10";
	signal horizontal : std_logic:= '1';
	signal vertical : std_logic:= '0';
begin

determine_next_position : process(slow_clk)
	begin
		if slow_clk'event and slow_clk = '1' then
			if(horizontal = '1') then 
				--horizontal move -> up or down or last_direction
				if up = '1' and down = '0' and left = '0' and right = '0' then
					tmp_direction <= "01";
					horizontal <= '0';
					vertical <= '1';
				elsif up = '0' and down = '1' and left = '0' and right = '0' then
					tmp_direction <= "11";
					horizontal <= '0';
					vertical <= '1';
				else
					--no button pressed -> repeat move
					tmp_direction <= last_direction;
				end if;
			else	
				--vertival move -> left or right or last_direction
				if up = '0' and down = '0' and left = '1' and right = '0' then
					tmp_direction <= "00";
					horizontal <= '1';
					vertical <= '0';
				elsif up = '0' and down = '0' and left = '0' and right = '1' then
					tmp_direction <= "10";
					horizontal <= '1';
					vertical <= '0';
				else
					--no button pressed -> repeat move
					tmp_direction <= last_direction;
				end if;
			end if;
		end if;
end process;
	dir <= tmp_direction;
	last_direction <= tmp_direction;

end behavioral;