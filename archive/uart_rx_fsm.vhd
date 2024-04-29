

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity UART_RX_FSM is
    port(
       CLK : in std_logic;                     
       RST : in std_logic;                     
       DIN : in std_logic;                     
       CLK_CYCLE_CNT : in std_logic_vector(4 downto 0);  
       CLK_CYCLE_ACTIVE : out std_logic;                    
       BIT_CNT : in std_logic_vector(3 downto 0);  
       DATA_RECIEVE_ACTIVE : out std_logic;                    
       DATA_VALIDATE_ACTIVE : out std_logic                     
    );
end entity;

architecture behavioral of UART_RX_FSM is
    type fsm_states is (NOT_ACTIVE, WAIT_FOR_FIRST_BIT, READ_DATA, WAIT_FOR_STOP_BIT, VALIDATE_DATA); 
    signal current_state : fsm_states := NOT_ACTIVE;  

begin
    CLK_CYCLE_ACTIVE <= '0' when current_state = VALIDATE_DATA  or current_state = NOT_ACTIVE else '1'; 
    DATA_VALIDATE_ACTIVE <= '1' when current_state = VALIDATE_DATA else '0'; 
    DATA_RECIEVE_ACTIVE <= '1' when current_state = READ_DATA else '0'; 

    process(CLK) begin

        if RST = '1' then
            current_state <= NOT_ACTIVE; 
            
        elsif rising_edge(CLK) then
            if NOT_ACTIVE = current_state then 
                if DIN = '0' then 
                    current_state <= WAIT_FOR_FIRST_BIT; 
                end if;
            end if;
            if  current_state = WAIT_FOR_FIRST_BIT then
                if CLK_CYCLE_CNT = 23 then 
                    current_state <= READ_DATA; 
                end if;
            end if;
            if current_state = READ_DATA then
                if BIT_CNT = 8 then 
                    current_state <= WAIT_FOR_STOP_BIT; 
                end if;
            end if;
            if current_state = WAIT_FOR_STOP_BIT then
                if DIN = '1' then 
                    if CLK_CYCLE_CNT = 15 then 
                        current_state <= VALIDATE_DATA; 
                    end if;
                end if;
            end if;
            if current_state = VALIDATE_DATA then
                current_state <= NOT_ACTIVE;
            end if; 
        end if;
    end process;
end architecture;