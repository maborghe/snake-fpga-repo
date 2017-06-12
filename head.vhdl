library ieee;
use ieee.std_logic_1164.all;

entity head is
  port (
    slow_clk : in std_logic;
    dir : in std_logic_vector(1 downto 0);
    head_x : out integer range 0 to 63;
    head_y : out integer range 0 to 47;
    head_dir : out integer range 1 to 4
  );
end head;


architecture behave of head is

  signal x_val : integer range 0 to 63 := 33;
  signal y_val : integer range 0 to 47 := 23;
  
begin
  
  move : process(slow_clk)
  begin
      if slow_clk'event and slow_clk = '1' then
          case dir is
              when "01" => head_dir <= 1;
                  if y_val = 0 then
                      y_val <= 47;
                  else
                      y_val <= y_val - 1;
                  end if;
                  
              when "10" => head_dir <= 2;
                  if x_val = 63 then
                      x_val <= 0;
                  else
                      x_val <= x_val + 1;
                  end if;
                  
              when "11" => head_dir <= 3;
                  if y_val = 47 then
                      y_val <= 0;
                  else
                      y_val <= y_val + 1;
                  end if;
                  
              when others => head_dir <= 4;
                    if x_val = 0 then
                        x_val <= 63;
                    else
                        x_val <= x_val - 1;
                    end if;
                    
          end case;
      end if;
      
  end process;
  
  head_x <= x_val;
  head_y <= y_val;
end behave;