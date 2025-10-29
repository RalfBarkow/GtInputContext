# SPEC — GtSpecSet‑Parser (Narrative Path Splitter)

## Problem
Exploratory notes (messy, multi‑voice Markdown) need to be **split** into four curated project documents:

- `SPEC.md` — what we intend to build
- `IMPLEMENTATION_PLAN.md` — how we plan to build it
- `RESEARCH.md` — context, sources, rationale
- `WORKLOG.md` — chronological project diary

We want a **repeatable, inspectable, non‑destructive** mechanism inside Glamorous Toolkit (GT) to convert an input Markdown (or String) into this 4‑file set.

## Goals
- Detect narrative sections in Markdown and **extract** them into separate files.
- Support **String and FileReference** inputs.
- Be **transparent**: explain why a given parser matched and was selected.
- Be **non‑destructive**: never mutate the source; always write to a target directory.
- Work natively in **Smalltalk/GT** with zero external dependencies.
- Provide GT **inspector views** for “Why this parser?”, “Preview output”, and “Write files now”.

## Non‑Goals (initial)
- Full Markdown AST fidelity or round‑trip editing.
- Multi‑language heading detection beyond simple markers.
- Reconciliation/merge of divergent sources (that is a future step).

## Key Concepts
- **GtInputFile**: wrapper around a `FileReference` (or memory file) with convenience accessors.
- **GtInputContext**: environment + parser registry deciding **which parser** applies and **why**.
- **GtSpecSetMarkdownParserAdapter**: concrete parser that splits Markdown into the four files.
- **Match Score**: `{ canHandle, priority, confidence, why }` used by the context to rank parsers.

## Functional Requirements
1. **Matching**
   - Recognize headings (case-sensitive initial version): `# SPEC`, `# IMPLEMENTATION_PLAN`, `# RESEARCH`, `# WORKLOG`.
   - `matchScoreFor:inContext:` returns a dictionary used for selection.
   - The selector MUST ignore narrative markers that appear within:
     - fenced code blocks (``` … ```),
     - indented code blocks,
     - blockquotes (lines starting with '> ').
   - If multiple parsers have identical {priority, confidence}, the winner is the 
     lexicographically smallest class name to ensure deterministic selection.
   - If no parser matches, the system MUST return a clear, human-readable explanation
    and the GT view MUST render without error.
2. **Parsing**
   - `parse:` accepts a `FileReference` (or memory file) containing Markdown.
   - `splitFromString:into:` accepts a `String` and a target directory, writes 4 files.
   - If a section is missing in the input, create an empty file with an explanatory stub.
3. **Writing**
   - Write `SPEC.md`, `IMPLEMENTATION_PLAN.md`, `RESEARCH.md`, `WORKLOG.md` to the **target directory** only.
   - Include a **provenance header** (timestamp, source path/label).
4. **Explainability**
   - `selectionExplanation` returns a human-readable report listing all candidate parsers, scores, and the winner.
   - GT view `FileReference>>gtInputWhyViewOn:` shows that explanation.
5. **Packaging**
   - Baseline includes packages: `GtSpecSet-Parser` (+ `GtSpecSet-Model` when introduced).
   - Examples are runnable via `<gtExample>` methods; red→green tests accompany key behavior.

## Constraints
- Pure Smalltalk (Pharo/GT), built on `FileSystem`, GT inspector APIs.
- No network I/O in the core parser.
- Output path must be user-selectable; default is sibling `specset/` or a given directory.

## Acceptance Criteria (Initial)
- Given a Markdown with at least one of the four headings, calling `splitFromString:into:` produces the four files.
- The output files contain the corresponding extracted sections; missing sections contain a stub with a TODO.
- The **Why** view shows that `GtSpecSetMarkdownParserAdapter` matched and why.
- A minimal example runs green in GT and shows the generated files in a memory filesystem.
- Baseline loads without errors; packages appear in Iceberg.

## Example (Do‑It style)
```smalltalk
"Split from a String into a directory"
GtSpecSetMarkdownParserAdapter
    splitFromString: '# SPEC\nGoal\n# IMPLEMENTATION_PLAN\nFirst steps'
    into: (FileSystem workingDirectory / 'specset')
```
(Use real newlines `\n` or a multi-line Smalltalk string.)

## Future Work (Out of initial scope)
- Heuristics for alternative headings (e.g., 'PLAN', 'RESEARCH NOTES').
- Multi-source intake (Lepiter note, FedWiki snapshot, DMX export) via additional parsers.
- Round‑trip editing and provenance links back to exploration artifacts.

*Provenance: generated 2025-10-29.*
