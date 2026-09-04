#!/usr/bin/env python3
"""Bar chart for bench_results/summary.csv (min wall-clock time)."""

import csv
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

plt.rcParams["font.family"] = ["Noto Sans CJK JP", "DejaVu Sans"]
plt.rcParams["axes.unicode_minus"] = False

ROOT = Path(__file__).resolve().parent

values = {}
with (ROOT / "summary.csv").open() as fh:
    for row in csv.DictReader(fh):
        values.setdefault(int(row["threads"]), {})[row["binary"]] = float(
            row["min_elapsed_s"]
        )

threads = sorted(values)
binaries = ["sys", "release", "debug"]
labels = {
    "sys": "系统 APBS",
    "release": "Rust release",
    "debug": "Rust debug",
}
colors = {
    "sys": "#4C72B0",
    "release": "#55A868",
    "debug": "#C44E52",
}

fig, ax = plt.subplots(figsize=(7.5, 5.2))
bar_width = 0.26

positions = range(len(threads))
for offset, name in enumerate(binaries):
    xs = [p + (offset - (len(binaries) - 1) / 2) * bar_width for p in positions]
    ys = [values[t][name] for t in threads]
    ax.bar(xs, ys, width=bar_width, label=labels[name], color=colors[name])

ax.set_xticks(list(positions))
ax.set_xticklabels([str(t) for t in threads])
ax.set_xlabel("线程数")
ax.set_ylabel("墙钟时间（s，取 3 次最短）")
ax.set_title("三种实现的并发性能对比（对数坐标）")
ax.set_yscale("log")
ax.set_ylim(bottom=1.0, top=35)
ax.grid(axis="y", linestyle=":", alpha=0.5)
ax.legend(loc="upper right")

fig.suptitle("test_apbs_par：APBS 并发性能柱状图", fontsize=14)
fig.tight_layout(rect=(0, 0, 1, 0.95))
out = ROOT / "summary_bar.png"
fig.savefig(out, dpi=150)
print(out)
