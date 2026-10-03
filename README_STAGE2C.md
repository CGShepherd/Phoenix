# Project Phoenix — Architecture C Stage 2C pack

Run in this order:

1. `electronics/spice/PHX_ARCH_C_stage2c_lowline_hot.cir`
2. `electronics/spice/PHX_ARCH_C_stage2c_highline_thermal.cir`

Paste both complete LTspice Error Logs.

This pack compares only 3.6 kΩ and 3.3 kΩ and targets the two actual worst-case
mechanisms instead of rerunning the full 108-corner decision matrix.

It also adds:
- `electronics/calculations/architecture_c_stage2c_thermal.md`
- `test/procedures/PHX-TV-002-stage2c-temperature-thermal.md`
