#!/usr/bin/env python3
"""
Batch run native and wasm programs using benchmark-internal timing output.

Each benchmark must print one timing line in stdout/stderr:
- TIME_NS:<integer nanoseconds>

Outputs:
1) summary CSV: label + mean/median/std/min/max (internal ms)
2) raw CSV: one row per run (internal ms)

Label rule by ratio r = wasm_median_internal_ms / native_median_internal_ms:
- r > 1 + threshold => native-better
- r < 1 - threshold => wasm-better
- else => similar
"""

import argparse
import csv
import re
import shlex
import statistics
import subprocess
from pathlib import Path
from typing import List, Optional, Tuple

RE_TIME_NS = re.compile(r"TIME_NS\s*:\s*([0-9]+)")
RE_NUMERIC = re.compile(r"^\s*([0-9]+)\s*$")


def parse_internal_time_ms(output: str) -> Optional[float]:
    m = RE_TIME_NS.search(output or "")
    if m:
        try:
            return int(m.group(1)) / 1_000_000.0
        except ValueError:
            pass

    nums: List[int] = []
    for line in (output or "").splitlines():
        mm = RE_NUMERIC.match(line)
        if not mm:
            continue
        try:
            nums.append(int(mm.group(1)))
        except ValueError:
            continue
    return (nums[-1] / 1_000_000.0) if nums else None


def run_once(cmd: List[str], timeout_sec: int) -> Tuple[bool, Optional[float], str]:
    try:
        p = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout_sec)
    except subprocess.TimeoutExpired:
        return False, None, f"timeout after {timeout_sec}s"

    out = f"{p.stdout or ''}\n{p.stderr or ''}"
    if p.returncode != 0:
        err = (p.stderr or p.stdout or "").strip() or f"exit code {p.returncode}"
        return False, None, err

    t_ms = parse_internal_time_ms(out)
    if t_ms is None:
        return False, None, "internal timing not found (expect TIME_NS:<ns>)"
    return True, t_ms, ""


def stats(values: List[float]) -> dict:
    if not values:
        return {"mean": 0.0, "median": 0.0, "std": 0.0, "min": 0.0, "max": 0.0}
    return {
        "mean": statistics.mean(values),
        "median": statistics.median(values),
        "std": statistics.stdev(values) if len(values) >= 2 else 0.0,
        "min": min(values),
        "max": max(values),
    }


def label_by_ratio(ratio: float, threshold: float) -> str:
    if ratio > 1.0 + threshold:
        return "native-better"
    if ratio < 1.0 - threshold:
        return "wasm-better"
    return "similar"


def parse_programs_arg(programs_arg: str) -> Optional[set]:
    vals = [x.strip() for x in (programs_arg or "").split(",") if x.strip()]
    return set(vals) if vals else None


def ensure_aot_artifact(wasmtime_cmd: str, wasm_path: Path, aot_cache_dir: Path) -> tuple[bool, Optional[Path], str]:
    aot_cache_dir.mkdir(parents=True, exist_ok=True)
    out_path = aot_cache_dir / f"{wasm_path.stem}.cwasm"
    if out_path.exists():
        return True, out_path, ""

    cmd = [wasmtime_cmd, "compile", str(wasm_path), "-o", str(out_path)]
    try:
        p = subprocess.run(cmd, capture_output=True, text=True, timeout=180)
    except subprocess.TimeoutExpired:
        return False, None, "wasmtime compile timeout after 180s"

    if p.returncode != 0:
        msg = (p.stderr or p.stdout or "").strip()
        return False, None, msg or f"wasmtime compile failed: {p.returncode}"
    return True, out_path, ""


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--build-dir", default="data/build")
    ap.add_argument("--out-csv", default="data/results/labels.csv")
    ap.add_argument("--raw-csv", default="data/results/labels_raw.csv")
    ap.add_argument("--wasmtime", default="wasmtime")
    ap.add_argument("--wasm-mode", choices=["jit", "aot", "both"], default="jit")
    ap.add_argument("--aot-cache-dir", default="data/build/microbench_internal/aot_cache")
    ap.add_argument("--repeats", type=int, default=30)
    ap.add_argument("--warmup", type=int, default=2)
    ap.add_argument("--timeout", type=int, default=180)
    ap.add_argument("--threshold", type=float, default=0.10)
    ap.add_argument("--programs", default="")
    args = ap.parse_args()

    build_dir = Path(args.build_dir)
    out_csv = Path(args.out_csv)
    raw_csv = Path(args.raw_csv)
    out_csv.parent.mkdir(parents=True, exist_ok=True)
    raw_csv.parent.mkdir(parents=True, exist_ok=True)

    selected = parse_programs_arg(args.programs)
    aot_cache_dir = Path(args.aot_cache_dir)
    requested_modes = ["jit", "aot"] if args.wasm_mode == "both" else [args.wasm_mode]

    summary_rows = []
    raw_rows = []

    for nb in sorted(build_dir.glob("*.native")):
        prog = nb.name[:-7] if nb.name.endswith(".native") else nb.stem
        if selected is not None and prog not in selected:
            continue

        wb = build_dir / f"{prog}.wasm"
        print(f"\n=== Running {prog} ===")

        n_cmd = [str(nb)]
        native_ok = True
        native_err = ""
        native_times: List[float] = []

        jit_ok = "jit" in requested_modes
        jit_err = "" if jit_ok else "not requested"
        jit_cmd: List[str] = [args.wasmtime, "--dir=.", str(wb)] if jit_ok else []
        jit_times: List[float] = []

        aot_ok = "aot" in requested_modes
        aot_err = "" if aot_ok else "not requested"
        aot_cmd: List[str] = []
        aot_times: List[float] = []

        if not wb.exists():
            native_ok = False
            native_err = f"missing {nb}"
            if "jit" in requested_modes:
                jit_ok = False
                jit_err = f"missing {wb}"
            if "aot" in requested_modes:
                aot_ok = False
                aot_err = f"missing {wb}"
        else:
            if "aot" in requested_modes:
                ok_aot, aot_path, build_err = ensure_aot_artifact(args.wasmtime, wb, aot_cache_dir)
                if ok_aot and aot_path is not None:
                    aot_cmd = [args.wasmtime, "run", "--allow-precompiled", "--dir=.", str(aot_path)]
                else:
                    aot_ok = False
                    aot_err = build_err or "aot-compile-failed"

            for _ in range(max(args.warmup, 0)):
                ok_n, _, err_nw = run_once(n_cmd, args.timeout)
                if not ok_n:
                    native_ok = False
                    native_err = f"warmup failed: {err_nw or 'unknown'}"
                    break

                if jit_ok:
                    ok_j, _, err_jw = run_once(jit_cmd, args.timeout)
                    if not ok_j:
                        jit_ok = False
                        jit_err = f"warmup failed: {err_jw or 'unknown'}"

                if aot_ok:
                    ok_a, _, err_aw = run_once(aot_cmd, args.timeout)
                    if not ok_a:
                        aot_ok = False
                        aot_err = f"warmup failed: {err_aw or 'unknown'}"

            if native_ok:
                for i in range(1, args.repeats + 1):
                    print("$", " ".join(shlex.quote(c) for c in n_cmd))
                    ok_n, t_n, err_n = run_once(n_cmd, args.timeout)
                    raw_rows.append({"program": prog, "runtime": "native", "run_index": i, "internal_ms": round(t_n, 6) if t_n is not None else 0.0, "ok": int(ok_n), "error": err_n})
                    if not ok_n or t_n is None:
                        native_ok = False
                        native_err = err_n
                        break
                    native_times.append(t_n)

                    if jit_ok:
                        print("$", " ".join(shlex.quote(c) for c in jit_cmd))
                        ok_j, t_j, err_j = run_once(jit_cmd, args.timeout)
                        raw_rows.append({"program": prog, "runtime": "wasm-jit", "run_index": i, "internal_ms": round(t_j, 6) if t_j is not None else 0.0, "ok": int(ok_j), "error": err_j})
                        if not ok_j or t_j is None:
                            jit_ok = False
                            jit_err = err_j
                        else:
                            jit_times.append(t_j)

                    if aot_ok:
                        print("$", " ".join(shlex.quote(c) for c in aot_cmd))
                        ok_a, t_a, err_a = run_once(aot_cmd, args.timeout)
                        raw_rows.append({"program": prog, "runtime": "wasm-aot", "run_index": i, "internal_ms": round(t_a, 6) if t_a is not None else 0.0, "ok": int(ok_a), "error": err_a})
                        if not ok_a or t_a is None:
                            aot_ok = False
                            aot_err = err_a
                        else:
                            aot_times.append(t_a)

        ns = stats(native_times)
        js = stats(jit_times)
        a_s = stats(aot_times)

        ratio_jit = (js["median"] / ns["median"]) if ns["median"] > 0 else 0.0
        ratio_aot = (a_s["median"] / ns["median"]) if ns["median"] > 0 else 0.0

        label_jit = label_by_ratio(ratio_jit, args.threshold) if (native_ok and jit_ok) else "run-failed"
        label_aot = label_by_ratio(ratio_aot, args.threshold) if (native_ok and aot_ok) else "run-failed"

        if args.wasm_mode == "jit":
            wasm_ok, wasm_stats, wasm_ratio, wasm_label, wasm_error = jit_ok, js, ratio_jit, label_jit, jit_err
        elif args.wasm_mode == "aot":
            wasm_ok, wasm_stats, wasm_ratio, wasm_label, wasm_error = aot_ok, a_s, ratio_aot, label_aot, aot_err
        else:
            if jit_ok:
                wasm_ok, wasm_stats, wasm_ratio, wasm_label, wasm_error = jit_ok, js, ratio_jit, label_jit, jit_err
            else:
                wasm_ok, wasm_stats, wasm_ratio, wasm_label, wasm_error = aot_ok, a_s, ratio_aot, label_aot, aot_err

        summary_rows.append({
            "program": prog,
            "native_ok": int(native_ok),
            "native_mean_internal_ms": round(ns["mean"], 6),
            "native_median_internal_ms": round(ns["median"], 6),
            "native_std_internal_ms": round(ns["std"], 6),
            "native_min_internal_ms": round(ns["min"], 6),
            "native_max_internal_ms": round(ns["max"], 6),
            "native_error": native_err,

            "jit_ok": int(jit_ok),
            "jit_mean_internal_ms": round(js["mean"], 6),
            "jit_median_internal_ms": round(js["median"], 6),
            "jit_std_internal_ms": round(js["std"], 6),
            "jit_min_internal_ms": round(js["min"], 6),
            "jit_max_internal_ms": round(js["max"], 6),
            "ratio_jit_over_native": round(ratio_jit, 6),
            "label_jit": label_jit,
            "jit_error": jit_err,

            "aot_ok": int(aot_ok),
            "aot_mean_internal_ms": round(a_s["mean"], 6),
            "aot_median_internal_ms": round(a_s["median"], 6),
            "aot_std_internal_ms": round(a_s["std"], 6),
            "aot_min_internal_ms": round(a_s["min"], 6),
            "aot_max_internal_ms": round(a_s["max"], 6),
            "ratio_aot_over_native": round(ratio_aot, 6),
            "label_aot": label_aot,
            "aot_error": aot_err,

            "wasm_ok": int(wasm_ok),
            "wasm_mean_internal_ms": round(wasm_stats["mean"], 6),
            "wasm_median_internal_ms": round(wasm_stats["median"], 6),
            "wasm_std_internal_ms": round(wasm_stats["std"], 6),
            "wasm_min_internal_ms": round(wasm_stats["min"], 6),
            "wasm_max_internal_ms": round(wasm_stats["max"], 6),
            "ratio_wasm_over_native": round(wasm_ratio, 6),
            "label": wasm_label,
            "wasm_error": wasm_error,
        })

    with out_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=[
            "program",
            "native_ok", "native_mean_internal_ms", "native_median_internal_ms", "native_std_internal_ms", "native_min_internal_ms", "native_max_internal_ms", "native_error",
            "jit_ok", "jit_mean_internal_ms", "jit_median_internal_ms", "jit_std_internal_ms", "jit_min_internal_ms", "jit_max_internal_ms", "ratio_jit_over_native", "label_jit", "jit_error",
            "aot_ok", "aot_mean_internal_ms", "aot_median_internal_ms", "aot_std_internal_ms", "aot_min_internal_ms", "aot_max_internal_ms", "ratio_aot_over_native", "label_aot", "aot_error",
            "wasm_ok", "wasm_mean_internal_ms", "wasm_median_internal_ms", "wasm_std_internal_ms", "wasm_min_internal_ms", "wasm_max_internal_ms", "ratio_wasm_over_native", "label", "wasm_error",
        ])
        writer.writeheader()
        writer.writerows(summary_rows)

    with raw_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=["program", "runtime", "run_index", "internal_ms", "ok", "error"])
        writer.writeheader()
        writer.writerows(raw_rows)

    print("\n=== Microbench Label Summary (JIT) ===")
    label_count_jit = {}
    for r in summary_rows:
        k = r.get("label_jit", "")
        label_count_jit[k] = label_count_jit.get(k, 0) + 1
    for k in sorted(label_count_jit):
        print(f"{k}: {label_count_jit[k]}")

    print("\n=== Microbench Label Summary (AOT) ===")
    label_count_aot = {}
    for r in summary_rows:
        k = r.get("label_aot", "")
        label_count_aot[k] = label_count_aot.get(k, 0) + 1
    for k in sorted(label_count_aot):
        print(f"{k}: {label_count_aot[k]}")

    print(f"summary output: {out_csv}")
    print(f"raw output:     {raw_csv}")


if __name__ == "__main__":
    main()
