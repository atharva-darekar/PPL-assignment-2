---
name: prolog-dev
description: Develop and review the CS F301 Assignment 2 Prolog work (P1 and P2) in SWI-Prolog 9.x, preserving the assignment's predicate, output, and library constraints.
---

# Prolog development for CS F301 Assignment 2

Use this skill only for the two Prolog problems in `PPL_Assignment_2_Final.pdf`: P1 (Department Assignment Puzzle, Reloaded) and P2 (Form a Valid Arithmetic Equation). Do not use it for Scheme work.

## Before a unit of work

1. Read the relevant P1 or P2 section of `PPL_Assignment_2_Final.pdf` and `AGENTS.md`; the PDF is authoritative if they differ.
2. Check that the request is exactly one unit: one predicate, one test file, or one review. If it contains more, name the units and ask for one at a time.
3. Record the request verbatim under the next numbered heading in `prompts/P1.md` or `prompts/P2.md` before editing code.
4. Do not guess the group ID. Use the required path `code/<group-id>_q1.pl` or `code/<group-id>_q2.pl` only once the group ID is known.

## Assignment-wide Prolog rules

- Target SWI-Prolog 9.x.
- Solution files contain definitions only. Do not add an initialization directive or call `halt/0`.
- Run P1's entry point with `swipl -q -f code/<group-id>_q1.pl -g main -t halt`.
- Run a predicate query with `swipl -q -f code/<group-id>_q1.pl -g "<goal>" -t halt`, substituting the relevant Prolog file and goal.
- Do not print output other than the output explicitly required by the current problem. P1's `main/0` is the only requested printing entry point; P2 must not print.
- The only allowed libraries for both P1 and P2 are `lists`, `apply`, `yall`, and `aggregate`. Do not import other libraries.
- Do not use `assert`, `retract`, or global variables. In P1 this explicitly includes `b_setval` and `nb_setval`.

## Coding conventions

- Use descriptive, lower-case snake_case predicate names. Use capitalized, meaningful variable names; replace unused variables with `_` or `_Name`.
- Put a short `%` comment above a non-obvious predicate stating its declarative meaning and expected argument roles. Explain *why* when a choice is not obvious; do not narrate syntax.
- Keep search state in arguments and let backtracking enumerate alternatives. Prefer relational, pure predicates over mutation, I/O, dynamic predicates, or hidden state.
- Make boundary behaviour deliberate: invalid or unsatisfiable inputs must fail where the PDF requires failure, rather than loop or raise an error.
- Keep all predicates available to the grader after loading; do not hide work in top-level queries.

## P1-specific guidance

- A solution is a four-element list of `p(Name, Dept, Lang, Project)` terms in the fixed order Alex, Ben, Carla, Dana. Preserve the PDF's required quoted atoms exactly.
- Encode each numbered clue as its own `clue(N, Solution)` clause or clauses. Each must succeed exactly when its named clue holds on a fully filled solution.
- Enforce that every department, language, and project value is used exactly once. Do not hard-code the final answer.
- `count_solutions(Active, N)` must apply exactly the requested clue numbers and ignore the others. Use `findall/3` or `aggregate_all/3` as required.
- For clue 9, put its English sentence directly above the implementation as a comment beginning `% CLUE 9:`. It must not name a friend and must reduce the active clues 1--9 to exactly one solution.

## P2-specific guidance

- Preserve every input number exactly once and in its original order; insert exactly one equality between non-empty left and right expression segments.
- Generate expression trees rather than relying on Prolog's surface parsing. A division step is valid only with a non-zero divisor and an exact integer result.
- Keep arithmetic evaluation separate from canonical rendering. Never build a string and parse it back into a term to evaluate it.
- Return an SWI-Prolog string, not an atom or code list, with no spaces. The printer must follow the PDF's precedence, associativity, and left/right-parenthesis rules so distinct trees remain distinct strings.
- `all_equations/2` must return duplicate-free results sorted with `sort/2`; `count_equations/2` is their length. Lists of length zero or one, and unsatisfiable inputs, must fail or return `[]` exactly as specified.

## Testing and review

- Put tests in a dedicated P1 or P2 test file only when that separate unit is requested. Include the PDF examples and focused boundary cases.
- Before reporting completion, run the applicable SWI-Prolog command when possible. State the exact command and observed result; if a test was not run, say so.
- Check that a load-only command produces no output and that only P1 `main/0` prints the required four lines.

### Self-review checklist

- Does the unit implement only the requested predicate, test file, or review?
- Is the group-ID filename correct, with no invented group ID?
- Are libraries limited to `lists`, `apply`, `yall`, and `aggregate`?
- Are initialization directives, `halt/0`, mutation, globals, and unrequested output absent?
- For P1, are clue numbers separate, all-different attributes enforced, and the answer derived rather than hard-coded?
- For P2, are input order, exact division, one equality, no duplicates, `sort/2`, and canonical parentheses preserved?
- Were all test claims actually run and reported honestly?

### Common AI failure modes

- Accidentally using non-permitted conveniences or dynamic state, especially `assert`/`retract`, global variables, or extra libraries.
- Treating `=/2` as arithmetic equality instead of evaluating both expression values before comparing them.
- Accepting fractional division, division by zero, reordered operands, or multiple equalities in P2.
- Collapsing different P2 expression trees to the same rendered string by omitting necessary right-side parentheses.
- Applying every P1 clue in `count_solutions/2` regardless of `Active`, or encoding a clue too loosely.
- Hard-coding a P1 solution, printing during file loading, or adding a directive that prevents the grader from controlling execution.
