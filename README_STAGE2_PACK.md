# Project Phoenix — Architecture C Stage 2 preparation pack

Date: 21 August 2026

This pack prepares Stage 2 validation without pretending that unavailable or unverified
device models have been obtained.

## Engineering disposition

Stage 2 is split into:

1. **Stage 2A — TI regulator model integration**
   - TI LM317 unencrypted PSpice transient model: `SLVMC40.ZIP`
   - TI LM337-N unencrypted PSpice transient model: `SNVMAP4.ZIP`
   - Inspect the actual `.SUBCKT` declarations before binding node order into LTspice.

2. **Stage 2B — TIP41C/TIP42C bounded-device validation**
   - No verified downloadable manufacturer SPICE macromodel has been established.
   - Retain datasheet-bounded gain sensitivity rather than importing an undocumented
     third-party model.
   - The existing BF = 15 / 35 / 75 diagnostic remains evidence, not a production model.

3. **Stage 2C — temperature/tolerance sweep**
   - Sweep BZX55C24 voltage/temperature behaviour and bounded BJT behaviour.
   - Revisit `RZ = 3.9 kΩ` only after Stage 2A/2B evidence exists.

## Repository destinations

Copy the files from this pack to these repository paths:

- `electronics/calculations/architecture_c_first_pass.md`
- `electronics/spice/models/README.md`
- `electronics/spice/models/ti/.gitkeep`
- `electronics/spice/PHX_ARCH_C_stage2_regulator_template.cir`
- `tools/inspect_spice_subckts.py`
- `tools/prepare_stage2_models.bat`
- `test/procedures/PHX-TV-001-ltspice-architecture-c.md`
- `test/results/PHX_ARCH_C_stage2_results_template.csv`

Do not commit TI model files to the repository until their redistribution/licence terms
have been reviewed. The default workflow keeps downloaded vendor archives and extracted
libraries local and ignored/untracked.

## Laptop execution sequence

1. Download the two official TI unencrypted PSpice packages.
2. Place them in:
   `electronics\spice\models\ti\downloads\`
3. Run:
   `tools\prepare_stage2_models.bat`
4. Paste the complete console output into ChatGPT.
5. Do **not** edit the Stage 2 regulator template manually yet. The reported `.SUBCKT`
   names and node order will determine the exact X-device calls.
6. After the deck is bound, run the smoke test first, then the full sweep.
