"""Render ARS post templates to 1080x1350 JPEGs.
Usage: python3 render.py OUT_DIR file1.html [file2.html ...]
Each output is OUT_DIR/<html basename>.jpg (rename to YYYY-MM-DD-slug.jpg before committing)."""
import asyncio, sys, os
from playwright.async_api import async_playwright
from PIL import Image
async def main(out, files):
    os.makedirs(out, exist_ok=True)
    async with async_playwright() as p:
        b = await p.chromium.launch(); pg = await b.new_page(viewport={'width':1080,'height':1350})
        for f in files:
            await pg.goto('file://' + os.path.abspath(f)); await pg.wait_for_timeout(500)
            png = os.path.join(out, os.path.basename(f)[:-5] + '.png')
            await pg.screenshot(path=png)
            Image.open(png).convert('RGB').save(png[:-4] + '.jpg', quality=90); os.remove(png)
        await b.close()
asyncio.run(main(sys.argv[1], sys.argv[2:]))
