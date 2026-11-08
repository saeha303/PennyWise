#!/usr/bin/env bash
# One-time setup: Tomcat 9, Python venv (Flask + ML + Playwright), runtime jars for the webapp.
# Everything lands in $PENNYWISE_RUN_DIR (default <repo>/.run, gitignored). Safe to re-run.
set -euo pipefail
APP=$(cd "$(dirname "$0")/../../.." && pwd)
R=${PENNYWISE_RUN_DIR:-$APP/.run}
TOMCAT_VER=9.0.98
mkdir -p "$R"

if [ ! -x "$R/apache-tomcat-$TOMCAT_VER/bin/catalina.sh" ]; then
  echo "== Downloading Tomcat $TOMCAT_VER"
  curl -fsSL "https://archive.apache.org/dist/tomcat/tomcat-9/v$TOMCAT_VER/bin/apache-tomcat-$TOMCAT_VER.tar.gz" | tar xz -C "$R"
fi

# The pages call /api/... relative to their own origin, so locally (as in the container) Caddy
# fronts both servers on :8080 and Tomcat moves to internal :8081. Same deploy/Caddyfile as Docker.
sed -i 's/port="8080"/port="8081"/' "$R/apache-tomcat-$TOMCAT_VER/conf/server.xml"
if [ ! -x "$R/caddy" ]; then
  echo "== Downloading Caddy 2.8.4"
  if ! curl -fsSL https://github.com/caddyserver/caddy/releases/download/v2.8.4/caddy_2.8.4_linux_amd64.tar.gz -o "$R/caddy.tgz"; then
    # GitHub release downloads have returned 504 for long stretches; the official image has the same binary.
    echo "   GitHub download failed, copying the binary out of the caddy:2.8.4 Docker image"
    cid=$(docker create caddy:2.8.4) && docker cp "$cid:/usr/bin/caddy" "$R/caddy" && docker rm "$cid" >/dev/null
  else
    tar xzf "$R/caddy.tgz" -C "$R" caddy && rm "$R/caddy.tgz"
  fi
fi

if [ ! -x "$R/venv/bin/python" ]; then
  echo "== Creating Python venv"
  python3 -m venv "$R/venv"
fi
"$R/venv/bin/pip" -q install flask joblib pandas scikit-learn psycopg2-binary playwright

echo "== Resolving Java dependencies"
cd "$APP"
rm -rf "$R/deps"
# Tomcat ships its own servlet container: drop spring-boot's embedded tomcat jars from the webapp.
mvn -q dependency:copy-dependencies -DincludeScope=runtime -DexcludeGroupIds=org.apache.tomcat.embed -DoutputDirectory="$R/deps"
mvn -q dependency:build-classpath -Dmdep.outputFile="$R/cp.txt"
echo "Setup done in $R"
