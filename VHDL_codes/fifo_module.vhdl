
library ieee;
use ieee.std_logic_1164.all;

entity fifo_module is
	generic 
	(
		DATA_WIDTH 	: natural := 8;
		FIFO_LENGTH	: natural := 40
	);
	port 
	(
		clk		: in std_logic;
		data_in	: in std_logic_vector(DATA_WIDTH-1 downto 0);
		data_out	: out std_logic_vector(DATA_WIDTH-1 downto 0);
		shift		: in std_logic
	);
end entity;

architecture rtl of fifo_module is

	
	constant	EFFECTIVE_FIFO_LENGTH	: natural := FIFO_LENGTH;

	signal	read_index_reg, read_index_next		: integer range 0 to EFFECTIVE_FIFO_LENGTH-1 := 1;
	signal	write_index_reg, write_index_next	: integer range 0 to EFFECTIVE_FIFO_LENGTH-1 := 0;
	
	signal	out_reg, out_next						: std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
	signal	out_ram									: std_logic_vector(DATA_WIDTH-1 downto 0);
	signal	shift_reg				: std_logic := '0';

begin


	ram_module:
	entity work.ram_module(rtl)
	generic map (
		DATA_WIDTH		=> DATA_WIDTH,
		RAM_LENGTH		=> EFFECTIVE_FIFO_LENGTH
	) port map(
		clk			=> clk,
		
		-- write port
		waddr			=> write_index_reg,
		data			=> data_in,
		we				=> shift,
		
		-- read port
		raddr			=> read_index_reg,
		q				=> out_ram
	);



	-- reg-state logic
	process(all)
	begin
		if rising_edge(clk) then
			read_index_reg		<= read_index_next;
			write_index_reg	<= write_index_next;
			out_reg				<= out_next;
			shift_reg			<= shift;
		end if;
	end process;
	
	-- next-state logic
	process(all)
	begin
		if shift = '1'  then
			if read_index_reg /= EFFECTIVE_FIFO_LENGTH-1 then
				read_index_next	<= read_index_reg + 1;
			else
				read_index_next	<= 0; 
			end if;
			if write_index_reg /= EFFECTIVE_FIFO_LENGTH-1 then
				write_index_next	<= write_index_reg + 1;
			else
				write_index_next	<= 0; 
			end if;
		else
			read_index_next	<= read_index_reg;
			write_index_next	<= write_index_reg;
		end if;
		
		if shift_reg = '1' then
			out_next		<= out_ram;
		elsif shift = '1' then
			out_next		<= out_ram;
		else
			out_next		<= out_reg;
		end if;
			
	end process;	
	
	
	-- output logic
	data_out		<= out_ram			when shift_reg = '1'		else
						out_reg;
	

end architecture;



