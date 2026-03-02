#!/bin/bash
cd "$(dirname "$0")/.."

python3 -m pip install -r scripts/requirements.txt
python3 -m playwright install chromium
python3 scripts/update_gobricks_csv.py
