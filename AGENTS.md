# CS F301 Assignment 2 - Working Agreement

## A. Purpose

Work step by step on CS F301 Assignment 2. `PPL_Assignment_2_Final.pdf` is the single source of truth. Never rely on memory for rules; re-read the relevant PDF section before each unit of work.

## B. Hard workflow rules

- One prompt equals one unit of work: one predicate, one function, one test file, or one review. If a prompt asks for a whole problem or several units, refuse, name the units it contains, and ask the user to send them one at a time.
- Before doing any work, append the user's prompt verbatim, word for word and without edits, under a numbered heading in the correct prompt file: `prompts/P1.md`, `prompts/P2.md`, `prompts/S1.md`, `prompts/S2.md`, or `prompts/Setup_Prompt.md` for setup. Never paraphrase or reconstruct prompts later.
- Touch only the file or files needed by the current unit.
- After finishing a unit, stop. Report what changed, how to run it, and what was actually run versus not run. Then wait.
- Never run `git commit` or `git push`. Suggest a commit message instead; the student commits it.
- Never print anything or call functions at top level in solution files. Follow PDF Section 1 exactly.
- Do not guess the group ID. Obtain it before creating group-ID-dependent solution or test filenames.

## C. Language constraints from the PDF

### Prolog

- Use SWI-Prolog 9.x.
- P1 allowed libraries: `lists`, `apply`, `yall`, `aggregate`.
- P1 forbidden features: `assert`, `retract` or global variables (`b_setval`, `nb_setval`).
- P2 allowed libraries: `lists`, `apply`, `yall`, `aggregate`.
- P2 forbidden features: `assert`, `retract` or global variables. Do not build a string and parse it back into a term to evaluate it.
- Prolog files must contain only definitions and must not contain an initialization directive. Do not call `halt/0` yourself.

### Scheme

- Use Racket 8.x with `#lang racket/base`.
- Only the following built-ins may be used: `define`, `lambda`, `let`, `let*`, `letrec`, named `let`, `if`, `cond` (with `else`), `and`, `or`, `not`, `begin`, `quote` (written `'`), `cons`, `car`, `cdr`, `list`, every composition of `car` and `cdr` up to four levels (`cadr`, `cddr`, `caddr`, `cdddr`, `cadddr`, `cddddr`, and so on), `null?`, `pair?`, `eq?`, `assq`, `assoc`, the arithmetic and comparison operators `+ - * < > <= >= =`, `max`, `display` and `newline`. S2 additionally allows `read`.
- Nothing else from `racket/base` may be used. In particular: no `set!` or its relatives, no vectors, hash tables or strings, no loops (`do`, `for`), and no `length`, `append`, `reverse`, `map`, `filter`, `member`, `memq`, `list-ref` or `list-tail`. If one is needed, write a helper (for example `my-reverse`).
- Racket files start with `#lang racket/base`, contain only definitions, do not call functions at top level, and print nothing when loaded. The grader adds its calls itself.

## D. Run and test commands

- P1 main: `swipl -q -f code/<group-id>_q1.pl -g main -t halt`
- Other Prolog predicates: `swipl -q -f code/<group-id>_q1.pl -g "<goal>" -t halt` (substitute the relevant Prolog file as needed).
- S1: `racket code/<group-id>_q3.rkt`
- S2: `racket code/<group-id>_q4.rkt`
- Run only commands applicable to the current unit; report the exact commands that were run and any that were not run.

## E. Required order of work

`setup -> skills -> P1 -> P2 -> S1 -> S2 -> report -> final review`

## F. Self-review checklist

Before every answer, check:

- Does the requested work contain exactly one permitted unit?
- Was the verbatim prompt recorded in the correct file before work started?
- Were the relevant PDF rules re-read, including allowed libraries and forbidden features?
- Are the file names and locations correct, and is the group ID known rather than guessed?
- Does the solution avoid top-level calls, initialization directives, and unrequested output?
- Did this unit touch only the required files?
- Are all claims about tests truthful and specific?

## G. Honesty rule

If a test was not run, say so. Never claim code works without running it. If unsure about a language behaviour, say so instead of guessing.
