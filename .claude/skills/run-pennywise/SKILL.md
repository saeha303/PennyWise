---
name: run-pennywise
description: Set up, build, start, stop, smoke-test, and drive the PennyWise expense tracker (Caddy proxy + Tomcat JSP pages + Spring Boot API + Flask budget-prediction service on a Neon Postgres database), locally or in its Docker/Vercel container. Use when asked to run or start PennyWise, build or test the Docker image, check that a change works in the real app, log in, take a screenshot of a page, or debug a 500 error on a JSP page.
---

PennyWise runs as three processes behind one **Caddy** proxy on `:8080`, the only URL you use. Caddy sends `/api/*` to **Spring Boot** (`:9090`) and everything else to **Tomcat**, which serves the JSP pages on internal port `:8081` at `/PennyWiseJF`. **Flask** (`POST :5000/predict-budget`) is internal, called only by the Java code. The pages call `/api/...` with relative URLs, so they only work through the proxy. The same `deploy/Caddyfile` is used locally and in the Docker image. The scripts in this directory start and stop all three. Drive the UI with `driver.py`: it logs in through the real form in headless Chrome and saves a screenshot of each page. All paths are relative to the repo root.

## Prerequisites

These were already installed on the machine this skill was verified on (Ubuntu 24.04): OpenJDK 17.0.20, Maven, Python 3.12 with `venv`, `psql` 16, and Google Chrome 136. Nothing extra was installed with apt. Playwright drives the system Chrome (`channel="chrome"`), so `playwright install` is not needed.

The database is hosted on **Neon**. Its connection string goes in `.env` at the repo root, which is gitignored:

```
DATABASE_URL=postgresql://<user>:<pass>@<host>.neon.tech:5432/neondb?sslmode=require&channel_binding=require
```

Both `org/db/database.java` and `python/database.py` read `DATABASE_URL`. Without it they fall back to `localhost:5432` with postgres/pennywise.

## Setup (one time, about 2 minutes)

```bash
.claude/skills/run-pennywise/setup.sh
```

This downloads Tomcat 9.0.98 (and switches it to port 8081) and Caddy 2.8.4, creates a venv (Flask, pandas, scikit-learn, psycopg2, Playwright) and copies the runtime jars into `.run/`, which is gitignored. It's safe to re-run.

## Run (agent path)

```bash
.claude/skills/run-pennywise/start.sh      # compiles, deploys, starts all 3, waits for the ports (~30s)
.claude/skills/run-pennywise/smoke.sh      # curl checks on all 3 services, read-only; exit 0 = all PASS
.run/venv/bin/python .claude/skills/run-pennywise/driver.py index.jsp pages-wallets.jsp pages-budget.jsp pages-report.jsp
.claude/skills/run-pennywise/stop.sh
```

`start.sh` recompiles the Java code and redeploys the JSPs every time. After editing `.java` or `.jsp` files, run `stop.sh` and then `start.sh`.

What `driver.py` does:

- **Login account:** it uses its own `smoke_test` / `SmokeTest123` account. It registers the account if needed and sets the password through the forgot-password action, so it never touches `john_doe` or anyone else's password. (A reset of `john_doe` during testing once wiped a password the user had set.)
- **Pages:** pass any JSP names as arguments. The default is `index.jsp`.
- **`--demo`:** logs in through the "Try as demo user" button instead, as `demo_user`, which has sample data. Run `psql "$U" -f sql/create_demo_user.sql` to create or reset that account; it copies john_doe's sample data with dates shifted to the last month.
- **Screenshots:** saved to `.run/shots/<page>.png`. Open them and look at them; a page can return 200 and still be broken.
- **Failure rules:** a page fails if it shows a Tomcat 500 or "Exception", if a JavaScript error is thrown, or if a request to localhost returns 4xx/5xx. Failures from outside servers (CDNs) are printed only as `warning (external)`.

Current baseline on unchanged code: `pages-wallets`, `pages-budget` and `pages-report` PASS. `index.jsp` **FAILS** with `js error: Cannot read properties of undefined (reading 'resize')`: the dashboard's "Report" chart has no data and stays blank. That error is already in the app; don't treat it as a regression.

Logs: `.run/logs/api.log` (Spring), `.run/logs/flask.log`, `.run/logs/caddy.log`, and `.run/apache-tomcat-9.0.98/logs/catalina.out` (Tomcat, including `System.out` from JSPs and `org.*` classes).

## Run in the deployment container (Docker / Vercel)

`Dockerfile.vercel` packages everything into one image: Caddy on `$PORT` (default 80), plus Tomcat, Spring and Flask, started by `deploy/start-container.sh`. Test it locally before deploying. Port 8090 avoids clashing with the local stack:

```bash
docker build -f Dockerfile.vercel -t pennywise .        # ~3-5 min the first time, image ~970 MB
docker run -d --name pennywise-test -p 8090:80 --env-file .env pennywise
timeout 150 bash -c 'until docker logs pennywise-test 2>&1 | grep -q "backends ready"; do sleep 2; done'
PENNYWISE_URL=http://localhost:8090 PENNYWISE_RUN_DIR=.run/container .run/venv/bin/python .claude/skills/run-pennywise/driver.py index.jsp pages-wallets.jsp
docker rm -f pennywise-test
```

Expect the same baseline as the local run. `docker logs pennywise-test` shows all processes; one `MissingServletRequestParameterException` WARN comes from the readiness probe and is harmless.

## Run (human path)

Run `start.sh`, then open http://localhost:8080/PennyWiseJF/. To log in with an existing account that has no password (every sample user, such as `john_doe` / `john.doe@example.com`), use **Forgot password?** on the login page first.

## Database

The schema and sample data come from `sql/`. They have already been loaded into Neon. To check them:

```bash
U=$(grep -m1 '^DATABASE_URL=' .env | cut -d= -f2-); psql "$U" -c '\dt'
```

If you ever reload them into a new database:
- `ALTER ... OWNER TO postgres` fails on Neon because it has no `postgres` role. Ignore it; the tables are still created.
- `insert_wallet.sql` needs 7 users that no script creates (`jane_doe`, `robert_langdon`, `park_rose`, `kim_jennie`, `kim_jisoo`, `john_smith`, `jane_smith`). Insert them first, and load the wallets into an empty table so the IDs come out 1–12, which `insert_expense.sql` expects.
- The last row of `insert_income.sql` refers to wallet 14, which doesn't exist. Skip it.

## Gotchas

- **Login is enforced by `org.register.AuthFilter`** (registered in `WEB-INF/web.xml` for `*.jsp`). Pages not on its public list redirect to the login page without a session. A new public page must be added to `PUBLIC_PAGES`, or logged-out visitors can't reach it.
- **Empty accounts exercise code that sample data hides.** Until Nov 2026 every page was forced to show john_doe's data, so crashes for users with no data went unnoticed (`getNetWorth` UNION, `getActualSpending` with no budget). Test new pages with both the empty `smoke_test` account and `--demo`.
- **Never `source .env`.** The Neon URL contains `&`, so bash backgrounds part of the line and `DATABASE_URL` ends up empty. The scripts read it with `grep | cut`.
- **Neon URL needs an explicit `:5432`.** On this machine libpq defaults to port **2345**, the local system Postgres. Without a port, `psql` and `psycopg2` hang until they time out instead of reaching Neon. JDBC defaults to 5432, so only the Python side and psql break, which is confusing.
- **Two app servers, one origin.** The JSPs run in standalone Tomcat (context `/PennyWiseJF`) and import `org.*` classes directly. Spring Boot only serves `/api/*` JSON. The pages use relative `/api/...` and `/PennyWiseJF/...` URLs, so always browse through Caddy on `:8080`. Opening Tomcat's `:8081` directly renders the pages, but every API call 404s.
- **GitHub release downloads (Caddy) returned 504 for a long stretch.** `setup.sh` falls back to copying `/usr/bin/caddy` out of the `caddy:2.8.4` Docker image; the harmless `ignored xattrs` warning comes from that.
- **Don't copy Spring's embedded Tomcat jars into the webapp.** `setup.sh` excludes `org.apache.tomcat.embed` when copying dependencies; those jars would clash with the real Tomcat.
- **Flask must run from the repo root**, because it loads `src/main/resources/models/budget_model.pkl` by relative path. It prints a harmless sklearn warning, "X does not have valid feature names", on every prediction.
- **Dead CDN.** `header.jsp:36` links Bootstrap 5.1.3 from `stackpath.bootstrapcdn.com`, which returns 404 on every page. The local vendor CSS keeps the layout intact.
- **Don't stop processes with `pkill -f psql...` or similar broad patterns.** They match the agent's own shell and kill it (exit 144). `stop.sh` kills by port.

## Troubleshooting

- **`psql: error: connection to server at "<ip>", port 2345 failed: timeout expired`**: the Neon URL has no port. Add `:5432` after `.neon.tech`.
- **`HTTP Status 500 ... index.jsp at line [23] ... IndexOutOfBoundsException ... budget.getActualSpending`**: no budget covers today's date. This is fixed in `budget.java` (it now checks `b_list.size()>=2`). If it comes back, that guard was removed.
- **Login to an existing account returns a 500 or "mismatch"**: the account's `password_hash` is NULL; the sample users have none. Use the forgot-password page.
- **`start.sh` times out**: read `.run/logs/api.log` for Spring, `caddy.log`, and `catalina.out` for Tomcat. Usually a port is still taken by an earlier run; run `stop.sh`. If `.run/caddy` is missing, re-run `setup.sh`; a failed download leaves no binary.
