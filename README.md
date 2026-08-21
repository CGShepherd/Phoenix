# Project Phoenix

Replacement balanced-input module and protected low-voltage supply for Quad 521F amplifiers.

## Current branch point

Architecture C is the active development branch. It uses complementary 100 V series-pass BJTs (TIP41C/TIP42C) whose bases are held by filtered nominal 24 V Zener references, feeding conventional LM317/LM337 post-regulators set to nominal ±17 V.

The raw Quad rails are treated as ±48 V to ±60 V for analysis until as-built measurements close that assumption. Receiver loading is nominally about 4.7 mA per rail, with 8 mA continuous design load and 10 mA commissioning stress inherited from PHX-BL-A unless superseded by measurement.

## Immediate verification gates

1. Confirm preregulator output range and dissipation across ±48…±60 V raw input.
2. Confirm LM317/LM337 dropout margin at nominal and worst-case load.
3. Explicitly verify minimum-load behaviour; do not rely on the 240 Ω canonical set resistor alone.
4. Check startup/shutdown and 100 Hz raw-rail ripple attenuation.
5. Check pass-transistor SOA and thermal margin.
6. After nominal behaviour is satisfactory, reinstate fault-energy, fuse and crowbar coordination.

## Repository structure

- `docs/` — requirements, decisions, FMECA, verification and controlled project records.
- `electronics/kicad/` — schematic and PCB sources.
- `electronics/spice/` — LTspice models and simulation decks.
- `electronics/calculations/` — reproducible engineering calculations.
- `mechanical/` — brackets, extrusion, heatsinking and envelope work.
- `test/` — bench procedures and measured results.
- `tools/` — scripts supporting reproducible analysis.
