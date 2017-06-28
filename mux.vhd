library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
	port (
		clk : in std_logic;
		-- Graphic
		col : in integer range 0 to 799;
		row : in integer range 0 to 524;
		vga_addr : out integer range 0 to 4799;
		--Logic
		found : in std_logic;
		head_dir : in std_logic_vector(2 downto 0);
		head_x, tail_x, del_x, new_head_x, fruit_x : in integer range 0 to 79;
		head_y, tail_y, del_y, new_head_y, fruit_y : in integer range 0 to 59;
		ram_addr : out integer range 0 to 4799;
		data : out std_logic_vector(2 downto 0);
		we : out std_logic
	);
end mux;

architecture Behavioral of mux is

	signal state : integer range 0 to 5 := 0; -- 0:	read head,
															-- 1: read tail,
															-- 2: read fruit,
															-- 3: write head, 
															-- 4: delete tail,
															-- 5: write fruit
	signal counter : integer range 0 to 10 := 0;
	
begin

	process(clk)
	begin
		if clk'event and clk = '1' then
			if col <= 639 and row <= 479 then
				vga_addr <= (row/8)*80 + (col/8);
			end if;
		end if;
	end process;
			
	process(clk)
	begin
		if clk'event and clk = '1' then
			case state is
				when 0 =>
					ram_addr <= new_head_y*80 + new_head_x;
					we <= '0';
				when 1 =>
					ram_addr <= tail_y*80 + tail_x;
					we <= '0';
				when 2 =>
					ram_addr <= fruit_y*80 + fruit_x;
					we <= '0';
				when 3 =>
					ram_addr <= head_y*80 + head_x;
					data <= head_dir;
					we <= '1';
				when 4 =>
					ram_addr <= del_y*80 + del_x;
					data <= "000";
					we <= '1';
				when 5 =>
					if found = '1' then
						ram_addr <= fruit_y*80 + fruit_x;
						data <= "101";
						we <= '1';
					end if;
			end case;
		end if;
	end process;
	
	count : process(clk)
	begin
		if clk'event and clk = '1' then
			if counter = 5 then
				counter <= 1;
				if state = 5 then
					state <= 0;
				else
					state <= state + 1;
				end if;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;
	
end Behavioral;

