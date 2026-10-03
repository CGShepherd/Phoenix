# PHX-TV-005 — Architecture C Stage 3C protection closure

## Working protection architecture

- Fuse: 62 mA very-fast, 125 VDC class
- Branch resistor: 100 ohm, pulse-capable/flameproof
- Crowbar SCR: 2N5064
- Trigger Zener: BZX55C30
- Gate resistor: 6.8 kohm
- Gate-cathode resistor: 47 kohm

## Closure criteria

1. minimum trigger threshold remains above maximum normal preregulator voltage;
2. maximum trigger threshold remains comfortably below the regulator 40 V
   input-output differential danger point;
3. crowbar fault current exceeds SCR holding current with large margin;
4. fuse melting I2t is reached quickly enough relative to regulator exposure;
5. branch resistor pulse energy is compatible with a selected pulse-rated part;
6. positive and negative rails remain symmetric in destructive-fault analysis.

The destructive-fault model is intentionally passive/source-based and does not use
the TI regulator behavioural macromodel outside its credible normal operating domain.
