# Architecture C — Stage 3A SOA and branch-protection basis

## Normal TIP41CG / TIP42CG operation

The established worst continuous electrical point is approximately:

- collector current: 20...21 mA;
- collector-emitter voltage: roughly 35...40 V;
- dissipation: approximately 0.74 W.

The onsemi TIP41CG/TIP42CG data sheet gives:

- VCEO = 100 V;
- IC continuous = 6 A;
- PD at TA=25 °C = 2 W;
- RθJA(max) = 57 °C/W;
- RθJC(max) = 1.67 °C/W.

The operating point is therefore far below the active-region SOA current limits.
Thermal environment, not secondary breakdown, is the primary normal-operation
constraint.

## Regulator fault constraint

With a 60 V raw rail and approximately 17 V regulated output, a preregulator
collector-emitter short can expose the regulator to approximately:

`60 - 17 = 43 V`

input-output differential.

This exceeds the 40 V class differential limit of the LM317/LM337 family and must
not be treated as a survivable steady-state condition.

Therefore Architecture C requires a dedicated branch-protection mechanism that
removes energy from the regulator supply branch after preregulator overvoltage.

## Proposed protection architecture for verification

Per rail:

raw rail -> dedicated branch fuse -> series branch resistor -> TIP41C/TIP42C collector

At the preregulator output:

- overvoltage detector / crowbar threshold nominally around 30 V magnitude;
- crowbar discharges the preregulated rail and forces dedicated branch-fuse current.

The branch resistor has three functions:

1. limits crowbar surge current;
2. moves some normal dissipation out of the pass transistor;
3. provides deterministic fault current for fuse coordination.

Candidate values for first-pass study: 47, 68 and 100 ohm.

A 30 V crowbar threshold is provisionally attractive because the hottest/highest
normal preregulator voltage observed is about 26.2 V, while 30 V remains far below
a level that would violate regulator differential voltage at a 17 V output.

No final fuse or SCR is selected in Stage 3A. The simulations establish the current
window first.
