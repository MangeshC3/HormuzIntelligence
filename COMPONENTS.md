# COMPONENTS.md — Hormuz Intelligence Centre

Full reference of every UI component, library, and module used in the dashboard.

---

## External Libraries

### 1. oat.ink (`@knadh/oat`)
- **Version:** latest (sub-v1)
- **Size:** ~6KB CSS + 2.2KB JS (minified + gzipped)
- **CDN:** `https://unpkg.com/@knadh/oat/oat.min.css`
         `https://unpkg.com/@knadh/oat/oat.min.js`
- **Used for:** CSS reset, semantic base styles, scrollbar styling
- **Docs:** https://oat.ink

### 2. Chart.js
- **Version:** 4.4.1
- **CDN:** `https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js`
- **Chart types used:**
  - `line` — 7-day oil throughput (multi-dataset area chart)
  - `doughnut` — Vessel types, AIS health, Cargo mix, Destination regions
- **Docs:** https://chartjs.org

### 3. Google Fonts
- **Families loaded:**
  - `Space Mono` (400, 700) — monospaced data labels, timestamps, MMSI
  - `Barlow Condensed` (300–900) — display headings, KPI values, section titles
  - `DM Sans` (300–600) — body text, table cells, descriptions

---

## Layout Components

### Sticky Header
- Brand logo (gradient square + emoji)
- Dashboard title + subtitle
- Live AIS pill (animated red dot)
- WebSocket status pill (green/amber)
- Alert bell button with badge counter
- UTC clock (updates every 1s)

### Section Navigation Bar
- 8 anchor links: AIS Map, Overview, BPD, Throughput, Cargo, Vessels, Live Feed, Routes
- Active state highlights on scroll (IntersectionObserver-style scroll listener)
- Glassmorphism background with blur

### Glass Panel System
- `.panel` — frosted glass card (rgba white + backdrop-filter blur)
- `.ph` — panel header bar with title and badge slot
- Used for: all major sections

---

## Data Display Components

### KPI Grid (8 cards)
| Card | Value | Color |
|------|-------|-------|
| Total Tankers | 27 | Orange |
| VLCC Count | 9 | Red |
| AIS Dark | 3 | Gold |
| Northbound | 14 | Green |
| Southbound | 13 | Blue |
| Avg Speed | 11.4 kn | Purple |
| 🇮🇳 India LPG (hero) | 3 vessels / 1.62 Mbbl/d | India orange |
| Crude Mbbl/day | ~18.1 | Teal |

- Coloured top-border accent per card
- Delta indicators (↑↓) with directional colour
- Hero India card spans 2 columns with tricolor flag bar

### Barrels-Per-Day Panel
- 9 export cards: Saudi Aramco, Iraq/Basra, Iran, Kuwait+UAE, Qatar LNG, India LPG, Total Gas, World Share
- Each card has a fill progress bar coloured by country/type
- India LPG card has special orange/green gradient border

### Cargo Analytics (3-column)
- **Column 1:** Cargo by volume — 6 horizontal bar rows + doughnut chart
- **Column 2:** Destination regions — 5 bar rows + doughnut chart
- **Column 3:** Top manifests — 4 mini manifest cards with fill bars (India LPG vessels highlighted)

### Charts
| ID | Type | Datasets |
|----|------|----------|
| `ch-thru` | Line/area | Crude total, LNG equiv, India LPG |
| `ch-type` | Doughnut | 6 vessel types |
| `ch-ais`  | Doughnut | Active / Sporadic / Dark |
| `ch-cargo`| Doughnut | Crude / LNG / Naphtha / LPG / Other |
| `ch-dest` | Doughnut | E.Asia / S.Asia / Europe / SE Asia / Unknown |

---

## Map Component

### Live AIS Canvas Map (`<canvas id="mapCanvas">`)
**Rendered elements:**
- Sea gradient background (dark blue gradient)
- Grid lines (subtle, 12×12)
- Iran coastline polygon (dark green fill)
- UAE + Oman coastline polygon (sandy fill)
- Musandam peninsula polygon
- Traffic Separation Scheme (TSS) lanes — dashed blue lines
- India LPG corridor route lines — orange dashed
- 27 vessel ship icons (triangle shapes, rotated by heading NB/SB)
- Vessel colour coding by type (VLCC=red, Suezmax=orange, Aframax=yellow, Chemical=blue, LNG=purple, LPG=green)
- India-bound vessels: orange glow + 🇮🇳 flag label
- AIS-dark vessels: grey fill + red dashed halo ring
- Coast labels: IRAN, UAE, OMAN, Musandam, India LPG corridor

**Interactions:**
- Hover → tooltip (name, type, speed, heading, AIS, cargo, India flag if applicable)
- Click → opens Vessel Detail Drawer
- Mouseleave → hides tooltip
- Zoom in/out buttons (`+` / `−`) + reset (`⌖`)
- Vessels jitter position on each AIS tick and on manual refresh

**Map legend:** 7 items (VLCC, Suezmax, Aframax, Chemical, LNG, LPG, AIS Dark)

---

## Table Components

### Vessel Intelligence Table
- **Columns:** Name, MMSI, Flag, Type, DWT, Cargo, Speed, Direction, Position (Lat/Lon), AIS Status
- **Filters:** Search (name/MMSI/flag), Type dropdown, AIS dropdown, Direction dropdown, Destination (India/China)
- **Row features:**
  - Click any row → opens Vessel Detail Drawer
  - India-bound rows: orange left border + orange name colour
  - AIS-dark rows: red name colour
  - Flash animation (`rowFlash`) on AIS streaming updates
- **Refresh button:** jitters speeds + positions, redraws map

### Routes Table
- **Columns:** #, Vessel, Type, Origin Port, Country, →, Destination, Country, ETA, Cargo, AIS
- Same row highlighting for India-bound and dark vessels
- Click row → opens Vessel Detail Drawer

---

## Drawer Components

### Vessel Detail Drawer (`#vdrawer`)
- Slides in from right (CSS transform + transition)
- Shared overlay backdrop
- **Contains:**
  - Vessel name + MMSI header
  - Route visualiser: origin port → destination port cards
  - Mini canvas track map (bezier path + current position dot)
  - 8-field vessel info grid (type, flag, DWT, speed, heading, position, AIS, ETA)
  - 6-field cargo manifest grid (cargo, volume, load port, consignee, charter party, IMO class)
  - Conditional India LPG highlight block (only for `india: true` vessels)
- Close via ✕ button, overlay click, or `Escape` key

### Geopolitical Alert Drawer (`#alert-drawer`)
- Slides in from right
- **Contains:** 6 alert cards with 4 severity types:
  - `danger` (red left border) — IRGC exercises, sanctions
  - `warn` (yellow) — AIS spoofing, US naval ops
  - `info` (blue) — Qatar LNG highs
  - `india` (orange) — India LPG corridor status
- Each card: type label, timestamp, title, body text

---

## Alert & Notification Components

### Alert Banner (`#alert-banner`)
- Fixed position, slides down from header
- Auto-cycles through danger/warn alerts every ~28s
- Manually dismissible (✕ button)
- Shows: alert text (truncated to 80 chars) + timestamp

### Bell Button
- Located in header
- Badge shows unread count (resets to 0 on open)
- Opens Geopolitical Alert Drawer on click

---

## Real-Time Feed Component (`#s-ais`)

### AIS Streaming Feed
- Simulates WebSocket Class A/B NMEA messages
- Push interval: 1.4–3 seconds (randomised)
- **Feed entries:** timestamp, vessel name, AIS status badge, message text
- Special tags for India LPG vessels in feed
- Keeps max 60 entries (oldest pruned)
- Each push: jitters vessel lat/lon, redraws map, flashes table row

### AIS Stats Sidebar
- 4 stat cards: Active (21), Sporadic (3), Dark (3), Msgs/min
- Segmented health bar (green/amber/red proportions)
- WebSocket status pill in header updates to ⬤ CONNECTED

---

## Badge & Indicator System

| Class | Colour | Used for |
|-------|--------|----------|
| `.bg` | Green | Active AIS, positive status |
| `.br` | Red | AIS Dark, danger |
| `.by` | Yellow | Sporadic AIS |
| `.bb` | Blue | Cargo type, general info |
| `.bp` | Purple | LNG specific |
| `.bt` | Teal | Info/neutral |
| `.bi` | India orange | India-bound vessels, LPG |

### AIS Status Dots
- `.ad-a` — green, glowing (Active)
- `.ad-s` — amber, glowing (Sporadic)
- `.ad-d` — red, glowing (Dark)

### Vessel Type Dots
- Inline coloured dots matching map icon colours per type

---

## CSS Animation Inventory

| Name | Effect | Applied to |
|------|--------|-----------|
| `blink` | Opacity pulse 1→0.2 | Live AIS pill dot |
| `slideIn` | Slide + fade from left | AIS feed entries |
| `rowFlash` | Yellow background fade | Table rows on AIS update |
| Drawer slide | `translateX` + `cubic-bezier` | Vessel + alert drawers |
| KPI hover | `translateY(-2px)` + shadow | KPI cards |
| Map hover | Cursor change + tooltip show | Canvas vessel icons |

---

## CSS Design System

- **Theme:** Sky-blue glassmorphism — `rgba(255,255,255,0.28)` panels with `backdrop-filter: blur(18px)`
- **Background:** Fixed linear gradient (sky blue → deep ocean)
- **Overlays:** Radial gradient pseudo-element for cloud/depth effect
- **Border radius:** `--r: 12px` (consistent)
- **Shadows:** `0 4px 20px rgba(7,24,40,0.10)` on panels
- **Scrollbar:** Custom thin 5px webkit scrollbar

---

## Data Structure

Each vessel object in `tankers[]` contains:
`name, mmsi, flag, type, dwt, cargo, spd, dir, ais, lat, lon, india (bool), orig, oc, dest, dc, eta, vol, load, cons, chart, imo`

Each alert in `alerts[]` contains:
`type, label, title, body, time, india (bool)`
