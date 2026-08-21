# PHX-TV-001 — Architecture C initial LTspice verification

## Objective

Establish whether the 24 V Zener + TIP41C/TIP42C preregulator gives sufficient but bounded headroom for ±17 V LM317/LM337 post-regulation across the raw-rail and receiver-load envelope.

## Stage 1 — topology model

Run `electronics/spice/PHX_ARCH_C_initial.cir` in LTspice. This deck intentionally uses simplified BJT/Zener models and behavioural post-regulators. It is suitable for topology and headroom checks only.

Accept provisionally if:

- preregulator magnitude remains nominally around 23.2–23.5 V;
- both post-regulators retain at least 2.5 V nominal headroom;
- ±17 V output is maintained for the loaded cases;
- no startup overshoot is produced by the preregulator topology model;
- pass-device dissipation remains compatible with the proposed thermal implementation.

## Stage 2 — vendor models

Replace the simplified BJT models with vendor TIP41C/TIP42C models and the behavioural regulator blocks with the exact LM317/LM337 vendor macromodels. Repeat:

- VRAW = 48, 55, 60 V;
- load = 0, 4.7, 8, 10 mA;
- 100 Hz raw-ripple sweep;
- startup and shutdown;
- Zener tolerance and temperature corners;
- BJT beta/VBE spread.

The 0 mA point is specifically used to expose LM317/LM337 minimum-load behaviour. Final acceptance must use the selected manufacturer's guaranteed data, not generic-family typicals.
