library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity estimator is
        Port (
                clk      : in  STD_LOGIC;
                reset    : in  STD_LOGIC;
                voltage  : in  STD_LOGIC_VECTOR(9-1 downto 0); -- 9 is width
                distance : out STD_LOGIC_VECTOR(9-1 downto 0) -- 9 is width
         );
end estimator;

architecture Behavioral of estimator is
	signal estimated_voltage: STD_LOGIC_VECTOR(9-1 downto 0) := (others => '0');
    type ROM is array (0 to 511) of STD_LOGIC_VECTOR(9-1 downto 0); -- 9 is width
    constant estimator_rom: ROM := (("000110011"), ("000110010"), ("000110001"), ("000110000"), ("000110000"), ("000101111"), ("000101110"), ("000101101"), ("000101101"), ("000101100"), ("000101011"), ("000101010"), ("000101010"), ("000101001"), ("000101000"), ("000101000"), ("000100111"), ("000100111"), ("000100110"), ("000100101"), ("000100101"), ("000100100"), ("000100100"), ("000100011"), ("000100010"), ("000100010"), ("000100001"), ("000100001"), ("000100000"), ("000100000"), ("000011111"), ("000011111"), ("000011110"), ("000011110"), ("000011101"), ("000011101"), ("000011100"), ("000011100"), ("000011100"), ("000011011"), ("000011011"), ("000011010"), ("000011010"), ("000011010"), ("000011001"), ("000011001"), ("000011000"), ("000011000"), ("000011000"), ("000010111"), ("000010111"), ("000010111"), ("000010110"), ("000010110"), ("000010110"), ("000010101"), ("000010101"), ("000010101"), ("000010100"), ("000010100"), ("000010100"), ("000010100"), ("000010011"), ("000010011"), ("000010011"), ("000010010"), ("000010010"), ("000010010"), ("000010010"), ("000010001"), ("000010001"), ("000010001"), ("000010001"), ("000010001"), ("000010000"), ("000010000"), ("000010000"), ("000010000"), ("000001111"), ("000001111"), ("000001111"), ("000001111"), ("000001111"), ("000001111"), ("000001110"), ("000001110"), ("000001110"), ("000001110"), ("000001110"), ("000001110"), ("000001101"), ("000001101"), ("000001101"), ("000001101"), ("000001101"), ("000001101"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001100"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001011"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001010"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001001"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000001000"), ("000000111"), ("000000111"), ("000000111"), ("000000111"), ("000000110"), ("000000110"), ("000000110"), ("000000110"), ("000000101"), ("000000101"), ("000000101"), ("000000100"), ("000000100"), ("000000100"), ("000000011"), ("000000011"), ("000000011"), ("000000010"), ("000000010"), ("000000010"), ("000000001"), ("000000001"), ("000000001"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"), ("000000000"));

begin
-- Internal processes ----------------------------------------------------------
	-- Weight is 3/4 current, 1/4 running average
	estimated_voltage <= estimated_voltage(9-3 downto 0) + voltage(9-3 downto 0) + voltage(9-2 downto 0);
    distance <= estimator_rom(CONV_INTEGER(UNSIGNED(estimated_voltage)));

end Behavioral;

