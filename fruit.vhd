library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fruit is
	port(
		clk, eaten 	: in std_logic;
		entry : in std_logic_vector(2 downto 0);
		random_x : out integer range 0 to 79;
		random_y : out integer range 0 to 59
	);
end fruit;

architecture behavioral of fruit is

	signal found : std_logic  := '0';
	signal x_temp : std_logic_vector (7 downto 0) := (others => '0');
	signal y_temp : std_logic_vector (7 downto 0) := (others => '0');
	signal x2_temp : std_logic_vector (7 downto 0) := (others => '0');
	signal y2_temp : std_logic_vector (7 downto 0) := (others => '0');
	signal x : integer := 0;
	signal y : integer := 0;
	signal counter : integer := 0;
	signal fill : std_logic_vector(2 downto 0) := "000";

	
begin
	generate_numbers: process(clk) is
	begin
		if clk'event and clk = '1' then
			if eaten = '1' or found = '0' then 
				x_temp(7 downto 1) <= x_temp(6 downto 0);
				x_temp(0) <= not(x_temp(7) xor x_temp(6) xor x_temp(4));
				y_temp(7 downto 1) <= y_temp(6 downto 0);
				y_temp(0) <= not(y_temp(5) xor y_temp(2) xor y_temp(0));	
				x2_temp(7) <= '0';
				x2_temp(6) <= '0';
				y2_temp(7) <= '0';
				y2_temp(6) <= '0';
				x <= to_integer(unsigned(x2_temp));
				y <= to_integer(unsigned(y2_temp));
			end if;
		end if;
	end process;
	
	x2_temp <= x_temp;
	y2_temp <= y_temp;
				
	output_filter: process(clk) is
		variable taken : std_logic:= '1';
	begin
		if clk'event and clk = '1' then
			if counter = 25 then
				counter <= 1;
				if eaten = '1' or taken = '1' then
						if fill = "000" and y <= 59 then
							random_x <= x;
							random_y	<= y;
							found <= '0';
						else
							found <= '1';
						end if;
				else
					counter <= counter + 1;		
					if counter = 14 then
						fill <= entry;
					end if;
				end if;
			end if;
		end if;
	end process;

end behavioral;