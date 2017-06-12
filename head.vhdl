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
              when "01" => y_val <= y_val - 1;
              when "10" => x_val <= x_val + 1;
              when "11" => y_val <= y_val + 1;
              when others => x_val <= x_val -1;
          end case;
      end if;
      
  end process;
  
  head_x <= x_val;
  head_y <= y_val;
end behave;