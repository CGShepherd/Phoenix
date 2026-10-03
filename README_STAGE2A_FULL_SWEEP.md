# Project Phoenix — Architecture C Stage 2A full sweep

The nominal TI-model smoke test passed in LTspice 26.0.2:

- Vpre ≈ ±23.42048 V
- Vout ≈ +16.88014 / -16.88006 V
- output ripple ≈ 5.72 µV p-p
- Zener current ≈ 7.256 mA per rail

The only LTspice diagnostic was the TI-model diode warning:

`dd: Emission coefficient, N=0.01, too small, this might lead to numerical problems.`

This warning is retained as a model limitation; the TI model is not modified to silence it.

The full sweep executes 36 corners:
- VRAW = 48 / 55 / 60 V
- external load = 0 / 4.7 / 8 / 10 mA
- VZ = 22.8 / 24.0 / 25.6 V
- BFBJT fixed at 15

It additionally measures regulator input current, dropout/headroom, output min/max/ripple,
and preregulator Zener/feed/base/collector currents.
