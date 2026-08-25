# Architecture C — schematic implementation connectivity

## Positive rail

`RAW+` -> `FUSE_P` -> `RBR_P 100R` -> node `PRE_RAW_P`

At `PRE_RAW_P`:
- RZP 3.6k to Zener/base node `ZBP`
- collector of TIP41CG
- fault branch supply source for regulator path

At `ZBP`:
- BZX55C24 cathode
- 47 uF capacitor positive terminal
- TIP41CG base

BZX55C24 anode -> 0 V
47 uF capacitor negative -> 0 V

TIP41CG emitter -> `PREP`

`PREP` -> LM317AT/NOPB input

At LM317 input:
- SMBJ30A cathode to LM317 input
- SMBJ30A anode to 0 V
- crowbar SCR anode to LM317 input
- crowbar SCR cathode to 0 V

LM317:
- OUT -> `+17V`
- R1 120R from OUT to ADJ
- R2 1.50k from ADJ to 0 V
- 10 uF output capacitor positive to `+17V`, negative to 0 V

Crowbar trigger:
- BZX55C30 senses regulator input overvoltage
- 6.8k series gate resistor to SCR gate
- 47k gate-cathode bleed
- orient to trigger only for positive overvoltage

## Negative rail

Mirror the positive rail electrically.

`RAW-` -> `FUSE_N` -> `RBR_N 100R` -> node `PRE_RAW_N`

At `PRE_RAW_N`:
- RZN 3.6k to Zener/base node `ZBN`
- collector of TIP42CG

At `ZBN`:
- BZX55C24 anode
- 47 uF capacitor negative terminal
- TIP42CG base

BZX55C24 cathode -> 0 V
47 uF capacitor positive -> 0 V

TIP42CG emitter -> `PREN`

`PREN` -> LM337T/NOPB input

At LM337 input:
- SMBJ30A anode to LM337 input
- SMBJ30A cathode to 0 V
- crowbar SCR cathode to LM337 input
- crowbar SCR anode to 0 V

LM337:
- OUT -> `-17V`
- R1 120R from OUT to ADJ
- R2 1.50k from ADJ to 0 V
- 10 uF output capacitor negative to `-17V`, positive to 0 V

Crowbar trigger:
- mirrored BZX55C30 / 6.8k / 47k network
- polarity must produce positive gate current relative to SCR cathode when the
  negative regulator input magnitude exceeds the trigger threshold.

## Layout priorities

1. Keep fuse -> 100R -> TVS/SCR fault path short and wide.
2. Place SMBJ30A physically close to the LM317/LM337 input and 0 V return.
3. Place regulator output capacitors close to regulator pins.
4. Keep 24 V Zener bypass loop compact.
5. Keep crowbar gate wiring away from high-dV/dt raw-rail traces.
6. Provide generous copper and airflow around TIP41CG/TIP42CG.
7. Provide test points for RAW+, RAW-, PREP, PREN, +17V, -17V and 0 V.
8. Label TO-220 pinouts explicitly in the schematic symbol/footprint mapping;
   do not assume positive and negative regulator pin orders are identical.
