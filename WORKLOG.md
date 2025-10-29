# WORKLOG — GtSpecSet‑Parser

## 2025-10-29
- Initialize project documents (SPEC, IMPLEMENTATION_PLAN, RESEARCH, WORKLOG).
- Captured goals: non‑destructive Markdown split into four files; transparent parser selection.
- Planned immediate next step: implement `splitFromString:into:` + `<gtExample>`; verify files appear in memory FS.
- Review: hardened selection design; identified risks (code-fence false positives,
  singleton drift, tie instability, non-text handling).
- Plan: add Baseline + README repo URL; suppress code/quote matches; add tie
  tiebreak; negative tests; deterministic Why-view with zero parsers.
- Next: implement Phase 0.5 & Phase 1 bullets; run clean-image demo end-to-end.

## Open Issues
- Decide minimum viable heuristics for section detection beyond exact headings.
- Baseline packaging for `GtSpecSet-Parser` (+ `GtSpecSet-Model` when ready).
- Add *Why & matches* view and tests ensuring deterministic ordering.

---
(Entries are reverse‑chronological; add new entries at the top.)
