library ieee;
use ieee.std_logic_1164.all;

entity head is
	port(
		clk, counter_step, reset	: in std_logic;
		dir 								: in std_logic_vector(1 downto 0);
		head, new_head 				: out integer range 0 to 4799;
		head_dir 						: out std_logic_vector(2 downto 0)
	);
end head;

architecture behave of head is
	signal x_val : integer range 0 to 79 := 47;
	signal y_val : integer range 0 to 59 := 29;
	signal head_dir_temp : std_logic_vector(2 downto 0) := "010";
	
begin
  
	move : process(clk)
		variable last_head_x : integer range 0 to 79 := 46;
		variable last_head_y : integer range 0 to 59 := 29;
	begin
		if clk'event and clk = '1' then
			if reset = '1' then
				x_val <= 47;
				y_val <= 29;
				last_head_x := 46;
				last_head_y := 29;
				head_dir_temp <= "010";
			else 
				if counter_step = '1' then
					last_head_x := x_val;
					last_head_y := y_val;
					case dir is
						when "01" => head_dir_temp <= "001";
							if y_val = 0 then
								y_val <= 59;
							else
								y_val <= y_val - 1;
							end if;
								
						when "10" => head_dir_temp <= "010";
							if x_val = 79 then
								x_val <= 0;
							else
								x_val <= x_val + 1;
							end if;
								
						when "11" => head_dir_temp <= "011";
							if y_val = 59 then
								y_val <= 0;
							else
								y_val <= y_val + 1;
							end if;
								
						when others => head_dir_temp <= "100";
							if x_val = 0 then
								x_val <= 79;
							else
								x_val <= x_val - 1;
							end if;       
					end case;
				end if;
			end if;
			head_dir <= head_dir_temp;
			head <= last_head_y*80 + last_head_x;
			new_head <= y_val*80 + x_val;
		end if;
	end process;

end behave;