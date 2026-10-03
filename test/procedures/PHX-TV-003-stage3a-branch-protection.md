# PHX-TV-003 — Architecture C branch protection predesign

Run in order:

1. `PHX_ARCH_C_stage3a_branch_resistor.cir`
   - choose a branch resistor that preserves >3 V minimum regulator headroom.
2. `PHX_ARCH_C_stage3a_pass_short.cir`
   - demonstrate regulator differential-voltage stress from a preregulator C-E short.
3. `PHX_ARCH_C_stage3a_crowbar_ideal.cir`
   - estimate fault current available to coordinate a dedicated branch fuse.

The crowbar deck is intentionally idealised and does not represent SCR trigger
dynamics. Its purpose is to select the current/fuse region before component
down-selection.

Acceptance direction:
- normal-operation headroom remains >3 V at low line/high load;
- preregulator short is demonstrably unsafe without protection;
- ideal crowbar fault current is high enough to clear a small dedicated branch fuse
  without requiring excessive continuous branch-resistor dissipation.

Final SCR, threshold network and fuse selection follow this test.
