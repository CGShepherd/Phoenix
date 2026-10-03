# Project Phoenix — Stage 2A LTspice compatibility patch

Exact uploaded TI source files reviewed:

- LM317_TRANS.LIB — SHA-256 `9b56d7c68b75d3c0fd1e0b55f5ddc448f89f82984f026ff31acdf89bde4bd7e1`
- LM337_N_TRANS.LIB — SHA-256 `dc9fd0b650ce944f69654e7c5ebe1bb68dae541b25d92633825973afe2c7d4ff`

## Finding

Both vendor files define the global helper subcircuit `COMPHYS_BASIC_GEN`.
When both are included, LTspice 26.0.2 rejects the duplicate definition.
The subsequent `No such node` diagnostics refer to output nodes created by
instances of that helper and are therefore consistent with a cascading parse/
elaboration failure.

The uploaded LM317 file also confirms that `OUT_1` appears only in the
top-level `.SUBCKT` declaration and is not referenced by the model body.

## Transformation

This pack makes only one semantic-neutral compatibility change:

- LM317: `COMPHYS_BASIC_GEN` -> `LM317_COMPHYS_BASIC_GEN`
- LM337: `COMPHYS_BASIC_GEN` -> `LM337_COMPHYS_BASIC_GEN`

The matching X-device calls are renamed as well. No equations, parameters,
component values, ABM expressions, or top-level regulator interfaces are changed.

This deliberately tests the smallest possible correction first. The previous
LTspice errors do **not** yet prove that TI's ABM expressions require conversion;
the missing-node messages can be consequences of the duplicate helper failure.

## Run

Extract this pack into the repository root, replacing
`electronics/spice/PHX_ARCH_C_stage2a_smoke.cir`.

Then run that smoke deck in LTspice and paste the complete SPICE Error Log.

Do not delete or edit the original files under `models/ti/extracted`.
