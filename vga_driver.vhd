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

	component pixel
		port (
			clk : in std_logic;
			video : in std_logic;
			col : in integer range 0 to 799;
			row : in integer range 0 to 524;
			r : out std_logic_vector(3 downto 0);
			g : out std_logic_vector(3 downto 0);
			b : out std_logic_vector(3 downto 0)
		);
	end component;

	signal s0 : integer range 0 to 799;
	signal s1 : integer range 0 to 524;
	signal s2 : std_logic := '0';

begin
	t1 : sync port map (clk, hsync, vsync, s2, s0, s1);
	t2 : pixel port map (clk, s2, s0, s1, r, g, b);

end structural;
