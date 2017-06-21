library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity snake is
	port (
		clk : in std_logic;
		hsync, vsync : out std_logic;
		r, g, b : out std_logic_vector(3 downto 0)
	);
end snake;

architecture structure of snake is
	
	component vga
		port (
			clk 	: in 	std_logic;
			hsync, vsync, video : out std_logic;
			col 	: out integer range 0 to 799;
			row 	: out integer range 0 to 524
		);
	end component;
	
	component mux
		port (
			clk, video : in std_logic;
			vga_col : in integer range 0 to 799;
			vga_row : in integer range 0 to 524;
			ram_addr : out integer range 0 to 4799;
			we : out std_logic
		);
	end component;
	
	component ram
		port (
		 clk   : in  std_logic;
		 we      : in  std_logic;
		 address : in  integer range 0 to 4799;
		 data_in  : in  std_logic_vector(2 downto 0);
		 data_out : out std_logic_vector(2 downto 0)
	  );
	end component;
	
	component pixel
		port (
			clk, video : in std_logic;
			data : in std_logic_vector(2 downto 0);
			r, g, b : out std_logic_vector(3 downto 0)
		);
	end component;
	
	signal video : std_logic;
	signal col : integer range 0 to 799;
	signal row : integer range 0 to 524;
	signal ram_addr : integer range 0 to 4799;
	signal we : std_logic;
	signal data : std_logic_vector(2 downto 0);
	
begin

	t1 : vga port map (clk, hsync, vsync, video, col, row);
	t2 : mux port map (clk, video, col, row, 
							ram_addr, we);
	t3 : ram port map (clk, we, ram_addr, "000", data);
	t4 : pixel port map (clk, video, data, r, g, b);
	
end structure;

