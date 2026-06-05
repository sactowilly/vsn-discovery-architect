# Vision Discovery Architect

> Beyond the Ten Questions. A deep-discovery branch-logic tool for sales training.

**Status:** v0.4 preview · training-only · not for live customer use

---

## What this is

The Ten Questions are the doorway to a sales conversation. This tool is what happens after them.

For every opener (Q1 through Q10), this is the full branch logic: every follow-up question worth asking, the related-question chains that come off it, the universal Custom Item gates that block the Order Form, and the cross-references between questions that loop back on themselves.

Built to be used in training sessions, in the car before a meeting, or in a 1:1 with a junior rep. Not designed for live use in front of a customer.

The two phrases drilled into reps by Carlos sit at the top of every view: **"Deep, meaningful insights. Meaningful business conversations."**

## Relationship to vsn-10Qs

`vsn-10Qs` teaches WHY the foundational ten questions exist.

This project teaches WHAT to do after you have asked them.

They are complementary. A rep working through `vsn-10Qs` learns to open the door. A rep working through this tool learns to walk through it.

## How to use

Open `index.html` in any modern browser. Single file, no build, no dependencies.

| Action | What it does |
|---|---|
| Click any of the four masthead cells | Filter the tree to a single job (or read the universal Custom Gate rule on the right) |
| Click any question card | Expand its branches |
| Click "Essentials only" in the toolbar | Show only the training subset (structural nodes plus any branch that fills an RFQ field) |
| Use the search box | Find any branch by keyword |
| Arrows next to the search box, or Enter / Shift+Enter | Cycle through search matches |
| Watch the sticky breadcrumb | It tracks where you are; click any segment to jump back to that level |
| Click any orange jump chip on a branch | Cross-reference jump to a related branch in another question |

## Tour for first-time users

1. Click the second masthead cell, "Job 2 // The Buy Matrix." Everything else hides. Q2 expands.
2. Open Q2, click "CORRUGATED," then "BOXES," then "Stock, custom, or both?"
3. Watch the breadcrumb build the trail.
4. Inside CUSTOM BOXES, find the red gate: **Custom Item Checklist + Signed Custom Item Agreement.** That is the universal rule, restated at the point of contact.
5. Back in the toolbar, toggle "Essentials only." The deep coaching detail collapses, you see the structural spine.

## Architecture

The whole tool is a single HTML file. Inside the `<script>` block at the bottom, the entire branch tree lives in a `const DATA` array. Every node is the same shape:

```js
{
  q:        "the question text",
  hint:     "rep-side coaching note",            // optional
  fk:       ["DESCRIPTION","QTY","PRICE"],       // RFQ fields this fills, optional
  type:     "section|gate|rule|required|loop",   // visual variant, optional
  id:       "target-stretch",                    // jump target id, optional
  xref:     [{label:"Q2 Stretch", target:"target-stretch"}],  // jump chips, optional
  children: [ ...nested nodes, same shape ]
}
```

The full schema is documented in a comment block directly above the DATA array in `index.html`. That comment is the canonical reference for adding new branches.

## Roadmap

| Version | Goal |
|---|---|
| **v0.5** | Hand-tuned essentials curation (replace algorithmic essential-flag with explicit `e:1` markers per branch) |
| **v0.6** | Deepen Q6 (shipping) and the strapping branch to parity with corrugated, tape, and foam |
| **v0.7** | Audit pass by ChatGPT (Cliff), revisions applied |
| **v0.8** | Separate companion project: live SKU-capture matrix bridging this tool to the RFQ form |
| **v1.0** | Approved for full sales-team rollout |

## File structure

```
.
├── index.html         The whole tool, one file
├── README.md          This file
├── CHANGELOG.md       Version history
├── LICENSE            Proprietary, internal use
├── .gitignore         
└── docs/              (planned) audit notes from Cliff and screenshots
```

## License

Proprietary. © 2026 Vision Packaging. Internal use only.
