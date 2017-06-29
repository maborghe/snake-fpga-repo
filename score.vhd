library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity score is
	port (
		clk, eaten : in std_logic;
		led : out std_logic_vector(7 downto 0)
	);
end score;

architecture Behavioral of score is

	signal score_value : std_logic_vector(7 downto 0) := "00000000";
	signal counter : integer := 0;
	
begin

	score_count : process(clk) 
	begin
		if clk'event and clk = '1' then
			if eaten = '1' then
				if counter = 6293750 then
				--if counter = 6293760 then
					counter <= 1;
					score_value <= std_logic_vector(unsigned(score_value) + 1);
					led <= std_logic_vector(unsigned(score_value));
				else
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process;

end Behavioral;

