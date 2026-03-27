/**
 * polybench_stub.c
 *
 * Minimal stub replacing utilities/polybench.c for use in this project.
 *
 * Rationale:
 *   The original polybench.c uses Linux-specific APIs not supported under
 *   WASI (sched_setaffinity, sys/resource.h, PAPI, etc.).
 *   run_benchmarks.py measures wall-clock time externally via Python
 *   subprocess timing, so we do NOT need polybench's built-in timer at all.
 *
 * What polybench.h already handles as macros (no function needed here):
 *   - polybench_start_instruments   -> empty macro (default, no POLYBENCH_TIME)
 *   - polybench_stop_instruments    -> empty macro
 *   - polybench_print_instruments   -> empty macro
 *   - polybench_prevent_dce(func)   -> calls the func then does a volatile sink
 *
 * What this stub provides:
 *   - polybench_alloc_data    (heap allocation, used by POLYBENCH_*D_ARRAY_DECL)
 *   - polybench_free_data     (free, used by POLYBENCH_FREE_ARRAY when padding on)
 *   - polybench_flush_cache   (no-op; declared extern in polybench.h)
 *
 * Compile with: -I utilities (so polybench.h is found) but WITHOUT
 *   -DPOLYBENCH_TIME or -DPOLYBENCH_PAPI, so that the instrument macros
 *   stay as empty stubs and we never reference the real timer functions.
 */

#include <stdlib.h>
#include <stdio.h>

/* Include polybench.h AFTER the guard, so we see the same macro environment
   as the kernel .c file.  We do NOT define POLYBENCH_TIME or POLYBENCH_PAPI
   so the instrument macros remain empty. */
#include "polybench.h"

/* polybench_flush_cache: declared extern in polybench.h, must be defined.
   We make it a no-op since we are not trying to flush LLC between runs.
   (run_benchmarks.py already adds warmup iterations for this purpose.) */
void polybench_flush_cache(void)
{
    (void)0;
}

/* polybench_alloc_data: allocates n * elt_size bytes.
   The original implementation supports inter-array padding; we just use
   malloc since padding is irrelevant for our measurements. */
void* polybench_alloc_data(unsigned long long int n, int elt_size)
{
    void* ptr = malloc((size_t)n * (size_t)elt_size);
    if (!ptr) {
        fprintf(stderr,
                "polybench_stub: malloc failed (%llu * %d bytes)\n",
                n, elt_size);
        exit(1);
    }
    return ptr;
}

/* polybench_free_data: called by POLYBENCH_FREE_ARRAY when inter-array
   padding is enabled.  Without padding, FREE_ARRAY calls free() directly.
   We provide the symbol regardless so linking always succeeds. */
void polybench_free_data(void* ptr)
{
    free(ptr);
}
