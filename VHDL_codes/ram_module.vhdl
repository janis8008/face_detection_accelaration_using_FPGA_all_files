
library ieee;
use ieee.std_logic_1164.all;

entity ram_module is
	generic 
	(
		DATA_WIDTH		: natural := 8;
		RAM_LENGTH		: natural := 40
	);
	port 
	(
		clk		: in std_logic;
		
		-- write port
		waddr		: in natural range 0 to RAM_LENGTH-1;
		data		: in std_logic_vector(DATA_WIDTH-1 downto 0);
		we			: in std_logic := '1';
		
		-- read port
		raddr		: in natural range 0 to RAM_LENGTH-1;
		q			: out std_logic_vector(DATA_WIDTH-1 downto 0)
	);
end entity;

architecture rtl of ram_module is

	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(DATA_WIDTH-1 downto 0);
	type memory_t is array(0 to RAM_LENGTH-1) of word_t;

	-- Declare the RAM signal.	
	signal ram : memory_t;

begin

	process(clk)
	begin
		if rising_edge(clk) then 
			if we = '1' then
				ram(waddr) <= data;
			end if;
	 
			-- On a read during a write to the same address, the read will
			-- return the OLD data at the address
			q <= ram(raddr);
		end if;
	end process;

end architecture;



