library ieee;
use ieee.std_logic_1164.all;

entity grid is
  port (
		clk, slow_clk, video : in std_logic;
		col : in integer range 0 to 799;
		row : in integer range 0 to 524;
		head_x : in integer range 0 to 79;
		head_y : in integer range 0 to 59;
		head_dir : in integer range 1 to 4;
		value : out integer range -1 to 4
  );
end grid;

architecture behave of grid is

  type matrix_row is array (0 to 59) of integer range 0 to 4;
  type matrix is array (0 to 79) of matrix_row;	
  signal grid : matrix := (30 to 33 => (23 => 2, others => 0), others => (others => 0));
                          
  signal tail_x : integer range 0 to 79 := 30;
  signal tail_y : integer range 0 to 59 := 23;
  
begin

	move : process (slow_clk)
		variable tail_dir : integer range 0 to 4 := 1;
		variable old_tail_x : integer range 0 to 79;
		variable old_tail_y : integer range 0 to 59;
	begin
		if (slow_clk'event and slow_clk = '1') then
			-- Normale Bewegung
			tail_dir := grid(tail_x)(tail_y);
			old_tail_x := tail_x;
			old_tail_y := tail_y;
			grid(head_x)(head_y) <= head_dir;
			grid(old_tail_x)(old_tail_y) <= 0;
			case tail_dir is 
				when 1 => 
					if tail_y = 0 then
						tail_y <= 59;
					else
						tail_y <= tail_y - 1;
					end if;
				when 2 => 
					if tail_x = 79 then
						tail_x <= 0;
					else	
						tail_x <= tail_x + 1;
					end if;
				when 3 =>
					if tail_y = 59 then
						tail_y <= 0;
					else
						tail_y <= tail_y + 1;
					end if;
				when others =>
					if tail_x = 0 then
						tail_x <= 79;
					else
						tail_x <= tail_x - 1; 
					end if;
			end case;
		end if;
	end process;
  
	draw : process(clk)	
	begin
		if (clk'event and clk = '1') then
			if video = '1' then	
				value <= grid(col / 8)(row / 8);
			else
				value <= -1;
			end if;
		end if;
	end process;
  
end behave;