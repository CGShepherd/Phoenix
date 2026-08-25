# Architecture C — exact component down-selection

## Status

This document converts the Architecture C electrical baseline into implementable
manufacturer part selections.

## Selected parts

| Function | Manufacturer | Manufacturer part number | Package / value | Status | Rationale |
|---|---|---|---|---|---|
| Positive pass transistor | onsemi | TIP41CG | TO-220-3, 100 V, 6 A | SELECTED | Active production; matches validated TIP41C class and BF>=15 sensitivity basis |
| Negative pass transistor | onsemi | TIP42CG | TO-220-3, 100 V, 6 A | SELECTED | Complementary active-production mate to TIP41CG |
| Positive regulator | Texas Instruments | LM317AT/NOPB | TO-220 NDE, 1.5 A, 40 V differential | SELECTED | Active, through-hole, improved accuracy and -40..125 C rating |
| Negative regulator | Texas Instruments | LM337T/NOPB | TO-220 NDE, 1.5 A, 40 V differential | SELECTED | Active, through-hole, direct negative complement class |
| 24 V preregulator Zener | Vishay | BZX55C24-TR | DO-35, 24 V, 500 mW, +/-5% | SELECTED | Matches Stage 2 model/tolerance basis |
| 30 V crowbar trigger Zener | Vishay | BZX55C30-TR | DO-35, 30 V, 500 mW, +/-5% | SELECTED | Matches Stage 3 trigger-window verification |
| Zener feed resistor | Vishay | PR01000103601JR500 | PR01 axial, 3.6 kΩ, 1 W, +/-5% | SELECTED | 1 W flameproof metal-film part; baseline value |
| Zener bypass capacitor | Panasonic Industry | EEU-FR1H470 | Radial, 47 µF, 50 V, 105 C | SELECTED | 50 V margin over ~24-27 V node; low impedance, long-life FR series |
| Regulator output capacitor | Panasonic Industry | EEU-FR1H100 | Radial, 10 µF, 50 V, 105 C | SELECTED | Satisfies 10 µF aluminum output-cap strategy, generous voltage margin |
| Branch fuse | Littelfuse | 0451.062MRL | NANO2 SMD, 62 mA, 125 V, very fast | SELECTED | Matches Stage 3 fuse-I2t analysis; 5.5 Ω nominal cold resistance |
| Branch pulse resistor | Vishay | AC03000001000JACCS | Axial, 100 Ω, 3 W, +/-5% | SELECTED | Pulse-capable/flameproof/fusible safety wirewound; large pulse-energy margin |
| Immediate regulator clamp | Littelfuse | SMBJ30A | SMB, 30 V standoff, 600 W TVS | SELECTED | Stage 3D clamp model based on this device family |
| Crowbar SCR | Central Semiconductor | 2N5064 PBFREE | TO-92, 200 V, 0.8 A, sensitive gate | SELECTED | Current-production electrical equivalent to validated 2N5064; avoids discontinued onsemi source |
| SCR gate resistor | Generic metal film | 6.8 kΩ, 1%, >=0.25 W | Axial or 1206 | VALUE FROZEN | Non-critical footprint choice |
| SCR gate-cathode bleed | Generic metal film | 47 kΩ, 1%, >=0.25 W | Axial or 1206 | VALUE FROZEN | Non-critical footprint choice |
| Regulator set resistor R1 | Generic metal film | 120 Ω, 1%, >=0.25 W | Axial or 1206 | VALUE FROZEN | Provides ~10.42 mA programming current |
| Regulator set resistor R2 | Generic metal film | 1.50 kΩ, 1%, >=0.25 W | Axial or 1206 | VALUE FROZEN | Gives ~16.9 V nominal output |

## Implementation notes

### Regulator package choice

Use TO-220 through-hole packages for both regulators and pass transistors. This gives:
- convenient thermal access;
- simple clip-on heatsink provision;
- robust prototype handling;
- straightforward bench probing.

### Fuse footprint

The Littelfuse 451-series NANO2 fuse is surface-mount:
- body approximately 6.10 x 2.69 mm;
- recommended pad length approximately 6.86 mm overall.

Place the fuse near the raw-rail entry to each protected branch.

### Branch resistor

The selected AC03-CS is much more capable than the simulated fault energy:
Stage 3D predicted only tens of millijoules before fuse operation, while the
AC03-CS family has multi-joule pulse capability at 100 Ω.

### SCR source correction

onsemi's historical 2N5064 source is discontinued. Central Semiconductor currently
lists through-hole 2N5064 as active. Use Central Semiconductor `2N5064 PBFREE` as the
preferred source while retaining the validated 2N5064 electrical assumptions.

## Remaining implementation-only choices

- exact heatsink / thermal clip;
- exact PCB footprints for generic 1% resistors;
- optional input bypass capacitor immediately at each LM317/LM337;
- connector family and test-point style;
- creepage/clearance rules for raw rails;
- PCB copper allocation around TO-220 devices and TVS.
