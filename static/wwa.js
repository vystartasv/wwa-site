// Works With Agents — shared tool API client
// Discovered from tools.workswithagents.com API contract

async function callTool(endpoint, text) {
  const res = await fetch(`https://tools.workswithagents.com/${endpoint}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ text }),
  });
  if (!res.ok) throw new Error(`API error: ${res.status}`);
  return res.json();
}

function renderReport(analysis, container) {
  let total = 0, passed = 0, failed = 0;
  const rows = [];
  for (const [cat, items] of Object.entries(analysis)) {
    if (!Array.isArray(items)) continue;
    for (const item of items) {
      total++;
      const ok = !item.status || item.status === 'pass' || item.status === 'met';
      if (ok) passed++; else failed++;
      rows.push(`          <div class="row ${ok ? 'ok' : 'gap'}"><span class="mark">${ok ? '✓' : '✕'}</span><span>${item.title || item.findings || item.requirement || ''}</span>${item.clause ? `<span class="clause">${item.clause}</span>` : ''}</div>`);
    }
  }
  container.innerHTML = `        <div class="report-head"><span class="t">Analysis</span><span class="verdict">${failed} gap${failed !== 1 ? 's' : ''}</span></div>
        <div class="report-body">${rows.join('\n')}</div>
        <div class="report-foot"><span><b>${passed} met</b> \u00b7 ${failed} gaps</span></div>`;
}

function copyReport() {
  const text = document.querySelector('.report-body')?.innerText || '';
  navigator.clipboard.writeText(text).then(() => {
    const btn = document.getElementById('copy-btn');
    if (btn) btn.textContent = 'Copied';
  });
}
