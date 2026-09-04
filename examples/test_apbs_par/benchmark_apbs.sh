#!/usr/bin/env bash
# APBS concurrency benchmark: system APBS vs Rust debug/release builds.
#
# Usage:
#   ./benchmark_apbs.sh                # 3 repeats, cores 1 4 8 16 32
#   REPS=2 THREADS="1 4 8" ./benchmark_apbs.sh
#
# Environment overrides:
#   SYS_APBS  - path to system/reference APBS   (default /usr/bin/apbs)
#   DBG_APBS  - path to Rust debug binary       (default ../../target/debug/apbs)
#   REL_APBS  - path to Rust release binary     (default ../../target/release/apbs)
set -u

ROOT="$(cd "$(dirname "$0")" && pwd)"
WORK="$ROOT/bench_results"
REPS="${REPS:-3}"
THREADS="${THREADS:-1 4 8 16 32}"

SYS_APBS="${SYS_APBS:-/usr/bin/apbs}"
DBG_APBS="${DBG_APBS:-$ROOT/../../target/debug/apbs}"
REL_APBS="${REL_APBS:-$ROOT/../../target/release/apbs}"

mkdir -p "$WORK/runs"
rm -f "$WORK/raw.tsv" "$WORK/summary.csv" "$WORK/raw.csv"

run_one() {
    local name="$1"
    local bin="$2"
    local threads="$3"
    local rep="$4"
    local dir="$WORK/runs/$name-$threads-$rep"
    mkdir -p "$dir"
    cp -f "$ROOT/test.apbs" "$ROOT/test.pqr" "$dir/"
    (cd "$dir" && /usr/bin/time -a -o "$WORK/raw.tsv" \
        -f "$name\t$threads\t$rep\t%e\t%U\t%S" \
        env OMP_NUM_THREADS="$threads" "$bin" test.apbs >/dev/null 2>err.log)
}

bench_binary() {
    local label="$1"
    local bin="$2"
    for t in $THREADS; do
        for r in $(seq 1 "$REPS"); do
            echo "  [$label] OMP_NUM_THREADS=$t repeat=$r"
            run_one "$label" "$bin" "$t" "$r"
        done
    done
}

echo "APBS concurrency benchmark"
echo "  system : $SYS_APBS"
echo "  debug  : $DBG_APBS"
echo "  release: $REL_APBS"
echo "  threads: $THREADS  repeats: $REPS"
echo "  output : $WORK"
echo

bench_binary "sys" "$SYS_APBS"
bench_binary "debug" "$DBG_APBS"
bench_binary "release" "$REL_APBS"

# raw.csv keeps the same field order as raw.tsv for easy import.
{
    echo "binary,threads,rep,elapsed_s,user_s,sys_s"
    awk -F '\t' '{printf "%s,%s,%s,%s,%s,%s\n", $1,$2,$3,$4,$5,$6}' "$WORK/raw.tsv"
} > "$WORK/raw.csv"

# summary.csv: fastest wall-clock run and mean wall-clock run per binary/threads.
{
    echo "binary,threads,min_elapsed_s,mean_elapsed_s"
    awk -F '\t' '
        {
            key = $1 FS $2
            if (!(key in count)) {
                min[key] = $4; sum[key] = 0.0; count[key] = 0
            }
            if ($4 < min[key]) min[key] = $4
            sum[key] += $4
            count[key]++
        }
        END {
            for (key in count) {
                split(key, parts, FS)
                printf "%s,%s,%.3f,%.3f\n", parts[1], parts[2], min[key], sum[key] / count[key]
            }
        }
    ' "$WORK/raw.tsv" | sort
} > "$WORK/summary.csv"

echo "done: $WORK/raw.csv, $WORK/summary.csv"
