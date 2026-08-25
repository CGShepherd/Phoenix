# Architecture C — provisional component baseline

| Function | Component / value | Status | Notes |
|---|---|---|---|
| Positive pass transistor | TIP41C-class TO-220 | Provisional | Final manufacturer/ordering code to be selected |
| Negative pass transistor | TIP42C-class TO-220 | Provisional | Final manufacturer/ordering code to be selected |
| Preregulator Zener | BZX55C24 | Baseline | Per rail |
| Zener feed resistor | 3.6 kΩ, 1 W | Baseline | Per rail |
| Zener bypass capacitor | 47 µF | Baseline electrical value | Voltage/series to be selected |
| Positive regulator | LM317 family | Baseline | Exact grade/package to be selected |
| Negative regulator | LM337 family | Baseline | Exact grade/package to be selected |
| R1 | 120 Ω | Baseline | Per regulator |
| R2 | 1.50 kΩ | Baseline | Per regulator |
| Output capacitor | 10 µF | Provisional | Stability/technology to confirm against selected parts |
| Branch fuse | 62 mA very-fast, ≥125 VDC | Baseline function/rating | Littelfuse 451/453 family candidate |
| Branch resistor | 100 Ω pulse-capable/flameproof | Baseline | 3 W safety/pulse wirewound candidate |
| Immediate clamp | SMBJ30A | Baseline | One per regulator input |
| Crowbar SCR | 2N5064 | Baseline candidate | One per rail |
| Crowbar trigger Zener | BZX55C30 | Baseline | One per rail |
| SCR gate resistor | 6.8 kΩ | Baseline | One per rail |
| SCR gate-cathode bleed | 47 kΩ | Baseline | One per rail |

## Items not yet frozen to manufacturer ordering code

The architecture is frozen at the electrical/component-function level. Final sourcing
still requires:

- exact TIP41C/TIP42C manufacturer;
- exact LM317/LM337 grade and package;
- capacitor voltage ratings, ESR class and series;
- exact 100 Ω pulse resistor;
- exact 62 mA fuse ordering code and footprint;
- exact SMBJ30A manufacturer/package;
- exact 2N5064 sourcing choice.

These are implementation selections, not architecture reopeners unless vendor data
reveals a material incompatibility.
