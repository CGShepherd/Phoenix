# ADR-PHX-ARCH-C-001 — Architecture C preregulator and protection baseline

## Decision

Adopt Architecture C as the working regulated low-current auxiliary supply architecture.

Per rail:

- BZX55C24 + 3.6 kΩ + 47 µF reference/filter;
- TIP41C/TIP42C emitter-follower preregulator;
- LM317/LM337 post-regulator at approximately ±17 V;
- 120 Ω / 1.50 kΩ programming network;
- 62 mA very-fast branch fuse;
- 100 Ω pulse-capable branch resistor;
- SMBJ30A regulator-input clamp;
- BZX55C30 / 2N5064 crowbar.

## Rationale

The architecture passed:
- nominal and 36-corner real-regulator model verification;
- pass-transistor gain sensitivity;
- Zener-feed and temperature sensitivity;
- normal branch-resistor operation;
- crowbar-current and fuse-I2t coordination;
- startup/shutdown and one-rail-loss tests;
- destructive pass-short protection analysis using physical/source-based models;
- TVS clamp verification.

## Constraints

- TI regulator macromodels are not used as destructive-fault truth models.
- Fuse-clearing timing must be validated in hardware.
- Pass-transistor and resistor temperatures must be validated in the final enclosure.
- Exact vendor ordering codes remain implementation choices.

## Reopen criteria

Reopen this decision only if:
- measured raw rails exceed the validated envelope materially;
- actual load exceeds the design current envelope materially;
- selected regulator/dropout behavior differs materially from the modeled device;
- physical layout prevents the required protection topology;
- hardware validation contradicts the modeled margins.
