#!/bin/bash

THRESHOLD=80
EXIT_CODE=0

echo "Checking disk usage..."

while read filesystem usage; do
    usage_percent=${usage%\%}

    if [[ "$usage_percent" =~ ^[0-9]+$ ]]; then
        if [ "$usage_percent" -ge "$THRESHOLD" ]; then
            echo "WARNING: $filesystem usage is at ${usage_percent}%"
            EXIT_CODE=1
        else
            echo "OK: $filesystem usage is at ${usage_percent}%"
        fi
    fi
done < <(df -h | awk 'NR>1 {print $1, $5}')

exit $EXIT_CODE
