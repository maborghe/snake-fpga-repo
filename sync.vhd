library ieee;
use ieee.std_logic_1164.all;

entity sync is
	port (
		clk 	: in 	std_logic;
		hsync : out std_logic;
		vsync : out std_logic;
		video : out std_logic;
		col 	: out integer range 0 to 799;
		row 	: out integer range 0 to 524
	);
end sync;

architecture behave of sync is
	signal h_pos : integer := 0;
	signal v_pos : integer := 0;

	constant HD : integer := 639;  --  639   Horizontal Display (640)
	constant HFP : integer := 20;  --   20   Right border (front porch)
	constant HSP : integer := 96;  --   96   Sync pulse (Retrace)
	constant HBP : integer := 44;  --   44   Left boarder (back porch)

	constant VD : integer := 479;   --  479   Vertical Display (480)
	constant VFP : integer := 14;   --   14   Right border (front porch)
	constant VSP : integer := 1;		--    1   Sync pulse (Retrace)
	constant VBP : integer := 30;   --   30   Left boarder (back porch)

begin
	h_count : process (clk)
	begin
		if clk'event and clk = '1' then
			if h_pos = HD + HFP + HSP + HBP then
				h_pos <= 0;
			else
				h_pos <= h_pos + 1;
			end if;
		end if;
	end process;

	v_count : process (clk)
	begin
		if clk'event and clk = '1' then
			if h_pos = HD + HFP + HSP + HBP then
				if v_pos = VD + VFP + VSP + VBP then
					v_pos <= 0;
				else
					v_pos <= v_pos + 1;
				end if;
			end if;
		end if;
	end process;

	h_sync : process (clk)
	begin
		if clk'event and clk = '1' then
			if h_pos <= HD + HFP or h_pos > HD + HFP + HSP  then
				hsync <= '1';
			else
				hsync <= '0';
			end if;
		end if;
	end process;

	v_sync : process (clk)
	begin
		if clk'event and clk = '1' then
			if v_pos <= VD + VFP or v_pos > VD + VFP + VSP then
				vsync <= '0';
			else
				vsync <= '1';
			end if;
		end if;
	end process;

	video_on : process (clk)
	begin
		if clk'event and clk = '1' then
			if h_pos < 640 and v_pos < 480 then
				video <= '1';
			else
				video <= '0';
			end if;
		end if;
	end process;
	col <= h_pos;
	row <= v_pos;

end behave;
