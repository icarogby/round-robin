library ieee;
use ieee.std_logic_1164.all;

entity tb is end;

architecture bhv of tb is
    signal req0: std_logic;
    signal req1: std_logic;
    signal req2: std_logic;
    signal req3: std_logic;

    signal sig0_in: std_logic;
    signal sig1_in: std_logic;
    signal sig2_in: std_logic;
    signal sig3_in: std_logic;

    signal sig0_out: std_logic := '1';
    signal sig1_out: std_logic := '1';
    signal sig2_out: std_logic := '1';
    signal sig3_out: std_logic := '1';

    signal esig_in: std_logic;
    signal esig_out: std_logic := '1';

    component css is
        port(
            req0: in std_logic;
            sig0_in: out std_logic;
            sig0_out: in std_logic;
            
            req1: in std_logic;
            sig1_in: out std_logic;
            sig1_out: in std_logic;
    
            req2: in std_logic;
            sig2_in: out std_logic;
            sig2_out: in std_logic;
    
            req3: in std_logic;
            sig3_in: out std_logic;
            sig3_out: in std_logic;
    
            esig_in: out std_logic;
            esig_out: in std_logic
    
        );
    
    end component;

begin
    dut: css
        port map(
            req0 => req0,
            sig0_in => sig0_in,
            sig0_out => sig0_out,

            req1 => req1,
            sig1_in => sig1_in,
            sig1_out => sig1_out,

            req2 => req2,
            sig2_in => sig2_in,
            sig2_out => sig2_out,

            req3 => req3,
            sig3_in => sig3_in,
            sig3_out => sig3_out,

            esig_in => esig_in,
            esig_out => esig_out
        );

    process begin
        req0 <= '1';
        req1 <= '0';
        req2 <= '0';
        req3 <= '0';

        wait for 100 ns;
        req0 <= '0';

        wait for 100 ns;

        req1 <= '1';
        req3 <= '1';
        wait for 100 ns;
        req1 <= '0';
        wait for 100 ns;
        req3 <= '0';

        wait;


    end process;

end;
