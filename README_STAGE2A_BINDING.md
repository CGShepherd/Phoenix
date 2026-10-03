# Project Phoenix — Stage 2A binding pack

Apply this after `tools\prepare_stage2_models.bat` has successfully extracted the
official TI model archives.

Adds `tools/bind_stage2a_models.py`, which verifies the exact model hashes,
interfaces and LM317 OUT_1 usage before generating the bound smoke-test deck.

It also replaces `tools/inspect_spice_subckts.py` solely to remove the harmless
Python invalid-escape SyntaxWarning.

From the repository root run:

    python tools\bind_stage2a_models.py

If it prints PASS, run:

    electronics\spice\PHX_ARCH_C_stage2a_smoke.cir

in LTspice and paste the SPICE Error Log.
