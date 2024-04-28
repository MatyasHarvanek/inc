-- uart_rx.vhd: UART controller - receiving (RX) side
-- Author(s): Name Surname (xlogin00)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



-- Entity declaration (DO NOT ALTER THIS PART!)
entity UART_RX is
    port(
        CLK      : in std_logic;
        RST      : in std_logic;
        DIN      : in std_logic;
        DOUT     : out std_logic_vector(7 downto 0);
        DOUT_VLD : out std_logic
    );
end entity;



-- Architecture implementation (INSERT YOUR IMPLEMENTATION HERE)
architecture behavioral of UART_RX is
    signal WAITING : std_logic;
    signal READY : std_logic;
    signal READ : std_logic;
    signal VALIDATION : std_logic; 
    signal CYCLE_COUNT : std_logic_vector(2 downto 0);
begin
    -- Instance of RX FSM
    fsm: entity work.UART_RX_FSM
    port map (
        CLK => CLK,
        RST => RST,
        WAITING => WAITING,
        READY => READY,
        CYCLE_COUNT => CYCLE_COUNT,
        DIN => DIN,
        READ => READ,
        VALIDATION => VALIDATION
    );

    process (CLK)
    begin
    end process;

    DOUT(0) <= WAITING; 
    DOUT(1) <= READY; 
    DOUT(2) <= READ;
    DOUT_VLD <= '0';

end architecture;
