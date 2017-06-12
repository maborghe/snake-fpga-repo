library ieee;
use ieee.std_logic_1164.all;

entity snake is
    port (
        slow_clk : in std_logic;
        dir : in std_logic_vector(1 downto 0)
    );
end snake;

architecture structure of snake is
    component head
        port (
        slow_clk : in std_logic;
        dir : in std_logic_vector(1 downto 0);
        head_x : out integer range 0 to 63;
        head_y : out integer range 0 to 47;
        head_dir : out integer range 1 to 4
      );
    end component;
    
    component grid
        port (
        slow_clk : in std_logic; -- jede Sekunde oder so
        head_x : in integer range 0 to 63;
        head_y : in integer range 0 to 47;
        head_dir : in integer range 1 to 4;
        apple_x : in integer range 0 to 63;
        apple_y : in integer range 0 to 47
      );
    end component;
    
    signal s0 : integer range 0 to 63;
    signal s1 : integer range 0 to 47;
    signal s2 : integer range 1 to 4;
  
begin
  
    t1 : head port map (slow_clk, "10", s0, s1, s2);
    t2 : grid port map (slow_clk, s0, s1, s2, 0, 0);
end structure;
