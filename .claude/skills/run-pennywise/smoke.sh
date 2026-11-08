#!/usr/bin/env bash
# HTTP smoke test of all three services (read-only). Exits non-zero on the first failure.
set -uo pipefail
fail=0
check() { # name, expected-substring, curl args...
  local name=$1 want=$2; shift 2
  local body; body=$(curl -s --max-time 30 "$@")
  if [[ "$body" == *"$want"* ]]; then echo "PASS $name"; else echo "FAIL $name -> ${body:0:200}"; fail=1; fi
}
check "tomcat guest page"     "<title>PennyWise"  http://localhost:8080/PennyWiseJF/
check "tomcat login page"     "Forgot password?"  http://localhost:8080/PennyWiseJF/pages-login.jsp
check "api via proxy :8080"  "["                 "http://localhost:8080/api/net-worth?user=john_doe&wallet=My%20Wallet"
check "spring net-worth"      "["                 "http://localhost:9090/api/net-worth?user=john_doe&wallet=My%20Wallet"
check "flask predict-budget"  "Food"              -X POST http://127.0.0.1:5000/predict-budget -H 'Content-Type: application/json' -d '{"username":"john_doe","wallet":"1","month":11}'
exit $fail
