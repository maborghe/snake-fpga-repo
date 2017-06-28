library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity collision is
	port (
		clk : in std_logic;
		entry : in std_logic_vector(2 downto 0);
		eaten, reset : out std_logic
	);
end collision;

architecture behave of collision is
	
	signal fill : std_logic_vector(2 downto 0) := "000";
	signal temp_eaten : std_logic := '0';
	constant num : integer := 6293760; --6293760
	signal counter : integer := 0;
	
	
begin
	
	process (clk)
	begin
		if clk'event and clk = '1' then
			if counter = num then
				counter <= 1;
				case fill is
					when "000" =>
						temp_eaten <= '0';
						reset <= '0';
					when "101" => -- fruit
						temp_eaten <= '1';
					when others => -- snake body
						reset <= '1';
					end case;
			else
				counter <= counter + 1;		
				if counter = 4 then
					fill <= entry;
				end if;
			end if;
		end if;
	end process;
	eaten <= temp_eaten;
	
end behave;

