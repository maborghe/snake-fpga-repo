library ieee;
use ieee.std_logic_1164.all;

entity grid is
  port (
    slow_clk : in std_logic; -- jede Sekunde oder so
    head_x : in integer range 0 to 63;
    head_y : in integer range 0 to 47;
    head_dir : in integer range 1 to 4;
    apple_x : in integer range 0 to 63;
    apple_y : in integer range 0 to 47
  );
end grid;

architecture behave of grid is
  
  type matrix_row is array (0 to 47) of integer range 0 to 4;
  type matrix is array (0 to 63) of matrix_row;	
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
       -- Schlange wächst
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
  
end behave;	