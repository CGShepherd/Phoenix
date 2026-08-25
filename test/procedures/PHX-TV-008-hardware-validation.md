# PHX-TV-008 — Architecture C hardware validation plan

## Purpose

Translate the completed LTspice verification into a controlled bench-validation plan.

## Pre-power checks

- verify fuse value and DC rating;
- verify branch resistor value and pulse-capable part;
- verify TVS and crowbar polarity on both rails;
- verify TIP41C/TIP42C pinout and heatsinking;
- verify LM317/LM337 pinout and programming resistors;
- verify no short between rails and 0 V.

## Initial current-limited power-up

1. power each rail separately with a current-limited bench supply;
2. start below final raw-rail voltage;
3. confirm preregulator voltage;
4. confirm ±17 V post-regulator output;
5. confirm quiescent current;
6. increase to nominal raw rail;
7. repeat both rails together.

## Functional load test

For each rail:
- 0 mA external load;
- 4.7 mA nominal load;
- 8 mA design load;
- 10 mA commissioning stress load.

Record:
- raw input;
- preregulator input/output;
- regulated output;
- regulator differential;
- branch current;
- Zener current if instrumentable;
- pass-transistor case temperature;
- branch-resistor temperature.

## Ripple test

Inject/measure representative 100 Hz raw-rail ripple and record:
- preregulator ripple;
- regulated output ripple.

## Thermal soak

At worst intended steady-state load:
- operate until temperatures stabilize;
- record ambient, TIP case temperature, regulator case temperature,
  branch-resistor temperature and Zener temperature if practical.

## Protection tests

Use a sacrificial/current-limited setup first.

### TVS clamp test
- emulate preregulator pass-short using current-limited source;
- confirm regulator-input clamp below 40 V;
- confirm positive/negative symmetry.

### Crowbar/fuse test
- use replaceable fuse;
- trigger crowbar deliberately;
- measure peak current and fuse-opening time;
- inspect branch resistor, SCR and TVS after event.

### One-rail-loss test
- remove each rail in turn while the opposite rail remains powered;
- confirm surviving rail remains regulated and no damaging cross-current occurs.

## Acceptance

Hardware validation passes when:
- normal outputs/regulation match analysis within component tolerances;
- thermal margins are acceptable in the final enclosure;
- TVS clamp keeps regulator differential below absolute maximum;
- crowbar/fuse clears fault without secondary damage;
- both rails behave symmetrically within expected tolerances.
