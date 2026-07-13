#!/usr/bin/env bash
# Track V verification — run after deployment
set -e

echo "═══ Track V Verification ═══"
echo ""

echo -n ".com hero……" && curl -s https://workswithagents.com | grep -q "Win more UK tenders" && echo " ✅" || echo " ❌"
echo -n ".com no gmail…" && curl -s https://workswithagents.com | grep -vq "gmail" && echo " ✅" || echo " ❌"
echo -n ".com trust……" && curl -s https://workswithagents.com/trust | grep -q "own key" && echo " ✅" || echo " ❌"
echo -n ".com pricing…" && curl -s https://workswithagents.com/pricing | grep -q "39" && echo " ✅" || echo " ❌"
echo -n ".com privacy…" && curl -s -o /dev/null -w "%{http_code}" https://workswithagents.com/privacy | grep -q 200 && echo " ✅" || echo " ❌"
echo -n ".com sitemap…" && curl -s -o /dev/null -w "%{http_code}" https://workswithagents.com/sitemap.xml | grep -q 200 && echo " ✅" || echo " ❌"
echo -n ".com llms.txt…" && curl -s https://workswithagents.com/llms.txt | grep -q "MCP" && echo " ✅" || echo " ❌"
echo -n ".co.uk UK tender…" && curl -s https://workswithagents.co.uk | grep -q "UK tender" && echo " ✅" || echo " ❌"
echo -n ".co.uk no .dev…" && curl -s https://workswithagents.co.uk | grep -vq "workswithagents.dev" && echo " ✅" || echo " ❌"
echo -n ".io redirect…" && curl -sI https://workswithagents.io | grep -qi "location: https://workswithagents.com" && echo " ✅" || echo " ❌"
echo -n ".dev MCP……" && curl -s https://workswithagents.dev | grep -qi "MCP" && echo " ✅" || echo " ❌"
echo -n "tools branding…" && curl -s https://tools.workswithagents.com/rfp | grep -q "Works With Agents" && echo " ✅" || echo " ❌"
echo -n "construction sector…" && curl -s https://workswithagents.com/sectors/construction-fm | grep -q "social value" && echo " ✅" || echo " ❌"
echo -n "digital sector……" && curl -s https://workswithagents.com/sectors/digital-it | grep -q "cyber essentials" && echo " ✅" || echo " ❌"
echo -n "health sector…" && curl -s https://workswithagents.com/sectors/health-care | grep -q "DSPT" && echo " ✅" || echo " ❌"
echo -n "grants sector…" && curl -s https://workswithagents.com/sectors/grants | grep -q "eligibility" && echo " ✅" || echo " ❌"
echo -n "tools sample…" && curl -s "https://tools.workswithagents.com/rfp?sample=1" > /dev/null && echo " ✅" || echo " ❌"

echo ""
echo "═══ ALL CHECKS PASS ═══"
