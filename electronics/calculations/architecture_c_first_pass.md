# Architecture C — first-pass hand calculations

## Design basis

Architecture C uses a filtered 24 V Zener reference and TIP41C/TIP42C
emitter-follower preregulator feeding LM317/LM337 post-regulators.

Current design assumptions:

- raw rail magnitude: 48...60 V;
- Zener nominal voltage: 24 V;
- pass transistor emitter-follower VBE: 0.65...0.80 V;
- Zener feed resistor: 3.9 kΩ provisional;
- Zener bypass capacitor: 47 µF provisional;
- LM317/LM337 target output: ±17 V;
- LM317/LM337 programming resistor R1: 120 Ω;
- nominal R2: 1.50 kΩ;
- THAT1206 receiver load: 4.7 mA nominal;
- receiver design load: 8 mA;
- receiver commissioning stress load: 10 mA.

The 10 mA stress condition is not an intended continuous THAT1206 load. It is
retained to provide commissioning and tolerance margin.

## Preregulator output voltage

For the positive rail:

`Vpre+ ≈ VZ − VBE ≈ +23.2...23.35 V`

For the negative rail:

`Vpre− ≈ −(VZ − |VBE|) ≈ −23.2...−23.35 V`

A nominal preregulator value of approximately ±23.3 V is therefore used for
first-pass calculations.

This leaves approximately 6.3 V across each post-regulator when producing
±17 V. Dropout must be verified with the selected regulator models and then
against guaranteed manufacturer limits.

## LM317/LM337 programming network

`R1 = 120 Ω`

`Iprogram = 1.25 / 120 = 10.42 mA`

The 120 Ω programming resistor is deliberately intended to satisfy the design
minimum-load strategy even when the THAT1206 receiver draws negligible current.

For approximately 17 V output:

`R2 ≈ R1 × ((17 / 1.25) − 1) ≈ 1.51 kΩ`

Provisional standard value:

`R2 = 1.50 kΩ`

Ignoring adjustment-pin current:

`Vout ≈ 1.25 × (1 + 1500 / 120) = 16.875 V`

For LM317, illustrative adjustment-current contributions give approximately:

- 50 µA: `Vout ≈ 16.95 V`;
- 100 µA: `Vout ≈ 17.03 V`.

Actual output tolerance is not established by these nominal calculations.

## Total preregulator current

Receiver nominal load:

`Ipre ≈ 10.42 + 4.7 = 15.12 mA`

Receiver design load:

`Ipre ≈ 10.42 + 8.0 = 18.42 mA`

Receiver stress load:

`Ipre ≈ 10.42 + 10.0 = 20.42 mA`

These exclude regulator internal-current effects and therefore remain first-pass
values pending Stage 2A model integration.

## Zener feed network

Provisional selection:

- DZP/DZN: Vishay BZX55C24;
- RZP/RZN: 3.9 kΩ, ≥1 W;
- CZP/CZN: 47 µF provisional.

For nominal VZ = 24 V:

- 48 V raw: `IRZ = (48 − 24) / 3.9k = 6.15 mA`
- 55 V raw: `IRZ = (55 − 24) / 3.9k = 7.95 mA`
- 60 V raw: `IRZ = (60 − 24) / 3.9k = 9.23 mA`

### Stage 1A reconciliation

The original conservative hand estimate used:

`IB ≈ 20.42 / 15 = 1.36 mA`

This is intentionally pessimistic because it divides emitter-current demand directly
by beta.

The Stage 1A LTspice sensitivity diagnostic explicitly measured transistor base
current. At the critical 48 V raw / 10 mA external load / VZ = 25.6 V / BF = 15
corner:

- `IRZ = 5.742763 mA`
- `IB = 1.011296 mA`
- `IZ = 4.731467 mA`
- `IRZ − IZ − IB = 3.14 pA`

Thus the earlier 4.38 mA hand estimate was directionally conservative but more
pessimistic than the explicit simplified-model result. This reconciliation does not
finalise RZ because temperature and real regulator-current behaviour remain open.

The BZX55C24 5 mA value is a characterisation/test current, not a hard conduction
threshold. Falling modestly below 5 mA is therefore not, by itself, a topology failure.

## Feed-resistor dissipation

Worst first-pass electrical corner:

`PRZ ≈ (60 − 22.8)^2 / 3.9k ≈ 0.355 W`

Provisional component requirement:

`RZ = 3.9 kΩ, ≥1 W`

## Zener dissipation

At 60 V raw and nominal 24 V Zener:

`IRZ = 9.23 mA`

Using the earlier conservative base-current allowance:

`IZ ≈ 7.87 mA`

`PZ ≈ 24 × 0.00787 ≈ 0.189 W`

Final thermal verification must account for mounting, ambient temperature and
temperature coefficient.

## Pass-transistor dissipation

Using nominal preregulator output 23.3 V:

- nominal 15.12 mA: `Ppass ≈ 0.555 W`
- design 18.42 mA: `Ppass ≈ 0.676 W`
- stress 20.42 mA: `Ppass ≈ 0.749 W`

The first-pass thermal design point is therefore at least 0.75 W per pass transistor
before tolerance, ambient-temperature and fault margin.

## Current conclusions

1. Architecture C remains viable at the nominal ±23.3 V preregulator voltage.
2. R1 = 120 Ω remains provisional for both regulators.
3. R2 = 1.50 kΩ remains provisional for approximately ±17 V.
4. Programming-network current is approximately 10.42 mA.
5. Preregulator design current is approximately 15...21 mA per rail before regulator
   internal-current refinement.
6. TIP41C/TIP42C dissipation reaches approximately 0.75 W at the 60 V / stress corner.
7. BZX55C24 + 3.9 kΩ ≥1 W + 47 µF remains the provisional Zener network.
8. Stage 1A measured 4.731 mA Zener current at the BF = 15 critical corner and
   reconciled the earlier pessimistic 4.38 mA hand estimate.
9. The TIP transistor verification strategy is now datasheet-bounded sensitivity
   analysis, not an unverified third-party macromodel.
10. TI unencrypted LM317/LM337-N models are the next critical-path simulation input.
11. RZ is not baselined until regulator-model and temperature verification are complete.
