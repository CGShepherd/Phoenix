# Project Phoenix — Architecture C RZ decision sweep

This sweep is intended to select between:

- 3.9 kΩ
- 3.6 kΩ
- 3.3 kΩ

using the verified Stage 2A TI LM317/LM337 models and the deliberately conservative
BF = 15 preregulator transistor model.

The run comprises 108 corners:

- RZ = 3.9 / 3.6 / 3.3 kΩ
- VRAW = 48 / 55 / 60 V
- external load = 0 / 4.7 / 8 / 10 mA
- VZ = 22.8 / 24.0 / 25.6 V

Decision metrics:

1. minimum Zener current at low-line/high-load/high-VZ;
2. maximum Zener dissipation at high-line/light-load;
3. maximum RZ dissipation;
4. maximum pass-transistor dissipation;
5. minimum regulator headroom;
6. positive/negative rail consistency.

Do not commit a final RZ value until this sweep has been reviewed.
