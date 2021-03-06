library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity collision is
	port (
		clk, ff, reset, counter_4, counter_step : in std_logic;
		entry : in std_logic_vector(2 downto 0);
		eaten, eaten_score, game_over : out std_logic
	);
end collision;

architecture behave of collision is
	
	signal fill : std_logic_vector(2 downto 0) := "000";
	signal temp_eaten : std_logic := '1'; 
	signal temp_reset, temp_eaten_score : std_logic := '0';

begin
	
	process (clk)
	begin
		if clk'event and clk = '1' then
			if reset = '1' or ff = '1' then
			temp_reset <= '0';
						temp_eaten <= '1';	
						temp_eaten_score <= '0';
			end if;
			if counter_step = '1' then
				case fill is
					when "000" =>
						temp_eaten <= '0';
						temp_reset <= '0';
						temp_eaten_score <= '0';
					when "101" => -- fruit
						temp_eaten <= '1';
						temp_reset <= '0';
						temp_eaten_score <= '1';
					when others => -- snake body or obstacle
						temp_reset <= '1';
						temp_eaten <= '1';	
						temp_eaten_score <= '0';
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
eaten_score <= temp_eaten_score;
	
end behave;