#!/usr/bin/env bash
# PROTOTYPE - NOT FOR PRODUCTION
# Question: rebuild the browser build that is published as a Claude artifact.
# Date: 2026-10-30
# Needs Godot 4.7.2 with the web_nothreads export templates. Output: build/m1-web/
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
out="$here/../../../build/m1-web"
mkdir -p "$out"
# The repo ignores export_presets.cfg, so recreate the web preset when it is missing.
if [ ! -f "$here/../export_presets.cfg" ]; then
  cat > "$here/../export_presets.cfg" <<'CFG'
[preset.0]

name="Web"
platform="Web"
runnable=true
export_filter="all_resources"
include_filter=""
exclude_filter="sim.gd, README.md, web/*"
export_path="../../build/m1-web/index.html"

[preset.0.options]

variant/extensions_support=false
variant/thread_support=false
vram_texture_compression/for_desktop=true
vram_texture_compression/for_mobile=false
html/export_icon=false
html/canvas_resize_policy=2
html/focus_canvas_on_start=true
progressive_web_app/enabled=false
CFG
fi
godot --headless --path "$here/.." --export-release Web
# The artifact host serves .wasm but caps files at 15 MB: publish the engine gzipped, page decompresses it.
gzip -9 -c "$out/index.wasm" > "$out/godot-engine-gzip.wasm"
# The host won't serve .pck, so the game data is embedded in the page.
python3 - "$here/page.html" "$out/index.pck" "$out/page.html" <<'PY'
import base64, sys
page, pck, dest = sys.argv[1:]
html = open(page).read().replace("__PCK_B64__", base64.b64encode(open(pck, "rb").read()).decode())
open(dest, "w").write(html)
PY
echo "Built $out/page.html (+ index.js, godot-engine-gzip.wasm)"
