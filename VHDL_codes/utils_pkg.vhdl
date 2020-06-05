library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package utils_pkg is

	subtype structure_line_item_t is natural range 0 to 256;
	type structure_line_t is array (natural range <>) of structure_line_item_t;
	type structure_t is array (natural range <>) of structure_line_t;

	subtype	taps_processing_line_item_t is natural;
	type		taps_processing_line_t is array (natural range 0 to 1) of taps_processing_line_item_t;
	type		taps_processing_t is array (natural range <>) of taps_processing_line_t;
	
	function get_structure_line_length (
		s : in structure_line_t)
	return natural;
	
	
	subtype tap_item_t is std_logic_vector(7 downto 0);
	type tap_line_t is array (natural range <>) of tap_item_t;
	
	type tap_lines_t is array (natural range <>) of tap_line_t;
	
	

	function count_tap_values (
		structure : structure_t
	) return natural;
	
	function count_tap_line_values (
		structure_line : structure_line_t
	) return natural;
	
	
	function get_index_for_tap_value (
		structure_line : structure_line_t;
		tap_index		: natural
	) return integer;

	
	function count_structure_line_zeros_from_current_position (
		structure_line : structure_line_t;
		position			: natural
	) return natural;
	
	
	function structure_line_only_zeros_remain (
		structure_line : structure_line_t;
		position			: natural
	) return boolean;

	
	function structure_line_is_first_zero (
		structure_line : structure_line_t;
		position			: natural
	) return boolean;
	
	
	function prepare_tap_value (
		value_in 				: std_logic_vector(7 downto 0);
		structure_constant	: natural
	) return std_logic_vector;
	
	


end package;



package body utils_pkg is


	
	function get_structure_line_length (
		s : in structure_line_t)
	return natural is
	begin
		return s'length;
	end;
	


	function count_tap_values (
		structure : structure_t
	) return natural is
		variable		tap_values : natural;
	begin
		tap_values := 0;
		for i in structure'low to structure'high loop
			tap_values	:= tap_values + count_tap_line_values(structure(i));
		end loop;
		return tap_values;
	end function;


	function count_tap_line_values (
		structure_line : structure_line_t
	) return natural is
		variable		tap_values : natural;
	begin
		tap_values	:= 0;
		for i in structure_line'low to structure_line'high loop
			if structure_line(i) > 0 then
				tap_values	:= tap_values + 1;
			end if;
		end loop;
		return tap_values;
	end function;
	
	
	function get_index_for_tap_value (
		structure_line : structure_line_t;
		tap_index		: natural
	) return integer is
		variable		tap_location 	: integer;
		variable		tap_index_i		: natural;
	begin
		tap_location := -1;
		tap_index_i	:= tap_index;
		for i in structure_line'low to structure_line'high loop
			if structure_line(i) > 0 then
				if tap_index_i = 0 then
					tap_location := i;
					exit;
				end if;
				tap_index_i := tap_index_i - 1;
			end if;
		end loop;
		return tap_location;
	end function;
	
	
	function count_structure_line_zeros_from_current_position (
		structure_line : structure_line_t;
		position			: natural
	) return natural is
		variable		zeros : natural;
	begin
		zeros	:= 0;
		for i in position to structure_line'high loop
			if structure_line(i) = 0 then
				zeros	:= zeros + 1;
			else
				exit;
			end if;
		end loop;
		return zeros;
	end function;
	
	
	function structure_line_only_zeros_remain (
		structure_line : structure_line_t;
		position			: natural
	) return boolean is
	begin
		for i in position to structure_line'high loop
			if structure_line(i) /= 0 then
				return false;
			end if;
		end loop;
		return true;
	end function;
	
	
	function structure_line_is_first_zero (
		structure_line : structure_line_t;
		position			: natural
	) return boolean is
	begin
		if structure_line(position) /= 0 then
			return false;
		end if;
		if position = 0 then
			return true;
		end if;
		return structure_line(position-1) /= 0;
	end function;


	function prepare_tap_value (
		value_in 				: std_logic_vector(7 downto 0);
		structure_constant	: natural
	) return std_logic_vector is
		variable value_in_unsigned		: unsigned(7 downto 0);
		variable constant_unsigned		: unsigned(7 downto 0);
		variable product_unsigned		: unsigned(15 downto 0);
	begin
		if structure_constant = 256 then
			return value_in;
		else
			value_in_unsigned		:= unsigned(value_in);
			constant_unsigned		:= to_unsigned(structure_constant, 8);
			assert(constant_unsigned /= 0);
			product_unsigned		:= value_in_unsigned * constant_unsigned;
			return std_logic_vector(product_unsigned(15 downto 8));
		end if;
	end function;




end package body;
