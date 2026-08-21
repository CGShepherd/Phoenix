# Architecture C — first-pass hand calculations

## Design basis

Architecture C uses a filtered 24 V Zener reference and TIP41C/TIP42C
emitter-follower preregulator feeding LM317/LM337 post-regulators.

Current design assumptions:

- raw rail magnitude: 48...60 V;
- Zener nominal voltage: 24 V;
- pass transistor emitter-follower VBE: 0.65...0.80 V;
- Zener feed resistor: 4.7 kΩ provisional;
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
±17 V. This is comfortably above the typical dropout requirement of both
regulators, although dropout must ultimately be verified using the selected
manufacturer models and temperature corners.

## LM317/LM337 programming network

The regulator feedback resistor is selected as:

`R1 = 120 Ω`

The resulting programming current is approximately:

`Iprogram = 1.25 / 120 = 10.42 mA`

This is deliberately greater than the specified 10 mA minimum-load requirement
and therefore keeps each post-regulator in regulation even when the THAT1206
receiver is disconnected or drawing negligible current.

For approximately 17 V output:

`R2 ≈ R1 × ((17 / 1.25) − 1) ≈ 1.51 kΩ`

A standard value of:

`R2 = 1.50 kΩ`

is therefore the provisional design value.

Ignoring adjustment-pin current:

`Vout ≈ 1.25 × (1 + 1500 / 120) = 16.875 V`

For the LM317, including approximately 50 µA typical adjustment current gives:

`Vout ≈ 16.95 V`

and approximately 100 µA gives:

`Vout ≈ 17.03 V`.

Actual output-voltage tolerance must be established using the selected LM317
and LM337 grades rather than resistor ratio alone.

## Total preregulator current

The preregulator must supply the post-regulator programming current as well as
the THAT1206 load.

Nominal receiver load:

`Ipre ≈ 10.42 + 4.7 = 15.12 mA`

Receiver design load:

`Ipre ≈ 10.42 + 8.0 = 18.42 mA`

Receiver stress load:

`Ipre ≈ 10.42 + 10.0 = 20.42 mA`

These figures exclude small regulator internal currents and therefore remain
first-pass values.

The preregulator current design range should therefore be regarded as
approximately 15...21 mA per rail rather than the earlier 5...10 mA estimate.

## Zener-feed current with 4.7 kΩ

With a nominal 24 V Zener:

At 48 V raw:

`IRZ = (48 − 24) / 4.7k = 5.11 mA`

At 55 V raw:

`IRZ = (55 − 24) / 4.7k = 6.60 mA`

At 60 V raw:

`IRZ = (60 − 24) / 4.7k = 7.66 mA`

Using the TIP41C/TIP42C minimum current gain assumption of beta = 15:

At 20.42 mA emitter current:

`IB ≈ 20.42 / 15 = 1.36 mA`

Therefore at the lowest raw-rail condition:

`IZ ≈ 5.11 − 1.36 = 3.75 mA`

This remains plausible but is no longer generous. The selected 24 V Zener must
therefore be checked for dynamic impedance, knee current, tolerance and noise
at approximately 3.5...8 mA.

The 4.7 kΩ feed resistor remains provisional pending that component
down-selection.

## Feed-resistor dissipation

At 60 V raw:

`PRZ ≈ (60 − 24)^2 / 4.7k = 0.276 W`

A 0.5 W resistor provides poor conservative derating. A ≥0.6 W component or a
series resistor pair should therefore be considered for the prototype.

## Pass-transistor dissipation

Using a nominal preregulator output of 23.3 V:

At 60 V raw and nominal 15.12 mA rail current:

`Ppass ≈ (60 − 23.3) × 0.01512 ≈ 0.555 W`

At the 18.42 mA design load:

`Ppass ≈ (60 − 23.3) × 0.01842 ≈ 0.676 W`

At the 20.42 mA stress load:

`Ppass ≈ (60 − 23.3) × 0.02042 ≈ 0.749 W`

The first-pass thermal design point is therefore at least 0.75 W per TIP41C /
TIP42C device before tolerance, ambient-temperature and fault margin.

TO-220 devices remain appropriate, but junction temperature and mounting
thermal resistance must be explicitly verified.

## Current conclusions

1. Architecture C remains viable at the nominal ±23.3 V preregulator voltage.
2. R1 = 120 Ω is selected provisionally for both LM317 and LM337.
3. R2 = 1.50 kΩ is the provisional nominal value for approximately ±17 V.
4. The regulator programming network independently guarantees approximately
   10.4 mA minimum load.
5. Preregulator design current is approximately 15...21 mA per rail.
6. TIP41C/TIP42C dissipation reaches approximately 0.75 W at the 60 V / stress
   corner and requires deliberate thermal design.
7. The 4.7 kΩ Zener feed resistor is still credible but now requires
   verification against the selected Zener at low raw voltage, minimum beta and
   maximum load.
8. Vendor device models and tolerance sweeps are required before the
   preregulator component values are baselined.
