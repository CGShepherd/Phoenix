# PHX-ADR-003 — Architecture C branch point

**Status:** Active development branch; verification required before freeze.

## Decision

Proceed with a symmetrical low-complexity preregulator comprising:

- + rail: filtered nominal 24 V Zener reference driving TIP41C emitter follower;
- − rail: polarity-mirrored filtered nominal 24 V Zener reference driving TIP42C emitter follower;
- post-regulation: LM317 / LM337 adjusted to nominal +17 V / −17 V.

## Reason for reopening the earlier trade

PHX-BL-A selected an LT3010 plus bespoke negative regulator and listed direct Zener followers and standard LM317/LM337-after-drop-stage approaches as rejected. Architecture C therefore constitutes an explicit branch from that baseline, not a continuation of the former frozen architecture.

The branch is justified only if modelling and bench evidence show that the simpler symmetrical implementation meets voltage, thermal, noise, minimum-load and fault-containment requirements with lower design risk.

## Verification conditions

Raw input magnitude: 48 V, 55 V and 60 V initially; load 0…10 mA per receiver rail. The 0 mA point is a regulator/minimum-load stress case rather than a normal receiver operating condition.

## Open items

- Zener part and test current.
- Zener feed resistor and filtering capacitor.
- LM317/LM337 manufacturer and exact set network.
- Required preload, if any.
- Pass-device heatsinking.
- Crowbar threshold and fuse coordination.
