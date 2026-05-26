# LLM Wiki — 정책학 (Policy Studies)

A personal knowledge base of policy studies papers, following [Karpathy's LLM Wiki pattern](https://gist.github.com/karpathy/1dd0294ef9567971c1e4348a90d69285):

```
Original PDF → sources/*.md (LLM summary) → wiki/{category}/*.md (final page)
```

**Language policy**: All wiki content is in English. Conversation can be in any language (including Korean).

---

## THE FOUR RULES (do not violate)

1. **No web search.** Never use `WebSearch` or `WebFetch` to fill gaps. Every answer must be grounded in papers we actually have.
2. **Answer from the wiki first.** Use `sources/` and `wiki/` as the only sources of truth.
3. **If the wiki is insufficient, re-read the PDF.** Go to `papers/{stem}.pdf` and extract more detail with `pypdf`. Then update the wiki.
4. **If the wiki has no paper on the topic, say so.** Tell the user *"I don't have a paper on this — please give me the PDF."* Do not improvise.

These rules apply to **every** response, including overview pages: cite only papers that exist in the wiki.

---

## Repository Structure

```
llm-wiki/
├── CLAUDE.md                        # This file
├── index.md                         # Page catalog
├── papers/                          # Original PDFs (cp, never symlink)
│   └── {author}-{year}-{title-5-words}.pdf
├── sources/                         # PDF summaries (English)
│   └── {author}-{year}-{title-5-words}.md
└── wiki/                            # Wiki pages (English)
    ├── policy-feedback/             # 정책피드백 이론
    ├── policy-process/              # 정책과정론
    ├── policy-analysis/             # 정책분석
    ├── law-of-war/                  # 전쟁법
    ├── military-personnel-policy/   # 군인사정책
    └── overviews/                   # Synthesis pages
```

## File Naming Convention

All three tiers (PDF, source, wiki) share the same stem:

```
{first-author-lastname}-{year}-{first-5-title-words}.{ext}
```

- Lowercase, special chars stripped, spaces → `-`
- Year is 4 digits
- Korean author names: romanize (e.g. `kim-2023-...`)
- Government/institutional reports: use org name (e.g. `ministry-of-defense-2022-...`)

Example: `pierson-1993-when-effect-becomes-cause.pdf`

## Categories

| Category (folder) | Korean | Includes |
|---|---|---|
| `policy-feedback` | 정책피드백 이론 | Policy feedback mechanisms, path dependence, lock-in effects, resource/incentive effects |
| `policy-process` | 정책과정론 | Agenda setting, policy formulation, implementation, evaluation, multiple streams, ACF, punctuated equilibrium |
| `policy-analysis` | 정책분석 | Analytical frameworks, cost-benefit analysis, regulatory impact, evidence-based policy |
| `law-of-war` | 전쟁법 | IHL, Geneva Conventions, LOAC, ROE, war crimes, proportionality |
| `military-personnel-policy` | 군인사정책 | Military HR, promotion systems, conscription, veteran policy, officer career management |
| `overviews` | 종합 정리 | Synthesis pages spanning multiple papers |

**Classification rule**: Classify by **theoretical framework or method**, not by topic. A paper on military promotion policy using feedback theory → `policy-feedback`, not `military-personnel-policy`.

---

## Adding a New Paper

### Step 1 — Copy PDF to `papers/` and extract text

```bash
pip3 install pypdf

python3 -c "
import pypdf, sys
reader = pypdf.PdfReader(sys.argv[1])
text = ''
for page in reader.pages[:15]:
    t = page.extract_text()
    if t: text += t + '\n'
    if len(text) > 12000: break
print(text[:12000])
" "/path/to/paper.pdf"
```

### Step 2 — Write `sources/{stem}.md`

```yaml
---
title: "Paper Title"
authors: Author List
year: YYYY
doi: DOI or URL
category: policy-feedback
pdf_path: C:/Users/USER/Desktop/llm-wiki/papers/{stem}.pdf
pdf_filename: {stem}.pdf
source_collection: external
---

## One-line Summary
## 1. Document Information
## 2. Key Contributions
## 3. Theoretical Framework / Methodology
## 4. Key Arguments and Findings
## 5. Limitations and Future Work
## 6. Related Work
## 7. Glossary
```

### Step 3 — Write `wiki/{category}/{stem}.md`

```yaml
---
title: "Paper Title"
authors: Author list
year: YYYY
doi: DOI or URL
source: {stem}.md
category: policy-feedback
pdf_path: C:/Users/USER/Desktop/llm-wiki/papers/{stem}.pdf
pdf_filename: {stem}.pdf
source_collection: external
tags: []
---

## Summary
## Key Contributions
## Theoretical Framework / Methodology
## Key Arguments and Findings
## Related Papers
- [[category/page]] — relationship
```

### Step 4 — Update `index.md`

Add a one-line entry under the right category.

---

## PDF Management Rules

- **Always copy, never symlink.** `cp` from external locations into `papers/`.
- `pdf_path` always uses the full path inside `papers/`. Never use `~/Downloads/` or external paths.
- `pdf_filename` must match `basename(pdf_path)`.

## Knowledge Compounding

The most valuable pages are `wiki/overviews/` — synthesis pages that connect multiple papers. When a question is answered well:

> "Save this as an overview page in `wiki/overviews/`"

Each conversation should produce 5–15 new or updated wiki pages.

## Browsing with Obsidian

Install [Obsidian](https://obsidian.md/) (free) and open `C:\Users\USER\Desktop\llm-wiki` as a Vault. You get graph view, `[[wikilinks]]` navigation, and full-text search. Obsidian only reads files — it does not interfere with the agent.

---

## Design Principles

- **3-tier**: Raw PDF (immutable) → sources/*.md → wiki/**/*.md
- **English only** in wiki content (RAG-friendly; conversation in Korean is fine)
- **Obsidian compatible**: `[[wikilinks]]`, plain markdown
- **Consistent YAML**: every file has title, authors, year, doi, category, pdf_path, pdf_filename, source_collection
- **No web search**: rule #1 above

When in doubt, follow rule #1.
