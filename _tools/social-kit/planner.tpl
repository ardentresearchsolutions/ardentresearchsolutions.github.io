<title>ARS Social Planner</title>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Source+Sans+3:wght@400;600;700&family=Source+Serif+4:opsz,wght@8..60,600;8..60,700&display=swap">
<style>
:root{--bg:#f2f5f9;--surface:#ffffff;--ink:#0b2240;--muted:#56687e;--line:#d8e1eb;--accent:#0874d1;--accent-ink:#ffffff;--xbg:#eaf3fc;--ok:#1d7a4d;--okbg:#e3f3ea;--wait:#8a5a00;--waitbg:#fbf0d9;
--serif:"Source Serif 4",Georgia,serif;--sans:"Source Sans 3","Segoe UI",Arial,sans-serif}
@media (prefers-color-scheme:dark){:root:not([data-theme="light"]){color-scheme:dark;--bg:#07172b;--surface:#0d223d;--ink:#e6eef7;--muted:#93a7bd;--line:#1f3a5c;--accent:#4fb3f0;--accent-ink:#04121f;--xbg:#10304f;--ok:#6fd3a0;--okbg:#123a2c;--wait:#f0c46a;--waitbg:#3a2e12}}
:root[data-theme="dark"]{color-scheme:dark;--bg:#07172b;--surface:#0d223d;--ink:#e6eef7;--muted:#93a7bd;--line:#1f3a5c;--accent:#4fb3f0;--accent-ink:#04121f;--xbg:#10304f;--ok:#6fd3a0;--okbg:#123a2c;--wait:#f0c46a;--waitbg:#3a2e12}
body{background:var(--bg);color:var(--ink);font:16px/1.5 var(--sans);padding-inline:16px;padding-block:28px 56px}
.wrap{max-width:1040px;margin:0 auto;display:flex;flex-direction:column;gap:28px}
.top{display:flex;flex-wrap:wrap;justify-content:space-between;gap:16px;align-items:flex-end;border-bottom:2px solid var(--ink);padding-bottom:18px}
.brand{font:700 13px var(--sans);letter-spacing:.18em;text-transform:uppercase;color:var(--muted)}
h1{font:700 clamp(28px,5vw,40px)/1.1 var(--serif);margin:6px 0 0;text-wrap:balance}
.week{font-size:15px;color:var(--muted);text-align:right}
.week b{display:block;color:var(--ink);font-size:18px}
.how{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:12px;font-size:15px;color:var(--muted)}
.how div{background:var(--surface);border:1px solid var(--line);padding:12px 14px;border-radius:6px}
.how b{color:var(--ink);display:block;font-size:14px;letter-spacing:.06em;text-transform:uppercase;margin-bottom:2px}
.day{display:grid;grid-template-columns:300px 1fr;gap:24px;background:var(--surface);border:1px solid var(--line);border-radius:8px;padding:20px}
figure{margin:0;display:flex;flex-direction:column;gap:8px}
figure img{width:100%;border-radius:4px;display:block}
figcaption{display:flex;flex-wrap:wrap;gap:8px;align-items:center;font-size:13px;color:var(--muted)}
.body{display:flex;flex-direction:column;gap:14px;min-width:0}
.body header{display:flex;justify-content:space-between;flex-wrap:wrap;gap:10px;align-items:baseline}
.dow{font:700 24px var(--serif)}
.time{margin-left:12px;color:var(--muted);font-variant-numeric:tabular-nums}
.done{font-size:15px;display:flex;gap:8px;align-items:center;cursor:pointer}
.done input{width:18px;height:18px;accent-color:var(--accent)}
.pub{margin:0;color:var(--muted);font-size:15px}
.cat{display:inline-block;font-weight:700;font-size:12px;letter-spacing:.14em;text-transform:uppercase;color:var(--accent);margin-right:10px}
.cap{border:1px solid var(--line);border-radius:6px;overflow:hidden}
.cap.x{background:var(--xbg);border-color:transparent}
.caphead{display:flex;align-items:center;gap:10px;padding:10px 12px 0;flex-wrap:wrap}
.net{font-weight:700;font-size:14px;letter-spacing:.04em}
.who{font-size:13px;color:var(--muted)}
.pill{font-size:12px;font-weight:600;padding:2px 8px;border-radius:99px}
.pill.ok{color:var(--ok);background:var(--okbg)}.pill.wait{color:var(--wait);background:var(--waitbg)}
pre{margin:0;padding:10px 12px 14px;white-space:pre-wrap;word-wrap:break-word;font:15px/1.55 var(--sans)}
button{font:600 14px var(--sans);border-radius:5px;cursor:pointer;padding:6px 12px}
.copy{margin-left:auto;background:var(--accent);color:var(--accent-ink);border:0}
.copyimg{background:transparent;color:var(--ink);border:1px solid var(--line)}
button:focus-visible,summary:focus-visible,input:focus-visible{outline:2px solid var(--accent);outline-offset:2px}
details{display:flex;flex-direction:column;gap:10px}
details[open]>summary{margin-bottom:10px}
details .cap+.cap{margin-top:10px}
summary{cursor:pointer;color:var(--accent);font-weight:600;font-size:15px}
.day.posted{opacity:.62}
.toast{position:fixed;left:50%;bottom:calc(20px + env(safe-area-inset-bottom,0px));transform:translateX(-50%);background:var(--ink);color:var(--bg);padding:8px 16px;border-radius:6px;font-weight:600}
@media (max-width:720px){.day{grid-template-columns:1fr}.week{text-align:left}figure img{max-width:420px}}
</style>
<div class=wrap>
<div class=top><div><div class=brand>Ardent Research Solutions</div><h1>Social Planner</h1></div>
<div class=week><b>%%WEEK%%</b>Facebook and Instagram daily · X every third day · 6:00 PM PKT</div></div>
<div class=how>
<div><b>Facebook &amp; Instagram</b>Scheduled in Metricool once you approve the week and push the images.</div>
<div><b>X · @ARSInsights</b>Scheduled in Typefully every third day, with the publication’s cover card.</div>
<div><b>Source</b>Every figure is taken from the key findings on arspakistan.pk.</div>
</div>
%%CARDS%%
</div>
<div class=toast id=toast hidden></div>
<script>
const toast=m=>{const t=document.getElementById('toast');t.textContent=m;t.hidden=false;clearTimeout(t._h);t._h=setTimeout(()=>t.hidden=true,1800)};
function selectText(el){const r=document.createRange();r.selectNodeContents(el);const s=getSelection();s.removeAllRanges();s.addRange(r)}
document.querySelectorAll('.copy').forEach(b=>b.addEventListener('click',()=>{const el=document.getElementById(b.dataset.t);
navigator.clipboard.writeText(el.textContent).then(()=>toast('Text copied')).catch(()=>{selectText(el);toast('Text selected. Press Ctrl+C to copy')})}));
document.querySelectorAll('.copyimg').forEach(b=>b.addEventListener('click',()=>{const img=b.closest('figure').querySelector('img');
try{const c=document.createElement('canvas');c.width=img.naturalWidth;c.height=img.naturalHeight;c.getContext('2d').drawImage(img,0,0);
c.toBlob(bl=>{navigator.clipboard.write([new ClipboardItem({'image/png':bl})]).then(()=>toast('Image copied. Paste it into X')).catch(()=>toast('Copying images is blocked here. Right-click or long-press the image to save it'))},'image/png')}catch(e){toast('Right-click or long-press the image to save it')}}));
</script></script>
