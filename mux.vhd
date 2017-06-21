library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
	port (
		clk, video : in std_logic;
		vga_col : in integer range 0 to 799;
		vga_row : in integer range 0 to 524;
		ram_addr : out integer range 0 to 4799;
		we : out std_logic
	);
end mux;

architecture Behavioral of mux is
	
	
begin

	process(clk)
	begin
		if clk'event and clk = '1' then
			if video = '1' then
				ram_addr <= (vga_row/8)*80 + (vga_col/8);
				we <= '0';			
			end if;
		end if;
	end process;

end Behavioral;

