library ieee;
use ieee.std_logic_1164.all;

entity testbench is end;

architecture bhvt of testbench is
    constant clk_period: time := 40 ns;
    signal clk_count: integer := 0;

    signal clk: std_logic;
    signal rst: std_logic;

    signal req0: std_logic;
    signal req1: std_logic;
    signal req2: std_logic;
    signal req3: std_logic;

    signal sig0_in: std_logic_vector(3 downto 0);
    signal sig1_in: std_logic_vector(3 downto 0);
    signal sig2_in: std_logic_vector(3 downto 0);
    signal sig3_in: std_logic_vector(3 downto 0);

    signal sig0_out: std_logic_vector(3 downto 0) := "1111";
    signal sig1_out: std_logic_vector(3 downto 0) := "1111";
    signal sig2_out: std_logic_vector(3 downto 0) := "1111";
    signal sig3_out: std_logic_vector(3 downto 0) := "1111";

    signal esig_in: std_logic_vector(3 downto 0);
    signal esig_out: std_logic_vector(3 downto 0) := "1111";

    component css is
        port(
            clk, rst: in std_logic;

            req0: in std_logic;
            req1: in std_logic;
            req2: in std_logic;
            req3: in std_logic;

            core0_in: out std_logic_vector(3 downto 0);
            core1_in: out std_logic_vector(3 downto 0);
            core2_in: out std_logic_vector(3 downto 0);
            core3_in: out std_logic_vector(3 downto 0);

            core0_out: in std_logic_vector(3 downto 0);
            core1_out: in std_logic_vector(3 downto 0);
            core2_out: in std_logic_vector(3 downto 0);
            core3_out: in std_logic_vector(3 downto 0);

            mem_in: out std_logic_vector(3 downto 0);
            mem_out: in std_logic_vector(3 downto 0)

    );
    
    end component;

begin
    clock_process: process

    begin
        clk <= '0';
        wait for clk_period/2;

        clk <= '1';
        clk_count <= clk_count + 1;
        wait for clk_period/2;

        if (clk_count = 100) then
            report "ending simulation";
            wait;

        end if;

    end process clock_process;

    reset_process: process
    
    begin
        rst <= '0';
        wait for 10 ns;

        rst <= '1';
        wait for 30 ns;

        rst <= '0';
        wait;
    
    end process reset_process;

    dut: css
        port map(
            clk => clk,
            rst => rst,

            req0 => req0,
            req1 => req1,
            req2 => req2,
            req3 => req3,

            core0_in => sig0_in,
            core1_in => sig1_in,
            core2_in => sig2_in,
            core3_in => sig3_in,

            core0_out => sig0_out,
            core1_out => sig1_out,  
            core2_out => sig2_out,
            core3_out => sig3_out,

            mem_in => esig_in,
            mem_out => esig_out

        );

    process begin
        req0 <= '1';
        req1 <= '1';
        req2 <= '1';
        req3 <= '1';

        wait for 100 ns;
        req0 <= '0';
        wait for 100 ns;

        wait for 100 ns;
        req1 <= '0';
        wait for 100 ns;

        wait for 100 ns;
        req2 <= '0';
        wait for 100 ns;

        wait for 100 ns;
        req3 <= '0';
        wait for 100 ns;

        req0 <= '1';
        req2 <= '1';

        wait for 100 ns;
        req0 <= '0';
        wait for 100 ns;
        req2 <= '0';

        req0 <= '1';
        req3 <= '1';

        wait for 100 ns;
        req3 <= '0';
        wait for 100 ns;
        req0 <= '0';

        wait;


    end process;

end bhvt;
