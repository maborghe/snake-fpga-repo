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
	signal random_val_tmp	: integer range 0 to 4799 := 130;
	signal x_tmp : std_logic_vector (5 downto 0) := "001001";
	signal y_tmp : std_logic_vector (4 downto 0) := "00101";
	signal c : integer range 0 to 3 := 2;
	signal x, y: integer := 20;
	signal temp_found : std_logic := '0';
	signal fill : std_logic_vector (2 downto 0);
	
begin
	
	generate_fruit_addr : process (clk)
	begin
		if clk'event and clk = '1' then	
			if counter_8 = '1' and temp_found = '0' then 
				if c = 2 then
					c <= 1;
					x_tmp(5 downto 1) <= x_tmp(4 downto 0);
					x_tmp(0) <= not(x_tmp(5) xor x_tmp(4) xor x_tmp(3));
					y_tmp(4 downto 1) <= y_tmp(3 downto 0);
					y_tmp(0) <= not(y_tmp(4) xor y_tmp(1) xor y_tmp(0));	
					y <= to_integer(unsigned(y_tmp));		
					x <= to_integer(unsigned(x_tmp));
					case state_mod is
						when 0 =>											-- normal			
							if (not(y = 29 and x >= 29 and x <= 42)) then
								random_val_tmp <= y*80 + x;
							end if;
						when 1 =>											
							if(y = 29 and x >= 29 and x <= 42) and
								((x >= 1 and x <= 78) and (y >= 1 and y <= 58)) then
								random_val_tmp <= y*80 + x;
							end if;
						when 2 =>	
							if (y = 29 and x >= 29 and x <= 42) and
									not((x >= 15 and x <= 30) and (y >= 15 and y <= 43)) and--k
									not((x = 40) and (y >= 15 and y <= 43)) and--I
									not((x = 60) and (y >= 15 and y <= 43)) and--T
									not(( x >= 51 and x <= 70) and (y = 15))then--T
									random_val_tmp <= y*80 + x;
							end if;								
						end case;		
				else	
					c <= c + 1;	
				end if;
			end if;
		end if;
	end process;
	
	process (clk)
	begin
		if clk'event and clk = '1' then
			if eaten = '1' then
				if counter_30 = '1' then
					if temp_found = '0' then
						if fill = "000" then
							temp_found <= '1';
						end if;	
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
	random_val <= random_val_tmp;
end Behavioral;