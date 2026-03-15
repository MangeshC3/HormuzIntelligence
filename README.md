# Hormuz Intelligence Centre — Deployment Package

Live AIS & Geopolitical Tanker Monitor for the Strait of Hormuz.

## Files

```
hormuz-deploy/
├── index.html          ← Main dashboard (v3 — latest, deploy this)
├── README.md           ← This file
├── COMPONENTS.md       ← Full component reference
└── docs/
    ├── hormuz-dashboard-v2.html   ← Version 2 (reference)
    └── hormuz-dashboard.html      ← Version 1 (reference)
```

## Quick Deploy

### Option 1 — Static file server (simplest)
Just open `index.html` in any modern browser. No build step required.

### Option 2 — Nginx
```nginx
server {
    listen 80;
    server_name yourdomain.com;
    root /var/www/hormuz;
    index index.html;
    location / { try_files $uri $uri/ =404; }
}
```

### Option 3 — GitHub Pages
1. Push this folder to a GitHub repo
2. Go to Settings → Pages → Deploy from branch (main / root)
3. Dashboard is live at `https://yourusername.github.io/repo-name`

### Option 4 — Netlify / Vercel
Drag and drop the `hormuz-deploy` folder onto netlify.com/drop — live in seconds.

### Option 5 — Python quick server (local dev)
```bash
cd hormuz-deploy
python3 -m http.server 8080
# Open http://localhost:8080
```

## External Dependencies (CDN)

All dependencies are loaded from CDN — no npm install needed.

| Library       | Version | Purpose                        | CDN URL |
|---------------|---------|--------------------------------|---------|
| oat.ink       | latest  | UI component base / CSS reset  | unpkg.com/@knadh/oat |
| Chart.js      | 4.4.1   | Charts (line, doughnut)        | cdnjs.cloudflare.com |
| Google Fonts  | —       | Space Mono, Barlow Condensed, DM Sans | fonts.googleapis.com |

> **Offline deployment?** Download the CDN assets and update the `<link>` / `<script>` src paths to local files. See COMPONENTS.md for exact URLs.

## Browser Support
Chrome 90+, Firefox 88+, Safari 14+, Edge 90+

## Features
- 🗺 Live AIS canvas map (Strait of Hormuz)
- 📊 KPI strip with 8 real-time metrics
- ⛽ Barrels-per-day export panel (9 country cards)
- 📈 7-day oil throughput charts
- 📦 Cargo analytics (volume breakdown + destination regions)
- 🚢 Vessel intelligence table with 5 filters
- 🔄 Simulated real-time AIS streaming feed
- 🔔 Geopolitical alert system with rotating banner
- 📋 Vessel detail slide-in drawer
- 🇮🇳 India-bound LPG corridor KPI & highlights

## Customisation
All data is in the `tankers[]` and `alerts[]` arrays at the top of the `<script>` block in `index.html`. Replace with live API data (MarineTraffic, VesselFinder, or AIS Hub) to make the dashboard fully live.
