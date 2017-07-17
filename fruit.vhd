library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fruit is
	port(
		clk, eaten, counter_30, counter_14, counter_8	: in std_logic;
		entry 						: in std_logic_vector(2 downto 0);
		state_mod 					: in integer range 0 to 2;
		found 						: out std_logic;
		random_val					: out integer range 0 to 4799
	);
end fruit;

architecture Behavioral of fruit is
	
	--signal x_temp, y_temp, x2_temp, y2_temp : std_logic_vector (7 downto 0) := (others => '0');
	signal x_temp, y_temp, x2_temp, y2_temp : std_logic_vector (7 downto 0) := "00000001";
	signal counter : integer := 0;
	signal x, y: integer range 0 to 64 := 10;
	signal temp_found : std_logic := '0';
	signal fill : std_logic_vector (2 downto 0);
	
begin
	
	generate_number : process (clk)
	begin
		if clk'event and clk = '1' then
		--no counter_8 = '1'
			if temp_found = '0' then
				
				x_temp(7 downto 1) <= x_temp(6 downto 0);
				x_temp(0) <= not(x_temp(7) xor x_temp(6) xor x_temp(4));
				y_temp(7 downto 1) <= y_temp(6 downto 0);
				y_temp(0) <= not(y_temp(6) xor y_temp(5) xor y_temp(3));	
			
				x2_temp <= x_temp;
				y2_temp <= y_temp;
				x2_temp(7) <= '0';
				x2_temp(6) <= '0';
				y2_temp(7) <= '0';
				y2_temp(6) <= '0';
				x <= to_integer(unsigned(x2_temp));
				y <= to_integer(unsigned(y2_temp));
			end if;
		end if;
	end process;
	
	
	process (clk)
	begin
		if clk'event and clk = '1' then
			if eaten = '1' then
				if counter_30 = '1' then
					if temp_found = '0' then
						
						case state_mod is
						when 0 =>											-- normal			
							if (fill = "000" and y <= 59) and 			-- empty field
								not(y = 29 and x >= 29 and x <= 42) then
								random_val <= y*80 + x;
								temp_found <= '1';
							end if;
						when 1 =>											
							if (fill = "000" and y <= 59) and 	
								not(y = 29 and x >= 29 and x <= 42) and
								not((x >= 0 or x<= 79) or (y >= 0 or y <= 59)) then
								random_val <= y*80 + x;
								temp_found <= '1';
								
							end if;
						when 2 =>											-- TODO apple
							if (fill = "000" and y <= 59) and 			-- empty field
								not(y = 29 and x >= 29 and x <= 42) then
								temp_found <= '1';
							end if;
					end case;

						
						
					end if;
				else
					if counter_14 = '1' then
						fill <= entry;
					end if;
				end if;
			else
				temp_found <= '0';
			end if;
		end if;
	end process;
	found <= temp_found;
	
end Behavioral;