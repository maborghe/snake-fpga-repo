library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity snake is
	port (
		clk : in std_logic;
		up			: in std_logic;
		down		: in std_logic;
		left		: in std_logic;
		right		: in std_logic;
		hsync, vsync : out std_logic;
		r, g, b : out std_logic_vector(3 downto 0)
	);
end snake;

architecture structure of snake is
	
	component direction
		port(
			slow_clk : in std_logic;
			up			: in std_logic;
			down		: in std_logic;
			left		: in std_logic;
			right		: in std_logic;
			dir : out std_logic_vector(1 downto 0)
		);
	end component;
	component slow_clock
		port(
			clk		: in std_logic;
			slow_clk : out std_logic
		);
	end component;
	
	component vga
		port (
			clk 	: in 	std_logic;
			hsync, vsync, video : out std_logic;
			col 	: out integer range 0 to 799;
			row 	: out integer range 0 to 524
		);
	end component;
	
	component tail
		port (
			slow_clk : in std_logic;
			entry : in std_logic_vector(2 downto 0);
			addr_x : out integer range 0 to 79;
			addr_y : out integer range 0 to 59;
			del_x : out integer range 0 to 79;
			del_y : out integer range 0 to 59
		);
	end component;
	
	
	component head
		port (
			slow_clk : in std_logic;
			dir : in std_logic_vector(1 downto 0);
			head_x : out integer range 0 to 79;
			head_y : out integer range 0 to 59;
			head_dir : out std_logic_vector(2 downto 0)
		);
	end component;
	
	component mux
		port (
			clk, video : in std_logic;
			col : in integer range 0 to 799;
			row : in integer range 0 to 524;
			vga_addr : out integer range 0 to 4799;
			head_x, tail_x, del_x : in integer range 0 to 79;
			head_y, tail_y, del_y : in integer range 0 to 59;
			ram_addr : out integer range 0 to 4799;
			data : out std_logic_vector(2 downto 0);
			we : out std_logic
		);
	end component;
	
	component ram
		port (
		 clk : in  std_logic;
		 gph_addr : in  integer range 0 to 4799;
		 gph_out : out std_logic_vector(2 downto 0);
		 log_addr : in  integer range 0 to 4799;
		 data_in  : in  std_logic_vector(2 downto 0);
		 we : in  std_logic;
		 log_out : out std_logic_vector(2 downto 0)
		  );
	end component;
	
	component pixel
		port (
			clk, video : in std_logic;
			data : in std_logic_vector(2 downto 0);
			r, g, b : out std_logic_vector(3 downto 0)
		);
	end component;
	
	signal video, slow_clk : std_logic;
	signal col : integer range 0 to 799;
	signal row : integer range 0 to 524;
	signal gph_addr, log_addr : integer range 0 to 4799;
	signal head_x, tail_x, del_x : integer range 0 to 79;
	signal head_y, tail_y, del_y : integer range 0 to 59;
	signal head_dir, pixel_data, data, entry : std_logic_vector(2 downto 0);
	signal we : std_logic := '0';
	signal dir : std_logic_vector(1 downto 0);
begin
	
	t0 : slow_clock port map (clk, slow_clk);
	t01: direction port map(clk, up, down, left, right, dir);
	t1 : vga port map (clk, hsync, vsync, video, col, row);
	t2 : tail port map (clk, entry, tail_x, tail_y, del_x, del_y);
	t3 : head port map (clk, dir, head_x, head_y, head_dir);
	t4 : mux port map (clk, video, col, row, gph_addr, head_x, tail_x, del_x,
							head_y, tail_y, del_y, log_addr, data, we);
	t5 : ram port map (clk, gph_addr, pixel_data, log_addr, data, we, entry);
	t6 : pixel port map (clk, video, pixel_data, r, g, b);
	
end structure;