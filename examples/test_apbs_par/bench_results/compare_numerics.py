#!/usr/bin/env python3
"""Compare numeric outputs of a system APBS run and a Rust APBS run.

Usage:
    python3 compare_numerics.py system_run.log rust_run.log

Both logs must contain the same APBS input (same calcenergy mode) with
per-atom energy blocks.
"""

import re
import statistics
import sys
import math


def parse_log(path):
    text = open(path, encoding="utf-8", errors="replace").read()
    totals = [
        float(m.group(1))
        for m in re.finditer(r"Total electrostatic energy = ([0-9.eE+]+) kJ/mol", text)
    ]
    comps = []
    for seg in text.split("Per-atom energies:")[1:]:
        d = {}
        for key in ("Fixed charge energy", "Mobile charge energy", "Dielectric energy"):
            m = re.search(key + r" = ([-0-9.eE+]+) kJ/mol", seg)
            d[key] = float(m.group(1)) if m else float("nan")
        comps.append(d)

    atoms = []
    cur = []
    for line in text.splitlines():
        m = re.match(r"\s*Atom\s+(\d+):\s*([-0-9.eE+]+) kJ/mol", line)
        if m:
            cur.append(float(m.group(2)))
            if len(cur) == 3218:  # molecule in test_apbs_par
                atoms.append(cur)
                cur = []
    return totals, comps, atoms


def main():
    sys_t, sys_c, sys_a = parse_log(sys.argv[1])
    rs_t, rs_c, rs_a = parse_log(sys.argv[2])

    names = ["coarse/test_0", "focus/test"]
    print("calc                system(kJ/mol)  rust(kJ/mol)  diff(kJ/mol)  rel(%)")
    for i, name in enumerate(names):
        s = sys_t[i]
        r = rs_t[i]
        print(f"{name:18s} {s:14.6f} {r:14.6f} {r - s:+12.6f} {(r - s) / s * 100:+.4f}")

    print("\ncomponents:")
    for i, name in enumerate(names):
        for key in sys_c[i]:
            s = sys_c[i][key]
            r = rs_c[i][key]
            print(
                f"  {name:12s} {key:22s} {s:12.6g} {r:12.6g} "
                f"{r - s:+12.6g} {(r - s) / s * 100:+.4f}%"
            )

    print("\nper-atom energies:")
    for i, name in enumerate(names):
        s = sys_a[i]
        r = rs_a[i]
        diffs = [a - b for a, b in zip(r, s)]
        ad = [abs(d) for d in diffs]
        rms = math.sqrt(statistics.mean(d * d for d in diffs))
        big = [
            (abs(d), abs(a))
            for d, a in zip(diffs, s)
            if abs(a) > 1.0
        ]
        rel_big = [
            abs(rr - ss) / abs(ss) * 100
            for rr, ss in zip(r, s)
            if abs(ss) > 1.0
        ]
        print(
            f"  {name:12s} n={len(diffs)} max_abs={max(ad):.6g} "
            f"mean_abs={statistics.mean(ad):.6g} rms={rms:.6g}"
        )
        if rel_big:
            print(
                f"              |sys|>1: n={len(rel_big)} "
                f"rel_max={max(rel_big):.4f}% rel_mean={statistics.mean(rel_big):.4f}%"
            )
        if big:
            print(
                f"              max abs among |sys|>1 kJ/mol atoms: "
                f"{max(d for d, _ in big):.6g} kJ/mol"
            )


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(__doc__)
        sys.exit(1)
    main()
