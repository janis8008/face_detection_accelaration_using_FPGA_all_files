
library ieee;
use ieee.std_logic_1164.all;

entity tap_module is
	generic 
	(
		DATA_WIDTH 	: natural := 8;
		TAP_LENGTH	: natural := 40
	);
	port 
	(
		clk		: in std_logic;
		data_in	: in std_logic_vector(DATA_WIDTH-1 downto 0);
		data_out	: out std_logic_vector(DATA_WIDTH-1 downto 0);
		shift		: in std_logic
	);
end entity;

architecture rtl of tap_module is

	signal	read_index_reg, read_index_next		: integer range 0 to TAP_LENGTH-1 := 0;
	signal	write_index_reg, write_index_next	: integer range 0 to TAP_LENGTH-1 := 0;

begin


	ram_module:
	entity work.ram_module(rtl)
	generic map (
		DATA_WIDTH		=> DATA_WIDTH,
		RAM_LENGTH		=> TAP_LENGTH
	) port map(
		clk			=> clk,
		
		-- write port
		waddr			=> write_index_reg,
		data			=> data_in,
		we				=> shift,
		
		-- read port
		raddr			=> read_index_reg,
		q				=> data_out
	);



	-- reg-state logic
	process(clk)
	begin
		if rising_edge(clk) then
			read_index_reg		<= read_index_next;
			write_index_reg	<= write_index_next;
		end if;
	end process;
	
	-- next-state logic
	process(clk)
	begin
		if shift = '1'  then
			if read_index_reg /= TAP_LENGTH-1 then
				read_index_next	<= read_index_reg + 1;
			else
				read_index_next	<= 0; 
			end if;
			if write_index_reg /= TAP_LENGTH-1 then
				write_index_next	<= write_index_reg + 1;
			else
				write_index_next	<= 0; 
			end if;
		else
			read_index_next	<= read_index_reg;
			write_index_next	<= write_index_reg;
		end if;
	end process;	
	
	
	-- output logic
	
end architecture;



