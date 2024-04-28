-- uart_rx_fsm.vhd: UART controller - finite state machine controlling RX side
-- Author(s): Name Surname (xlogin00)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity UART_RX_FSM is
    port(
       CLK : in std_logic;
       DIN : in std_logic;
       RST : in std_logic;
       CYCLE_COUNT : in std_logic_vector (2 downto 0);
       WAITING : out std_logic;
       READY : out std_logic;
       READ: out std_logic;
       VALIDATION: out std_logic
    );
end entity;

architecture behavioral of UART_RX_FSM is
    type STATE_TYPE is ( WAIT_START_BIT, READY_FOR_READ, READ_YOU_FUCK, WAIT_STOP_BIT, DATA_VALID);
    signal state : STATE_TYPE;
    signal clockCounter : std_logic_vector(3 downto 0);
   
begin

    process(CLK)
        begin
        if rising_edge(CLK) then
            if RST = '1' then
                clockCounter  <= "0000";
                state <= WAIT_START_BIT;
                end if;

            if RST = '0' then
                if  DIN = '0' and state = WAIT_START_BIT then
                    clockCounter <= clockCounter + 1;
                end if; 

                if clockCounter = 7 and state = WAIT_START_BIT and DIN = '0' then
                    clockCounter <= "0000";
                    state <= READY_FOR_READ;
                end if;

                if state = READY_FOR_READ then
                    clockCounter <= clockCounter + 1;
                end if;
                
                if state = READY_FOR_READ and clockCounter = 15 then
                    state <= READ_YOU_FUCK;
                end if;
                if state = READ_YOU_FUCK then
                    state <= READY_FOR_READ;
                    clockCounter <= "0000";
                end if;
                
            end if;
        end if;
    end process;
    
    process(CLK)
        begin

            WAITING <= '0';
            READY <= '0';
            READ <= '0';
            VALIDATION <= '0';

            if state = WAIT_START_BIT then
                WAITING <= '1';
                
            end if;
            if state = READY_FOR_READ then
                READY <= '1';
            end if;

            if state = READ_YOU_FUCK then
                READ <= '1';
            end if;
       
    end process;

    
end architecture;
