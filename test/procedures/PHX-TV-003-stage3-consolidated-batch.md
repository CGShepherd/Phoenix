# PHX-TV-003 — Stage 3 consolidated protection/dynamic batch

## Objective

Run the principal remaining Architecture C protection and dynamic verification in one
repeatable LTspice batch, minimizing operator interaction.

## Acceptance framework

The suite is evidence-generating. A single failed deck does not invalidate results from
other decks; failures are reviewed individually.

Key criteria:

- no nuisance crowbar trigger under normal electrical corners;
- trigger threshold below the regulator-danger region but above maximum normal input;
- fuse/crowbar I2t coordination with useful margin;
- protected pass-short differential exposure characterized for 50 us, 200 us and 1 ms;
- positive/negative protection symmetry;
- no unacceptable startup/shutdown output excursion;
- surviving rail remains regulated during one-rail loss.

## Datasheet anchors

- BZX55C30: 28...32 V at 5 mA; alpha_VZ approximately 0.04...0.12 %/K.
- 2N5064 family: IGT max 200 uA at 25 C and 350 uA at -40 C; IH max 5 mA at 25 C.
- Littelfuse 451/453 62 mA: 125 V rating, 5.5 ohm nominal cold resistance,
  0.00019 A^2s nominal melting I2t.

Model limitations and final dispositions must remain explicit in the verification record.
