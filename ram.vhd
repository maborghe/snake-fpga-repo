library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity ram is
  port (
    clk : in  std_logic;
    -- Graphic
	 gph_addr : in  integer range 0 to 4799;
	 gph_out : out std_logic_vector(2 downto 0);
	 -- Logic
    log_addr : in  integer range 0 to 4799;
    data_in  : in  std_logic_vector(2 downto 0);
	 we : in  std_logic;
    log_out : out std_logic_vector(2 downto 0)
  );
end ram;

architecture behave of ram is

	type ram_type is array (0 to 4799) of std_logic_vector(2 downto 0);
   --signal memory : ram_type := (2450 to 2456 => "010", others => "000");
	signal memory : ram_type := (2450 => "010", others => "000");
	signal log_read : integer range 0 to 4799;

begin

  graphic : process(clk)
  begin
    if clk'event and clk = '1' then
		gph_out <= memory(gph_addr);     
    end if;
  end process;
  
  logic : process(clk) 
  begin
    if clk'event and clk = '1' then
      if we = '1' then
        memory(log_addr) <= data_in;
      end if;
      log_read <= log_addr;
    end if;
  end process;
  log_out <= memory(log_read);
  
end behave;