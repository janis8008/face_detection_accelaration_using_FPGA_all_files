library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.utils_pkg.all;


entity taps_processing is
	generic 
	(
		TAPS_LEN						: natural := 4 ;
		TAPS_PROCESSING_VALUES	: taps_processing_t 
	);
	port 
	(
		clk		: in std_logic;
		
		-- input bus
		taps			: in tap_line_t(0 to TAPS_LEN-1);
		shift			: in std_logic;
		
		-- output bus
		detected_output	: out boolean
	);
end entity;

architecture rtl of taps_processing is

	constant TAP_EVAL_RESULTS	:	natural := TAPS_PROCESSING_VALUES'length;
	
	subtype	result_t is boolean;
	type		results_t is array (0 to TAP_EVAL_RESULTS - 1) of result_t;
	
	signal	results_reg, results_next		: results_t;
	signal	result_reg, result_next			: boolean;
	
begin


	--reg-state logic
	process(all)
	begin
		if rising_edge(clk) then
			if shift = '1' then
				results_reg		<=	results_next;
				result_reg		<= result_next;
				
			end if;
		end if;
	end process;
	
	-- next-state logic
	process(all)
	begin
		-- calculating taps results
		for i in 0 to TAP_EVAL_RESULTS - 1 loop
			results_next(i)	<=	unsigned(taps(TAPS_PROCESSING_VALUES(i)(0))) < unsigned(taps(TAPS_PROCESSING_VALUES(i)(1)));
		end loop;
		
	end process;
	
	process(all)
		variable	result : boolean;
	begin
		-- combining tap results
		result := true;
		for i in 0 to TAP_EVAL_RESULTS - 1 loop
			result := result and results_reg(i);
		end loop;
		result_next		<= result;
		
	end process;
	
	--output logic
	detected_output		<= result_reg;
	
end architecture;






