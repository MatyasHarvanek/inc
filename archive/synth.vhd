library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity UART_RX is
  port (
    CLK: in std_logic;
    RST: in std_logic;
    DIN: in std_logic;
    DOUT: out std_logic_vector (7 downto 0);
    DOUT_VLD: out std_logic
  );
end entity;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx_fsm is
  port (
    clk : in std_logic;
    din : in std_logic;
    rst : in std_logic;
    cycle_count : in std_logic_vector (2 downto 0);
    waiting : out std_logic;
    ready : out std_logic;
    read : out std_logic;
    validation : out std_logic);
end entity uart_rx_fsm;

architecture rtl of uart_rx_fsm is
  signal state : std_logic_vector (2 downto 0);
  signal clockcounter : std_logic_vector (3 downto 0);
  signal n19_o : std_logic;
  signal n21_o : std_logic_vector (2 downto 0);
  signal n23_o : std_logic_vector (3 downto 0);
  signal n24_o : std_logic;
  signal n25_o : std_logic;
  signal n27_o : std_logic;
  signal n28_o : std_logic;
  signal n30_o : std_logic_vector (3 downto 0);
  signal n31_o : std_logic_vector (3 downto 0);
  signal n33_o : std_logic;
  signal n35_o : std_logic;
  signal n36_o : std_logic;
  signal n37_o : std_logic;
  signal n38_o : std_logic;
  signal n40_o : std_logic_vector (2 downto 0);
  signal n42_o : std_logic_vector (3 downto 0);
  signal n44_o : std_logic;
  signal n46_o : std_logic_vector (3 downto 0);
  signal n47_o : std_logic_vector (3 downto 0);
  signal n49_o : std_logic;
  signal n51_o : std_logic;
  signal n52_o : std_logic;
  signal n54_o : std_logic_vector (2 downto 0);
  signal n56_o : std_logic;
  signal n58_o : std_logic_vector (2 downto 0);
  signal n60_o : std_logic_vector (3 downto 0);
  signal n61_o : std_logic_vector (2 downto 0);
  signal n62_o : std_logic_vector (3 downto 0);
  signal n66_q : std_logic_vector (2 downto 0);
  signal n67_q : std_logic_vector (3 downto 0);
  signal n71_o : std_logic;
  signal n74_o : std_logic;
  signal n77_o : std_logic;
  signal n80_o : std_logic;
  signal n83_o : std_logic;
  signal n86_o : std_logic;
  constant n89_o : std_logic := '0';
begin
  waiting <= n74_o;
  ready <= n80_o;
  read <= n86_o;
  validation <= n89_o;
  -- uart_rx_fsm.vhd:23:12
  state <= n66_q; -- (signal)
  -- uart_rx_fsm.vhd:24:12
  clockcounter <= n67_q; -- (signal)
  -- uart_rx_fsm.vhd:30:12
  n19_o <= '1' when rising_edge (clk) else '0';
  -- uart_rx_fsm.vhd:31:13
  n21_o <= state when rst = '0' else "000";
  -- uart_rx_fsm.vhd:31:13
  n23_o <= clockcounter when rst = '0' else "0000";
  -- uart_rx_fsm.vhd:36:20
  n24_o <= not rst;
  -- uart_rx_fsm.vhd:37:25
  n25_o <= not din;
  -- uart_rx_fsm.vhd:37:41
  n27_o <= '1' when state = "000" else '0';
  -- uart_rx_fsm.vhd:37:31
  n28_o <= n25_o and n27_o;
  -- uart_rx_fsm.vhd:38:50
  n30_o <= std_logic_vector (unsigned (clockcounter) + unsigned'("0001"));
  -- uart_rx_fsm.vhd:37:17
  n31_o <= n23_o when n28_o = '0' else n30_o;
  -- uart_rx_fsm.vhd:41:33
  n33_o <= '1' when clockcounter = "0111" else '0';
  -- uart_rx_fsm.vhd:41:47
  n35_o <= '1' when state = "000" else '0';
  -- uart_rx_fsm.vhd:41:37
  n36_o <= n33_o and n35_o;
  -- uart_rx_fsm.vhd:41:72
  n37_o <= not din;
  -- uart_rx_fsm.vhd:41:64
  n38_o <= n36_o and n37_o;
  -- uart_rx_fsm.vhd:41:17
  n40_o <= n21_o when n38_o = '0' else "001";
  -- uart_rx_fsm.vhd:41:17
  n42_o <= n31_o when n38_o = '0' else "0000";
  -- uart_rx_fsm.vhd:46:26
  n44_o <= '1' when state = "001" else '0';
  -- uart_rx_fsm.vhd:47:50
  n46_o <= std_logic_vector (unsigned (clockcounter) + unsigned'("0001"));
  -- uart_rx_fsm.vhd:46:17
  n47_o <= n42_o when n44_o = '0' else n46_o;
  -- uart_rx_fsm.vhd:50:26
  n49_o <= '1' when state = "001" else '0';
  -- uart_rx_fsm.vhd:50:60
  n51_o <= '1' when clockcounter = "1111" else '0';
  -- uart_rx_fsm.vhd:50:43
  n52_o <= n49_o and n51_o;
  -- uart_rx_fsm.vhd:50:17
  n54_o <= n40_o when n52_o = '0' else "010";
  -- uart_rx_fsm.vhd:53:26
  n56_o <= '1' when state = "010" else '0';
  -- uart_rx_fsm.vhd:53:17
  n58_o <= n54_o when n56_o = '0' else "001";
  -- uart_rx_fsm.vhd:53:17
  n60_o <= n47_o when n56_o = '0' else "0000";
  -- uart_rx_fsm.vhd:36:13
  n61_o <= n21_o when n24_o = '0' else n58_o;
  -- uart_rx_fsm.vhd:36:13
  n62_o <= n23_o when n24_o = '0' else n60_o;
  -- uart_rx_fsm.vhd:30:9
  process (clk)
  begin
    if rising_edge (clk) then
      n66_q <= n61_o;
    end if;
  end process;
  -- uart_rx_fsm.vhd:30:9
  process (clk)
  begin
    if rising_edge (clk) then
      n67_q <= n62_o;
    end if;
  end process;
  -- uart_rx_fsm.vhd:70:22
  n71_o <= '1' when state = "000" else '0';
  -- uart_rx_fsm.vhd:70:13
  n74_o <= '0' when n71_o = '0' else '1';
  -- uart_rx_fsm.vhd:74:22
  n77_o <= '1' when state = "001" else '0';
  -- uart_rx_fsm.vhd:74:13
  n80_o <= '0' when n77_o = '0' else '1';
  -- uart_rx_fsm.vhd:78:22
  n83_o <= '1' when state = "010" else '0';
  -- uart_rx_fsm.vhd:78:13
  n86_o <= '0' when n83_o = '0' else '1';
end rtl;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture rtl of uart_rx is
  signal wrap_CLK: std_logic;
  signal wrap_RST: std_logic;
  signal wrap_DIN: std_logic;
  subtype typwrap_DOUT is std_logic_vector (7 downto 0);
  signal wrap_DOUT: typwrap_DOUT;
  signal wrap_DOUT_VLD: std_logic;
  signal waiting : std_logic;
  signal ready : std_logic;
  signal read : std_logic;
  signal cycle_count : std_logic_vector (2 downto 0);
  signal fsm_waiting : std_logic;
  signal fsm_ready : std_logic;
  signal fsm_read : std_logic;
  signal fsm_validation : std_logic;
  constant n9_o : std_logic := '0';
  signal n12_o : std_logic_vector (7 downto 0);
begin
  wrap_clk <= clk;
  wrap_rst <= rst;
  wrap_din <= din;
  dout <= wrap_dout;
  dout_vld <= wrap_dout_vld;
  wrap_DOUT <= n12_o;
  wrap_DOUT_VLD <= n9_o;
  -- uart_rx.vhd:25:12
  waiting <= fsm_waiting; -- (signal)
  -- uart_rx.vhd:26:12
  ready <= fsm_ready; -- (signal)
  -- uart_rx.vhd:27:12
  read <= fsm_read; -- (signal)
  -- uart_rx.vhd:29:12
  cycle_count <= "XXX"; -- (signal)
  -- uart_rx.vhd:32:5
  fsm : entity work.uart_rx_fsm port map (
    clk => wrap_CLK,
    din => wrap_DIN,
    rst => wrap_RST,
    cycle_count => cycle_count,
    waiting => fsm_waiting,
    ready => fsm_ready,
    read => fsm_read,
    validation => open);
  n12_o <= "ZZZZZ" & read & ready & waiting;
end rtl;
