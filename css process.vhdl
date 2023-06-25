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
    signal served: integer := 0;
    
    signal reqs: std_logic_vector(0 to 3);
    signal sigs_in: std_logic_vector(0 to 3);
    signal sigs_out: std_logic_vector(0 to 3);

begin
    reqs <= req0 & req1 & req2 & req3;
    
    sig0_in <= sigs_in(0);
    sig1_in <= sigs_in(1);
    sig2_in <= sigs_in(2);
    sig3_in <= sigs_in(3);

    sigs_out <= sig0_out & sig1_out & sig2_out & sig3_out;

    round_process: process(priority, reqs, sigs_in, sigs_out)
    begin
        if (reqs(priority) = '1') then
            sigs_in(priority) <= esig_out;
            esig_in <= sigs_out(priority);

            sigs_in((priority + 1) mod 4) <= '0';
            sigs_in((priority + 2) mod 4) <= '0';
            sigs_in((priority + 3) mod 4) <= '0';

            served <= priority;

        elsif (reqs((priority + 1) mod 4) = '1') then
            sigs_in((priority + 1) mod 4) <= esig_out;
            esig_in <= sigs_out((priority + 1) mod 4);

            sigs_in((priority + 2) mod 4) <= '0';
            sigs_in((priority + 3) mod 4) <= '0';
            sigs_in(priority)             <= '0';

            served <= (priority + 1) mod 4;

        elsif (reqs((priority + 2) mod 4) = '1') then
            sigs_in((priority + 2) mod 4) <= esig_out;
            esig_in <= sigs_out((priority + 2) mod 4);

            sigs_in((priority + 3) mod 4) <= '0';
            sigs_in(priority)             <= '0';
            sigs_in((priority + 1) mod 4) <= '0';

            served <= (priority + 2) mod 4;

        elsif (reqs((priority + 3) mod 4) = '1') then
            sigs_in((priority + 3) mod 4) <= esig_out;
            esig_in <= sigs_out((priority + 3) mod 4);

            sigs_in(priority)             <= '0';
            sigs_in((priority + 1) mod 4) <= '0';
            sigs_in((priority + 2) mod 4) <= '0';

            served <= (priority + 3) mod 4;

        end if;

    end process round_process;

    process begin
        if (served'event) then
            priority <= (priority + 1) mod 4;
        end if;
        
        wait on served;
    end process;

end bhv;
