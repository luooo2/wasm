#!/usr/bin/env python3
from pathlib import Path

ROOT = Path(r"c:\Users\86187\Desktop\graduation project\wasm")

# 1) Fix warmup error passthrough in run_benchmarks.py
rb = ROOT / "src" / "run_benchmarks.py"
s = rb.read_text(encoding="utf-8")
old = (
    "        # warmup phase (not recorded)\n"
    "        for _ in range(max(args.warmup, 0)):\n"
    "            ok_n, _, _ = run_once(n_cmd, args.timeout)\n"
    "            ok_w, _, _ = run_once(w_cmd, args.timeout)\n"
    "            if not ok_n or not ok_w:\n"
    "                break\n"
)
new = (
    "        # warmup phase (not recorded)\n"
    "        for _ in range(max(args.warmup, 0)):\n"
    "            ok_n, _, err_n_warm = run_once(n_cmd, args.timeout)\n"
    "            if not ok_n:\n"
    "                native_ok = False\n"
    "                native_err = f\"warmup failed: {err_n_warm or 'unknown'}\"\n"
    "                break\n\n"
    "            ok_w, _, err_w_warm = run_once(w_cmd, args.timeout)\n"
    "            if not ok_w:\n"
    "                wasm_ok = False\n"
    "                wasm_err = f\"warmup failed: {err_w_warm or 'unknown'}\"\n"
    "                break\n"
)
if old in s:
    s = s.replace(old, new, 1)

old2 = "        # measured phase\n        for i in range(1, args.repeats + 1):\n"
new2 = "        # measured phase\n        if native_ok and wasm_ok:\n            for i in range(1, args.repeats + 1):\n"
if old2 in s:
    s = s.replace(old2, new2, 1)

# fix indentation inside measured loop block after wrapping with if
s = s.replace("\n            print(\"$\", \" \".join(shlex.quote(c) for c in n_cmd))", "\n                print(\"$\", \" \".join(shlex.quote(c) for c in n_cmd))")
s = s.replace("\n            ok_n, t_n, err_n = run_once(n_cmd, args.timeout)", "\n                ok_n, t_n, err_n = run_once(n_cmd, args.timeout)")
s = s.replace("\n            raw_rows.append(", "\n                raw_rows.append(")
s = s.replace("\n            if not ok_n or t_n is None:", "\n                if not ok_n or t_n is None:")
s = s.replace("\n            native_times.append(t_n)", "\n                native_times.append(t_n)")
s = s.replace("\n            print(\"$\", \" \".join(shlex.quote(c) for c in w_cmd))", "\n                print(\"$\", \" \".join(shlex.quote(c) for c in w_cmd))")
s = s.replace("\n            ok_w, t_w, err_w = run_once(w_cmd, args.timeout)", "\n                ok_w, t_w, err_w = run_once(w_cmd, args.timeout)")
s = s.replace("\n            if not ok_w or t_w is None:", "\n                if not ok_w or t_w is None:")
s = s.replace("\n            wasm_times.append(t_w)", "\n                wasm_times.append(t_w)")

rb.write_text(s, encoding="utf-8")

# 2) Fix nanosecond borrow in all microbenchmarks C files
micro_dir = ROOT / "data" / "microbenchmarks"
for p in sorted(micro_dir.glob("*.c")):
    c = p.read_text(encoding="utf-8")
    old_calc = (
        "    __time_ns = (unsigned long long)(__ts_end.tv_sec - __ts_start.tv_sec) * 1000000000ull\n"
        "              + (unsigned long long)(__ts_end.tv_nsec - __ts_start.tv_nsec);\n"
    )
    if old_calc in c:
        new_calc = (
            "    __time_ns = (unsigned long long)(__ts_end.tv_sec - __ts_start.tv_sec) * 1000000000ull;\n"
            "    if (__ts_end.tv_nsec >= __ts_start.tv_nsec) {\n"
            "        __time_ns += (unsigned long long)(__ts_end.tv_nsec - __ts_start.tv_nsec);\n"
            "    } else {\n"
            "        __time_ns -= 1000000000ull;\n"
            "        __time_ns += (unsigned long long)(__ts_end.tv_nsec + 1000000000L - __ts_start.tv_nsec);\n"
            "    }\n"
        )
        c = c.replace(old_calc, new_calc, 1)
        p.write_text(c, encoding="utf-8")

# 3) Keep generator template in sync
inst = ROOT / "src" / "instrument_microbench_internal_timer.py"
t = inst.read_text(encoding="utf-8")
old_gen = (
    '        "    __time_ns = (unsigned long long)(__ts_end.tv_sec - __ts_start.tv_sec) * 1000000000ull\\n"\n'
    '        "              + (unsigned long long)(__ts_end.tv_nsec - __ts_start.tv_nsec);\\n"\n'
)
new_gen = (
    '        "    __time_ns = (unsigned long long)(__ts_end.tv_sec - __ts_start.tv_sec) * 1000000000ull;\\n"\n'
    '        "    if (__ts_end.tv_nsec >= __ts_start.tv_nsec) {\\n"\n'
    '        "        __time_ns += (unsigned long long)(__ts_end.tv_nsec - __ts_start.tv_nsec);\\n"\n'
    '        "    } else {\\n"\n'
    '        "        __time_ns -= 1000000000ull;\\n"\n'
    '        "        __time_ns += (unsigned long long)(__ts_end.tv_nsec + 1000000000L - __ts_start.tv_nsec);\\n"\n'
    '        "    }\\n"\n'
)
if old_gen in t:
    t = t.replace(old_gen, new_gen, 1)
inst.write_text(t, encoding="utf-8")
