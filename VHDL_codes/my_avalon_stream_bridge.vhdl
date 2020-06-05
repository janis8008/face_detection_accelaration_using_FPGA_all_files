library ieee;
use ieee.std_logic_1164.all;

entity my_avalon_stream_bridge is
	port 
	(
		clk			: in std_logic;
		reset			: in std_logic;
		
		-- input
		data_in		: in std_logic_vector(7 downto 0);
		valid_in		: in std_logic;
		ready_out	: out std_logic;
		
		-- output
		data_out		: out std_logic_vector(7 downto 0);
		valid_out	: out std_logic;
		ready_in		: in std_logic
	);
end entity;

architecture rtl of my_avalon_stream_bridge is
begin

	data_out		<= data_in;
	valid_out	<= valid_in;
	ready_out	<= ready_in;

end architecture;