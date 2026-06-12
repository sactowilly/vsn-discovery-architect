# Q2 Audit and Extension Framework

Status: v0.5 working standard  
Scope: Q2, "What do you buy?"  
Purpose: make Q2 reliable before using it as the pattern for the rest of the Discovery Architect.

## Audit Standard

Every Q2 branch must earn its place by passing at least one of these tests:

1. It helps the rep ask a better next question.
2. It fills an RFQ or Order Form field.
3. It creates a qualification decision: pursue, quote lightly, slow down, sample, measure, or disqualify.
4. It protects Vision with a required gate before a custom, printed, fabricated, or custom-sized item reaches the Order Form.

Branches should be removed or rewritten when they are only clever, motivational, speculative, or too broad to help a rep know what to ask next.

## Extension Question Rubric

Use this sequence before adding any deeper branch to a product category:

| Layer | Question to answer | Useful output |
|---|---|---|
| Identify/spec | What exactly is it? | DESCRIPTION, UNIT, item family |
| Use case | What does it touch, protect, seal, carry, display, clean, or ship? | Application context |
| Current state | What are they using now? | Existing product, source, baseline |
| Failure/pain | What breaks, delays, costs money, wastes labor, or creates complaints? | Reason to change |
| Quantity/frequency loop | How much and how often? | QTY, UNIT, LEAD TIME, run rate |
| Vendor/price loop | From whom and at what economics? | VENDOR, PRICE, COST, GTM clue |
| Custom gate | Is it printed, fabricated, custom-sized, custom-color, custom-cut, or custom-spec? | Custom Item Checklist and Signed Agreement |
| Next action | What should the rep do now? | Quote, sample, measure, photo, invoice, slow down, or disqualify |

Do not add an extension question unless the answer changes the quote, the risk, the next step, or the rep's understanding of the account.

## Q2 Category Audit

| Category | Keep | Tighten next | Do not add yet |
|---|---|---|---|
| Corrugated boxes | Custom-first discipline, printed = custom rule, Q7/Q3 loops, stock run-rate qualifier | Add "get a sample/photo/drawing" as a standard custom-box evidence step if Vision wants it formalized | More board-grade theory unless tied to quoting or redesign |
| Corrugated sheets | Single-face/single-wall/double-wall and in-house fabrication question | Add dimensions and sheet size if the RFQ needs it | Converter-process branches unrelated to Vision supply |
| Stretch film | Hand vs machine, gauge, pre-stretch, cost-per-load framing, custom-color/printed gate | Deepen machine specifics later with Q6 shipping parity work | Unsupported claims about exact savings percentages |
| Tape | Adhesive type, width, mil, hand vs machine, stock/custom split, printed-tape gate | Replace brand/model examples with "make/model" if they imply support Vision does not provide | Extra specialty tape categories without a clear application |
| Void fill and dunnage | Material type and damage-rate driver | Needs more practical branching in a later pass: current pack station, speed, damage, disposal, storage | A long material catalog with no quote action |
| Foam | Stock vs fabricated split, material type, density, thickness, ESD, CAD/sample/tooling requirements | Confirm terms like waterjet and heat-formed match Vision's actual vendor capabilities before expanding | Fabrication methods Vision cannot source or explain |
| Bubble | Bubble type/size, perforation, roll/bag/pouch, custom-size gate | Add current damage and packing-speed questions | Niche bubble materials unless customer use case demands it |
| Edge/corner protection | Type and custom-cut gate | Add load geometry and strap/stretch interaction if tied to Q6 | Detailed engineering branches without product ownership |
| Strapping/banding | Material and tools | Roadmap item: deepen to parity with tape and foam | Equipment recommendations without verifying application and break strength |
| Pallets | Material, construction, GMA/custom, export, load rating, monthly volume | Tie more strongly to Q6: dock equipment, stack height, transit distance | Unsupported international compliance detail beyond ISPM-15 prompt |
| Chip board | Application, caliper, standard/custom-cut gate, monthly sheet use | Add size and finish only when needed for quote | Paperboard taxonomy that does not change the order |
| Janitorial | Liners, paper goods, chemicals, dispensers, soap, tools, gloves/wipes | Keep as procurement wedge, but avoid over-training reps outside Vision's real jan-san catalog | Claims about chemical compliance unless confirmed by label/SDS |
| Safety gear | PPE families, size distribution, hi-vis custom gate | Keep regulated-product language cautious and ask-based | Definitive OSHA/legal guidance or product certification claims beyond customer-provided requirements |

## Reviewed Change List

### Keep

- The 10-category Q2 spine: corrugated, stretch, tape, void fill/dunnage, protective, strapping/banding, pallets, chip board, janitorial, safety.
- The "custom = blocked" gate pattern anywhere the item is printed, fabricated, custom-sized, custom-cut, custom-color, or custom-spec.
- The loops into Q3, Q4, Q7, Q8, and Q9 when product answers require frequency, quantity, price, vendor, or timing.
- The stock vs custom discipline on boxes, tape, and foam.
- The "run rate or one-off" qualifier because it controls rep investment level.

### Rewrite Later

- Any branch that sounds like a guaranteed savings claim should become an ask-based prompt.
- Any product-specific hint that sounds too certain should be converted into "ask what they use now" or "verify with sample/photo/invoice."
- Any machinery branch should capture make/model and throughput without pretending the rep can diagnose equipment in the field.

### Delete If Found

- Branches that do not change RFQ fields, qualification, risk, or next action.
- Product trivia that teaches vocabulary but does not improve the conversation.
- Safety or chemical statements that sound like compliance advice instead of discovery prompts.
- Competitive claims not grounded in the customer's invoice, quote, delivery experience, or stated pain.

### Add Only When Passing the Rubric

- Evidence prompts: photo, sample, invoice, box label, CAD, artwork, die/tooling ownership, drawing, or spec sheet.
- Failure prompts: damage rate, tape failure, load collapse, freight claims, line stoppage, stockout, labor waste, returns.
- Next-step prompts: quote now, request sample, measure item, slow down for next order cycle, calendar renewal date, or disqualify.

## Essentials Curation Rule

Q2 now uses explicit `e:1` markers for the essentials spine. A branch marked `e:1` appears in Essentials mode, and its ancestors remain visible so the path makes sense.

Questions that do not yet have any `e:1` markers continue to use the legacy fallback: section/gate/rule/required/loop nodes, field-tagged nodes, and top-level branches.

This lets Q2 become the hand-curated standard without breaking the rest of the tool before each question gets its own audit.

## Acceptance Checklist

- Q2 still exposes all ten product groups.
- Every custom, printed, fabricated, custom-size, custom-cut, or custom-color path keeps a visible gate.
- Essentials mode shows Q2's curated spine, not every field-tagged detail.
- No extension question should be added unless it changes quote quality, qualification, risk, or next action.
