"""Drive the running PennyWise UI in headless Chrome and screenshot pages.

Usage (from repo root, app already started):
  .run/venv/bin/python .claude/skills/run-pennywise/driver.py [page.jsp ...]
  PENNYWISE_URL=http://localhost:8090 .run/venv/bin/python .claude/skills/run-pennywise/driver.py   # container

Steps:
  1. Ensures a dedicated `smoke_test` account exists with a known password: it registers the
     account, then sets the password through the forgot-password action. Real or sample
     accounts such as john_doe are never touched.
  2. Logs in through the real login form (fill + click), the way a user would.
  3. Visits each page (default: index.jsp), saves a full-page screenshot to .run/shots/<page>.png,
     and fails if the page shows a Tomcat error or the browser console logged errors.
"""
import os
import sys
import urllib.parse
import urllib.request
from playwright.sync_api import sync_playwright

# PENNYWISE_URL points the driver at another instance, e.g. the Docker container or a deployment.
BASE = os.environ.get("PENNYWISE_URL", "http://localhost:8080").rstrip("/") + "/PennyWiseJF/"
USER, EMAIL, PASSWORD = "smoke_test", "smoke_test@example.com", "SmokeTest123"
APP = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", ".."))
SHOTS = os.path.join(os.environ.get("PENNYWISE_RUN_DIR", os.path.join(APP, ".run")), "shots")


def post(data):
    body = urllib.parse.urlencode(data).encode()
    with urllib.request.urlopen(BASE + "changePassword.jsp", body, timeout=60) as r:
        return r.read().decode().strip()


def ensure_account():
    post({"action": "register", "fn": "Smoke", "ln": "Test", "email": EMAIL, "un": USER, "ps": PASSWORD})
    r = post({"action": "resetPassword", "username": USER, "email": EMAIL,
              "newPassword": PASSWORD, "renewPassword": PASSWORD})
    if r != "1":
        sys.exit(f"could not prepare {USER} account (resetPassword returned {r!r})")


def main(pages):
    os.makedirs(SHOTS, exist_ok=True)
    ensure_account()
    ok = True
    with sync_playwright() as p:
        # channel="chrome" uses the system Google Chrome, so no `playwright install` download is needed.
        browser = p.chromium.launch(channel="chrome")
        page = browser.new_page(viewport={"width": 1400, "height": 900})
        errors, warnings = [], []
        # Only failures from the app's own servers count. External CDN failures (e.g. the dead
        # stackpath.bootstrapcdn.com link in the JSPs) are reported as warnings.
        page.on("response", lambda r: r.status >= 400 and
                (errors if r.url.startswith(BASE.split("/PennyWiseJF")[0]) else warnings).append(f"{r.status} {r.url}"))
        page.on("pageerror", lambda e: errors.append(f"js error: {e}"))
        page.on("dialog", lambda d: (print("dialog:", d.message), d.accept()))

        page.goto(BASE + "pages-login.jsp")
        page.fill("#yourUsername", USER)
        page.fill("#yourPassword", PASSWORD)
        page.click("button[type=submit]")
        page.wait_for_url("**/index.jsp", timeout=60000)
        print("logged in as", USER)

        for name in pages:
            errors.clear()
            warnings.clear()
            page.goto(BASE + name, wait_until="networkidle", timeout=90000)
            shot = os.path.join(SHOTS, name.replace("/", "_").replace(".jsp", "") + ".png")
            page.screenshot(path=shot, full_page=True)
            text = page.inner_text("body")
            broken = "HTTP Status 500" in text or "Exception" in text
            status = "FAIL" if broken or errors else "PASS"
            ok &= status == "PASS"
            print(f"{status} {name}  title={page.title()!r}  screenshot={shot}")
            for e in errors:
                print("   error:", e[:200])
            for w in sorted(set(warnings)):
                print("   warning (external):", w[:200])
            if broken:
                print("   page error:", text[:300].replace("\n", " "))
        browser.close()
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main(sys.argv[1:] or ["index.jsp"])
