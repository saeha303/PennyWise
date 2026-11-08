#!/usr/bin/env bash
# Container entrypoint: start Tomcat, Spring Boot and Flask, wait until all three answer,
# then run Caddy in the foreground on $PORT (default 80) as the only public port.
set -euo pipefail
cd /app
export PORT=${PORT:-80}
[ -n "${DATABASE_URL:-}" ] || echo "WARNING: DATABASE_URL is not set" >&2

/opt/tomcat/bin/catalina.sh start
java -cp "/app/classes:/app/apideps/*" org.application.PennyWiseApplication &
/opt/venv/bin/python src/main/resources/python/api.py &

for i in $(seq 1 120); do
  if curl -s -o /dev/null http://127.0.0.1:8081/PennyWiseJF/ &&
     curl -s -o /dev/null http://127.0.0.1:9090/api/net-worth &&
     curl -s -o /dev/null http://127.0.0.1:5000/; then
    echo "backends ready after ${i}s"; break
  fi
  sleep 1
done

exec caddy run --config /app/deploy/Caddyfile --adapter caddyfile
