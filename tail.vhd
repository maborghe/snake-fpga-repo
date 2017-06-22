library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tail is
	port (
		slow_clk : in std_logic;
		entry : in std_logic_vector(2 downto 0);
		addr_x : out integer range 0 to 79;
		addr_y : out integer range 0 to 59;
		del_x : out integer range 0 to 79;
		del_y : out integer range 0 to 59
	);
end tail;

architecture behave of tail is
	signal dir : std_logic_vector(2 downto 0);
	signal tail_x : integer range 0 to 79 := 1;
	signal tail_y : integer range 0 to 59 := 5;
begin

	update : process(slow_clk)
	variable save_x : integer range 0 to 79 := 1;
	variable save_y : integer range 0 to 59 := 5;
	begin
		if slow_clk'event and slow_clk = '1' then
			save_x := tail_x;
			save_y := tail_y;
			case entry is
				when "001" => 
					if tail_y = 0 then
						tail_y <= 59;
					else
						tail_y <= tail_y - 1;
					end if;
				when "100" => 
					if tail_x = 0 then
						tail_x <= 79;
					else
						tail_x <= tail_x - 1; 
					end if;
				when "011" =>
					if tail_y = 59 then
						tail_y <= 0;
					else
						tail_y <= tail_y + 1;
					end if;
				when others =>
					if tail_x = 79 then
						tail_x <= 0;
					else	
						tail_x <= tail_x + 1;
					end if;
			end case;
		end if;
		del_x <= save_x;
		del_y <= save_y;
	end process;
	addr_x <= tail_x;
	addr_y <= tail_y;
	
end behave;
