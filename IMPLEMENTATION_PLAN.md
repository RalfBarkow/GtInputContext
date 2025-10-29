# IMPLEMENTATION_PLAN — GtSpecSet‑Parser

## Phase 0 — Repo Hygiene
- [ ] Baseline includes `GtSpecSet-Parser` (and `GtSpecSet-Model` when introduced).
- [ ] Minimal examples & tests scaffolded and runnable in GT.
- [ ] CI script (optional) to run tests in headless image.

## Phase 1 — Parser Core
- [ ] Implement `GtSpecSetMarkdownParserAdapter class>>matchScoreFor:inContext:` returning `{canHandle, priority, confidence, why}`.
- [ ] Implement `#parse:` to extract sections from a `FileReference`.
- [ ] Implement `#splitFromString:into:` to write the four files to target directory.
- [ ] Handle missing sections by writing stub files with TODO notes.
- [ ] Add `<gtExample>` demonstrating in‑memory split.

## Phase 2 — File Writer & Provenance
- [ ] Add common header (timestamp, source path/label) to each generated file.
- [ ] Ensure **non‑destructive** write semantics; never mutate source.
- [ ] Parameterize output directory; default to `specset/` next to source.

## Phase 3 — Input Context & Selection Transparency
- [ ] Implement `GtInputContext` with a parser registry and selection logic.
- [ ] Implement `GtInputFile` convenience wrapper.
- [ ] `FileReference>>gtInputWhyViewOn:` view showing **Parsers (why & matches)**.
- [ ] `GtInputFile>>selectionExplanation` returning the formatted explanation.

## Phase 4 — GT Views & UX
- [ ] Add a **Preview output** action (dry‑run split; show would‑be files).
- [ ] Add a **Write files now** action.
- [ ] Add a project‑level context inspector view listing available parsers and priorities.

## Phase 5 — Tests (Red → Green)
- [ ] Matching: positive and negative cases for heading detection.
- [ ] Parsing: correct extraction boundaries; missing‑section stubs.
- [ ] Writing: files created with expected names and contents.
- [ ] Explainability: explanation lists candidates and winner deterministically.
- [ ] Baseline loads; examples run green.

## Phase 6 — Integrations (Next)
- [ ] Add additional parsers (FedWiki sitemap, DMX topic map, Lepiter export).
- [ ] Provide a simple CLI/Do‑It entry to run the splitter on a file path.

## Immediate Next Step
- Implement `GtSpecSetMarkdownParserAdapter class>>splitFromString:into:` and one `<gtExample>` that demonstrates generating the 4‑file set into a memory filesystem.

*Plan created 2025-10-29.*
