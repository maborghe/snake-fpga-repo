library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vga_driver is
	port (
		clk : in std_logic;
		hsync, vsync : out std_logic;
		r, g, b : out std_logic_vector(3 downto 0)
	);
end vga_driver;

architecture structure of vga_driver is

	component sync 
		port (
			clk 	: in 	std_logic;
			hsync, vsync, video : out std_logic;
			col 	: out integer range 0 to 799;
			row 	: out integer range 0 to 524
		);
	end component;
	
	component snake
		port (
			clk, video : in std_logic;
			col : in integer range 0 to 799;
			row : in integer range 0 to 524;
			dir : in std_logic_vector(1 downto 0);
			value : out integer range -1 to 4
		);
	end component;
	
	component graphic_unit
		port (
			clk : in std_logic;
			value : in integer range -1 to 4;
			r, g, b : out std_logic_vector(3 downto 0)
		);
	end component;
	
	signal video : std_logic;
	signal col : integer range 0 to 799 := 0;
	signal row : integer range 0 to 524 := 0;
	signal value : integer range -1 to 4;
	
begin
	
	mySync : sync port map(clk, hsync, vsync, video, col, row);
	mySnake : snake port map(clk, video, col, row, "10", value);
	myGraphicUnit : graphic_unit port map(clk, value, r, g, b);

end structure;