library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity snake is
	port (
		clk, video : in std_logic;
		col : in integer range 0 to 799;
		row : in integer range 0 to 524;
		dir : in std_logic_vector(1 downto 0);
		value : out integer range -1 to 4
	);
end snake;

architecture structure of snake is
	
	component slow_clock
		port (
			clk  : in  std_logic;
			slow_clk : out std_logic
		);
	end component;
	
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
			clk, slow_clk, video : in std_logic;
			col : in integer range 0 to 799;
			row : in integer range 0 to 524;
			head_x : in integer range 0 to 79;
			head_y : in integer range 0 to 59;
			head_dir : in integer range 1 to 4;
			value : out integer range -1 to 4
		);
	end component;
	
	signal slow_clk : std_logic;
	signal head_x : integer range 0 to 79;
	signal head_y : integer range 0 to 59;
	signal head_dir : integer range 1 to 4;
	
begin

	mySlowClock : slow_clock port map(clk, slow_clk);
	myHead : head port map(slow_clk, dir, head_x, head_y, head_dir);
	myGrid : grid port map(clk, slow_clk, video, col, row, head_x, head_y, head_dir, value);
	
end structure;

