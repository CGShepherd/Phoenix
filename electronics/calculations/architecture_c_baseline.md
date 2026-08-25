# Architecture C — consolidated electrical and protection baseline

## Status

Architecture C has completed the exploratory LTspice phase through Stage 3D.

Current disposition:

- preregulator topology: PASS;
- TI LM317/LM337 model integration: PASS;
- Zener-feed sensitivity: PASS;
- temperature/thermal sensitivity: PASS;
- protection architecture: PASS;
- destructive-fault TI macromodel use: explicitly rejected outside credible operating domain;
- remaining work: schematic implementation, physical component selection, PCB layout and bench validation.

## Electrical baseline

Per rail:

- raw rail design envelope: 48...60 V nominal analysis range;
- regulator output target: approximately ±17 V;
- preregulator Zener: BZX55C24;
- Zener feed resistor: 3.6 kΩ, 1 W;
- Zener bypass capacitor: 47 µF;
- pass transistor: TIP41C / TIP42C class, TO-220;
- regulator programming resistor R1: 120 Ω;
- regulator programming resistor R2: 1.50 kΩ;
- regulator output capacitor: 10 µF provisional;
- normal external load: 4.7 mA nominal;
- design load: 8 mA;
- commissioning stress load: 10 mA.

The 120 Ω regulator programming resistor provides approximately 10.42 mA
minimum-load current independent of the external receiver load.

## Stage 2A real-regulator results

The official TI unencrypted LM317/LM337 PSpice models were converted only by
namespacing duplicate helper subcircuits so they could coexist in LTspice.

Nominal smoke-test result:

- preregulator ≈ ±23.4205 V;
- regulated outputs ≈ +16.8801 / -16.8801 V;
- output ripple ≈ 5.7 µV p-p;
- Zener current ≈ 7.26 mA per rail.

The subsequent 36-corner regulator sweep confirmed:

- regulation across 48/55/60 V raw rails;
- 0/4.7/8/10 mA external loads;
- 22.8/24/25.6 V preregulator-Zener parameter;
- regulator input current closely matching programming current + external load;
- minimum preregulator headroom comfortably above the 3 V design requirement.

## Stage 2B/2C Zener-feed decision

A BF=15 bounded pass-transistor case was retained as the conservative sensitivity point.

The RZ decision sweep compared 3.9 kΩ, 3.6 kΩ and 3.3 kΩ.

At 25 °C electrical corners:

- 3.9 kΩ minimum IZ ≈ 4.73 mA;
- 3.6 kΩ minimum IZ ≈ 5.21 mA;
- 3.3 kΩ minimum IZ ≈ 5.77 mA.

Temperature sensitivity then showed, at the deliberately harsh
48 V / 10 mA / high-VZ / 85 °C corner:

- 3.6 kΩ: IZ ≈ 4.88 mA;
- 3.3 kΩ: IZ ≈ 5.41 mA.

The 5 mA BZX55C24 value is a characterization current, not a hard conduction limit.
High-line thermal analysis showed lower dissipation with 3.6 kΩ, so the balanced
selection is:

`RZ = 3.6 kΩ, 1 W`

## Pass-transistor thermal basis

Worst normal pass-transistor dissipation is approximately 0.7...0.75 W depending
on electrical corner.

Working thermal interpretation:

- bare TO-220 may be acceptable at modest local ambient;
- enclosure temperature and airflow remain critical;
- provision for clip-on heatsink or chassis coupling should be retained;
- hardware thermal validation is required.

## Protection architecture

The final working protection stack per rail is:

1. 62 mA very-fast branch fuse, 125 VDC class;
2. 100 Ω pulse-capable/flameproof branch resistor;
3. preregulator;
4. local SMBJ30A TVS at regulator input;
5. BZX55C30-triggered 2N5064 crowbar;
6. LM317/LM337 regulator.

### Protection responsibilities

- SMBJ30A: immediate regulator input-voltage clamp;
- 2N5064 crowbar: sustained low-impedance fault path;
- 62 mA fuse: fault-energy interruption;
- 100 Ω branch resistor: current limiting and energy sharing.

## Stage 3C trigger/crowbar results

Trigger-threshold sensitivity remained:

- above maximum normal preregulator input with useful margin;
- below the regulator absolute-maximum danger region with large margin.

Crowbar current with 100 Ω branch resistance remained in the several-hundred-mA
range and had very large SCR holding-current margin.

## Stage 3D TVS results

Normal operation:

- modeled regulator input max ≈ 26.30 V;
- modeled TVS current ≈ 6 nA.

Static fault clamp:

- positive clamp ≈ 37.16 V;
- negative clamp ≈ 37.16 V.

TVS + delayed crowbar:

- regulator input remained clamped ≈ 37.14 V for simulated SCR delays from
  3 µs to 1 ms.

This resolves the Stage 3C finding that a pass-transistor C-E short could otherwise
produce about 40.47 V regulator differential.

## Final fuse-I2t closure

Corrected TVS-only fault currents:

- 48 V: ≈ 104 mA;
- 55 V: ≈ 170 mA;
- 60 V: ≈ 217 mA;
- 62 V: ≈ 235 mA.

At the 62 V corner:

- 0.25 ms I²t ≈ 13.86 µA²s;
- 0.5 ms ≈ 27.71 µA²s;
- 1 ms ≈ 55.43 µA²s;
- 2 ms ≈ 110.86 µA²s;
- 5 ms ≈ 277.15 µA²s;
- 10 ms ≈ 554.30 µA²s.

Using a nominal fuse melting I²t of 190 µA²s gives a nominal pre-arcing estimate
of approximately 3.4 ms at the 62 V TVS-only fault current.

This is suitable for architecture closure but remains a hardware-validation item
because fuse I²t is not a guaranteed maximum-clearing characteristic.

## Architecture C conclusion

Architecture C is electrically viable and the protection architecture is sufficiently
mature to proceed to schematic and PCB implementation.

No further exploratory LTspice protection sweeps are planned unless schematic
implementation introduces a material topology change.
