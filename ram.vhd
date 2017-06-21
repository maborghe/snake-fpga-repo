library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity ram is
  port (
    clk : in  std_logic;
    we : in  std_logic;
    address : in  integer range 0 to 4799;
    data_in  : in  std_logic_vector(2 downto 0);
    data_out : out std_logic_vector(2 downto 0)
  );
end ram;

architecture behave of ram is

	type ram_type is array (0 to 4799) of std_logic_vector(2 downto 0);
   signal memory : ram_type := (2450 to 2456 => "010", others => "000");
   signal read_address : integer range 0 to 4799;

begin

  process(clk) is
  begin
    if clk'event and clk = '1' then
      if we = '1' then
        memory(address) <= data_in;
      end if;
      read_address <= address;
    end if;
  end process;

  data_out <= memory(read_address);

end behave;