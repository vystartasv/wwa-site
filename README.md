# wwa-site — static site for Works With Agents

## What this is
Pure static HTML site. No build step, no frameworks, no bundlers.
`/static/wwa.css` and `/static/wwa.js` are shared across all pages.

## Structure
```
/                         landing page (workswithagents.com + .co.uk)
/static/wwa.css           single stylesheet (extracted from index.html template)
/static/wwa.js            shared JS API client for tool calls
/trust/index.html
/privacy/index.html
/terms/index.html
/pricing/index.html
/sectors/construction-fm/index.html
/sectors/digital-it/index.html
/sectors/health-care/index.html
/sectors/grants/index.html
/tools/rfp/index.html     (12 tool pages, each with API call JS)
/tools/pqq/index.html
/tools/grant/index.html
/tools/esg/index.html
/tools/bidnobid/index.html
/tools/timeline/index.html
/tools/winthesis/index.html
/tools/score/index.html
/tools/plain/index.html
/tools/price/index.html
/tools/risk/index.html
/tools/obligations/index.html
/dev/index.html           docs page for workswithagents.dev
/llms.txt
/sitemap.xml
/robots.txt
```

## Design tokens (from index.html — DO NOT CHANGE)
- paper: #FAF8F3, ink: #1C1C1A, pass: #0F6E56, fail: #A32D2D
- Display font: Fraunces, Body: Public Sans, Mono: IBM Plex Mono
- Dark mode: prefers-color-scheme (already in wwa.css)
- No emoji anywhere. UK spelling. Sentence case.

## Building
No build step. Files are served directly by nginx.

```bash
# Preview locally (Python)
cd ~/Agent-Projects/wwa-site && python3 -m http.server 8080
```

## Deploying
```bash
bash deploy.sh
```

This rsyncs all files to the VPS, fixes permissions, updates nginx config, and reloads nginx.

## Verification (Track V — run after deploy)
```bash
bash verify.sh
```

## Distribution — MCP registry listings

| Registry | URL |
|----------|-----|
| Official MCP Registry | `io.github.vystartasv/wwa-mcp` |
| Smithery | `https://smithery.ai/servers/vystartasv/wwa-mcp` |
| PulseMCP | Auto-ingests from official registry within a week |

## Rules
- FRONTEND IS FROZEN after acceptance. No changes without naming exact files.
- "Improve the look/UX" is not a valid instruction.
- Any change ships with before/after screenshot + re-run verify.sh.
