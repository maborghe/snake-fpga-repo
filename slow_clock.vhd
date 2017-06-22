library ieee;
use ieee.std_logic_1164.all;

entity slow_clock is
	port(
		clk		: in std_logic;
		slow_clk : out std_logic
	);
end slow_clock;

architecture behavioral of slow_clock is
	--3146875*2 bug -- f div 4
	--3146875 reduced bug 
	constant num : integer := 3146875;	-- f div 8
	signal counter : integer := 0;
	signal temp : std_logic := '0';
	
begin
	process(clk)
	begin
		if clk'event and clk = '1' then
			if counter = num then
				counter <= 1;
				temp <= not temp;
			else
				counter <= counter + 1;		
			end if;
		end if;
	end process;
	
	slow_clk <= temp;

end behavioral;