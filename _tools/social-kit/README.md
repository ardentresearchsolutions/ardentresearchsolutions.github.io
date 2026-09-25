# ARS social media kit

Everything needed to produce a week of ARS social posts from arspakistan.pk publications.

## Accounts and tools
- **Facebook + Instagram:** Metricool, brand "Ardent Research Solutions", blogId `7075711`, timezone Asia/Karachi. One post per network per day at 18:00 PKT. Facebook and Instagram are scheduled as separate posts (different captions), each with the day's image.
- **X (@ARSInsights):** Typefully, social_set_id `335484`. Free plan = 10 posts per calendar month, so X posts **every third day** (anchor 2026-10-01, then 10-04, 10-07 … continuing every 3 days across month ends), at 18:00 PKT. Check `publishing_quota` before scheduling and never exceed it. Images cannot be uploaded to Typefully from the cloud workspace (S3 is blocked), so X posts go out text + publication link; every publication page has a `summary_large_image` card.
- **Images:** Metricool needs a public URL. Images go in the site repo's `social/` folder as `YYYY-MM-DD-slug.jpg`; Reza pushes with GitHub Desktop; the URL is then `https://arspakistan.pk/social/<file>`.
- **Planner page:** https://claude.ai/artifact/8BgY4TqjUXMXSAXnW4FhZD — republish each week's planner to this same URL.

## Brand (from the site and publication covers)
- Deep navy radial background (`#123e6e` → `#092b52` → `#061a33`), white text, cyan accent bar `#22b4e6`, light-blue labels `#8bc7ff`.
- Serif display: Source Serif 4. Sans body/labels: Source Sans 3 (letter-spaced uppercase labels). Fonts are in `fonts/`.
- Every image: ARS wordmark top-left ("ARS | ARDENT RESEARCH SOLUTIONS"), category label top-right (ARS DATA BRIEF / ARS INSIGHT / ARS POLICY BRIEF / ARS RESEARCH REPORT / ARS SPECIAL REPORT), footer with source + publication code on the left and **arspakistan.pk** on the right.
- 1080 × 1350 portrait JPEG. Render with `python3 render.py OUT_DIR templates/*.html`.
- No photos of Reza. No emojis.

## Post formats (rotate them across the week)
`templates/` holds one worked example of each; copy and edit.
1. **Stat card** — one headline number, a serif sentence explaining it, one supporting line (`stat-card-*.html`).
2. **Bar / column / range chart** — 3–5 values from one finding, drawn to scale (`chart-*.html`).
3. **Quote card** — one sentence quoted exactly from an ARS publication (`quote-card-*.html`). Quote only ARS's own text.
4. **Publication promo** — headline finding, three key numbers, the publication cover (`promo-cover-*.html`, covers are in `assets/publications/`).

## Words
- Voice: formal, analytical, plain. Figures exactly as in the publication's Key findings; never round differently or add numbers not in the publication. Credit external authors by name (e.g. Muneeb Maayr).
- **X:** under 280 characters counting the link as 23; the finding, one line of framing, then the canonical publication URL.
- **Facebook:** 2–4 sentences plus the full publication URL.
- **Instagram:** a one-line hook, 2–3 short paragraphs, "link in bio", then 4–6 hashtags ending with #ARSDataBrief / #ARSInsight / #ARSPolicyBrief / #ARSResearchReport.
- British spelling in captions, except names and quoted text.

## Choosing content
- Read `post-log.json` first; do not reuse a finding already posted. New publications on arspakistan.pk (check sitemap.xml and the section index pages) go first.
- Take facts only from a publication page's Key findings / summary. Canonical URLs are in each page's `<link rel="canonical">`.
- After a week is scheduled, append each post to `post-log.json` and update `last_x_post`.
