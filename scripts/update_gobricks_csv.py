#!/usr/bin/env python3
"""
Scrapes GoBricks reseller shops (mocbrickstore.com, yourwobb.com) to extract
GDS↔Lego part number mappings, then updates assets/gobrick_conversion_table.csv.

Usage:
    pip install -r scripts/requirements.txt
    playwright install chromium
    python scripts/update_gobricks_csv.py
"""

import csv
import re
import sys
import time
from pathlib import Path
from dataclasses import dataclass

import requests
from bs4 import BeautifulSoup

# ---------------------------------------------------------------------------
# Config
# ---------------------------------------------------------------------------

PROJECT_ROOT = Path(__file__).resolve().parent.parent
CSV_PATH = PROJECT_ROOT / "assets" / "gobrick_conversion_table.csv"

GDS_PATTERN = re.compile(r"GDS-[A-Z]?\d+", re.IGNORECASE)
LEGO_NUM_PATTERN = re.compile(r"\b(\d{3,6}[a-z]?\d{0,2})\b", re.IGNORECASE)

# Shopify limits to 250 products per page
SHOPIFY_PAGE_SIZE = 250


@dataclass
class ScrapedPart:
    gds_number: str
    lego_numbers: list[str]
    description: str = ""
    source: str = ""


# ---------------------------------------------------------------------------
# Step 1 — Scrape mocbrickstore.com (Shopify JSON API)
# ---------------------------------------------------------------------------

def scrape_mocbrickstore() -> list[ScrapedPart]:
    """Fetch all GoBricks parts from mocbrickstore.com via Shopify JSON API."""
    parts: list[ScrapedPart] = []
    page = 1
    session = requests.Session()
    session.headers["User-Agent"] = (
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
        "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    )

    while True:
        url = (
            f"https://www.mocbrickstore.com/collections/gobrick-part/products.json"
            f"?limit={SHOPIFY_PAGE_SIZE}&page={page}"
        )
        print(f"  [mocbrickstore] Fetching page {page}...")
        try:
            resp = session.get(url, timeout=60)
            resp.raise_for_status()
        except requests.RequestException as e:
            print(f"  [mocbrickstore] Request failed on page {page}: {e}")
            break

        data = resp.json()
        products = data.get("products", [])
        if not products:
            break

        for product in products:
            part = _parse_mocbrickstore_product(product)
            if part:
                parts.append(part)

        print(f"  [mocbrickstore] Page {page}: {len(products)} products ({len(parts)} GDS parts total)")
        if len(products) < SHOPIFY_PAGE_SIZE:
            break
        page += 1
        time.sleep(1)

    return parts


def _parse_mocbrickstore_product(product: dict) -> ScrapedPart | None:
    """Extract GDS and Lego numbers from a mocbrickstore Shopify product."""
    title = product.get("title", "")
    body_html = product.get("body_html", "")

    # Extract GDS number from title (e.g. "GDS-502 - Plate 1 x 2")
    gds_match = GDS_PATTERN.search(title)
    if not gds_match:
        return None

    gds_number = gds_match.group(0).upper()

    # Extract Lego IDs from body_html
    # Format: <p>Compatible with LEGO IDs:</p><ul><li>3023</li><li>...</li></ul>
    lego_numbers: list[str] = []
    if "Compatible with LEGO IDs:" in body_html:
        soup = BeautifulSoup(body_html, "html.parser")
        # Find the <ul> after "Compatible with LEGO IDs:"
        for p_tag in soup.find_all("p"):
            if "Compatible with LEGO IDs:" in p_tag.get_text():
                ul = p_tag.find_next_sibling("ul")
                if ul:
                    for li in ul.find_all("li"):
                        lego_id = li.get_text(strip=True)
                        if lego_id and re.match(r"^[\da-zA-Z]+$", lego_id):
                            lego_numbers.append(lego_id)
                break

    # Clean description from title
    description = re.sub(r"GDS-[A-Z]?\d+\s*-?\s*", "", title, flags=re.IGNORECASE).strip()

    return ScrapedPart(
        gds_number=gds_number,
        lego_numbers=lego_numbers,
        description=description,
        source="mocbrickstore",
    )


# ---------------------------------------------------------------------------
# Step 2 — Scrape yourwobb.com (Playwright)
# ---------------------------------------------------------------------------

def scrape_yourwobb() -> list[ScrapedPart]:
    """Scrape yourwobb.com loose bricks collection with Playwright."""
    from playwright.sync_api import sync_playwright

    parts: list[ScrapedPart] = []

    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True)
        page = browser.new_page()

        page_num = 1
        while True:
            url = f"https://www.yourwobb.com/collections/gobricks-loose-bricks?page={page_num}"
            print(f"  [yourwobb] Loading page {page_num}...")
            try:
                page.goto(url, wait_until="networkidle", timeout=60000)
            except Exception as e:
                print(f"  [yourwobb] Failed to load page {page_num}: {e}")
                break

            time.sleep(2)
            _scroll_to_bottom(page)

            html = page.content()
            new_parts = _parse_yourwobb_html(html)

            if not new_parts:
                break

            parts.extend(new_parts)
            print(f"  [yourwobb] Page {page_num}: {len(new_parts)} parts (total {len(parts)})")
            page_num += 1

            if page_num > 100:
                break

        browser.close()

    return parts


def _parse_yourwobb_html(html: str) -> list[ScrapedPart]:
    """Parse yourwobb HTML for GDS/Lego part mappings."""
    soup = BeautifulSoup(html, "html.parser")
    parts: list[ScrapedPart] = []

    for elem in soup.find_all(["a", "h2", "h3", "span", "div"], string=GDS_PATTERN):
        text = elem.get_text(strip=True)
        gds_match = GDS_PATTERN.search(text)
        if not gds_match:
            continue

        gds_number = gds_match.group(0).upper()
        lego_number = _extract_lego_number(text, gds_number)
        description = _clean_description(text)

        parts.append(
            ScrapedPart(
                gds_number=gds_number,
                lego_numbers=[lego_number] if lego_number else [],
                description=description,
                source="yourwobb",
            )
        )

    return parts


def _extract_lego_number(text: str, gds_number: str) -> str | None:
    """Extract a Lego part number from text, excluding the GDS number digits."""
    cleaned = text.replace(gds_number, "")
    cleaned = re.sub(r"(?i)gobricks?|gds-?\d+", "", cleaned)

    candidates = LEGO_NUM_PATTERN.findall(cleaned)
    filtered = []
    for c in candidates:
        num = int(re.match(r"\d+", c).group())
        if num < 100 or 1990 <= num <= 2030:
            continue
        filtered.append(c)

    return filtered[0] if filtered else None


def _clean_description(text: str) -> str:
    """Clean a product title into a plain description."""
    desc = text.strip()
    desc = GDS_PATTERN.sub("", desc)
    desc = re.sub(r"(?i)^gobricks?\s*,?\s*", "", desc)
    desc = re.sub(r",?\s*\d{3,6}[a-z]?\d{0,2}\s*$", "", desc)
    desc = re.sub(r"^[,\s]+|[,\s]+$", "", desc)
    desc = re.sub(r"\s{2,}", " ", desc)
    return desc


def _scroll_to_bottom(page) -> None:
    """Scroll a Playwright page to the bottom to trigger lazy loading."""
    for _ in range(10):
        page.evaluate("window.scrollBy(0, window.innerHeight)")
        time.sleep(0.5)


# ---------------------------------------------------------------------------
# Step 3 — Merge & deduplicate
# ---------------------------------------------------------------------------

def merge_parts(
    all_parts: list[ScrapedPart],
) -> dict[str, ScrapedPart]:
    """Deduplicate by GDS number. Prefer entries with Lego numbers."""
    merged: dict[str, ScrapedPart] = {}
    for part in all_parts:
        gds = part.gds_number
        if gds not in merged:
            merged[gds] = part
        elif part.lego_numbers and not merged[gds].lego_numbers:
            merged[gds] = part
        elif part.lego_numbers and merged[gds].lego_numbers:
            # Combine Lego numbers from multiple sources
            existing_nums = set(merged[gds].lego_numbers)
            for num in part.lego_numbers:
                if num not in existing_nums:
                    merged[gds].lego_numbers.append(num)
    return merged


# ---------------------------------------------------------------------------
# Step 4 — Read/write CSV
# ---------------------------------------------------------------------------

def read_existing_csv() -> dict[str, str]:
    """Read existing CSV. Returns {lego_part: gds_number}."""
    mapping: dict[str, str] = {}
    if not CSV_PATH.exists():
        return mapping

    with open(CSV_PATH, newline="") as f:
        reader = csv.reader(f)
        for row in reader:
            if len(row) >= 2:
                lego_part, gds_part = row[0].strip(), row[1].strip()
                if lego_part and gds_part:
                    mapping[lego_part] = gds_part
    return mapping


def write_csv(mapping: dict[str, str]) -> None:
    """Write mapping to CSV sorted by Lego part number."""

    def sort_key(item):
        lego = item[0]
        m = re.match(r"(\d+)(.*)", lego)
        if m:
            return (int(m.group(1)), m.group(2))
        return (float("inf"), lego)

    sorted_items = sorted(mapping.items(), key=sort_key)

    with open(CSV_PATH, "w", newline="") as f:
        writer = csv.writer(f)
        for lego_part, gds_part in sorted_items:
            writer.writerow([lego_part, gds_part])

    print(f"  Wrote {len(sorted_items)} entries to {CSV_PATH}")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    print("=" * 60)
    print("GoBricks Conversion Table Updater")
    print("=" * 60)

    # Step 1: Scrape mocbrickstore.com
    print("\n[Step 1] Scraping mocbrickstore.com (Shopify JSON API)...")
    moc_parts: list[ScrapedPart] = []
    try:
        moc_parts = scrape_mocbrickstore()
    except Exception as e:
        print(f"  WARNING: mocbrickstore scraping failed: {e}")
    print(f"  Total from mocbrickstore: {len(moc_parts)}")

    # Step 2: Scrape yourwobb.com
    print("\n[Step 2] Scraping yourwobb.com (Playwright)...")
    wobb_parts: list[ScrapedPart] = []
    try:
        wobb_parts = scrape_yourwobb()
    except Exception as e:
        print(f"  WARNING: yourwobb scraping failed: {e}")
    print(f"  Total from yourwobb: {len(wobb_parts)}")

    # Step 3: Merge
    print("\n[Step 3] Merging and deduplicating...")
    all_parts = moc_parts + wobb_parts
    merged = merge_parts(all_parts)

    with_lego = {gds: p for gds, p in merged.items() if p.lego_numbers}
    without_lego = {gds: p for gds, p in merged.items() if not p.lego_numbers}

    print(f"  Unique GDS parts:      {len(merged)}")
    print(f"  With Lego mapping:     {len(with_lego)}")
    print(f"  Without Lego mapping:  {len(without_lego)}")

    # Step 4: Update CSV
    print("\n[Step 4] Updating CSV...")
    existing = read_existing_csv()
    original_count = len(existing)

    new_count = 0
    for gds, part in with_lego.items():
        for lego in part.lego_numbers:
            if lego not in existing:
                existing[lego] = gds
                new_count += 1

    write_csv(existing)

    # Summary
    print("\n" + "=" * 60)
    print("Summary")
    print("=" * 60)
    print(f"  Products scraped:      {len(all_parts)}")
    print(f"  Unique GDS parts:      {len(merged)}")
    print(f"  With Lego mapping:     {len(with_lego)}")
    print(f"  Without Lego mapping:  {len(without_lego)}")
    print(f"  Previous CSV entries:  {original_count}")
    print(f"  New entries added:     {new_count}")
    print(f"  Total CSV entries:     {len(existing)}")
    print("=" * 60)


if __name__ == "__main__":
    main()
