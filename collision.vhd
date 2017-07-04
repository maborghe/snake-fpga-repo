library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity collision is
	port (
		clk, counter_4, counter_step : in std_logic;
		entry : in std_logic_vector(2 downto 0);
		eaten, game_over : out std_logic
	);
end collision;

architecture behave of collision is
	
	signal fill : std_logic_vector(2 downto 0) := "000";
	signal temp_eaten, temp_reset : std_logic := '0';

begin
	
	process (clk)
	begin
		if clk'event and clk = '1' then
			if counter_step = '1' then
				case fill is
					when "000" =>
						temp_eaten <= '0';
						temp_reset <= '0';
					when "101" => -- fruit
						temp_eaten <= '1';
						temp_reset <= '0';
					when others => -- snake body
						temp_reset <= '1';
						temp_eaten <= '1';						
					end case;
			elsif counter_4 = '1' then
				fill <= entry;
			else
				temp_reset <= '0';
			end if;
		end if;
	end process;

	eaten <= temp_eaten;
	game_over <= temp_reset;
	
end behave;