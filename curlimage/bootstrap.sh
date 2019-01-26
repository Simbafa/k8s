#!/bin/sh
set -e

for i in {150..0}; do
    ret_code=$(curl -s --connect-timeout 3 --url "http://$URL" -w "\n%{http_code}" | tail -n1)
    if [ "x$ret_code" = "x200" ] || [ "x$ret_code" = "x302" ]; then
       exit 0
    fi
    echo "  $URL未准备好($ret_code)，2秒后重试..."
    sleep 2
done
exit -1

