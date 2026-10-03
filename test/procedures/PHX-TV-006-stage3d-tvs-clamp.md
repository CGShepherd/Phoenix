# PHX-TV-006 — Stage 3D TVS clamp integration

Run `tools\run_stage3d_batch.bat`.

Acceptance intent:

1. normal preregulator voltage remains below TVS standoff/breakdown with negligible TVS current;
2. positive and negative fault clamp voltage remains below 40 V at all raw-rail corners;
3. delayed SCR action never allows regulator-input voltage above the TVS clamp;
4. fuse I2t accumulation with TVS-only conduction is quantified;
5. TVS and 100 ohm resistor transient energies remain modest relative to pulse-rated components.

This deck uses a conservative linearized TVS model derived from Littelfuse SMBJ30A
datasheet endpoints. Hardware transient testing remains required.
