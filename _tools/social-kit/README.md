# ARS social media kit

Everything needed to produce a week of ARS social posts from arspakistan.pk publications.

## Accounts and tools
- **Facebook + Instagram:** Metricool, brand "Ardent Research Solutions", blogId `7075711`, timezone Asia/Karachi. One post per network per day at 18:00 PKT. Facebook and Instagram are scheduled as separate posts (different captions), each with the day's image.
- **X (@ARSInsights):** Typefully, social_set_id `335484`. Free plan = 10 posts per calendar month, so X posts **every third day** (anchor 2026-10-01, then 10-04, 10-07 … continuing every 3 days across month ends), at 18:00 PKT. Check `publishing_quota` before scheduling and never exceed it. Images are not uploaded to Typefully in this workflow, so X posts go out text + publication link; every publication page has a `summary_large_image` card.
- **Images:** Metricool needs a public URL. Images go in the site repo's `social/` folder as `YYYY-MM-DD-slug.jpg` and are served at `https://arspakistan.pk/social/<file>`. Images are committed to `main` directly, so no computer is needed. Commit only `social/` images and `_tools/social-kit/` files unless Reza asks for more.
- **LinkedIn:** Reza's personal profile (there is no ARS company page), connected in Metricool as network `linkedin` on the same blogId. See the LinkedIn section below.
- **Google Business Profile:** network `gmb` in Metricool, used for publication launches and the author-card campaign.
- **Planner page:** each week's planner is republished to the same private planner page (link kept outside this repository).

## Brand (from the site and publication covers)
- Deep navy radial background (`#123e6e` → `#092b52` → `#061a33`), white text, cyan accent bar `#22b4e6`, light-blue labels `#8bc7ff`.
- Serif display: Source Serif 4. Sans body/labels: Source Sans 3 (letter-spaced uppercase labels). Fonts are in `fonts/`.
- Every image: ARS wordmark top-left ("ARS | ARDENT RESEARCH SOLUTIONS"), category label top-right (ARS DATA BRIEF / ARS INSIGHT / ARS POLICY BRIEF / ARS RESEARCH REPORT / ARS SPECIAL REPORT), footer with source + publication code on the left and **arspakistan.pk** on the right.
- 1080 × 1350 portrait JPEG. Render with `python3 render.py OUT_DIR templates/*.html`.
- No emojis. Reza's photo appears only on author cards (he approved those on 29 Sep 2026); no photos of him on any other format.

## Post formats (rotate them across the week; at least four of the seven daily cards should be charts, because charts are what people share)
`templates/` holds one worked example of each; copy and edit.
1. **Stat card** — one headline number, a serif sentence explaining it, one supporting line (`stat-card-*.html`).
2. **Bar / column / range chart** — 3–5 values from one finding, drawn to scale (`chart-*.html`).
3. **Quote card** — one sentence quoted exactly from an ARS publication (`quote-card-*.html`). Quote only ARS's own text.
4. **Publication promo** — headline finding, three key numbers, the publication cover (`promo-cover-*.html`, covers are in `assets/publications/`).
5. **Author card** — one sentence quoted exactly from the publication, one key number, the author's round photo, name and designation (`author-card-*.html`). Take each designation from the author. Dr. Rubina Fareed: "Physician; former Member, National Commission on the Rights of Child".

## Words
- Voice: formal, analytical, plain. Figures exactly as in the publication's Key findings; never round differently or add numbers not in the publication. Credit external authors by name (e.g. Muneeb Maayr).
- **X:** under 280 characters counting the link as 23; the finding, one line of framing, then the canonical publication URL.
- **Facebook:** 2–4 sentences plus the full publication URL.
- **Instagram:** a one-line hook, 2–3 short paragraphs, "link in bio", then 4–6 hashtags ending with #ARSDataBrief / #ARSInsight / #ARSPolicyBrief / #ARSResearchReport.
- British spelling in captions, except names and quoted text.
- Every caption says the publication is free to read. On Instagram the bio link points to `https://arspakistan.pk/insights/`, so write "link in bio" only for Insights and "free to read at arspakistan.pk" for other categories.

## LinkedIn (Reza's profile)
- Weekdays only, 11:00 PKT (Metricool's best-time data puts LinkedIn's peak at 11:00; the one 6 PM post got half the views). **At most one post a day.**
- Before writing, list what is already scheduled in Metricool for LinkedIn and what was published (LIPO analytics also shows posts Reza made himself). Skip any day that already has a post. Never repeat a finding, and do not feature the same publication on consecutive days.
- Written in Reza's own voice ("my ARS Data Brief", "the ARS Special Report I co-authored with ..."; for other authors, "Dr. Rubina Fareed's ARS Insight"). One-line opener with the finding, the figures exactly as published, one sentence naming the publication, **one closing question to invite comments**, then "Free to read: <canonical URL>" and exactly three hashtags (two topics, then #Pakistan).
- Uses one of the week's daily cards as its image (prefer the charts); it need not be the same card as that day's Facebook post.
- Remind Reza to tag co-authors and guest authors after a post about their publication goes out.

## Author-card campaign ("In the author's words")
- A verbatim quote from the publication's PDF, one supporting number, the author's round photo, name and role. Template: `templates/author-card-in005.html`; images are `social/author-<code>-<name>.jpg`.
- Scheduled on 29 Sep 2026: Facebook, Instagram and Google Business Profile at 12:00 every third day from 3 Oct to 27 Oct; LinkedIn on Fridays at 11:00 from 9 Oct to 4 Dec (nine cards), each ending with one closing question. Check Metricool before adding more.

## Approval
Nothing is scheduled or published until Reza replies "approved" to the week shown in the planner. He usually reviews on his phone.

## Choosing content
- Read `post-log.json` first; do not reuse a finding already posted. New publications on arspakistan.pk (check sitemap.xml and the section index pages) go first.
- Take facts only from a publication page's Key findings / summary. Canonical URLs are in each page's `<link rel="canonical">`.
- After a week is scheduled, append each post to `post-log.json` and update `last_x_post`.
