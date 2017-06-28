library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pseudo_random_generator is
	port(
		clk 		: in std_logic;
		random_x : out integer range 0 to 79;
		random_y : out integer range 0 to 59
	);
end pseudo_random_generator;

architecture behavioral of pseudo_random_generator is

	signal x_temp : std_logic_vector (7 downto 0) := (others => '0');
	signal y_temp : std_logic_vector (7 downto 0) := (others => '0');
	signal x : integer := 0;
	signal y : integer := 0;
begin
	generate_numbers: process(clk) is
	begin
		if clk'event and clk = '1' then
			x_temp(7 downto 1) <= x_temp(6 downto 0);
			x_temp(0) <= not(x_temp(7) xor x_temp(6) xor x_temp(4));
			y_temp(7 downto 1) <= y_temp(6 downto 0);
			y_temp(0) <= not(y_temp(7) xor y_temp(6) xor y_temp(4));	
			x_temp(7) <= '0';
			y_temp(6) <= '0';
			y_temp(7) <= '0';
			x <= to_integer(unsigned(x_temp));
			y <= to_integer(unsigned(y_temp));
		end if;
	end process;
	
	output_filter: process(x, y) is
	begin
		if x >= 0 and x <= 79 and y >= 0 and y <= 59 then
			random_x <= x;
			random_y	<= y;
		end if;
	end process;

end behavioral;

	--linear feedback shift register vs kongruenzgenerator
	--float y2 = 0;
	--float x2 = 0; 
	--for (int y = 0; y < 64; y++) {
	--	y2 = (18 * y + 11) % 65;
	--	printf("y:  %d  ->  y2:  %f\n", y, y2);
	--}

	--for (int x = 0; x < 128; x++) {
	--	x2 = (18 * x + 11) % 129;
	--	printf("x:  %d  ->  x2:  %f\n", x, x2);
	--}

 --signal count           :std_logic_vector (7 downto 0);
  --  signal linear_feedback :std_logic;

--begin
   -- linear_feedback <= not(count(7) xor count(3));


   -- process (clk, reset) begin
     --   if (reset = '1') then
     --       count <= (others=>'0');
      -- elsif (rising_edge(clk)) then
        --    if (enable = '1') then
           --     count <= (count(6) & count(5) & count(4) & count(3) 
            --              & count(2) & count(1) & count(0) & 
             --             linear_feedback);
          --  end if;
     ---  end if;
   -- end process;
   -- cout <= count;