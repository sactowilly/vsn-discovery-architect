# Changelog

All notable changes to the Discovery Architect tool.
Format follows [Keep a Changelog](https://keepachangelog.com/).

---

## [Unreleased]

Priority order for the next iteration. Pick from the top.

### Changed
- Reframed the interface as a packaging field manual with an indexed workbench, operational cover, ledger-style question plates, and a clearer notation system for gates, loops, scripts, and RFQ fields
- Added keyboard operation and synchronized expanded states for question and branch controls
- Added responsive question-index navigation with active-section tracking

### Planned
- **Deepen Q6 (shipping).** Currently 20 branches, shallow compared to corrugated (226), tape, and foam. Bring to parity. Cover dunnage and load securement in transit, parcel-vs-LTL-vs-truckload cost dynamics, cube-utilization and DIM-weight optimization, accessorials, and damage-claim history as a discovery wedge.
- **Deepen the strapping branch in Q2.** Currently minimal. Cover poly vs PET vs steel, break strength matching, hand vs battery vs pneumatic tools, seal types, and unitization patterns. Apply the same stock-vs-custom qualifier as the other Q2 categories.
- **Hand-curate the essentials filter.** Replace the algorithmic `markEssentials()` rule in `index.html` with explicit `e:1` flags on hand-picked nodes in the DATA array. Target 6 to 10 essential branches per product category. The algorithm is a v0.4 placeholder, not the final approach.

### Pending audit
- v0.4 will be handed to Cliff (ChatGPT) for audit. When findings come back, apply them as v0.6.

---

## [v0.4.2] — 2026-06-05

### Added
- `AGENTS.md` as canonical agent context file, read by both Claude Code and Codex CLI
- Dual-agent workflow protocol: commit-message prefixing convention (`[claude]` and `[codex]`), pre-flight git pull and log review, shared Unreleased todo list
- Default role bias: Claude Code for building and extending, Codex CLI for auditing and bug-finding
- PowerShell setup script (`setup-vsn-discovery.ps1`) for one-shot Windows install of both tools, repo clone, and initial publish

### Changed
- `CLAUDE.md` reduced to a 12-line pointer at `AGENTS.md` to maintain a single source of truth
- `README.md` updated with "Working on this repo" section and new file structure

---

## [v0.4] — 2026-06-05

### Added
- Four-cell masthead: three clickable job filters (Qualify, Buy Matrix, Next Move) plus the universal Custom Gate rule cell
- Sticky breadcrumb showing the current trail through any branch, with clickable jump-back navigation
- Search rebuilt: results counter, prev/next arrows, Enter and Shift+Enter cycle through matches, current match outlined in amber
- "Essentials only" toggle that algorithmically filters to the structural-plus-RFQ-filling subset (roughly 130 of 300 branches)
- Carlos's drilled phrases stamped in the masthead mantra: "Deep, meaningful insights · Meaningful business conversations"
- Three product categories on Q2 to match the worksheet's footer strip: chip board, janitorial, safety gear
- Five cross-reference jump chips (Q6 → Q2 stretch, Q8 → Q2 buy matrix, Q5 → Q9 renewal, Q1 ↔ Q10 multi-location)
- Schema documentation comment block above DATA, written for downstream LLM-assisted audit
- Version stamp in footer

### Changed
- Em-dash sweep complete: 33 em-dashes replaced contextually (colon for lists, period for new thoughts) plus 9 manual smoothings for choppy reads
- Tape branch deepened: full adhesive / width / application / stock-vs-custom workflow with printed-tape gate
- Foam branch deepened: stock-rolls and custom-fabricated split, full material discrimination (PE, PU, EPS, EPP, crosslinked), die-cut / CNC / convoluted / laminated / heat-formed fabrication tree with gate
- Pallets branch deepened: stringer vs block, GMA vs custom, ISPM-15 export note, capacity rating
- Custom gate pattern applied to: corrugated, tape (carton sealing and printed), foam, bubble, edge protection, pallets, stretch film, chip board, safety hi-vis apparel

### Removed
- Print button (this is a training tool, not a field tool; per stakeholder direction)

---

## [v0.3] — 2026-06-05

### Added
- Cross-reference jump chip system: target IDs on landing nodes, xref chips on source nodes, animated flash on landing
- Custom gate pattern as a visual node type (red border, required-checkbox children)
- Initial branch-logic deep dives on tape, foam, bubble, edge protection
- Custom-fabricated gate pattern beyond just "printed" items

### Changed
- "Printed = Custom only" rule expanded to cover any item made specifically for the customer

---

## [v0.2] — 2026-06-05

### Added
- Q2 corrugated boxes branch restructured to enforce custom-first discipline
- "Both" answer fork now branches to CUSTOM section first, STOCK section second
- Custom Item Checklist and Signed Custom Item Agreement gate nodes block the Order Form path
- Run-rate vs one-off qualifier added under STOCK BOXES to set rep investment level

### Changed
- Stock items reorganized to surface the structural qualifier (run rate vs one-off) above the spec questions

---

## [v0.1] — 2026-06-05

### Added
- Initial 10-question framework with three-job model (Qualify, Buy Matrix, Next Move)
- Field-mapping tags showing which RFQ or Order Form field each branch fills
- Branch tree with expand-collapse interaction per question card and per node
- Initial search filter (binary include / hide per question)
- Print stylesheet for paper handoff
- 105 follow-up branches across the 10 openers
