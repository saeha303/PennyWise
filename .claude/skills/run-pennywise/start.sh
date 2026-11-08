#!/usr/bin/env bash
# Build and start PennyWise, then wait until every port answers:
#   Caddy   :8080  the only URL to use: http://localhost:8080/PennyWiseJF/  (/api/* -> Spring, rest -> Tomcat)
#   Tomcat  :8081  JSP pages (internal)
#   Spring  :9090  REST API (internal)
#   Flask   :5000  budget prediction at POST /predict-budget (internal)
set -euo pipefail
APP=$(cd "$(dirname "$0")/../../.." && pwd)
R=${PENNYWISE_RUN_DIR:-$APP/.run}
TOMCAT=$R/apache-tomcat-9.0.98
[ -x "$TOMCAT/bin/catalina.sh" ] || { echo "Run setup.sh first"; exit 1; }

# DATABASE_URL comes from <repo>/.env. Read it with grep, never `source` it:
# Neon URLs contain '&' which makes the shell background half the line.
if [ -z "${DATABASE_URL:-}" ] && [ -f "$APP/.env" ]; then
  DATABASE_URL=$(grep -m1 '^DATABASE_URL=' "$APP/.env" | cut -d= -f2- | sed "s/^['\"]//; s/['\"]$//")
fi
[ -n "${DATABASE_URL:-}" ] || echo "WARNING: DATABASE_URL unset, falling back to localhost:5432 postgres/pennywise"
export DATABASE_URL

cd "$APP" && mvn -q compile

# JSPs import org.* classes directly, so Tomcat needs compiled classes + jars in an exploded webapp.
W=$TOMCAT/webapps/PennyWiseJF
rm -rf "$W" && mkdir -p "$W/WEB-INF/classes" "$W/WEB-INF/lib"
cp -r "$APP/src/main/webapps/." "$W/"
cp -r "$APP/target/classes/." "$W/WEB-INF/classes/"
cp "$R"/deps/*.jar "$W/WEB-INF/lib/"

mkdir -p "$R/logs"
"$TOMCAT/bin/catalina.sh" start > "$R/logs/tomcat-start.log" 2>&1
nohup java -cp "$APP/target/classes:$(cat "$R/cp.txt")" org.application.PennyWiseApplication > "$R/logs/api.log" 2>&1 &
# api.py loads the model from a cwd-relative path (src/main/resources/models), so run from repo root.
nohup "$R/venv/bin/python" src/main/resources/python/api.py > "$R/logs/flask.log" 2>&1 &
PORT=8080 nohup "$R/caddy" run --config "$APP/deploy/Caddyfile" --adapter caddyfile > "$R/logs/caddy.log" 2>&1 &

timeout 120 bash -c 'until curl -sf -o /dev/null http://localhost:8080/PennyWiseJF/ && curl -s -o /dev/null http://localhost:8081/PennyWiseJF/ && curl -s -o /dev/null http://localhost:9090/api/net-worth && curl -s -o /dev/null http://127.0.0.1:5000/; do sleep 2; done' \
  || { echo "Timed out waiting for ports; see $R/logs/ and $TOMCAT/logs/catalina.out"; exit 1; }
echo "PennyWise up: http://localhost:8080/PennyWiseJF/   logs: $R/logs/  $TOMCAT/logs/catalina.out"
