FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
```

**Step 5** → Scroll down, commit message: `Add Dockerfile for Railway deployment`, click **Commit changes**

---

That's the only file you need to add. Here's what your repo should look like after:
```
HormuzIntelligence/
├── Dockerfile        ← NEW — tells Railway to use Nginx to serve the HTML
├── index.html        ← your dashboard
├── README.md
└── COMPONENTS.md
```

---

### Now deploy on Railway

**Step 6** → Go to [railway.com/new](https://railway.com/new)

**Step 7** → Click **Deploy from GitHub repo** → select **MangeshC3/HormuzIntelligence**

**Step 8** → Click **Deploy Now** — Railway detects the Dockerfile automatically and builds it

**Step 9** → Once deployed, click your service → **Settings → Networking → Generate Domain**

You'll get a live URL like:
```
https://hormuzintelligence-production.up.railway.app
