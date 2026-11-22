---
name: scheme-dev
description: Develop and review the CS F301 Assignment 2 Scheme work (S1 and S2) in Racket 8.x under its restricted racket/base built-in set.
---

# Scheme development for CS F301 Assignment 2

Use this skill only for the two Scheme problems in `PPL_Assignment_2_Final.pdf`: S1 (Binary Tree Traversals) and S2 (Conditionally Insert into a Nested List). Do not use it for Prolog work.

## Before a unit of work

1. Re-read the relevant S1 or S2 section of `PPL_Assignment_2_Final.pdf` and `AGENTS.md`. The PDF is authoritative if they differ.
2. Confirm that the request is exactly one unit: one function, one test file, or one review. If it includes more, name the units and ask for one at a time.
3. Record the request verbatim under the next numbered heading in `prompts/S1.md` or `prompts/S2.md` before changing code.
4. Do not guess the group ID. Use `code/<group-id>_q3.rkt` or `code/<group-id>_q4.rkt` only after the group ID is known.

## Language boundary

- Target Racket 8.x. Every solution file begins with `#lang racket/base`.
- A solution file contains definitions only. Do not call functions at top level, and do not print when the file is loaded; the grader adds its calls itself.
- Run the source files with `racket code/<group-id>_q3.rkt` and `racket code/<group-id>_q4.rkt`. Loading without output is expected. Run a dedicated test file only when that separate unit is requested.
- No `require` form or other library facility is permitted.

Only the following built-ins may be used: `define`, `lambda`, `let`, `let*`, `letrec`, named `let`, `if`, `cond` (with `else`), `and`, `or`, `not`, `begin`, `quote` (written `'`), `cons`, `car`, `cdr`, `list`, every composition of `car` and `cdr` up to four levels (`cadr`, `cddr`, `caddr`, `cdddr`, `cadddr`, `cddddr`, and so on), `null?`, `pair?`, `eq?`, `assq`, `assoc`, the arithmetic and comparison operators `+ - * < > <= >= =`, `max`, `display` and `newline`. S2 additionally allows `read`.

Nothing else from `racket/base` may be used. In particular: no `set!` or its relatives, no vectors, hash tables or strings, no loops (`do`, `for`), and no `length`, `append`, `reverse`, `map`, `filter`, `member`, `memq`, `list-ref` or `list-tail`. If you need such a function, write your own helper (for example `my-reverse`).

## Coding conventions

- Use lower-case hyphenated names for functions and descriptive parameters. Use a short `;` comment only where a function's recursive contract or accumulator role is not obvious.
- For every helper, be able to state its structural or tail-recursive reading: its base case, the smaller argument in the recursive case, and what any accumulator represents.
- Pass all state through parameters. Do not simulate mutation through hidden top-level state or rely on effects except the required `display`, `newline`, and S2 `read`.
- Write list helpers directly from `null?`, `pair?`, `car`, `cdr`, and `cons`. Never silently substitute a forbidden convenience.
- Preserve the grader's interface exactly and keep helpers private by convention; there is no need to add a module interface or exports.

## S1-specific guidance

- A tree is either `()` or a three-element list `(value left right)`. Treat `()` as height 0 and as having no leaves.
- Traverse left before right. Use the stated definitions of inorder, preorder, and postorder rather than relying on a library traversal.
- `print-inorder` prints exactly one list and ends with `newline`.
- `print-all-traversals` prints exactly three lines, in inorder, preorder, postorder order; each is a displayed list followed by `newline`.
- `print-height-and-leaves` prints exactly one displayed list `(height leaf-count)` followed by `newline`. A leaf has both subtrees equal to `()`.
- Keep traversal construction separate from printing so the same recursive reasoning can be checked independently of output formatting.

## S2-specific guidance

- `print-insert-result` takes no arguments, reads `x`, `lst`, and `n` in that exact order, then displays only the result followed by `newline`. It prints no prompt or extra text.
- Implement `my-length` and `my-map` yourself using the allowed built-ins. Define `insert-if-short` with them.
- `make-inserter` takes `x` and `len-ok?`, returns a one-argument function over a list, and inserts at the front of every list at every nesting level whose length satisfies `len-ok?`.
- The final file has one definition of `insert-if-short`: the one defined using `make-inserter`.
- Measure each list's length on its original top-level elements before inserting anything. Apply the same rule to the top-level list and to empty lists. Recurse into nested lists while leaving atoms unchanged.
- Design for the hidden nesting-depth-100 and list-length-10,000 cases: use linear list passes, avoid repeated traversal of the same list, and prefer tail recursion where it fits without changing required output order.

## Testing and review

- Write a separate S1 or S2 test file only when asked. Use every PDF example plus focused empty, boundary, and deep-nesting cases appropriate to that unit.
- Before reporting completion, run the relevant `racket` command when possible and state exactly what it did. If calls need a temporary test harness or were not run, say so plainly.
- Confirm that loading a solution source file does not invoke a required output function itself.

### Self-review checklist

- Is this exactly one requested unit, with its prompt recorded word for word first?
- Does the file start with `#lang racket/base`, contain definitions only, and use the correct group-ID filename?
- Are every built-in and helper permitted by the exact allowed list above, with S2 alone using `read`?
- Are forbidden conveniences, mutation, loops, libraries, strings, and top-level calls absent?
- For S1, are empty-tree height and leaves, left-before-right order, and exact line counts/newlines correct?
- For S2, are original-list lengths used, empty lists handled, atoms preserved, and the sole final `insert-if-short` defined through `make-inserter`?
- Were test commands actually run, with output and any unrun checks reported honestly?

### Common AI failure modes

- Accidentally using `append`, `map`, `length`, `reverse`, `list-ref`, `match`, `apply`, `require`, `provide`, or another convenient Racket feature outside the allowed list.
- Printing examples at top level, which creates output as soon as the grader loads the file.
- Treating an empty tree as a leaf, traversing right before left, or omitting a required newline in S1.
- Counting a nested list's transformed length instead of its original top-level length in S2.
- Treating `()` as an atom or skipping insertion into it when `n` is positive.
- Defining `insert-if-short` twice, failing to use `make-inserter` in its final definition, or adding prompts around S2 standard input/output.
- Writing apparently correct recursion with repeated list scans that becomes impractical for the hidden 10,000-element or depth-100 tests.
