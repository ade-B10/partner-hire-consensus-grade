# Deploy Guide — 3 Steps to Go Live

**Estimated time: 4 minutes total.**

You're deploying to: `https://ade-B10.github.io/partner-hire-consensus-grade/`
Password (save in 1Password under "Base10 · Partner Hire Consensus Grade"): `Base10Automation!`

---

## Step 1: Create the GitHub repo (90 seconds)

1. Go to [github.com/new](https://github.com/new)
2. Repository name: `partner-hire-consensus-grade`
3. Set to **Public** (required for free GitHub Pages — the content is encrypted, so this is safe)
4. **Do NOT** check "Add a README" — we already have one
5. Click **Create repository**

You'll land on an empty repo page with setup instructions. Ignore them — we'll use the web UI to upload.

## Step 2: Upload the deploy folder (60 seconds)

1. On the empty repo page, click **uploading an existing file** link (near the top of the instructions)
2. In Finder, open `/Users/ade/Desktop/Urizen/partner-hire-consensus-grade-deploy/`
3. Select ALL files (Cmd+A) **EXCEPT the `source/` folder** — that one's gitignored, but the web uploader doesn't know that
4. Drag the files onto the GitHub upload area
5. Scroll down, commit message: `Initial deploy`
6. Click **Commit changes**

Files you should be uploading:
- `index.html` (the encrypted page)
- `README.md`
- `DEPLOY_GUIDE.md` (this file)
- `.gitignore`
- `.staticrypt.json`
- `update.sh`

Do NOT upload the `source/` folder. The unencrypted HTML stays on your machine.

## Step 3: Enable GitHub Pages (60 seconds)

**Skip the navigation hunt — go straight to:**

`https://github.com/ade-B10/partner-hire-consensus-grade/settings/pages`

Then:

1. Under "Build and deployment":
   - **Source**: Deploy from a branch
   - **Branch**: `main` / `/ (root)`
2. Click **Save**
3. Wait ~30 seconds. The page will show: "Your site is live at `https://ade-B10.github.io/partner-hire-consensus-grade/`"

## Done.

Open the URL. You'll see a password prompt. Enter `Base10Automation!`. The page loads.

Share the URL + password with the team (Slack DM, 1Password shared vault, however you want to handle it).

---

## Bonus: making future updates easy

When you want to refresh the content:

**Easiest path (have Claude do it):**
- Ask in Claude to "update Base10 · Partner Hire Consensus Grade with [the new info]"
- Claude will edit `source/Partner_Hire_Consensus_Grade.html`, run `./update.sh`, and tell you the exact commit message
- You just commit + push (or paste the new `index.html` into GitHub web UI)

**DIY path:**
1. Update `source/Partner_Hire_Consensus_Grade.html` directly (or have Claude do it)
2. In Terminal: `cd ~/Desktop/Urizen/partner-hire-consensus-grade-deploy && ./update.sh`
3. Drag the new `index.html` into the GitHub repo (or `git add index.html && git commit && git push` if you've set up git CLI)

The URL stays the same. Live in ~30 seconds.

---

## If something goes wrong

- **"Page not loading"** — Wait 60 seconds after enabling Pages. GitHub takes a moment to provision.
- **"Wrong password"** — Confirm exact case + special characters. Password is: `Base10Automation!`
- **"I want to change the password"** — Edit `update.sh`, change the `PASSWORD=` line, run `./update.sh`, push. Team will need the new password.
- **"I want to revoke access for someone"** — Single-shared-password model can't do this. Rotate the password (see above). For true per-user revocation, migrate to Cloudflare Access (see README).

---

*Questions? Ask Claude. Built via the `password-protected-site` skill.*
