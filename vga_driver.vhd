library ieee;
use ieee.std_logic_1164.all;

entity vga_driver is
	port (
		clk 	: in 	std_logic;
		hsync : out std_logic;
		vsync : out std_logic;
		r 		: out std_logic_vector(3 downto 0);
		g 		: out std_logic_vector(3 downto 0);
		b 		: out std_logic_vector(3 downto 0)
		);
end vga_driver;

architecture structural of vga_driver is

	component slow_clock
		port (
			clk  : in  std_logic;
			slow_clk : out std_logic
		);
	end component;
	
	
	component sync
		port (
			clk : in std_logic;
			hsync : out std_logic;
			vsync : out std_logic;
			video : out std_logic;
			col : out integer range 0 to 799;
			row : out integer range 0 to 524
		);
	end component;

	component snake
		port (
			col : in integer range 0 to 79;
			row : in integer range 0 to 59;
			video_on : in std_logic;
			clk : in std_logic;
			slow_clk : in std_logic;
			dir : in std_logic_vector(1 downto 0);
			value : out integer range 0 to 4
		);
	end component;
	
	component graphic_unit 
		port (
			clk : in std_logic;
			value : in integer range 0 to 4;
			r : out std_logic_vector(3 downto 0);
			g : out std_logic_vector(3 downto 0);
			b : out std_logic_vector(3 downto 0)
		);
	end component;
	 
	signal col : integer range 0 to 799;
	signal row : integer range 0 to 524;
	signal video : std_logic;
	signal slow_clk : std_logic;
	signal value : integer range 0 to 4;

begin
	t1 : sync port map (clk, hsync, vsync, video, col, row);
	t2 : slow_clock port map (clk, slow_clk);
	t3 : snake port map (col, row, video, clk, slow_clk, "10", value);
	t4 : graphic_unit port map (clk, value, r, g, b);
	
end structural;
