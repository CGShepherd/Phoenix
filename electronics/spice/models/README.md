# SPICE model policy — Project Phoenix

## Purpose

Vendor and bounded models used for Project Phoenix verification are controlled evidence,
not anonymous simulation dependencies.

## TI regulator models selected for Stage 2A

Official TI product pages publish:

- LM317 Unencrypted PSpice Transient Model — package `SLVMC40.ZIP`
- LM337-N Unencrypted PSpice Transient Model — package `SNVMAP4.ZIP`

Download these directly from the relevant TI product pages.

Place downloaded archives locally under:

`electronics/spice/models/ti/downloads/`

The preparation script extracts them into:

`electronics/spice/models/ti/extracted/`

The script then enumerates every `.SUBCKT` declaration. The exact top-level subcircuit
name and node order must be reviewed before any LTspice deck is considered valid.

## Repository policy

Do not commit third-party model archives or extracted vendor libraries until their
redistribution/licence terms have been explicitly reviewed.

The repository should contain:

- model source/reference metadata;
- our own wrappers or test decks;
- hashes of locally used vendor files where useful;
- execution records.

## TIP41C / TIP42C

A downloadable manufacturer SPICE macromodel has not been verified for the selected
pass transistors. Project Phoenix therefore uses a datasheet-bounded sensitivity model
for Stage 2B rather than an undocumented third-party model.

This is deliberate: a nominal macromodel would not, by itself, establish production
worst-case beta or VBE behaviour.

## Validation rule

A model is not accepted merely because LTspice converges. Acceptance requires:

1. identified manufacturer/source;
2. identified model/version or archive;
3. known top-level `.SUBCKT` and pin order;
4. smoke-test behaviour consistent with the datasheet;
5. recorded limitations;
6. repeatable test deck and result capture.
