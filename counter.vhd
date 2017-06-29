library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter is
	port (
		clk: in std_logic;
		counter_6293760, counter_9_of_6293760 : out std_logic
	);
end counter;

architecture Behavioral of counter is
	signal counter : integer := 0;
	signal output_value_6293760 : std_logic := '0';
	signal output_value_9 : std_logic := '0';
	
begin

	count_function : process(clk)
	begin
		if clk'event and clk = '1' then
			if counter = 6293760 then
				if counter = 9 then
					output_value_9 <= '1';
				else 
					output_value_9 <= '0';
				end if;
				counter <= 0;
				--output_value_6293760 <= not output_value_6293760;--impuls signal
				output_value_6293760 <= '1';
			else
				output_value_6293760 <= '0';
				counter <= counter + 1;
			end if;
		end if;
	end process;
	
	counter_6293760 <= output_value_6293760;
	counter_9_of_6293760 <= output_value_9;
end Behavioral;

