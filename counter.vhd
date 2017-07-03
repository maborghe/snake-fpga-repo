library ieee;
use ieee.std_logic_1164.all;

entity counter is
	port(
		clk, reset							: in std_logic;
		counter_step, counter_9			: out std_logic;
		counter_30, counter_14 			: out std_logic
	);
end counter;

architecture Behavioral of counter is
	--head,tail
	signal counter : integer := 0;
	--fruit
	signal counter2 : integer := 0;
	
begin

	count0_function : process(clk)
	begin
		if clk'event and clk = '1' then
			if reset = '1' then
				counter <= 0;
			else
				--counter for head/tail
				if counter = 6293760 then
					counter_step <= '1';
					counter <= 1;
				else
					if counter = 9 then
						counter_9 <= '1';
					else 
						counter_9 <= '0';
					end if;
					counter_step <= '0';
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process;
	
	count1_function : process(clk)
	begin
		if clk'event and clk = '1' then
			if reset = '1' then
				counter2 <= 0;
			else
				--counter fruit
				if counter2 = 30 then
					counter2 <= 1;
					counter_30 <= '1';
				else
					if counter2 = 14 then
						counter_14 <= '1';
					else 
						counter_14 <= '0';
					end if;
					counter_30 <= '0';
					counter2 <= counter2 + 1;
				end if;
				--
			end if;
		end if;
	end process;
end Behavioral;

