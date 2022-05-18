#!/bin/bash
echo Step: "${PARAM_NAME}"
date

curl -i -H 'Content-Type: application/json' \
    -H "Api-Key: ${NR_LICENSE_KEY}" \
    -H 'Data-Format: zipkin' \
    -H 'Data-Format-Version: 2' \
    -X POST \
    -d '[
    ]' 'https://trace-api.newrelic.com/trace/v1'
