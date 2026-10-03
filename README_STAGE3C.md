# Project Phoenix — Stage 3C final protection-closure batch

This is the final LTspice protection batch planned for Architecture C.

Destructive-fault simulations no longer use TI LM317/LM337 macromodels. The regulator
is evaluated against its datasheet differential-voltage limit using the physical source,
fuse, branch resistor and crowbar network.

Run:

    tools\run_stage3c_batch.bat

Return:

    test\results\stage3c_batch\PHX_STAGE3C_MASTER.log

The batch covers:
- corrected trigger threshold bounds;
- positive and negative fault-delay exposure from 10 us to 5 ms;
- fuse-current/I2t accumulation;
- 100 ohm branch resistor peak power and pulse energy;
- trigger margin against maximum normal preregulator voltage.

If these results are coherent, freeze the protection architecture and move to
component/schematic baseline plus bench-validation planning.
