# Discovery Architect · Agent Context

> Canonical project brief. Read this at the start of every session.
> Applies to **all** agentic coding tools used on this repo: Claude Code,
> Codex CLI, and any other tool that follows the AGENTS.md convention.

---

## What this is

A deep-discovery branch-logic training tool for Vision Packaging sales reps.
The Ten Questions are the doorway to a sales conversation. This tool is what
happens after them: every follow-up question worth asking, every related-
question chain, every universal Custom Item gate that blocks the Order Form,
and the cross-references between questions that loop back.

It is a **training tool, not a field tool.** Used in training sessions, in
the car before a meeting, in a 1:1 with a junior rep. Not designed for live
use in front of a customer.

## What it is not

- Not a customer-facing tool
- Not a CRM, not an RFQ form, not an order entry system
- Not connected to QuickBooks, the Vision RFQ form, or any production system
- Not a printable handout (the print button was deliberately removed)
- Not a replacement for `vsn-10Qs` (see "Sister project" below)

## Owner and communication style

Will Zrnchik (sactowilly). Sales Manager at Vision Packaging.

Apply these in every response on this project, regardless of which agent you are:

- Direct, no-nonsense. Jump to content. No fluff intros, no sign-offs.
- **No em-dashes.** Use period, comma, colon, parentheses, or rewrite the sentence.
- Use **1-3-1 framing** when solving problems: define the exact problem, give exactly three options, recommend one.
- Challenge assumptions. Do not agree by default.
- State upfront anything Will must do himself. Flag handoffs and guardrails immediately.
- Concise but complete. Skip safety disclaimers unless the risk is non-obvious.
- Refer to **ChatGPT as "Cliff."** Refer to Anthropic's chat product as Claude.
- When the keyword **"potato"** prefixes an idea or argument: switch to Hostile Critic mode. Identify three specific failure points, two unproven assumptions, and one unaddressed counter-argument. Be precise, not polite.

## Dual-agent workflow

This repo is worked by both **Claude Code** and **Codex CLI**. To stay
coordinated and avoid stepping on each other:

### Before starting work

1. Run `git pull` to make sure you have the latest commits.
2. Run `git log --oneline -10` to see what the other agent has done since
   the last context load. Their commits are your context.
3. Read the **Unreleased** section of `CHANGELOG.md` as the shared todo list.
   Pick from the top.

### While working

4. Commit small, frequent, descriptive. Other agents read your commit
   messages as context. "fix stuff" wastes the next agent's time.
5. Prefix your commit messages so the originating agent is obvious in the log:
   - Claude Code commits: `[claude] short description`
   - Codex CLI commits: `[codex] short description`
   - Manual edits by Will: no prefix
6. If you are mid-task and need to step away, push your work-in-progress
   commit with `[wip]` in the message so the other agent knows not to
   touch the same file yet.

### Default role bias (not a rule, just a tendency)

- **Claude Code:** building, extending, adding new branches and features
- **Codex CLI:** auditing, finding bugs, asking critical questions, refactoring

This is the default for ambiguous tasks. If Will tells either agent to do
something outside its default bias, do it.

### Before committing

7. Run both verify commands in the "How to verify changes" section below.
8. Em-dash count must be zero. JS syntax must pass. Branch count should be
   at or above the previous release.
9. Bump the version stamp in two places when shipping a release: the
   `<footer>` line in `index.html` and `CHANGELOG.md` (move Unreleased
   content under the new version heading).

## Sister project

`vsn-10Qs` teaches **why** the foundational ten questions exist.

This project teaches **what to do after** you have asked them.

They are complementary. Do not merge them. Keep this repo focused on the
deep branch logic, not on the foundational question pedagogy.

## Architecture

The entire tool is **one single self-contained HTML file**, `index.html`.

- No build step. No npm install. No bundler.
- All CSS lives in a `<style>` block in the `<head>`.
- All JS lives in a `<script>` block at the bottom of the `<body>`.
- All content lives in a `const DATA` array inside the script block.
- External dependencies: only Google Fonts (Saira Condensed, IBM Plex Sans, IBM Plex Mono) via CDN link in `<head>`.

This is intentional. The file can be opened in any browser, hosted on
GitHub Pages, dropped on a thumb drive, or emailed as an attachment, with
no setup. Do not introduce build tooling without explicit approval from Will.

## Data model

The full schema lives in a comment block directly above the `const DATA`
array in `index.html`. That comment is the canonical reference. Read it
before adding or modifying any branch.

Quick reference (recursive node):

```js
{
  q:        "the question text",                          // required
  hint:     "rep-side coaching note",                     // optional, muted italic
  fk:       ["DESCRIPTION","QTY","PRICE"],                // RFQ fields filled, optional
  type:     "section|gate|rule|required|loop|note",       // visual variant, optional
  id:       "target-stretch",                             // xref target id, optional
  xref:     [{label:"Q2 Stretch", target:"target-stretch"}], // jump chips, optional
  children: [ ...nested nodes, same shape ]               // optional
}
```

Top-level question shape:

```js
{ n, title, job, jobLabel, why, fills, branches: [...] }
```

`job` is one of `"qualify" | "matrix" | "next"`. It controls the badge
color and which masthead cell filter the question belongs to.

## The Universal Gate

**The single most important rule in the data model.** Anything made
specifically for a customer (printed, fabricated, custom-sized, custom-spec)
requires both the Custom Item Checklist and a Signed Custom Item Agreement
on file before the Order Form is touched.

Wherever this rule applies in a branch, encode it with three node types in
sequence:

1. `type:"rule"` stating the category-specific phrasing of the rule
2. `type:"gate"` warning that the gate applies before the Order Form
3. One or more `type:"required"` children inside the gate, listing the
   specific paperwork items

See the corrugated, tape, foam, and chip board branches for examples to follow.

## Vocabulary

Two phrases are drilled into reps by Carlos and appear in the masthead
mantra. Use them when writing UI copy and any rep-facing content:

- **"Deep, meaningful insights."**
- **"Meaningful business conversations."**

Reframe content to align with these when in doubt. Avoid consulting-speak.

## Pending work

See `CHANGELOG.md` "Unreleased" section for the current priority list.

## Future modules (separate projects, not this repo)

- **Live SKU-capture matrix.** A companion tool that digitizes the paper form
  Will currently uses. Rows are SKUs, columns are the looping questions
  (Q2/Q7/Q3/Q8/Q4/Q9/Q6). Each row links into the relevant branch in this tool.
  Exports to a populated RFQ. **This is its own project, not part of this one.**
- **RFQ auto-populator.** Takes the SKU matrix output and prepares an email-
  ready RFQ. Also a separate project.

## How to verify changes

This project has no test framework. Two snippets to run before every commit.

### Snippet 1: syntax and em-dash check

```bash
node -e "
const fs=require('fs');
const html=fs.readFileSync('index.html','utf8');
const m=html.match(/<script>([\s\S]*?)<\/script>\s*<\/body>/);
try{ new Function(m[1]); console.log('JS syntax: OK'); }
catch(e){ console.log('SYNTAX ERROR:', e.message); process.exit(1); }
console.log('em-dashes remaining:', (html.match(/—/g)||[]).length);
console.log('file size:', html.length, 'chars');
"
```

Pass criteria: `JS syntax: OK` and `em-dashes remaining: 0`.

### Snippet 2: branch and gate inventory

```bash
node -e "
const fs=require('fs');
const html=fs.readFileSync('index.html','utf8');
const start=html.indexOf('const DATA = [');
const end=html.indexOf('/* =====',start+200);
const DATA=new Function(html.slice(start,end)+'\nreturn DATA;')();
function count(ns){let c=0;ns.forEach(n=>{c++;if(n.children)c+=count(n.children);});return c;}
function findType(nodes,t){let r=0;nodes.forEach(n=>{if(n.type===t)r++;if(n.children)r+=findType(n.children,t);});return r;}
const total=DATA.reduce((a,q)=>a+count(q.branches),0);
console.log('branches:', total);
console.log('gates:', DATA.reduce((a,q)=>a+findType(q.branches,'gate'),0));
console.log('required:', DATA.reduce((a,q)=>a+findType(q.branches,'required'),0));
DATA.forEach(q=>console.log(' Q'+q.n+' branches:', count(q.branches)));
"
```

Pass criteria: branch count is greater than or equal to the previous release.
v0.4 baseline: 300 branches, 9 gates, 25 required items.

## Versioning

Semantic-ish: `vMAJOR.MINOR`. Snapshot to GitHub at meaningful milestones,
not on every micro-edit. Bump the version stamp in two places per release:

1. The `<footer>` line in `index.html` (currently `v0.4 · build YYYY-MM-DD · training mode`)
2. `CHANGELOG.md` (move "Unreleased" content under the new version heading)

## File structure

```
.
├── index.html         The whole tool. All CSS, JS, and DATA inside.
├── README.md          User-facing overview
├── CHANGELOG.md       Version history with Unreleased todo list
├── AGENTS.md          This file. Canonical agent context.
├── CLAUDE.md          Pointer to AGENTS.md (so Claude Code's default lookup finds it).
├── LICENSE            Proprietary, internal use only
└── .gitignore         OS junk and editor caches
```

## Distribution

The tool is served via GitHub Pages at
https://sactowilly.github.io/vsn-discovery-architect/

Any push to `main` triggers a Pages rebuild. Cache window is typically 30 to
60 seconds before the new content is live. When sharing with reps, send the
github.io URL, not the github.com source URL.
