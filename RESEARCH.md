# RESEARCH — Narrative Path & Parser Selection

## Motivation
Two phases of collaboration need different tooling:
1. **Exploration** — parallel, personal, possibly contradictory working notes.
2. **Convergence** — a shared, curated artifact (SPEC/PLAN/RESEARCH/WORKLOG).

Most tools optimize for convergence; we explicitly support exploration and provide a **transparent bridge** to convergence via parsing.

## Related Ideas / Systems
- **Federated Wiki**: fork‑first, parallel narratives; ideal for exploration.
- **Glamorous Toolkit (GT)**: moldable dev environment; examples, views, inspectors.
- **Topic Maps (DMX)**: associative models for exploratory structure.
- **Markdown Splitters**: prior art on section extraction; usually lack provenance/traceability.
- **Context‑aware selection**: registry + scoring to explain *why this parser* won.

## Design Rationale
- Keep extraction **non‑destructive** and **explainable** (audit trail).
- Prefer a **simple heading protocol** first; expand heuristics later.
- Use **GtInputContext** to isolate project‑level assumptions (available parsers, priorities, output dirs).

## Open Questions
- How tolerant should heading matching be (case/locale/aliases)?
- What minimal provenance is sufficient (source path, commit hash, sitemap URL)?
- How to surface diffs between exploratory source and converged SPEC set?

## Notes to Self
- Add examples that take a small real exploratory note (chat/WORKLOG snippet) and show end‑to‑end split.
- Consider embedding a YAML front‑matter block with provenance into outputs (optional).

## Alternatives & Trade-offs
- Alternative: global plugin registry vs per-context registry. We pick per-context
  to avoid cross-project leakage; keep a Default for quick demos.
- Alternative: full Markdown AST parse to avoid code/quote false positives.
  We start with light heuristics for speed; AST can come later if needed.
- Trade-off: strict heading names increase precision but reduce recall.
  We document exact matching and plan alias heuristics later.

*Compiled 2025-10-29. Iterate as understanding evolves.*
