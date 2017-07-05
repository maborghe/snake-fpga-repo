library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tail is
	port (
		clk,counter_step,counter_9,reset, eaten : in std_logic;
		entry : in std_logic_vector(2 downto 0);
		addr, del : out integer range 0 to 4799
	);
end tail;

architecture behave of tail is
	signal dir : std_logic_vector(2 downto 0) := "010";
	signal tail_x : integer range 0 to 79 := 38;
	signal tail_y : integer range 0 to 59 := 29;
	
begin

	update : process(clk)
		variable save_x : integer range 0 to 79 := 38;
		variable save_y : integer range 0 to 59 := 29;
	begin
		if clk'event and clk = '1' then
			if reset = '1' then
				tail_x <= 38;
				tail_y <= 29;
				save_x := 38;
				save_y := 29;
				--counter <= 0;
			else
				if eaten = '0' then
					if counter_step = '1' then
						save_x := tail_x;
						save_y := tail_y;
						case dir is
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
					else
						if counter_9 = '1' then
							dir <= entry;
						end if;
					end if;
				end if;
			end if;
			del <= save_y*80 + save_x;
		end if;
		
	end process;
	addr <= tail_y*80 + tail_x;

	
end behave;
