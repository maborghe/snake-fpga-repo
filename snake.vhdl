library ieee;
use ieee.std_logic_1164.all;

entity snake is
    port (
		col : in integer range 0 to 79;
		row : in integer range 0 to 59;
		video_on : in std_logic;
		clk : in std_logic;
		slow_clk : in std_logic;
		dir : in std_logic_vector(1 downto 0);
		value : out integer range 0 to 4
    );
end snake;

architecture structure of snake is
    component head
      port (
			slow_clk : in std_logic;
			dir : in std_logic_vector(1 downto 0);
			head_x : out integer range 0 to 79;
			head_y : out integer range 0 to 59;
			head_dir : out integer range 1 to 4
		);
    end component;
    
    component grid
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
    end component;
    
    signal s0 : integer range 0 to 79;
    signal s1 : integer range 0 to 59;
    signal s2 : integer range 1 to 4;
  
begin
  
    t1 : head port map (slow_clk, dir, s0, s1, s2);
    t2 : grid port map (col, row, video_on, clk, slow_clk, s0, s1, s2, 0, 0, value);
end structure;
