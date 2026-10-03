# Project Phoenix — Stage 3 consolidated batch pack

This pack changes the workflow from small manual test batches to a single automated
suite. It intentionally accepts that one deck may fail; the remaining decks still run,
and all stdout is collected into one master log.

## Prerequisites

The repository must already contain the locally prepared TI compatibility libraries:

- `electronics/spice/models/ti/ltspice/LM317_TRANS_LTSPICE.LIB`
- `electronics/spice/models/ti/ltspice/LM337_N_TRANS_LTSPICE.LIB`

The runner uses LTspice command-line batch mode. Analog Devices documents `-b` as the
batch-mode flag for simulation.

## Run

From the repository root:

    tools\run_stage3_batch.bat

Or double-click it.

If LTspice is installed somewhere unusual, set:

    set LTSPICE_EXE=C:\full\path\to\LTspice.exe
    tools\run_stage3_batch.bat

## Test suite

00 — Normal operation with 5.5 ohm fuse cold resistance and 100 ohm branch resistor.
     Sweeps VRAW, load and preregulator Zener tolerance.

01 — Trigger-threshold sensitivity using BZX55C30 28/30/32 V tolerance,
     0.04/0.12 %/K temperature-coefficient bounds, and 200/350 uA SCR trigger-current
     criteria.

02 — Ideal crowbar + fuse I2t coordination at 48/55/60 V. Measures I2t over
     0.5/1/2/5 ms and branch-resistor pulse energy.

03P — Positive pass-transistor short with crowbar response delays of 50 us, 200 us
      and 1 ms.

03N — Mirrored negative pass-transistor short with the same delays.

04 — Bipolar startup and shutdown at the 60 V raw-rail endpoint.

05 — Negative-rail loss while the positive rail remains powered.

## Important modelling limits

- 2N5064 is represented by trigger-current criteria and an ideal crowbar switch,
  not a vendor SCR macromodel.
- Fuse clearing is evaluated by measured current-squared-time against the
  Littelfuse 451/453 62 mA nominal melting I2t; the fuse is not dynamically opened
  in SPICE.
- BZX55C30 trigger-voltage temperature behaviour uses datasheet sensitivity bounds,
  not a full electrothermal model.
- TI regulator-model `N=0.01` diode warnings remain accepted vendor-model diagnostics.

## Output

All logs are written under:

`test/results/stage3_batch/`

Send back the single file:

`PHX_STAGE3_BATCH_MASTER.log`

If a deck fails, also send its corresponding `.stdout.log`.
