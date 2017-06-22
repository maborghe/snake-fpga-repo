library ieee;
use ieee.std_logic_1164.all;

entity head is
	port (
		slow_clk : in std_logic;
		dir : in std_logic_vector(1 downto 0);
		head_x : out integer range 0 to 79;
		head_y : out integer range 0 to 59;
		head_dir : out std_logic_vector(2 downto 0)
	);
end head;


architecture behave of head is
	signal x_val : integer range 0 to 79 := 50;
	--signal x_val : integer range 0 to 79 := 56;
	signal y_val : integer range 0 to 59 := 30;
  
begin
  
	move : process(slow_clk)
	begin
		if slow_clk'event and slow_clk = '1' then
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
		end if;
	end process;
	
	head_x <= x_val;
	head_y <= y_val;
end behave;