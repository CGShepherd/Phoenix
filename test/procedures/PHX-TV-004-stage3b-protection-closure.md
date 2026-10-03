# PHX-TV-004 — Stage 3B consolidated protection closure batch

## Purpose

Correct the two Stage 3 measurement defects and close the remaining Architecture C
protection/dynamic questions in one batch.

## Tests

00 — corrected fuse I2t and branch-resistor pulse energy.
01P/01N — bounded positive/negative pass-short regulator stress, 50 us / 200 us / 1 ms crowbar delay.
02 — BZX55C30 / 2N5064 trigger-window tolerance and temperature sensitivity.
03 — maximum normal preregulator input / nuisance-trigger margin.
04 — corrected startup/shutdown decay windows.
05 — both positive-rail-loss and negative-rail-loss directions.
06 — crowbar holding-current margin after trigger.

## Working protection baseline

- RBR = 100 ohm
- Fuse = 62 mA very-fast, 125 VDC class
- SCR = 2N5064
- Trigger Zener = BZX55C30
- Gate series resistor = 6.8 kohm
- Gate-cathode bleed = 47 kohm

## Decision objective

If all valid measurements support adequate margins, freeze the protection architecture
and move to schematic/component baseline and hardware-validation planning.
