# Architecture C — Stage 2C thermal basis

## Datasheet basis

- Vishay BZX55C24: typical VZ temperature coefficient at 5 mA is approximately
  7.5...8 × 10^-4 /K around 24 V. The Stage 2C sensitivity deck uses 7.5e-4 /K.
- Vishay BZX55 series: nominal total dissipation is 500 mW at 25 °C ambient,
  derating approximately linearly to zero at 175 °C under the datasheet lead
  mounting condition.
- onsemi TIP41CG/TIP42CG: RθJC(max) = 1.67 °C/W; RθJA(max) = 57 °C/W.
- TI LM317: operation can require up to 3 V input-output headroom; maximum
  minimum-load requirement over temperature is 10 mA.
- TI LM337-N: maximum minimum-load requirement is likewise 10 mA over the
  specified conditions.

## Pass-transistor first thermal estimate

Using the established worst electrical dissipation of approximately 0.738 W:

Free-air, datasheet RθJA:

- ΔTJ-A ≈ 0.738 × 57 = 42.1 °C
- at TA = 25 °C => TJ ≈ 67 °C
- at TA = 40 °C => TJ ≈ 82 °C
- at TA = 60 °C => TJ ≈ 102 °C

These are first-order steady-state estimates only. Enclosure temperature, PCB
copper, mutual heating and reduced natural convection must be assessed before
declaring heatsinks unnecessary.

With case-coupled cooling, RθJC contributes only:

- ΔTJ-C ≈ 0.738 × 1.67 = 1.23 °C

so practical junction temperature is dominated by case-to-ambient thermal
resistance.

## Working thermal targets

Until enclosure testing exists:

- design continuous TJ target: <= 100 °C;
- absolute analysis must remain below manufacturer maximum TJ;
- do not rely on bare TO-220 free-air dissipation if local ambient could exceed
  about 55...60 °C;
- prefer provision for PCB-mounted clip-on heatsinks or chassis coupling if
  mechanical layout permits.

## RZ component rating

The 3.6 kΩ candidate was approximately 0.384 W maximum at 25 °C electrical
corners. A 1 W resistor remains the working requirement. This offers useful
thermal derating and avoids treating a 0.5 W rating as a continuous design point.

Stage 2C high-line results will be used to confirm this at elevated effective VZ.
