# Architecture C — first-pass hand calculations

Assumptions for the initial model only:

- raw rail magnitude: 48…60 V;
- Zener nominal voltage: 24 V;
- pass transistor emitter follower VBE: 0.65…0.80 V;
- Zener feed resistor: 4.7 kΩ provisional;
- receiver load: 4.7 mA nominal, 8 mA design, 10 mA stress;
- LM317/LM337 target output: ±17 V.

## Preregulator output

Positive emitter follower: `Vpre+ ≈ VZ − VBE ≈ +23.2…23.35 V`.

Negative emitter follower: `Vpre− ≈ −(VZ − |VBE|) ≈ −23.2…−23.35 V`.

This leaves about 6.2 V across each 17 V post-regulator, comfortably above a ~2–3 V dropout assumption.

## Zener-feed current with 4.7 kΩ

At 48 V raw: `(48 − 24)/4.7k = 5.11 mA` total feed current.

At 55 V raw: `(55 − 24)/4.7k = 6.60 mA`.

At 60 V raw: `(60 − 24)/4.7k = 7.66 mA`.

At 10 mA emitter current and conservative BJT beta = 15, base current is about 0.67 mA. This leaves approximately 4.4 mA Zener current at 48 V raw and 7.0 mA at 60 V raw. This is plausible but the exact Zener must be selected for acceptable dynamic impedance at that current.

## Feed-resistor dissipation

At 60 V raw, `P ≈ (60 − 24)^2 / 4.7k = 0.276 W`. A 0.5 W part is marginal under conservative derating; 0.6–1 W or a series pair is preferred for prototype work.

## Pass-transistor dissipation

Ignoring regulator set-network current, at 10 mA load and 60 V raw:

`Ppass ≈ (60 − 23.3) × 0.010 ≈ 0.367 W`.

Actual dissipation will be higher because the LM317/LM337 programming network and quiescent/minimum-load current also pass through the transistor. Thermal verification must therefore use total rail current, not receiver current alone.

## Critical minimum-load observation

The post-regulator stage is the first design gate. The canonical 240 Ω set resistor draws about `1.25/240 = 5.2 mA`. This does not by itself guarantee regulation for every LM317/LM337 variant at zero external load. The normal THAT1206 load may provide the remainder, but startup, disconnected-receiver and fault cases still require explicit modelling and likely a deliberate preload or lower-value programming resistor.
