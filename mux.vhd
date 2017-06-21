library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
	port (
		clk, video : in std_logic;
		vga_col : in integer range 0 to 799;
		vga_row : in integer range 0 to 524;
		tail_addr, head_addr : in integer range 0 to 4799;
		data : out std_logic_vector(2 downto 0);
		ram_addr : out integer range 0 to 4799;
		we : out std_logic
	);
end mux;

architecture Behavioral of mux is
	
	signal i : integer range 0 to 59 := 0;
	signal state : integer range 0 to 3 := 0; -- 0 : idle
	
begin

	process(clk)
	begin
		if clk'event and clk = '1' then
			if video = '1' then
				ram_addr <= (vga_row/8)*80 + (vga_col/8);
				we <= '0';
			elsif state = 1 then
				ram_addr <= tail_addr; -- read tail direction
				we <= '0';
				state <= state + 1;
			elsif state = 2 then
				ram_addr <= head_addr; -- write new head
				data <= "010";
				we <= '1';
				state <= state + 1;
			elsif state = 3 then
				ram_addr <= tail_addr; -- delete old tail
				data <= "000";
				we <= '1';
				state <= 0;
			end if;
		end if;
	end process;


	inc : process(clk)
	begin
		if clk'event and clk = '1' then
			if vga_col = 640 and vga_row = 480 then -- 60 mal pro Sekunde
				if i = 59 then -- 1 mal pro Sekunde
					i <= 0;
					state <= 1; -- Erlaube Zugriffe
				else
					i <= i +1;
				end if;
			end if;
		end if;
	end process;
	
end Behavioral;

