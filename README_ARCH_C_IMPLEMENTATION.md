# Project Phoenix — Architecture C implementation pack

This pack moves Architecture C from architecture closure into schematic implementation.

Files:
- `electronics/design/architecture_c_exact_parts.md`
- `electronics/design/architecture_c_schematic_connectivity.md`
- `electronics/bom/architecture_c_bom.csv`

Key sourcing decisions:
- onsemi TIP41CG / TIP42CG
- TI LM317AT/NOPB / LM337T/NOPB
- Vishay BZX55C24-TR / BZX55C30-TR
- Vishay PR01 3.6 kΩ / 1 W
- Panasonic FR 47 µF / 50 V and 10 µF / 50 V
- Littelfuse 0451.062MRL fuse
- Vishay AC03-CS 100 Ω / 3 W
- Littelfuse SMBJ30A
- Central Semiconductor 2N5064 PBFREE

Important:
The historical onsemi 2N5064 is discontinued. The Central Semiconductor 2N5064
is active and preserves the validated electrical class.

Next recommended project step:
Create the KiCad power/protection schematic using the connectivity document and BOM.
