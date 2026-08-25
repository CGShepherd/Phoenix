#!/usr/bin/env python3
"""Enumerate SPICE .SUBCKT declarations and basic file hashes.

Usage:
    python tools\inspect_spice_subckts.py <file-or-directory> [...]

This tool deliberately does not guess which subcircuit is the regulator.
It reports the declarations so that the vendor model interface can be reviewed.
"""

from __future__ import annotations
import hashlib
import pathlib
import re
import sys

EXTENSIONS = {".lib", ".cir", ".sub", ".sp", ".spi", ".mod", ".txt"}

def sha256(path: pathlib.Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()

def logical_lines(text: str):
    """Join SPICE '+' continuation lines to the preceding logical line."""
    current = None
    for raw in text.splitlines():
        line = raw.rstrip()
        if line.lstrip().startswith("+") and current is not None:
            current += " " + line.lstrip()[1:].strip()
        else:
            if current is not None:
                yield current
            current = line
    if current is not None:
        yield current

def inspect(path: pathlib.Path):
    try:
        text = path.read_text(encoding="utf-8", errors="replace")
    except Exception as exc:
        print(f"ERROR {path}: {exc}")
        return

    subs = []
    for lineno, line in enumerate(logical_lines(text), start=1):
        m = re.match(r"^\s*\.subckt\s+(\S+)\s*(.*)$", line, re.I)
        if m:
            name = m.group(1)
            nodes = m.group(2).strip()
            subs.append((name, nodes))

    print("=" * 78)
    print(f"FILE: {path}")
    print(f"SHA256: {sha256(path)}")
    if not subs:
        print("SUBCKT: none found")
    else:
        for name, nodes in subs:
            print(f"SUBCKT: {name}")
            print(f"NODES : {nodes}")

def iter_files(arg: pathlib.Path):
    if arg.is_file():
        yield arg
    elif arg.is_dir():
        for p in sorted(arg.rglob("*")):
            if p.is_file() and p.suffix.lower() in EXTENSIONS:
                yield p
    else:
        print(f"WARNING: not found: {arg}", file=sys.stderr)

def main():
    if len(sys.argv) < 2:
        print("Usage: python tools\\inspect_spice_subckts.py <file-or-directory> [...]")
        return 2

    seen = set()
    for arg in map(pathlib.Path, sys.argv[1:]):
        for path in iter_files(arg):
            rp = path.resolve()
            if rp not in seen:
                seen.add(rp)
                inspect(path)
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
