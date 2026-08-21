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

## Zener feed network

The initial 4.7 kΩ Zener-feed resistor is replaced provisionally by:

`RZ = 3.9 kΩ`

The selected provisional Zener is:

`Vishay BZX55C24`

The BZX55C24 is characterised at approximately 5 mA, which aligns well with
the intended operating region of this preregulator.

For the nominal 24 V Zener voltage:

At 48 V raw:

`IRZ = (48 − 24) / 3.9k = 6.15 mA`

At 55 V raw:

`IRZ = (55 − 24) / 3.9k = 7.95 mA`

At 60 V raw:

`IRZ = (60 − 24) / 3.9k = 9.23 mA`

Using the conservative pass-transistor current-gain assumption of beta = 15
and the 20.42 mA stress emitter current:

`IB ≈ 20.42 / 15 = 1.36 mA`

At nominal Zener voltage and 48 V raw:

`IZ ≈ 6.15 − 1.36 = 4.79 mA`

This places the worst nominal operating point close to the BZX55C24 5 mA
characterisation current.

### Zener-voltage tolerance

The BZX55C24 Zener-voltage range is approximately 22.8...25.6 V at its
specified test current.

At the minimum raw rail, maximum Zener voltage and maximum preregulator load:

`IRZ = (48 − 25.6) / 3.9k = 5.74 mA`

With beta = 15:

`IZ ≈ 5.74 − 1.36 = 4.38 mA`

At the minimum raw rail, minimum Zener voltage and the same load:

`IRZ = (48 − 22.8) / 3.9k = 6.46 mA`

`IZ ≈ 6.46 − 1.36 = 5.10 mA`

The approximate worst-case Zener-current range at the low-line/high-load
corner is therefore:

`IZ ≈ 4.4...5.1 mA`

This is materially better aligned with the selected Zener than the original
4.7 kΩ feed resistor.

The 3.9 kΩ value is therefore selected provisionally, subject to SPICE and
bench verification.

## Feed-resistor dissipation

The maximum first-pass feed-resistor dissipation occurs at high raw voltage
and low Zener voltage.

For 60 V raw and VZ = 22.8 V:

`PRZ ≈ (60 − 22.8)^2 / 3.9k ≈ 0.355 W`

A 0.5 W component does not provide desirable thermal derating at this operating
point.

The provisional component requirement is therefore:

`RZ = 3.9 kΩ, ≥1 W`

A single 1 W resistor or an electrically equivalent series pair may be used
subject to PCB layout and thermal considerations.

## Zener dissipation

At 60 V raw and a nominal 24 V Zener:

`IRZ = 9.23 mA`

Allowing approximately 1.36 mA base current at the stress load:

`IZ ≈ 7.87 mA`

The corresponding nominal Zener dissipation is approximately:

`PZ ≈ 24 × 0.00787 ≈ 0.189 W`

Across the first-pass Zener-voltage tolerance corners, calculated Zener
dissipation remains approximately 0.19 W. Additional thermal and device
tolerances will be assessed separately rather than folded into this nominal
electrical calculation.

This remains below the BZX55C24 nominal power rating, but final thermal
verification must account for PCB mounting, lead length, ambient temperature
and the Zener's positive temperature coefficient.

## Provisional Zener-network down-selection

The current Architecture C preregulator down-selection is:

- DZP/DZN: Vishay BZX55C24;
- RZP/RZN: 3.9 kΩ, ≥1 W;
- CZP/CZN: 47 µF provisional.

The Zener voltage and feed resistor remain subject to tolerance simulation,
thermal verification and bench measurement before being baselined.


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
7. The provisional Zener network is BZX55C24 with a 3.9 kΩ, ≥1 W feed
   resistor. Worst-case low-line Zener current is approximately 4.4...5.1 mA.
8. Zener tolerance, temperature behaviour, vendor transistor models and
   regulator models must be verified before the preregulator values are
   baselined.
