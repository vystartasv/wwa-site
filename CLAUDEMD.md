~We need to pop in and see how things are getting along. This is Claude Code. We're building the replacement static site for Works With Agents. You're taking over from Claw.

## What exists already

Claw has set up:
- `/Users/vilius/Agent-Projects/wwa-site/` — git repo, directory structure for all pages
- `/Users/vilius/Agent-Projects/wwa-site/static/wwa.css` — extracted from the template
- `/Users/vilius/Agent-Projects/wwa-site/static/wwa.js` — shared API client + report renderer + copy function
- `/Users/vilius/Agent-Projects/wwa-site/deploy.sh` — rsyncs to VPS + reloads nginx
- `/Users/vilius/Agent-Projects/wwa-site/verify.sh` — Track V acceptance script
- `/Users/vilius/Agent-Projects/wwa-site/wwa-site.nginx.conf` — nginx config for all domains
- `/Users/vilius/Agent-Projects/wwa-site/README.md` — repo docs with deploy instructions

## What you need to build

### Source files
- `/tmp/wwa-files/index.html` — THE design template (source of truth for every visual decision)
- `/tmp/wwa-files/wwa-rebuild-brief.md` — authoritative brief
- `/tmp/wwa-files/wwa-agent-execution-plan.md` — detailed 6-track plan

### 1. Landing page: `index.html` (root)
Copy the template. Fix nav links:
- Tool cards: point to `/tools/rfp/` etc. (not `https://tools.workswithagents.com/rfp`)
- Sector cards: point to `/sectors/construction-fm/` etc.
- "For AI agents →" anchor: keep `#agents` (same-page anchor)
- Nav links: keep `#tools`, `#sectors`, `#agents`, `#trust`, `#pricing` as anchors

Change the `<style>` block to `<link rel="stylesheet" href="/static/wwa.css">`.
Add `<script src="/static/wwa.js"></script>` before `</body>`.

### 2. .co.uk variant: `index.html` (same file, hostname-aware)
The same file works for both domains. The nginx config serves the same root.
The brief says .co.uk needs: canonical = co.uk URL, title suffix "— UK tender tools", meta contains "UK tender".
Since this is static HTML, create a separate `co.uk.html` as the .co.uk root with those changes, or handle via nginx rewrite.

Actually — simplest approach: use nginx to serve the same file. The brief says "A copy step or host rule; keep dumb." So just note in README that .co.uk needs canonical/title/meta adjusted at the nginx level or via a separate file.

### 3. Trust: `/trust/index.html`
Expand the landing's four trust items. Use the same nav/header/footer pattern from index.html.
Nav links point to real URLs here (not anchors): `/`, `/trust/`, `/pricing/`, etc.

### 4. Privacy: `/privacy/index.html`
Plain-English, UK GDPR-aware. HTML comment: "Template — not legal advice"

### 5. Terms: `/terms/index.html`
Same pattern. HTML comment: "Template — not legal advice"

### 6. Pricing: `/pricing/index.html`
£0 forever, hosted £39/month coming soon, mailto capture.

### 7. Sector pages (4): `/sectors/construction-fm/`, `/sectors/digital-it/`, `/sectors/health-care/`, `/sectors/grants/`
Each: theme headline · three pain points · mapped 3-tool workflow · CTA.
Vocab from the brief:
- construction-fm: "Pass every gate." — social value, CDM, frameworks
- digital-it: "Framework-ready answers." — G-Cloud, DOS, Cyber Essentials  
- health-care: "Evidence every claim." — NHS frameworks, DSPT, IG
- grants: "Meet every guideline." — eligibility, match funding, budgets

### 8. Tool pages (12): `/tools/rfp/`, `/tools/pqq/`, `/tools/grant/`, `/tools/esg/`, `/tools/bidnobid/`, `/tools/timeline/`, `/tools/winthesis/`, `/tools/score/`, `/tools/plain/`, `/tools/price/`, `/tools/risk/`, `/tools/obligations/`
Each:
- Shared nav/footer from theme
- H1 = tool's question/promise from the landing card lines
- Textarea + submit button
- Submit calls the EXISTING API via `callTool(endpoint, text)` from wwa.js
- Results rendered via `renderReport(analysis, container)` from wwa.js
- "Copy report" button wired to `copyReport()`
- BidCheck only: `?sample=1` preloads a committed synthetic sample ITT and auto-runs

API endpoints (same as tools.workswithagents.com):
- rfp → /rfp (BidCheck)
- pqq → /pqq (SQ / PQQ Check)
- grant → /grant
- esg → /esg
- bidnobid → /bidnobid (BidMate)
- timeline → /timeline
- winthesis → /winthesis
- score → /score
- plain → /plain
- price → /price
- risk → /risk
- obligations → /obligations

### 9. Dev docs: `/dev/index.html`
Single page: MCP server usage, docker commands, link to .com. Theme/wwa.css.

### 10. SEO files
- `/llms.txt` — product + MCP endpoints + 12 tools, one line each
- `/sitemap.xml` — all pages
- `/robots.txt` — allow all, point to sitemap

## Design rules (from brief)
- Use classes from wwa.css only. Never add inline styles or second stylesheets.
- UK spelling. Sentence case. No emoji. No hype words.
- Brand: "Works With Agents" only (never "Agent Tools").
- Contact: hello@workswithagents.com only (never gmail).
- Every page: unique title + meta description + canonical.

## Deploy
```bash
cd /Users/vilius/Agent-Projects/wwa-site && bash deploy.sh
```

## Verify
```bash
bash verify.sh
```

## Freeze rule
When verify.sh passes all checks, the frontend is FROZEN.
No changes without naming exact files and exact changes.
"Improve the look/UX" is not a valid instruction.
