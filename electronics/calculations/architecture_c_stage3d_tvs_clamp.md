# Architecture C — Stage 3D TVS clamp integration

## Datasheet finding

TI specifies 40 V maximum input-output differential for LM317 and LM337-N as an
absolute maximum rating. Stresses beyond absolute maximum may cause permanent
damage; no transient exception is given.

## Added protection

Add one unidirectional SMBJ30A TVS at each regulator input:

- positive rail: TVS cathode to LM317 input, anode to 0 V;
- negative rail: TVS anode to LM337 input, cathode to 0 V.

Littelfuse SMBJ30A:
- VRWM = 30 V;
- VBR = 33.3...36.8 V at 1 mA;
- VCL = 48.4 V at 12.4 A.

Because the Phoenix source is limited by approximately 105.5 ohm before the clamp,
fault current is only a few hundred milliamps. A conservative linearized model based
on maximum breakdown and the datasheet clamp point predicts clamp voltage around
37 V at the available current, below the regulator's 40 V differential ceiling even
if the regulator output has collapsed close to 0 V.

## Layered protection

The TVS is the immediate absolute-maximum clamp.
The 2N5064 + BZX55C30 crowbar remains the sustained low-impedance path that forces
rapid fuse clearing when its trigger threshold is reached.

In worst tolerance cases where the TVS begins clamping before the SCR trigger
threshold, the TVS itself carries the limited fault current until the fuse clears.

## Working component baseline

- Fuse: Littelfuse 451 series, 62 mA, e.g. 0451.062MRL/MRSN family
- Branch resistor: 100 ohm Vishay AC03-CS, 3 W, pulse/safety wirewound
- Immediate clamp: Littelfuse SMBJ30A
- Crowbar SCR: onsemi 2N5064
- Trigger Zener: Vishay BZX55C30
- Gate resistor: 6.8 kohm
- Gate-cathode resistor: 47 kohm

Stage 3D simulation is the final check before freezing this protection stack.
