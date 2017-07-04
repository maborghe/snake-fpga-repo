library ieee;
use ieee.std_logic_1164.all;

entity state_machine is
	port (
		clk, game_over : in std_logic;
		fruit_addr : in integer range 0 to 4799;
		reset : out std_logic;
		data : out std_logic_vector(2 downto 0);
		address : out integer range 0 to 4799
	);
end state_machine;

architecture behave of state_machine is
	
	signal state : integer range 0 to 2;
	signal new_game : std_logic := '0';
	signal counter : integer range 0 to 4799 := 0;
	
begin

	-- if sw4 elsif sw5
	count : process(clk)
	begin
		if clk'event and clk = '1' then
			if new_game = '1' then
				if counter = 4799 then
					counter <= 0;
				else
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process;
	
	set_up : process(clk)
	begin
		if clk'event and clk = '1' then
			if new_game = '1' then
				if counter >= 2358 and counter <= 2361 then
					data <= "010";
				elsif counter = fruit_addr then
					data <= "101";
				else
					data <= "000";
				end if;
			end if;
		end if;
	end process;
	
	-- process new mode
	change_state : process(clk)
	begin
		if clk'event and clk = '1' then
			if game_over = '1' then
				new_game <= '1';
			elsif counter = 4799 then
				new_game <= '0';
			end if;
		end if;
	end process;
	
	reset <= new_game;
	address <= counter;
	
end behave;