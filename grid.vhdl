library ieee;
use ieee.std_logic_1164.all;

-- 1. ghdl -a grid.vhdl funktioniert

-- 2. Kein Bedarf, die Schlange in einem eigenen Modul zu speichern:
-- wenn der Zugriff in Z. 37 und 41 zulässig sind (was ich mir nicht ganz sicher bin)
-- verschieben wir einfach den Kopf und löschen den Schwanz, die Kollisionsüberprüfung
-- würde auch recht einfach. Es gäbe zudem keine Längengrenze. Das ganze sollte mit
-- Modelsim simuliert werden um zu schauen ob es läuft


entity grid is
	port (
		slow_clock : in std_logic; -- jede Sekunde oder so
		head_x : in integer;
		head_y : in integer;
		last_tail_x : in integer;
		last_tail_y : in integer;
		apple_x : in integer;
		apple_y : in integer
	);
end grid;

architecture behave of grid is
	
	type matrix_row is array (0 to 59) of std_logic;
	type matrix is array (0 to 47) of matrix_row;	
	signal grid : matrix := (others => (others => '0')); -- TODO: initialize snake!
	
begin

	move : process (slow_clock)
	begin
		if head_x = apple_x and head_y = apple_y then
			-- Schlange wächst
		elsif grid(head_x)(head_y) = '1' then
			-- Schlange stirbt
		else
			-- Normale Bewegung
			grid(head_x)(head_y) <= '1';
			grid(last_tail_x)(last_tail_y) <= '0';
		end if;
		
		
	end process;
	
end behave;