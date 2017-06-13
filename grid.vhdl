library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity grid is
  port (
		col : in integer range 0 to 79;
		row : in integer range 0 to 59;
		video_on : in std_logic;
		clk : in std_logic;
		slow_clk : in std_logic; -- jede Sekunde oder so
		head_x : in integer range 0 to 79;
		head_y : in integer range 0 to 59;
		head_dir : in integer range 1 to 4;
		apple_x : in integer range 0 to 79;
		apple_y : in integer range 0 to 59;
		value : out integer range 0 to 4
  );
end grid;

architecture behave of grid is
  
  type matrix_row is array (0 to 59) of integer range 0 to 4;
  type matrix is array (0 to 79) of matrix_row;	
  signal grid : matrix := (30 to 33 => (23 => 2, others => 0), others => (others => 0));
                          
  signal tail_x : integer := 30;
  signal tail_y : integer := 23;
  
begin

  move : process (slow_clk)
    variable tail_dir : integer range 0 to 4 := 1;
  begin
    if (slow_clk'event and slow_clk = '1') then
      if head_x = apple_x and head_y = apple_y then
       grid(head_x)(head_y) <= 1;
       -- Schlange wchst
      elsif grid(head_x)(head_y) = 1 then
       -- Schlange stirbt
      else
       -- Normale Bewegung
       tail_dir := grid(tail_x)(tail_y);
       grid(head_x)(head_y) <= head_dir;
       grid(tail_x)(tail_y) <= 0;
       case tail_dir is 
         when 1 => tail_y <= tail_y - 1;
           
         when 2 => tail_x <= tail_x + 1;
           
         when 3 => tail_y <= tail_y + 1;
          
         when others => tail_x <= tail_x - 1;
           
       end case;
       
      end if;
    end if;
    
  end process;
  
  
	draw : process(clk)
		variable x : unsigned (10 downto 0);
		variable y : unsigned (9 downto 0);
	begin
		if (clk'event and clk = '1') then
			if video_on = '1' then
				x := to_unsigned(col, 11);
				y := to_unsigned(row, 10);
				x := x srl 3;
				y := y srl 3;
				value <= grid(to_integer(x))(to_integer(y));
			end if;
		end if;
	end process;
  
end behave;	