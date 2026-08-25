# PHX-TV-001 — Architecture C LTspice verification

## Objective

Establish whether the 24 V Zener + TIP41C/TIP42C preregulator gives sufficient
but bounded headroom for ±17 V LM317/LM337 post-regulation across the raw-rail,
receiver-load, device-tolerance and temperature envelope.

## Stage 1 — topology model

Run `electronics/spice/PHX_ARCH_C_initial.cir` in LTspice. This deck intentionally
uses simplified BJT/Zener models and behavioural post-regulators. It is suitable
for topology and headroom checks only.

Accept provisionally if:

- preregulator magnitude remains sufficiently above the ±17 V post-regulator target
  to preserve at least 2.5 V headroom;
- ±17 V behavioural output is maintained for the loaded cases;
- preregulator ripple remains small relative to available post-regulator headroom;
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
- minimum preregulator headroom above behavioural ±17 V output ≈ 5.204 V;
- maximum positive preregulator average = 25.036120 V;
- preregulator ripple range ≈ 4.774 to 7.095 mV p-p;
- Zener-current range ≈ 5.296 to 9.335 mA per rail;
- pass-transistor collector-current range ≈ 10.191 to 20.029 mA;
- positive and negative results are effectively symmetrical in this matched model.

The behavioural LM317/LM337 blocks force ±17 V whenever the preregulator has
sufficient headroom. Therefore the observed ±17 V output is not evidence of
real-device regulation accuracy, dropout behaviour, minimum-load compliance,
startup behaviour, or fault survival.

Raw measured values are recorded in `test/results/PHX_ARCH_C_first_pass.csv`.

A prior deck revision used `.tran 0 300m 200m 20u startup`, which discarded the
first 200 ms of saved transient data and caused the 250–300 ms `.meas` windows to
fail in LTspice 26.0.2. The validated deck retains the full transient record with
`.tran 0 300m 0 20u startup`.

### Stage 1A — BJT forward-gain sensitivity diagnostic

Run `electronics/spice/PHX_ARCH_C_bf_diag.cir` to reconcile Zener-feed current
against pass-transistor base current and to test sensitivity to simplified
pass-transistor forward gain.

Additional sweep:

- BFBJT = 15, 35, 75;
- combined with Stage 1 VRAW, load and Zener-voltage corners;
- 108 total operating points.

Result: **PASS as a diagnostic; RZ = 3.9 kΩ remains provisional.**

Observed:

- all 108 operating points converged;
- critical low-line/high-load/high-Zener-voltage/low-gain corner:
  VRAW = 48 V, load = 10 mA, VZ = 25.6 V, BFBJT = 15;
- positive preregulator average = 24.996887 V;
- Zener current = 4.731467 mA;
- Zener-feed resistor current = 5.742763 mA;
- pass-transistor base current = 1.011296 mA;
- KCL residual `IRZ - IZ - IB` = 3.14 pA;
- minimum preregulator voltage over the complete gain sweep remains about 22.202 V.

The BF = 35 result that previously gave about 5.296 mA Zener current at the same
electrical corner is therefore not conservative for transistor gain. The BF = 15
diagnostic reduces Zener current below the BZX55C24 5 mA characterisation current.
This is not a preregulator-headroom failure, but it is insufficient evidence to
finalise the 3.9 kΩ feed resistor.

## Stage 2 — model and tolerance verification

### Stage 2A — TI LM317 / LM337-N regulator models

Use the official TI **unencrypted PSpice transient models**:

- LM317: `SLVMC40.ZIP`;
- LM337-N: `SNVMAP4.ZIP`.

Do not guess the model node order. Run `tools/prepare_stage2_models.bat`, record
the extracted-file hashes and actual `.SUBCKT` declarations, then bind
`electronics/spice/PHX_ARCH_C_stage2_regulator_template.cir`.

Stage 2A sequence:

1. model-interface inspection;
2. single nominal smoke test;
3. verify approximately ±17 V with R1 = 120 Ω and R2 = 1.50 kΩ;
4. 0 mA external-load case;
5. 4.7 mA nominal load;
6. 8 mA design load;
7. 10 mA commissioning stress load;
8. 48/55/60 V raw-rail sweep with 100 Hz ripple;
9. compare real-model preregulator current against Stage 1 explicit-current approximation;
10. record model limitations exposed by LTspice/PSpice compatibility.

The regulator model is evidence of model behaviour, not a substitute for guaranteed
datasheet limits.

### Stage 2B — TIP41C / TIP42C bounded-device verification

No verified downloadable manufacturer SPICE macromodel has been established for
the selected TIP41C/TIP42C pair. Therefore Stage 2B will use datasheet-bounded
sensitivity analysis rather than an undocumented third-party model.

Retain the Stage 1A BF = 15 / 35 / 75 evidence. Extend the bounded model only where
manufacturer data support the parameter range. Do not tune parameters merely to
make simulation agree with the desired design.

Acceptance focus:

- preregulator headroom;
- Zener feed-current margin;
- pass-transistor base current;
- VBE sensitivity;
- power dissipation;
- positive/negative asymmetry where supported by device data.

### Stage 2C — temperature and tolerance

After Stage 2A and 2B:

- apply BZX55C24 voltage tolerance;
- apply supported temperature coefficient / temperature sweep;
- apply bounded transistor sensitivity;
- verify regulator dropout and minimum-load behaviour;
- revisit final RZ selection;
- assess CZ and regulator output-capacitor assumptions.

Do not baseline `RZ = 3.9 kΩ` before Stage 2C disposition.

## Stage 3 — dynamic and fault verification

After the nominal/tolerance model is stable, test:

- startup;
- shutdown;
- one-rail loss;
- output short/overload;
- preregulator pass-transistor C-E short;
- regulator input-output differential under preregulator fault;
- fuse/crowbar coordination and protection consequences.

## Current disposition

Stage 1 and Stage 1A support continuing Architecture C. They do **not** close:

- LM317/LM337 minimum-load and dropout verification;
- regulator model/LTspice compatibility;
- BZX55C24 temperature behaviour;
- TIP41C/TIP42C bounded device spread and thermal verification;
- final RZ selection;
- startup/shutdown and one-rail-loss behaviour;
- preregulator pass-transistor short-circuit fault consequences;
- fuse/crowbar coordination and final protection design.
