#!/usr/bin/env bash
# Stop all three processes by port (avoid `pkill -f`: broad patterns can kill the caller's own shell).
APP=$(cd "$(dirname "$0")/../../.." && pwd)
R=${PENNYWISE_RUN_DIR:-$APP/.run}
"$R/apache-tomcat-9.0.98/bin/catalina.sh" stop >/dev/null 2>&1 || true
for port in 8080 8081 9090 5000; do
  pids=$(ss -ltnpH "sport = :$port" 2>/dev/null | grep -o 'pid=[0-9]*' | cut -d= -f2 | sort -u)
  [ -n "$pids" ] && kill $pids 2>/dev/null
done
timeout 20 bash -c 'while ss -ltnH | grep -qE ":(8080|8081|9090|5000) "; do sleep 1; done' || echo "Some ports still busy"
echo Stopped.
