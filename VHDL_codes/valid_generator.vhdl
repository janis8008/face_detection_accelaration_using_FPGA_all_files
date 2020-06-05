library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity valid_generator is
	generic 
	(
		DATA_AMOUNT		: natural := 60
	);
	port 
	(
		clk		: in std_logic;
		
		valid_in		: in std_logic;
		valid_last	: in std_logic;
		ready_in		: in std_logic;
		shift_out	: out std_logic;
		valid_out	: out std_logic
		
	);
end entity;

architecture rtl of valid_generator is

	signal	data_counter_reg, data_counter_next		: natural range 0 to DATA_AMOUNT := 0;
	signal	valid_out_en_reg, valid_out_en_next		: std_logic := '0';
	signal	shift		: std_logic;

begin

	shift		<= valid_in and ready_in			when data_counter_reg /= DATA_AMOUNT		else
					ready_in;

	process(clk)
	begin
		if rising_edge(clk) then 
			data_counter_reg		<= data_counter_next;
			valid_out_en_reg		<= valid_out_en_next;
		end if;
	end process;
	
	
	process(all)
	begin
		if shift = '1' and data_counter_reg /= DATA_AMOUNT then
			data_counter_next		<= data_counter_reg + 1;
		else
			data_counter_next		<= data_counter_reg;
		end if;
	end process;
	
	
	process(all)
	begin
		if shift = '1' then
			-- set has priority
			valid_out_en_next		<= '1';
		elsif ready_in = '1' then
			valid_out_en_next		<= '0';
		else
			valid_out_en_next		<= valid_out_en_reg;
		end if;
	end process;
	
	
	
	-- output logic
	valid_out			<= valid_last and valid_out_en_reg;
	shift_out			<= shift;
	

end architecture;



