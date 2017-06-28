library ieee;
use ieee.std_logic_1164.all;

entity head is
	port (
		clk : in std_logic;
		dir : in std_logic_vector(1 downto 0);
		head_x, new_head_x : out integer range 0 to 79;
		head_y, new_head_y : out integer range 0 to 59;
		head_dir : out std_logic_vector(2 downto 0)
	);
end head;


architecture behave of head is
	signal x_val : integer range 0 to 79 := 7;
	signal y_val : integer range 0 to 59 := 0;
	constant num : integer := 6293760; --6293760
	signal counter : integer := 0;
	
begin
  
	move : process(clk)
		variable last_head_x : integer range 0 to 79 := 6;
		variable last_head_y : integer range 0 to 59 := 0;
	begin
		if clk'event and clk = '1' then	
			if counter = num then
				counter <= 1;
				last_head_x := x_val;
				last_head_y := y_val;
				case dir is
					when "01" => head_dir <= "001";
						if y_val = 0 then
							y_val <= 59;
						else
							y_val <= y_val - 1;
						end if;
							
					when "10" => head_dir <= "010";
						if x_val = 79 then
							x_val <= 0;
						else
							x_val <= x_val + 1;
						end if;
							
					when "11" => head_dir <= "011";
						if y_val = 59 then
							y_val <= 0;
						else
							y_val <= y_val + 1;
						end if;
							
					when others => head_dir <= "100";
						if x_val = 0 then
							x_val <= 79;
						else
							x_val <= x_val - 1;
						end if;       
				end case;
			else
				counter <= counter + 1;		
			end if;
			head_x <= last_head_x;
			head_y <= last_head_y;
			new_head_x <= x_val;
			new_head_y <= y_val;
		end if;
		
	end process;

end behave;