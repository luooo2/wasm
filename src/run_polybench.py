#!/usr/bin/env python3
"""
Run all PolyBench kernels (built by build_polybench.py) in three modes:
- native (Linux binary, compiled with POLYBENCH_TIME)
- wasm-jit (wasmtime JIT)
- wasm-aot (wasmtime precompiled artifact)

Each run uses PolyBench's internal timer (POLYBENCH_TIME). This script does
NOT use external wall-clock timing for labels/ratios; labels are computed only
from parsed internal timings.

Outputs (under data/results by default):
- polybench_summary.csv  : per-program aggregated statistics + labels
- polybench_raw.csv      : raw per-run status + internal timing parse results
- polybench_internal.csv : per-run internal PolyBench times parsed from output
"""

import argparse
import csv
import re
import shlex
import statistics
import subprocess
from pathlib import Path
from typing import Dict, List, Optional, Tuple


EXTERNAL_RUNTIME_NATIVE = "native"
EXTERNAL_RUNTIME_WASM_JIT = "wasm-jit"
EXTERNAL_RUNTIME_WASM_AOT = "wasm-aot"


INTERNAL_TIME_REGEXES = [
    # Common PolyBench output forms; keep flexible
    re.compile(r"==\s*TIME\s*=\s*([0-9]*\.?[0-9]+)"),
    re.compile(r"Time\s*:\s*([0-9]*\.?[0-9]+)"),
    re.compile(r"([0-9]*\.?[0-9]+)\s*(?:ms|milliseconds)"),
]

RE_NUMERIC_ONLY_LINE = re.compile(r"^\s*([0-9]+(?:\.[0-9]+)?)\s*$")


def parse_internal_time_ms(output: str) -> Optional[float]:
    """
    Best-effort parse of PolyBench internal timing from stdout/stderr text.
    Returns milliseconds if found, else None.

    PolyBench often prints the timer as a single line containing only a number
    (format depends on which timer path is used). We:
    1) try labeled patterns first;
    2) then fall back to the last numeric-only line.
       - if the token contains '.', treat it as seconds => ms = s*1000
       - else treat it as microseconds => ms = us/1000
    """
    text = output or ""
    for pat in INTERNAL_TIME_REGEXES:
        m = pat.search(text)
        if m:
            try:
                val = float(m.group(1))
                # The labeled patterns already express a concrete unit (ms),
                # so assume ms when we see them.
                return val
            except ValueError:
                continue

    # Fallback: last numeric-only line.
    candidates: list[Tuple[str, float]] = []
    for line in text.splitlines():
        m = RE_NUMERIC_ONLY_LINE.match(line)
        if not m:
            continue
        token = m.group(1)
        try:
            v = float(token)
        except ValueError:
            continue
        candidates.append((token, v))

    if not candidates:
        return None

    token, v = candidates[-1]
    if "." in token:
        # seconds -> ms
        return v * 1000.0
    # integer -> microseconds -> ms
    return v / 1000.0


def run_once(cmd: List[str], timeout_sec: int) -> Tuple[bool, str, str]:
    """
    Run a single process, returning:
    - ok (bool)
    - stdout
    - stderr
    """
    try:
        p = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=timeout_sec,
        )
        ok = p.returncode == 0
        return ok, (p.stdout or ""), (p.stderr or "")
    except subprocess.TimeoutExpired as exc:
        stdout = exc.stdout.decode() if isinstance(exc.stdout, bytes) else (exc.stdout or "")
        stderr = exc.stderr.decode() if isinstance(exc.stderr, bytes) else (exc.stderr or "")
        return False, stdout, stderr + f"\n[timeout after {timeout_sec}s]"


def safe_stats(values: List[float]) -> Dict[str, float]:
    if not values:
        return {"mean": 0.0, "median": 0.0, "std": 0.0, "min": 0.0, "max": 0.0}
    return {
        "mean": statistics.mean(values),
        "median": statistics.median(values),
        "std": statistics.stdev(values) if len(values) >= 2 else 0.0,
        "min": min(values),
        "max": max(values),
    }


def label_by_ratio(r: float, threshold: float) -> str:
    if r > 1.0 + threshold:
        return "native-better"
    if r < 1.0 - threshold:
        return "wasm-better"
    return "similar"


def ensure_aot_artifact(
    wasmtime_cmd: str,
    wasm_path: Path,
    aot_cache_dir: Path,
) -> Tuple[bool, Optional[Path], str]:
    """
    Build (or reuse) a wasmtime precompiled artifact for AOT timing.
    Compile cost is paid once, outside the main timing loop.
    """
    aot_cache_dir.mkdir(parents=True, exist_ok=True)
    out_path = aot_cache_dir / f"{wasm_path.stem}.cwasm"
    if out_path.exists():
        return True, out_path, ""

    cmd = [wasmtime_cmd, "compile", str(wasm_path), "-o", str(out_path)]
    try:
        p = subprocess.run(cmd, capture_output=True, text=True, timeout=300)
    except subprocess.TimeoutExpired:
        return False, None, "wasmtime compile timeout after 300s"

    if p.returncode != 0:
        msg = (p.stderr or p.stdout or "").strip()
        return False, None, msg or f"wasmtime compile failed: {p.returncode}"
    return True, out_path, ""


def parse_programs_arg(programs_arg: str) -> Optional[set[str]]:
    if not programs_arg:
        return None
    vals = [x.strip() for x in programs_arg.split(",") if x.strip()]
    return set(vals) if vals else None


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--build-dir",
        default="data/polybench_build",
        help="Directory containing PolyBench *.native / *.wasm (from build_polybench.py)",
    )
    parser.add_argument(
        "--wasmtime",
        default="wasmtime",
        help="wasmtime command name (default: wasmtime)",
    )
    parser.add_argument(
        "--aot-cache-dir",
        default="data/polybench_build/aot_cache",
        help="Directory to store *.cwasm artifacts for AOT mode",
    )
    parser.add_argument(
        "--repeats",
        type=int,
        default=30,
        help="Measured repeats per mode (default: 30)",
    )
    parser.add_argument(
        "--warmup",
        type=int,
        default=2,
        help="Warmup runs per mode (not recorded, default: 2)",
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=300,
        help="Per-run timeout in seconds (default: 300)",
    )
    parser.add_argument(
        "--threshold",
        type=float,
        default=0.10,
        help="Label threshold on ratio r = wasm_median / native_median (default: 0.10)",
    )
    parser.add_argument(
        "--programs",
        default="",
        help="Optional comma-separated program names (e.g., gemm,atax). If empty, run all.",
    )
    parser.add_argument(
        "--summary-csv",
        default="data/results/polybench_summary.csv",
        help="Summary CSV output path",
    )
    parser.add_argument(
        "--raw-csv",
        default="data/results/polybench_raw.csv",
        help="Raw external timing CSV output path",
    )
    parser.add_argument(
        "--internal-csv",
        default="data/results/polybench_internal.csv",
        help="Parsed internal PolyBench timing CSV output path",
    )
    args = parser.parse_args()

    build_dir = Path(args.build_dir)
    if not build_dir.exists():
        raise SystemExit(f"build-dir does not exist: {build_dir}")

    summary_csv = Path(args.summary_csv)
    raw_csv = Path(args.raw_csv)
    internal_csv = Path(args.internal_csv)
    summary_csv.parent.mkdir(parents=True, exist_ok=True)
    raw_csv.parent.mkdir(parents=True, exist_ok=True)
    internal_csv.parent.mkdir(parents=True, exist_ok=True)

    selected = parse_programs_arg(args.programs)
    aot_cache_dir = Path(args.aot_cache_dir)

    native_bins = sorted(build_dir.glob("*.native"))
    if not native_bins:
        raise SystemExit(f"No *.native files found in {build_dir}. Run build_polybench.py first.")

    summary_rows: List[Dict] = []
    raw_rows: List[Dict] = []
    internal_rows: List[Dict] = []

    for nb in native_bins:
        prog = nb.stem
        if selected is not None and prog not in selected:
            continue

        wasm_path = build_dir / f"{prog}.wasm"
        if not wasm_path.exists():
            summary_rows.append(
                {
                    "program": prog,
                    "native_ok": 0,
                    "wasm_jit_ok": 0,
                    "wasm_aot_ok": 0,
                    "label_jit": "missing-artifact",
                    "label_aot": "missing-artifact",
                    "note": f"missing {wasm_path}",
                    "native_median_internal_ms": 0.0,
                    "wasm_jit_median_internal_ms": 0.0,
                    "wasm_aot_median_internal_ms": 0.0,
                    "ratio_jit_over_native": 0.0,
                    "ratio_aot_over_native": 0.0,
                }
            )
            continue

        print(f"\n=== Running PolyBench kernel: {prog} ===")

        # Pre-create AOT artifact (once) for this program
        ok_aot, aot_artifact, aot_err = ensure_aot_artifact(
            args.wasmtime, wasm_path, aot_cache_dir
        )
        if not ok_aot or aot_artifact is None:
            print(f"[AOT] compile failed for {prog}: {aot_err}")
            aot_artifact = None

        # Collect internal/external times for each mode
        all_modes = [
            (EXTERNAL_RUNTIME_NATIVE, [str(nb)]),
            (EXTERNAL_RUNTIME_WASM_JIT, [args.wasmtime, "run", "--dir=.", str(wasm_path)]),
        ]
        if aot_artifact is not None:
            all_modes.append(
                (
                    EXTERNAL_RUNTIME_WASM_AOT,
                    [args.wasmtime, "run", "--allow-precompiled", "--dir=.", str(aot_artifact)],
                )
            )

        mode_stats: Dict[str, Dict[str, float]] = {}
        mode_internal_medians: Dict[str, float] = {}
        mode_ok: Dict[str, bool] = {}

        for mode_name, cmd in all_modes:
            print(f"\n--- Mode {mode_name} for {prog} ---")

            # Warmup
            for _ in range(max(args.warmup, 0)):
                ok, _, _ = run_once(cmd, args.timeout)
                if not ok:
                    break

            internal_times: List[float] = []
            ok_mode = True
            last_err = ""

            for i in range(1, args.repeats + 1):
                print("$", " ".join(shlex.quote(c) for c in cmd))
                ok, stdout, stderr = run_once(cmd, args.timeout)

                # Internal time parsed from stdout/stderr
                parsed_internal = parse_internal_time_ms(stdout) or parse_internal_time_ms(stderr)
                internal_rows.append(
                    {
                        "program": prog,
                        "runtime": mode_name,
                        "run_index": i,
                        "internal_ms": parsed_internal if parsed_internal is not None else 0.0,
                        "parsed_ok": int(parsed_internal is not None),
                    }
                )

                # Raw record (status + parse result)
                raw_rows.append(
                    {
                        "program": prog,
                        "runtime": mode_name,
                        "run_index": i,
                        "internal_ms": parsed_internal if parsed_internal is not None else 0.0,
                        "parsed_ok": int(parsed_internal is not None),
                        "ok": int(ok),
                        "error": (stderr or "").strip(),
                    }
                )

                if not ok:
                    ok_mode = False
                    last_err = (stderr or "").strip()
                    print(f"[{mode_name}] run {i} failed: {last_err}")
                    break

                if parsed_internal is None:
                    ok_mode = False
                    last_err = "failed to parse POLYBENCH_TIME from output"
                    print(f"[{mode_name}] run {i} failed: {last_err}")
                    break

                internal_times.append(parsed_internal)

            s = safe_stats(internal_times)
            mode_stats[mode_name] = s
            mode_internal_medians[mode_name] = s["median"]
            mode_ok[mode_name] = ok_mode

        native_median = mode_internal_medians.get(EXTERNAL_RUNTIME_NATIVE, 0.0)
        jit_median = mode_internal_medians.get(EXTERNAL_RUNTIME_WASM_JIT, 0.0)
        aot_median = mode_internal_medians.get(EXTERNAL_RUNTIME_WASM_AOT, 0.0)

        ratio_jit = (jit_median / native_median) if native_median > 0 else 0.0
        ratio_aot = (aot_median / native_median) if native_median > 0 else 0.0

        label_jit = "run-failed"
        label_aot = "run-failed"

        if mode_ok.get(EXTERNAL_RUNTIME_NATIVE, False) and mode_ok.get(
            EXTERNAL_RUNTIME_WASM_JIT, False
        ):
            label_jit = label_by_ratio(ratio_jit, args.threshold)

        if mode_ok.get(EXTERNAL_RUNTIME_NATIVE, False) and mode_ok.get(
            EXTERNAL_RUNTIME_WASM_AOT, False
        ):
            label_aot = label_by_ratio(ratio_aot, args.threshold)

        summary_rows.append(
            {
                "program": prog,
                "native_ok": int(mode_ok.get(EXTERNAL_RUNTIME_NATIVE, False)),
                "wasm_jit_ok": int(mode_ok.get(EXTERNAL_RUNTIME_WASM_JIT, False)),
                "wasm_aot_ok": int(mode_ok.get(EXTERNAL_RUNTIME_WASM_AOT, False)),
                "native_median_internal_ms": round(native_median, 6),
                "wasm_jit_median_internal_ms": round(jit_median, 6),
                "wasm_aot_median_internal_ms": round(aot_median, 6),
                "ratio_jit_over_native": round(ratio_jit, 6),
                "ratio_aot_over_native": round(ratio_aot, 6),
                "label_jit": label_jit,
                "label_aot": label_aot,
                "note": "",
            }
        )

    # Write summary CSV
    with summary_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "program",
                "native_ok",
                "wasm_jit_ok",
                "wasm_aot_ok",
                "native_median_internal_ms",
                "wasm_jit_median_internal_ms",
                "wasm_aot_median_internal_ms",
                "ratio_jit_over_native",
                "ratio_aot_over_native",
                "label_jit",
                "label_aot",
                "note",
            ],
        )
        writer.writeheader()
        writer.writerows(summary_rows)

    # Write raw external timing CSV
    with raw_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=["program", "runtime", "run_index", "internal_ms", "parsed_ok", "ok", "error"],
        )
        writer.writeheader()
        writer.writerows(raw_rows)

    # Write internal timing CSV
    with internal_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=["program", "runtime", "run_index", "internal_ms", "parsed_ok"],
        )
        writer.writeheader()
        writer.writerows(internal_rows)

    print("\n=== PolyBench Label Summary (JIT) ===")
    summary_jit: Dict[str, int] = {}
    for r in summary_rows:
        summary_jit[r["label_jit"]] = summary_jit.get(r["label_jit"], 0) + 1
    for k in sorted(summary_jit):
        print(f"{k}: {summary_jit[k]}")

    print("\n=== PolyBench Label Summary (AOT) ===")
    summary_aot: Dict[str, int] = {}
    for r in summary_rows:
        summary_aot[r["label_aot"]] = summary_aot.get(r["label_aot"], 0) + 1
    for k in sorted(summary_aot):
        print(f"{k}: {summary_aot[k]}")

    print(f"\nsummary output:  {summary_csv}")
    print(f"raw timings:     {raw_csv}")
    print(f"internal timings:{internal_csv}")


if __name__ == "__main__":
    main()

