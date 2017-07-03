library ieee;
use ieee.std_logic_1164.all;

entity direction is
	port(
		clk, reset	: in std_logic;
		up, down, left, right : in std_logic;
		dir 					: out std_logic_vector(1 downto 0)
	);
end direction;


architecture behavioral of direction is
	--intial values
	signal last_direction : std_logic_vector(1 downto 0):= "10";
	signal horizontal : std_logic:= '1';
	
begin

	determine_next_position : process(clk, reset)
	begin
		if clk'event and clk = '1' then
			if reset = '1' then
				last_direction <= "10";
				horizontal <= '1';
			else
				if(horizontal = '1') then 
					--horizontal move -> up or down or repeat
					if up = '1' and down = '0' and left = '0' and right = '0' then
						horizontal <= '0';
						last_direction <= "01";
					elsif up = '0' and down = '1' and left = '0' and right = '0' then
						horizontal <= '0';
						last_direction <= "11";
					end if;
				else	
					--vertival move -> left or right or repeat
					if up = '0' and down = '0' and left = '1' and right = '0' then
						horizontal <= '1';
						last_direction <= "00";
					elsif up = '0' and down = '0' and left = '0' and right = '1' then
						horizontal <= '1';
						last_direction <= "10";
					end if;
				end if;
			end if;
		end if;
	end process;
	
	dir <= last_direction;

end behavioral;