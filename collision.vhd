library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity collision is
	port (
		clk : in std_logic;
		entry : in std_logic_vector(2 downto 0);
		eaten, reset : out std_logic;
		reset_counter : out integer range 0 to 4799
	);
end collision;

architecture behave of collision is
	
	signal fill : std_logic_vector(2 downto 0) := "000";
	signal temp_eaten, temp_reset : std_logic := '0';
	constant num : integer := 6293760; --6293760
	signal counter : integer := 0;
	signal temp_reset_counter : integer range 0 to 4799 := 0;

begin
	
	process (clk)
	begin
		if clk'event and clk = '1' then
			if temp_reset = '0' then
				if counter = num then
					counter <= 1;
					case fill is
						when "000" =>
							temp_eaten <= '0';
							temp_reset <= '0';
						when "101" => -- fruit
							temp_eaten <= '1';
						when others => -- snake body
							temp_reset <= '1';
							temp_eaten <= '1';						
						end case;
				else
					counter <= counter + 1;		
					if counter = 4 then
						fill <= entry;
					end if;
				end if;
			else
				if temp_reset_counter = 4799 then
					temp_reset_counter <= 0;
					temp_reset <= '0';
					temp_eaten <= '0';
				else
					temp_reset_counter <= temp_reset_counter + 1;
				end if;
				counter <= 0;
			end if;
		end if;
	end process;

	eaten <= temp_eaten;
	reset <= temp_reset;
	reset_counter <= temp_reset_counter;
	
end behave;

