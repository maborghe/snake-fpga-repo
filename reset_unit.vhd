library ieee;
use ieee.std_logic_1164.all;

entity reset_unit is
	port (
		clk, counter_8, counter_14, counter_30, sw4, game_over : in std_logic;
		fruit_addr : in integer range 0 to 4799;
		reset, game_over_pixel : out std_logic;
		data : out std_logic_vector(2 downto 0);
		address : out integer range 0 to 4799;
		state_mod : out integer range 0 to 2;
		ff: out std_logic
	);
end reset_unit;

architecture behave of reset_unit is
	
	signal state : integer range 0 to 2 := 2;
	signal new_game, game_over_pixel_temp : std_logic := '0';
	signal counter : integer range 0 to 4799 := 0;
	signal diag : integer range 0 to 4799 := 1230;
	signal round : integer range 0 to 8500 := 0;
	signal row : integer range 0 to 59 := 0;
	--signal flag ,flag_t : std_logic := '0';
begin

	count : process(clk)
	begin
		if clk'event and clk = '1' then
			if new_game = '1' then
				if counter = 4799 then
					if round = 8500 then
						round <= 0;
					else
						round <= round + 1;
					end if;
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
				if counter >= 2363 and counter <= 2366 then
					data <= "010";
				--bug part :
				--elsif counter = 120 then --
					--data <= "101";
				else
					if counter = row*80 + 79 then 			
						if row = 59 then
							row <= 0;
						else
							row <= row + 1;
						end if;
					end if;
					case state is
						when 0 =>											-- normal			
							data <= "000";
						when 1 =>											-- barriers at the boundaries
							if counter <= 79 or counter >= 4720 or --horizontal
									counter = row*80 or counter = row*80+79 then				
								data <= "110";
							else
								data <= "000";
							end if;
						when 2 =>
							if counter = diag then
								if diag = 3470 then
									diag <= 1230;
								elsif diag < 2336 then
									diag <= diag + 79;
								else
									diag <= diag + 81;
								end if;
								data <= "110";
							elsif row >= 15 and row < 44 and --Schrift
								(counter = row*80+15 or -- K Stange
									counter = row*80+40 or counter = row*80+60 or -- I T Stangen
									(counter >= 1251 and counter <= 1270)) then -- T Balken
								data <= "110";
							else
								data <= "000";
							end if;
					end case;
				end if;
			end if;
			game_over_pixel <= game_over_pixel_temp;
			reset <= new_game;
			address <= counter;
		end if;
	end process;
	
	-- process new mode
	change_state : process(clk)
		variable taken : std_logic := '1';
	begin
		if clk'event and clk = '1' then
			-- RESET ALL
			--if sw4 = '1' then
			--	if taken = '1' then
			--		new_game <= '1';
			--		state <= 0;
			--		taken := '0';
			--	end if;
			--elsif sw1000 = '1' then
			if sw4 = '1' then
				if taken = '1' then
					if state = 2 then
						state <= 0;
					else
						state <= state + 1;
					end if;
					new_game <= '1';
					taken := '0';
				end if;
			else
				taken := '1';
			end if;
			if game_over = '1' then
				new_game <= '1';
				game_over_pixel_temp <= '1';
			elsif counter = 4799 and round = 8500 then
				new_game <= '0';
				game_over_pixel_temp <= '0';
			end if;
		end if;
		state_mod <= state;
	end process;
ff <= new_game;
end behave;