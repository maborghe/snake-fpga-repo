library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity snake is
	port (
		clk, sw4							: in std_logic;
		up, down, left, right	: in std_logic;
		hsync, vsync 				: out std_logic;
		r, g, b 						: out std_logic_vector(3 downto 0);
		led 							: out std_logic_vector(7 downto 0)
	);
end snake;

architecture structure of snake is
	
	component collision
		port (
			clk, counter_4, counter_step : in std_logic;
			entry : in std_logic_vector(2 downto 0);
			eaten, game_over : out std_logic
		);
	end component;
	
	component counter 
		port(
			clk, reset					: in std_logic;
			counter_step, counter_4, counter_9 : out std_logic;
			counter_30, counter_14,  counter_8 	: out std_logic;
			counter_reset 	: out std_logic
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
			clk, eaten, counter_30, counter_14, counter_8 : in std_logic;
			entry : in std_logic_vector(2 downto 0);
			state_mod : in integer range 0 to 2;
			found : out std_logic;
			random_val					: out integer range 0 to 4799
		);
	end component;
	
	component head
		port (
			clk, counter_step,reset : in std_logic;
			dir : in std_logic_vector(1 downto 0);
			head, new_head 	: out integer range 0 to 4799;
			head_dir : out std_logic_vector(2 downto 0)
		);
	end component;
	
	component mux
		port (
			clk,reset : in std_logic;
			found : in std_logic;
			reset_data, head_dir : in std_logic_vector(2 downto 0);
			reset_addr, head_addr, tail_addr, del_addr, new_head_addr, fruit_addr : in integer range 0 to 4799;
			ram_addr : out integer range 0 to 4799;
			data : out std_logic_vector(2 downto 0);
			we : out std_logic
		);
	end component;
	
	component pixel
		port (
			clk, video, reset : in std_logic;
			data : in std_logic_vector(2 downto 0);
			vga_addr : in integer range 0 to 4799;
			r, g, b : out std_logic_vector(3 downto 0)
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
	
	component score
		port (
			clk, eaten : in std_logic;
			led : out std_logic_vector(7 downto 0)
		);
	end component;
	
	component state_machine
		port (
			clk, sw4, game_over : in std_logic;
			fruit_addr : in integer range 0 to 4799;
			reset : out std_logic;
			data : out std_logic_vector(2 downto 0);
			address : out integer range 0 to 4799;
			state_mod : out integer range 0 to 2
		);
	end component;
	
	component tail
		port (
			clk,counter_step,counter_9,reset, eaten : in std_logic;
			entry : in std_logic_vector(2 downto 0);
			addr, del : out integer range 0 to 4799
		);
	end component;
	
	component vga
		port (
			clk 	: in 	std_logic;
			hsync, vsync, video : out std_logic;
			vga_addr : out integer range 0 to 4799
		);
	end component;
	
	signal gph_addr, log_addr, reset_addr, head_addr, tail_addr,
				del_addr, new_head_addr, fruit_addr : integer range 0 to 4799;
	signal head_dir, pixel_data, reset_data, ram_data, entry : std_logic_vector(2 downto 0);
	signal video, counter_step, counter_4, counter_9,counter_8, counter_30, counter_14,counter_reset,
				we, eaten, game_over, reset, found : std_logic := '0';
	signal dir : std_logic_vector(1 downto 0);
	signal state_mod : integer range 0 to 2;
begin

	m0 : counter port map (clk, reset, counter_step, counter_4, counter_9, counter_30, counter_14, counter_8, counter_reset);
	m1: direction port map(clk,reset, up, down, left, right, dir);
	m2 : fruit port map (clk,eaten, counter_30, counter_14,counter_8, entry,state_mod, found, fruit_addr);
	m3 : vga port map (clk, hsync, vsync, video, gph_addr);
	m4 : tail port map (clk, counter_step,counter_9, reset,eaten, entry, tail_addr, del_addr);
	m5 : head port map (clk,counter_step, reset, dir, head_addr, new_head_addr, head_dir);
	m6 : collision port map (clk, counter_4, counter_step, entry, eaten, game_over);
	m7 : mux port map (clk, reset, found, reset_data, head_dir, reset_addr, head_addr, tail_addr, del_addr,
							new_head_addr,	fruit_addr, log_addr, ram_data, we);
	m8 : ram port map (clk,reset, gph_addr, pixel_data, log_addr, ram_data, we, entry);
	m9 : pixel port map (clk, video, reset, pixel_data, gph_addr, r, g, b);
	m10 : score port map (clk, eaten, led);
	m11 : state_machine port map (clk, sw4, game_over, fruit_addr, reset, reset_data, reset_addr,state_mod);
	
end structure;