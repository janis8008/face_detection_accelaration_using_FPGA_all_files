library ieee;
use ieee.std_logic_1164.all;

library work;
use work.utils_pkg.all;


entity filter_line is
	generic 
	(
		FILTER_LINE_STRUCTURE	: structure_line_t;
		FILTER_LINE_LENGTH		: natural
	);
	port 
	(
		clk		: in std_logic;
		
		-- data
		data_in		: in std_logic_vector(7 downto 0);
		data_out		: out std_logic_vector(7 downto 0);
		shift			: in std_logic;
		
		-- tap data
		tap_out		: out tap_line_t(0 to count_tap_line_values(FILTER_LINE_STRUCTURE)-1)
	);
end entity;

architecture rtl of filter_line is

	constant ACTIVE_LENGTH	: natural := get_structure_line_length(FILTER_LINE_STRUCTURE);

	subtype	line_item_t is std_logic_vector(7 downto 0);
	type		line_items_t is array(0 to ACTIVE_LENGTH-1) of line_item_t;

	signal	line_items_reg, line_items_next	: line_items_t;
	signal	to_fifo, from_fifo					: line_items_t;
	signal	last_line_item							: line_item_t;

begin

	-- reg-state logic
	process(all)
	begin
		for i in 0 to ACTIVE_LENGTH-1 loop
			if FILTER_LINE_STRUCTURE(i) > 0 then
				if rising_edge(clk) then
					if shift = '1' then
						line_items_reg(i)		<= line_items_next(i);
					end if;
				end if;
			else
				line_items_reg(i)		<= (others => '0');
				line_items_next(i)	<= (others => '0');
			end if;
		end loop;
	end process;
	
	
	-- next-state logic
	process(all)
	begin
		-- active part
		-- first element
		if FILTER_LINE_STRUCTURE(0) > 0 then
			line_items_next(0)		<= data_in;
		end if;
		
		for i in 1 to ACTIVE_LENGTH-1 loop
			if FILTER_LINE_STRUCTURE(i) > 0 then
				line_items_next(i)	<= from_fifo(i-1);
			end if;
		end loop;
		
		-- last element
		if FILTER_LINE_STRUCTURE(ACTIVE_LENGTH-1) > 0 then
			last_line_item			<= line_items_reg(ACTIVE_LENGTH-1);
		end if;
	end process;
	
	
	process(all)
		variable	index_for_tap_value : integer;
	begin
		-- active part
		for i in 0 to count_tap_line_values(FILTER_LINE_STRUCTURE)-1 loop
			index_for_tap_value	:= get_index_for_tap_value(FILTER_LINE_STRUCTURE, i);
			if index_for_tap_value >= 0 then
				tap_out(i)	<= prepare_tap_value(line_items_reg(index_for_tap_value), FILTER_LINE_STRUCTURE(index_for_tap_value));
			else
				tap_out(i)	<= (others => '0');
			end if;
		end loop;
	end process;


	-- FIFO in active line
	fifo_active_1:
	for i in 0 to ACTIVE_LENGTH-1 generate
		
		fifo_active_2:
		if structure_line_is_first_zero(FILTER_LINE_STRUCTURE, i) generate
			
			to_fifo_first:
			if i = 0 generate
				to_fifo(0)				<= data_in;
			end generate;
			
			to_fifo_others:
			if i /= 0 generate
				to_fifo(i)				<= line_items_reg(i-1);
			end generate;
		
			fifo_active_last:
			if structure_line_only_zeros_remain(FILTER_LINE_STRUCTURE, i) generate
				
				fifo_module:
				entity work.fifo_module(rtl)
				generic map (
					DATA_WIDTH 		=> 8,
					FIFO_LENGTH		=> count_structure_line_zeros_from_current_position(FILTER_LINE_STRUCTURE, i)+(FILTER_LINE_LENGTH-ACTIVE_LENGTH)
				)
				port map (
					clk			=> clk,
					data_in		=> to_fifo(i),
					data_out		=> data_out,
					shift			=> shift
				);
				
			end generate;
		
			fifo_active_not_last:
			if not structure_line_only_zeros_remain(FILTER_LINE_STRUCTURE, i) generate
			
				fifo_module:
				entity work.fifo_module(rtl)
				generic map (
					DATA_WIDTH 		=> 8,
					FIFO_LENGTH		=> count_structure_line_zeros_from_current_position(FILTER_LINE_STRUCTURE, i)
				)
				port map (
					clk			=> clk,
					data_in		=> to_fifo(i),
					data_out		=> from_fifo(i+count_structure_line_zeros_from_current_position(FILTER_LINE_STRUCTURE, i)-1),
					shift			=> shift
				);
			
			end generate;
			

		end generate;
		
	end generate;
	
	
	-- Passive part
	fifo_passive:
	if FILTER_LINE_STRUCTURE(FILTER_LINE_STRUCTURE'high) > 0 generate
		
		fifo_module:
		entity work.fifo_module(rtl)
		generic map (
			DATA_WIDTH 		=> 8,
			FIFO_LENGTH		=> FILTER_LINE_LENGTH-ACTIVE_LENGTH
		)
		port map (
			clk			=> clk,
			data_in		=> last_line_item,
			data_out		=> data_out,
			shift			=> shift
		);
		
	end generate;
	

		
	-- output logic



end architecture;



