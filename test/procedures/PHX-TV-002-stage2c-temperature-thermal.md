# PHX-TV-002 — Architecture C Stage 2C temperature and thermal verification

## Objective

Resolve the remaining RZ temperature margin and establish provisional thermal
requirements for the Zener feed resistor, BZX55C24 and TIP41C/TIP42C pass devices.

## Test A — low-line hot-Zener margin

Run `electronics/spice/PHX_ARCH_C_stage2c_lowline_hot.cir`.

Fixed electrical corner:

- VRAW = 48 V with 2 Vpk, 100 Hz ripple;
- external regulator load = 10 mA;
- BFBJT = 15.

Sweeps:

- RZ = 3.6 kΩ, 3.3 kΩ;
- VZ25 = 22.8, 24.0, 25.6 V;
- effective Zener temperature = 25, 60, 85 °C.

Acceptance intent:

- maintain regulator output and >3 V instantaneous headroom;
- quantify minimum IZ rather than imposing 5 mA as a hard conduction threshold;
- prefer useful margin around the 5 mA BZX55C24 characterisation point.

## Test B — high-line dissipation

Run `electronics/spice/PHX_ARCH_C_stage2c_highline_thermal.cir`.

Fixed electrical corner:

- VRAW = 60 V with 2 Vpk, 100 Hz ripple;
- zero external load;
- BFBJT = 15.

Same RZ/VZ25/temperature sweep.

Record:

- maximum RZ dissipation;
- maximum Zener dissipation;
- pass-transistor dissipation.

## Disposition rule

If 3.6 kΩ retains adequate low-line Zener-current margin at the 85 °C
sensitivity corner and all thermal limits remain comfortably derated, retain
3.6 kΩ. Otherwise prefer 3.3 kΩ unless its resistor/Zener dissipation creates a
stronger thermal penalty.

The Zener temperature coefficient used here is typical datasheet behaviour,
not a guaranteed production maximum. Final hardware validation remains required.
