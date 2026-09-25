"""Build the ARS Social Planner page from a week's posts.json.
Usage: python3 build_planner.py posts.json IMAGE_DIR OUT.html
posts.json: list of {date:'YYYY-MM-DD', day:'Fri 2 Oct', img:'YYYY-MM-DD-slug.jpg', category:'ARS Data Brief', title:'...',
  alt, fb, ig, x (x may be '' when no X post that day), fb_status, x_status}"""
import json, base64, html, sys
posts = json.load(open(sys.argv[1])); imgdir = sys.argv[2]; out = sys.argv[3]
tpl = open(__file__.replace('build_planner.py', 'planner.tpl')).read()
e = html.escape; cards = []
def pill(st): return f'<span class="pill {"ok" if st.lower().startswith("scheduled") else "wait"}">{e(st)}</span>'
for i, p in enumerate(posts):
    b64 = base64.b64encode(open(f"{imgdir}/{p['img']}", 'rb').read()).decode()
    def block(net, label, txt, st):
        return f'<div class="cap{" x" if net=="x" else ""}"><div class=caphead><span class=net>{label}</span>{pill(st)}<button class=copy data-t="{net}{i}" type=button>Copy text</button></div><pre id="{net}{i}">{e(txt)}</pre></div>'
    xb = block('x', 'X · @ARSInsights', p['x'], p.get('x_status', 'Awaiting your approval')) if p.get('x') else '<p class=pub>No X post today (X runs every third day).</p>'
    cards.append(f'''<article class=day id="d{i}">
<figure><img src="data:image/jpeg;base64,{b64}" alt="{e(p['alt'])}" loading=lazy><figcaption><button class=copyimg type=button>Copy image</button><span class=hint>or long-press / right-click to save</span></figcaption></figure>
<div class=body><header><div class=when><span class=dow>{e(p['day'])}</span><span class=time>6:00 PM</span></div></header>
<p class=pub><span class=cat>{e(p['category'])}</span>{e(p['title'])}</p>
{block('fb','Facebook',p['fb'],p.get('fb_status','Awaiting your approval'))}
{block('ig','Instagram',p['ig'],p.get('fb_status','Awaiting your approval'))}
{xb}
</div></article>''')
week = f"{posts[0]['day']} – {posts[-1]['day']}"
open(out, 'w').write(tpl.replace('%%WEEK%%', e(week)).replace('%%CARDS%%', '\n'.join(cards)))
