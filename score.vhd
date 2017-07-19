library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity score is
	port (
		clk, reset, eaten : in std_logic;
		led : out std_logic_vector(7 downto 0)
	);
end score;

architecture Behavioral of score is

	signal score_value, rec : std_logic_vector(7 downto 0) := "00000000";
	signal counter : integer := 0;
	
begin

	score_count : process(clk)
		variable taken : std_logic := '1';
	begin
		if clk'event and clk = '1' then
			if reset = '1' then
				score_value <= "00000000";
			elsif eaten = '1' then
				if taken = '1' then
					score_value <= std_logic_vector(unsigned(score_value) + 1);
					if unsigned(score_value) = unsigned(rec) then
						rec <= std_logic_vector(unsigned(score_value) + 1);
					end if;
					taken := '0';
				end if;
			else
				taken := '1';
			end if;
		end if;
	end process;

led <= rec;

end Behavioral;

