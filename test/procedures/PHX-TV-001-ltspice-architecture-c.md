# PHX-TV-001 — Architecture C initial LTspice verification

## Objective

Establish whether the 24 V Zener + TIP41C/TIP42C preregulator gives sufficient but bounded headroom for ±17 V LM317/LM337 post-regulation across the raw-rail and receiver-load envelope.

## Stage 1 — topology model

Run `electronics/spice/PHX_ARCH_C_initial.cir` in LTspice. This deck intentionally uses simplified BJT/Zener models and behavioural post-regulators. It is suitable for topology and headroom checks only.

Accept provisionally if:

- preregulator magnitude remains sufficiently above the ±17 V post-regulator target to preserve at least 2.5 V headroom;
- ±17 V behavioural output is maintained for the loaded cases;
- preregulator ripple remains small relative to the available post-regulator headroom;
- the Zener remains in a credible operating-current region across the electrical sweep;
- positive and negative rails remain acceptably symmetrical.

### Stage 1 execution record — 21 August 2026

Environment: LTspice 26.0.2 for Windows.

Sweep:

- VRAW = 48, 55, 60 V;
- THAT1206 external load = 0, 4.7, 8, 10 mA per rail;
- BZX55C24 voltage parameter = 22.8, 24.0, 25.6 V;
- 36 total operating corners;
- 100 Hz raw-rail ripple parameter = 2 V;
- steady-state measurements taken from 250 ms to 300 ms.

Result: **PASS — provisional topology/tolerance verification only.**

Observed across the 36 corners:

- all 36 operating points converged;
- minimum positive preregulator average = 22.204435 V;
- corresponding negative rail magnitude agrees within numerical precision;
- minimum preregulator headroom above the behavioural ±17 V output ≈ 5.204 V;
- maximum positive preregulator average = 25.036120 V;
- preregulator ripple range ≈ 4.774 to 7.095 mV p-p;
- Zener-current range ≈ 5.296 to 9.335 mA per rail;
- pass-transistor collector-current range ≈ 10.191 to 20.029 mA;
- positive and negative results are effectively symmetrical in this matched simplified model.

The behavioural LM317/LM337 blocks force ±17 V whenever the preregulator has sufficient headroom. Therefore the observed ±17 V output is not evidence of real-device regulation accuracy, dropout behaviour, minimum-load compliance, startup behaviour, or fault survival.

Raw measured values are recorded in `test/results/PHX_ARCH_C_first_pass.csv`.

A prior deck revision used `.tran 0 300m 200m 20u startup`, which discarded the first 200 ms of saved transient data and caused the 250–300 ms `.meas` windows to fail in LTspice 26.0.2. The validated deck retains the full transient record with `.tran 0 300m 0 20u startup`.

### Stage 1A — BJT forward-gain sensitivity diagnostic

Run `electronics/spice/PHX_ARCH_C_bf_diag.cir` to reconcile Zener-feed current against pass-transistor base current and to test sensitivity to the simplified transistor-model forward gain.

Additional sweep:

- BFBJT = 15, 35, 75;
- combined with the Stage 1 VRAW, load and Zener-voltage corners;
- 108 total operating points.

Result: **PASS as a diagnostic; RZ = 3.9 kΩ remains provisional.**

Observed:

- all 108 operating points converged;
- the critical low-line/high-load/high-Zener-voltage/low-gain corner is VRAW = 48 V, load = 10 mA, VZ = 25.6 V, BFBJT = 15;
- at that corner, positive preregulator average = 24.996887 V;
- Zener current = 4.731467 mA;
- Zener-feed resistor current = 5.742763 mA;
- pass-transistor base current = 1.011296 mA;
- KCL residual `IRZ - IZ - IB` = 3.14 pA, confirming measurement and model consistency;
- minimum preregulator voltage over the complete gain sweep remains about 22.202 V, so BJT gain sensitivity affects Zener-current margin more strongly than preregulator headroom in this simplified model.

The BF = 35 result that previously gave about 5.296 mA Zener current at the same electrical corner is therefore not conservative for transistor gain. The BF = 15 diagnostic reduces the Zener current below the BZX55C24 5 mA characterisation current. This is not a preregulator-headroom failure, but it is insufficient evidence to finalise the 3.9 kΩ Zener-feed resistor before vendor-model and temperature verification.

The artificial BF sweep is a sensitivity diagnostic only; it is not a substitute for validated manufacturer TIP41C/TIP42C models.

## Stage 2 — vendor models

Replace the simplified BJT models with validated manufacturer TIP41C/TIP42C models and the behavioural regulator blocks with the selected LM317/LM337 manufacturer macromodels. Repeat:

- VRAW = 48, 55, 60 V;
- load = 0, 4.7, 8, 10 mA;
- 100 Hz raw-ripple sweep;
- startup and shutdown;
- Zener tolerance and temperature corners;
- BJT beta/VBE spread.

The 0 mA external-load point is specifically retained to expose LM317/LM337 minimum-load behaviour once real regulator models are introduced. Final acceptance must use the selected manufacturer's guaranteed data, not generic-family typicals.

## Stage 1 disposition

Stage 1 and Stage 1A support continuing Architecture C into vendor-model verification. They do **not** close:

- LM317/LM337 minimum-load and dropout verification;
- BZX55C24 temperature behaviour;
- TIP41C/TIP42C device spread and thermal verification;
- final RZ selection;
- startup/shutdown and one-rail-loss behaviour;
- preregulator pass-transistor short-circuit fault consequences;
- fuse/crowbar coordination and final protection design.
