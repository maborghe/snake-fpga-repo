library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
	port (
		clk, video : in std_logic;
		-- Graphic
		col : in integer range 0 to 799;
		row : in integer range 0 to 524;
		vga_addr : out integer range 0 to 4799;
		--Logic
		head_x, tail_x, del_x : in integer range 0 to 79;
		head_y, tail_y, del_y : in integer range 0 to 59;
		ram_addr : out integer range 0 to 4799;
		data : out std_logic_vector(2 downto 0);
		we : out std_logic
	);
end mux;

architecture Behavioral of mux is

	signal state : integer range 0 to 2 := 0; -- 0: read tail, 
															-- 1: write head, 
															-- 2: delete tail
	
begin

	process(clk)
	begin
		if clk'event and clk = '1' then
			if video = '1' then
				vga_addr <= (row/8)*80 + (col/8);
			end if;
		end if;
	end process;
			
	process(clk)
	begin
		if clk'event and clk = '1' then
			case state is
				when 0 =>
					ram_addr <= tail_y*80 + tail_x;
					we <= '0';
					state <= 1;
				when 1 => 
					ram_addr <= head_y*80 + head_x;
					data <= "010";
					we <= '1';
					state <= 2;
				when 2 =>
					ram_addr <= del_y*80 + del_x;
					data <= "101";
					we <= '1';
					state <= 0;
			end case;
		end if;
	end process;
	
end Behavioral;

