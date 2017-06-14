library ieee;
use ieee.std_logic_1164.all;

entity slow_clock is
	port (
		clk  : in  std_logic;
		slow_clk : out std_logic
	);
end slow_clock;

architecture behave of slow_clock is
	
	constant num : integer := 12587500;
	signal counter : integer := 1;
	signal clk_out : std_logic;
	
begin

	process(clk)
	begin
		if (clk'event and clk='1') then
			if (counter = num) then
				counter <= 1;
				clk_out <= not clk_out;
			else
				counter <= counter + 1;		
			end if;
		end if;
	end process;
	slow_clk <= clk_out;
	
end behave;