library ieee;
use ieee.std_logic_1164.all;

entity css is
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

end css;

architecture bhv of css is
    signal priority: integer := 0;
    
    signal reqs: std_logic_vector(0 to 3);
    signal sigs_in: std_logic_vector(0 to 3);
    signal sigs_out: std_logic_vector(0 to 3);
    signal finded: std_logic := '0';

begin
    reqs <= req0 & req1 & req2 & req3;
    sigs_in <= sig0_in & sig1_in & sig2_in & sig3_in;
    sigs_out <= sig0_out & sig1_out & sig2_out & sig3_out;

    round_process: process(priority, reqs, sigs_in, sigs_out)
    
    begin
        if (reqs /= "0000") then
            finded <= '0';

            src: for i in 0 to 3 loop
                if (reqs((priority + i) mod 4) = '1') and (finded = '0') then
                    while (reqs((priority + i) mod 4) = '1') loop
                        sigs_in((priority + i) mod 4) <= esig_out;
                        esig_in <= sigs_out((priority + i) mod 4);
                    end loop;
                    
                    finded <= '1';
                    priority <= (priority + 1) mod 4;
                else
                    sigs_in((priority + i) mod 4) <= '0';
                    esig_in <= '0';

                end if;

            end loop src;
        
        end if;
            
    end process round_process;

end bhv;
