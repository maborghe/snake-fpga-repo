library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity snake is
	port (
		clk 							: in std_logic;
		up, down, left, right	: in std_logic;
		hsync, vsync 				: out std_logic;
		r, g, b 						: out std_logic_vector(3 downto 0);
		led 							: out std_logic_vector(7 downto 0)
	);
end snake;

architecture structure of snake is
	
	component counter 
		port(
			clk, reset					: in std_logic;
			counter_step, counter_9 : out std_logic;
			counter_30, counter_14 	: out std_logic
		);
	end component;
	
	component direction
		port(
			clk, reset, up, down, left, right : in std_logic;
			dir 												: out std_logic_vector(1 downto 0)
		);
	end component;
	
	component fruit
		port (
			clk, eaten, counter_30, counter_14 : in std_logic;
			entry : in std_logic_vector(2 downto 0);
			found : out std_logic;
			random_x 					: out integer range 0 to 79;
			random_y						: out integer range 0 to 59
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
			clk,counter_step,counter_9,reset, eaten : in std_logic;
			entry : in std_logic_vector(2 downto 0);
			addr_x : out integer range 0 to 79;
			addr_y : out integer range 0 to 59;
			del_x : out integer range 0 to 79;
			del_y : out integer range 0 to 59
		);
	end component;
	
	
	component head
		port (
			clk, counter_step,reset : in std_logic;
			dir : in std_logic_vector(1 downto 0);
			head_x, new_head_x : out integer range 0 to 79;
			head_y, new_head_y : out integer range 0 to 59;
			head_dir : out std_logic_vector(2 downto 0)
		);
	end component;
	
	component collision
		port (
			clk : in std_logic;
			entry : in std_logic_vector(2 downto 0);
			eaten, reset : out std_logic;
			reset_counter : out integer range 0 to 4799
		);
	end component;
	
	component mux
		port (
			clk,reset : in std_logic;
			reset_counter : in integer range 0 to 4799;
			col : in integer range 0 to 799;
			row : in integer range 0 to 524;
			vga_addr : out integer range 0 to 4799;
			found : in std_logic;
			head_dir : in std_logic_vector(2 downto 0);
			head_x, tail_x, del_x, new_head_x, fruit_x : in integer range 0 to 79;
			head_y, tail_y, del_y, new_head_y, fruit_y : in integer range 0 to 59;
			ram_addr : out integer range 0 to 4799;
			data : out std_logic_vector(2 downto 0);
			we : out std_logic
		);
	end component;
	
	component ram
		port (
		 clk,reset : in  std_logic;
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
	
	component score
		port (
			clk, eaten : in std_logic;
			led : out std_logic_vector(7 downto 0)
		);
	end component;
	
	signal video, counter_step, counter_9, counter_30, counter_14 : std_logic;
	signal col : integer range 0 to 799;
	signal row : integer range 0 to 524;
	signal gph_addr, log_addr, reset_counter : integer range 0 to 4799;
	signal head_x, tail_x, del_x, new_head_x, fruit_x : integer range 0 to 79;
	signal head_y, tail_y, del_y, new_head_y, fruit_y : integer range 0 to 59;
	signal head_dir, pixel_data, data, entry : std_logic_vector(2 downto 0);
	signal we, eaten, reset, found : std_logic := '0';
	signal dir : std_logic_vector(1 downto 0);

begin
	m0 : counter port map (clk, reset, counter_step,counter_9, counter_30, counter_14);
	m1: direction port map(clk,reset, up, down, left, right, dir);
	m2 : fruit port map (clk,eaten, counter_30, counter_14, entry, found, fruit_x, fruit_y);
	m3 : vga port map (clk, hsync, vsync, video, col, row);
	m4 : tail port map (clk, counter_step,counter_9, reset,eaten, entry, tail_x, tail_y, del_x, del_y);
	m5 : head port map (clk,counter_step, reset, dir, head_x, new_head_x, head_y, new_head_y, head_dir);
	m6 : collision port map (clk, entry, eaten, reset, reset_counter);
	m7 : mux port map (clk,reset,reset_counter, col, row, gph_addr, found, head_dir, head_x, tail_x, del_x,
							new_head_x,	fruit_x, head_y, tail_y, del_y, new_head_y, fruit_y, log_addr, data, we);
	m8 : ram port map (clk,reset, gph_addr, pixel_data, log_addr, data, we, entry);
	m9 : pixel port map (clk, video, pixel_data, r, g, b);
	m10 : score port map (clk, eaten, led);
	
end structure;