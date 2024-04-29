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
    rst : in std_logic;
    din : in std_logic;
    clk_cycle_cnt : in std_logic_vector (4 downto 0);
    bit_cnt : in std_logic_vector (3 downto 0);
    clk_cycle_active : out std_logic;
    data_recieve_active : out std_logic;
    data_validate_active : out std_logic);
end entity uart_rx_fsm;

architecture rtl of uart_rx_fsm is
  signal current_state : std_logic_vector (2 downto 0);
  signal n105_o : std_logic;
  signal n107_o : std_logic;
  signal n108_o : std_logic;
  signal n109_o : std_logic;
  signal n113_o : std_logic;
  signal n114_o : std_logic;
  signal n118_o : std_logic;
  signal n119_o : std_logic;
  signal n123_o : std_logic;
  signal n125_o : std_logic;
  signal n126_o : std_logic;
  signal n128_o : std_logic_vector (2 downto 0);
  signal n129_o : std_logic;
  signal n131_o : std_logic;
  signal n133_o : std_logic;
  signal n135_o : std_logic_vector (2 downto 0);
  signal n136_o : std_logic;
  signal n138_o : std_logic;
  signal n140_o : std_logic;
  signal n142_o : std_logic_vector (2 downto 0);
  signal n143_o : std_logic;
  signal n145_o : std_logic;
  signal n147_o : std_logic;
  signal n149_o : std_logic_vector (2 downto 0);
  signal n150_o : std_logic;
  signal n151_o : std_logic;
  signal n153_o : std_logic;
  signal n155_o : std_logic_vector (2 downto 0);
  signal n160_q : std_logic_vector (2 downto 0) := "000";
begin
  clk_cycle_active <= n109_o;
  data_recieve_active <= n119_o;
  data_validate_active <= n114_o;
  -- uart_rx_fsm.vhd:22:12
  current_state <= n160_q; -- (isignal)
  -- uart_rx_fsm.vhd:25:48
  n105_o <= '1' when current_state = "100" else '0';
  -- uart_rx_fsm.vhd:25:82
  n107_o <= '1' when current_state = "000" else '0';
  -- uart_rx_fsm.vhd:25:65
  n108_o <= n105_o or n107_o;
  -- uart_rx_fsm.vhd:25:29
  n109_o <= '1' when n108_o = '0' else '0';
  -- uart_rx_fsm.vhd:26:52
  n113_o <= '1' when current_state = "100" else '0';
  -- uart_rx_fsm.vhd:26:33
  n114_o <= '0' when n113_o = '0' else '1';
  -- uart_rx_fsm.vhd:27:51
  n118_o <= '1' when current_state = "010" else '0';
  -- uart_rx_fsm.vhd:27:32
  n119_o <= '0' when n118_o = '0' else '1';
  -- uart_rx_fsm.vhd:34:15
  n123_o <= '1' when rising_edge (clk) else '0';
  -- uart_rx_fsm.vhd:37:31
  n125_o <= '1' when std_logic_vector'("000") = current_state else '0';
  -- uart_rx_fsm.vhd:38:28
  n126_o <= not din;
  -- uart_rx_fsm.vhd:37:17
  n128_o <= current_state when n129_o = '0' else "001";
  -- uart_rx_fsm.vhd:37:17
  n129_o <= n125_o and n126_o;
  -- uart_rx_fsm.vhd:43:35
  n131_o <= '1' when current_state = "001" else '0';
  -- uart_rx_fsm.vhd:44:38
  n133_o <= '1' when clk_cycle_cnt = "10111" else '0';
  -- uart_rx_fsm.vhd:43:17
  n135_o <= n128_o when n136_o = '0' else "010";
  -- uart_rx_fsm.vhd:43:17
  n136_o <= n131_o and n133_o;
  -- uart_rx_fsm.vhd:49:34
  n138_o <= '1' when current_state = "010" else '0';
  -- uart_rx_fsm.vhd:50:32
  n140_o <= '1' when bit_cnt = "1000" else '0';
  -- uart_rx_fsm.vhd:49:17
  n142_o <= n135_o when n143_o = '0' else "011";
  -- uart_rx_fsm.vhd:49:17
  n143_o <= n138_o and n140_o;
  -- uart_rx_fsm.vhd:54:34
  n145_o <= '1' when current_state = "011" else '0';
  -- uart_rx_fsm.vhd:56:42
  n147_o <= '1' when clk_cycle_cnt = "01111" else '0';
  -- uart_rx_fsm.vhd:54:17
  n149_o <= n142_o when n151_o = '0' else "100";
  -- uart_rx_fsm.vhd:55:21
  n150_o <= din and n147_o;
  -- uart_rx_fsm.vhd:54:17
  n151_o <= n145_o and n150_o;
  -- uart_rx_fsm.vhd:62:34
  n153_o <= '1' when current_state = "100" else '0';
  -- uart_rx_fsm.vhd:62:17
  n155_o <= n149_o when n153_o = '0' else "000";
  -- uart_rx_fsm.vhd:34:9
  process (clk, rst)
  begin
    if rst = '1' then
      n160_q <= "000";
    elsif rising_edge (clk) then
      n160_q <= n155_o;
    end if;
  end process;
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
  signal clk_cycle_cnt : std_logic_vector (4 downto 0);
  signal clk_cycle_active : std_logic;
  signal bit_cnt : std_logic_vector (3 downto 0);
  signal data_recieve_active : std_logic;
  signal data_validate_active : std_logic;
  signal fsm_clk_cycle_active : std_logic;
  signal fsm_data_recieve_active : std_logic;
  signal fsm_data_validate_active : std_logic;
  signal n12_o : std_logic;
  signal n13_o : std_logic;
  signal n15_o : std_logic_vector (4 downto 0);
  signal n17_o : std_logic_vector (4 downto 0);
  signal n19_o : std_logic;
  signal n22_o : std_logic;
  signal n24_o : std_logic_vector (3 downto 0);
  signal n26_o : std_logic;
  signal n28_o : std_logic;
  signal n30_o : std_logic;
  signal n32_o : std_logic;
  signal n34_o : std_logic;
  signal n36_o : std_logic;
  signal n38_o : std_logic;
  signal n40_o : std_logic;
  signal n42_o : std_logic;
  signal n44_o : std_logic;
  signal n46_o : std_logic;
  signal n47_o : std_logic_vector (7 downto 0);
  signal n48_o : std_logic;
  signal n49_o : std_logic;
  signal n50_o : std_logic;
  signal n51_o : std_logic;
  signal n52_o : std_logic;
  signal n53_o : std_logic;
  signal n54_o : std_logic;
  signal n55_o : std_logic;
  signal n56_o : std_logic;
  signal n57_o : std_logic;
  signal n58_o : std_logic;
  signal n59_o : std_logic;
  signal n60_o : std_logic;
  signal n61_o : std_logic;
  signal n62_o : std_logic;
  signal n63_o : std_logic;
  signal n72_o : std_logic_vector (3 downto 0);
  signal n73_o : std_logic_vector (7 downto 0);
  signal n76_o : std_logic_vector (4 downto 0);
  signal n77_o : std_logic_vector (3 downto 0);
  signal n78_o : std_logic;
  signal n79_o : std_logic;
  signal n80_o : std_logic;
  signal n94_o : std_logic_vector (7 downto 0);
  signal n95_q : std_logic_vector (7 downto 0);
  signal n96_q : std_logic;
  signal n97_q : std_logic_vector (4 downto 0) := "00001";
  signal n98_q : std_logic_vector (3 downto 0) := "0000";
begin
  wrap_clk <= clk;
  wrap_rst <= rst;
  wrap_din <= din;
  dout <= wrap_dout;
  dout_vld <= wrap_dout_vld;
  wrap_DOUT <= n95_q;
  wrap_DOUT_VLD <= n96_q;
  -- uart_rx.vhd:19:12
  clk_cycle_cnt <= n97_q; -- (isignal)
  -- uart_rx.vhd:20:12
  clk_cycle_active <= fsm_clk_cycle_active; -- (isignal)
  -- uart_rx.vhd:21:12
  bit_cnt <= n98_q; -- (isignal)
  -- uart_rx.vhd:22:12
  data_recieve_active <= fsm_data_recieve_active; -- (isignal)
  -- uart_rx.vhd:23:12
  data_validate_active <= fsm_data_validate_active; -- (isignal)
  -- uart_rx.vhd:27:5
  fsm : entity work.uart_rx_fsm port map (
    clk => wrap_CLK,
    rst => wrap_RST,
    din => wrap_DIN,
    clk_cycle_cnt => clk_cycle_cnt,
    bit_cnt => bit_cnt,
    clk_cycle_active => fsm_clk_cycle_active,
    data_recieve_active => fsm_data_recieve_active,
    data_validate_active => fsm_data_validate_active);
  -- uart_rx.vhd:50:15
  n12_o <= '1' when rising_edge (wrap_CLK) else '0';
  -- uart_rx.vhd:52:33
  n13_o <= not clk_cycle_active;
  -- uart_rx.vhd:55:48
  n15_o <= std_logic_vector (unsigned (clk_cycle_cnt) + unsigned'("00001"));
  -- uart_rx.vhd:52:13
  n17_o <= n15_o when n13_o = '0' else "00001";
  -- uart_rx.vhd:60:24
  n19_o <= '1' when bit_cnt = "1000" else '0';
  -- uart_rx.vhd:61:17
  n22_o <= '0' when data_validate_active = '0' else '1';
  -- uart_rx.vhd:60:13
  n24_o <= bit_cnt when n28_o = '0' else "0000";
  -- uart_rx.vhd:60:13
  n26_o <= '0' when n19_o = '0' else n22_o;
  -- uart_rx.vhd:60:13
  n28_o <= n19_o and data_validate_active;
  -- uart_rx.vhd:68:34
  n30_o <= '1' when unsigned (clk_cycle_cnt) >= unsigned'("10000") else '0';
  -- uart_rx.vhd:73:25
  n32_o <= '1' when bit_cnt = "0000" else '0';
  -- uart_rx.vhd:76:25
  n34_o <= '1' when bit_cnt = "0001" else '0';
  -- uart_rx.vhd:79:25
  n36_o <= '1' when bit_cnt = "0010" else '0';
  -- uart_rx.vhd:82:25
  n38_o <= '1' when bit_cnt = "0011" else '0';
  -- uart_rx.vhd:85:25
  n40_o <= '1' when bit_cnt = "0100" else '0';
  -- uart_rx.vhd:88:25
  n42_o <= '1' when bit_cnt = "0101" else '0';
  -- uart_rx.vhd:91:25
  n44_o <= '1' when bit_cnt = "0110" else '0';
  -- uart_rx.vhd:94:25
  n46_o <= '1' when bit_cnt = "0111" else '0';
  n47_o <= n46_o & n44_o & n42_o & n40_o & n38_o & n36_o & n34_o & n32_o;
  n48_o <= n95_q (0);
  -- uart_rx.vhd:72:21
  with n47_o select n49_o <=
    n48_o when "10000000",
    n48_o when "01000000",
    n48_o when "00100000",
    n48_o when "00010000",
    n48_o when "00001000",
    n48_o when "00000100",
    n48_o when "00000010",
    wrap_DIN when "00000001",
    n48_o when others;
  n50_o <= n95_q (1);
  -- uart_rx.vhd:72:21
  with n47_o select n51_o <=
    n50_o when "10000000",
    n50_o when "01000000",
    n50_o when "00100000",
    n50_o when "00010000",
    n50_o when "00001000",
    n50_o when "00000100",
    wrap_DIN when "00000010",
    n50_o when "00000001",
    n50_o when others;
  n52_o <= n95_q (2);
  -- uart_rx.vhd:72:21
  with n47_o select n53_o <=
    n52_o when "10000000",
    n52_o when "01000000",
    n52_o when "00100000",
    n52_o when "00010000",
    n52_o when "00001000",
    wrap_DIN when "00000100",
    n52_o when "00000010",
    n52_o when "00000001",
    n52_o when others;
  n54_o <= n95_q (3);
  -- uart_rx.vhd:72:21
  with n47_o select n55_o <=
    n54_o when "10000000",
    n54_o when "01000000",
    n54_o when "00100000",
    n54_o when "00010000",
    wrap_DIN when "00001000",
    n54_o when "00000100",
    n54_o when "00000010",
    n54_o when "00000001",
    n54_o when others;
  n56_o <= n95_q (4);
  -- uart_rx.vhd:72:21
  with n47_o select n57_o <=
    n56_o when "10000000",
    n56_o when "01000000",
    n56_o when "00100000",
    wrap_DIN when "00010000",
    n56_o when "00001000",
    n56_o when "00000100",
    n56_o when "00000010",
    n56_o when "00000001",
    n56_o when others;
  n58_o <= n95_q (5);
  -- uart_rx.vhd:72:21
  with n47_o select n59_o <=
    n58_o when "10000000",
    n58_o when "01000000",
    wrap_DIN when "00100000",
    n58_o when "00010000",
    n58_o when "00001000",
    n58_o when "00000100",
    n58_o when "00000010",
    n58_o when "00000001",
    n58_o when others;
  n60_o <= n95_q (6);
  -- uart_rx.vhd:72:21
  with n47_o select n61_o <=
    n60_o when "10000000",
    wrap_DIN when "01000000",
    n60_o when "00100000",
    n60_o when "00010000",
    n60_o when "00001000",
    n60_o when "00000100",
    n60_o when "00000010",
    n60_o when "00000001",
    n60_o when others;
  n62_o <= n95_q (7);
  -- uart_rx.vhd:72:21
  with n47_o select n63_o <=
    wrap_DIN when "10000000",
    n62_o when "01000000",
    n62_o when "00100000",
    n62_o when "00010000",
    n62_o when "00001000",
    n62_o when "00000100",
    n62_o when "00000010",
    n62_o when "00000001",
    n62_o when others;
  -- uart_rx.vhd:72:21
  with n47_o select n72_o <=
    "1000" when "10000000",
    "0111" when "01000000",
    "0110" when "00100000",
    "0101" when "00010000",
    "0100" when "00001000",
    "0011" when "00000100",
    "0010" when "00000010",
    "0001" when "00000001",
    n24_o when others;
  n73_o <= n63_o & n61_o & n59_o & n57_o & n55_o & n53_o & n51_o & n49_o;
  -- uart_rx.vhd:67:13
  n76_o <= n17_o when n79_o = '0' else "00001";
  -- uart_rx.vhd:67:13
  n77_o <= n24_o when n80_o = '0' else n72_o;
  -- uart_rx.vhd:67:13
  n78_o <= data_recieve_active and n30_o;
  -- uart_rx.vhd:67:13
  n79_o <= data_recieve_active and n30_o;
  -- uart_rx.vhd:67:13
  n80_o <= data_recieve_active and n30_o;
  -- uart_rx.vhd:67:13
  n94_o <= n95_q when n78_o = '0' else n73_o;
  -- uart_rx.vhd:50:9
  process (wrap_CLK, wrap_RST)
  begin
    if wrap_RST = '1' then
      n95_q <= "00000000";
    elsif rising_edge (wrap_CLK) then
      n95_q <= n94_o;
    end if;
  end process;
  -- uart_rx.vhd:50:9
  process (wrap_CLK, wrap_RST)
  begin
    if wrap_RST = '1' then
      n96_q <= '0';
    elsif rising_edge (wrap_CLK) then
      n96_q <= n26_o;
    end if;
  end process;
  -- uart_rx.vhd:50:9
  process (wrap_CLK, wrap_RST)
  begin
    if wrap_RST = '1' then
      n97_q <= "00001";
    elsif rising_edge (wrap_CLK) then
      n97_q <= n76_o;
    end if;
  end process;
  -- uart_rx.vhd:50:9
  process (wrap_CLK, wrap_RST)
  begin
    if wrap_RST = '1' then
      n98_q <= "0000";
    elsif rising_edge (wrap_CLK) then
      n98_q <= n77_o;
    end if;
  end process;
end rtl;
