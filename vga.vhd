----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity vga is
	port (
		clk 	: in 	std_logic;
		hsync, vsync, video : out std_logic;
		col 	: out integer range 0 to 799;
		row 	: out integer range 0 to 524
	);
end vga;

architecture behave of vga is
	signal h_pos : integer := 0;
	signal v_pos : integer := 0;
	signal init : integer := 0;
	
	constant hd : integer := 639; --horizontal display (640)
	constant hfp : integer := 20;	--front porch
	constant hsp : integer := 96; --sync pulse
	constant hbp : integer := 44; --back porch
	
	constant vd : integer := 479;	--vertical display (480)
	constant vfp : integer := 14; --front porch
	constant vsp : integer := 1;	--Sync pulse
	constant vbp : integer := 30; --back porch
	 
begin
	h_count : process (clk)
	begin
		if clk'event and clk = '1' then
			if h_pos = hd + hfp + hsp + hbp then
				h_pos <= 0;
			else
				if init = 0 then
					h_pos <= 0;
					init <= 1;
				else
				h_pos <= h_pos + 1;
				end if;
			end if;
		end if;
	end process;

	v_count : process (clk)
	begin
		if clk'event and clk = '1' then
			if h_pos = hd + hfp + hsp + hbp then
				if v_pos = vd + vfp + vsp + vbp then
					v_pos <= 0;
				else
					v_pos <= v_pos + 1;
				end if;
			end if;
		end if;
	end process;
	
	h_sync : process (h_pos)
	begin
		if h_pos <= hd + hfp or h_pos > hd + hfp + hsp then
			hsync <= '1';
		else
			hsync <= '0';
		end if;
	end process;
	
	v_sync : process (v_pos)
	begin
		if v_pos <= vd + vfp or v_pos > vd + vfp + vsp then
			vsync <= '1';
		else
			vsync <= '0';
		end if;
end process;

	--video_on : process (clk)
	--begin
		--if clk'event and clk = '1' then
		--	if h_pos < 640 and v_pos < 480 then
		--		video <= '1';
		--	else
		--		video <= '0';
		--	end if;
	--	end if;
	--end process;
	
	--col <= h_pos;
	--row <= v_pos;
	
	output_filter : process (h_pos, v_pos)
	begin
		if h_pos <= hd and v_pos <= vd then
			col <= h_pos;
			row <= v_pos;
			video <= '1';
		else
			video <= '0';
		end if;
end process;

end behave;
