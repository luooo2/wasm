#!/usr/bin/env python3
import re
from pathlib import Path

ROOT = Path(r"c:\Users\86187\Desktop\graduation project\wasm\data\microbenchmarks")

MAIN_PATTERNS = [
    re.compile(r"(int\s+main\s*\(\s*void\s*\)\s*\{\n)"),
    re.compile(r"(int\s+main\s*\(\s*\)\s*\{\n)"),
]

for path in sorted(ROOT.glob("*.c")):
    src = path.read_text(encoding="utf-8")
    orig = src

    if "#include <time.h>" not in src:
        if "#include <stdio.h>\n" in src:
            src = src.replace("#include <stdio.h>\n", "#include <stdio.h>\n#include <time.h>\n", 1)
        else:
            src = "#include <time.h>\n" + src

    src = re.sub(r"^\s*printf\([^\n]*\);\s*\n", "", src, flags=re.M)

    injected = False
    for pat in MAIN_PATTERNS:
        m = pat.search(src)
        if not m:
            continue
        timer_start = (
            m.group(1)
            + "    struct timespec __ts_start, __ts_end;\n"
            + "    unsigned long long __time_ns = 0;\n"
            + "    clock_gettime(CLOCK_MONOTONIC, &__ts_start);\n"
        )
        src = src[: m.start()] + timer_start + src[m.end() :]
        injected = True
        break

    if not injected:
        print(f"[WARN] main not found: {path.name}")
        continue

    ret_idx = src.rfind("return 0;")
    if ret_idx < 0:
        print(f"[WARN] return 0 not found: {path.name}")
        continue

    timer_end = (
        "    clock_gettime(CLOCK_MONOTONIC, &__ts_end);\n"
        "    __time_ns = (unsigned long long)(__ts_end.tv_sec - __ts_start.tv_sec) * 1000000000ull;\n"
        "    if (__ts_end.tv_nsec >= __ts_start.tv_nsec) {\n"
        "        __time_ns += (unsigned long long)(__ts_end.tv_nsec - __ts_start.tv_nsec);\n"
        "    } else {\n"
        "        __time_ns -= 1000000000ull;\n"
        "        __time_ns += (unsigned long long)(__ts_end.tv_nsec + 1000000000L - __ts_start.tv_nsec);\n"
        "    }\n"
        "    printf(\"TIME_NS:%llu\\n\", __time_ns);\n"
        "    return 0;"
    )
    src = src[:ret_idx] + timer_end + src[ret_idx + len("return 0;") :]

    if src != orig:
        path.write_text(src, encoding="utf-8")
        print(f"[OK] {path.name}")
