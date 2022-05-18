#!/bin/bash
echo Step: "${PARAM_NAME}"

CURRENT_TIME=$(($(date +%s%N)/1000000))

TRACE_STAMP="{'name':'end','time':${CURRENT_TIME}}"

if [ -z "$TRACE_COLLECTION" ]
then
      export TRACE_COLLECTION="${TRACE_STAMP}"
else
      export TRACE_COLLECTION="${TRACE_COLLECTION},${TRACE_STAMP}"
fi

echo "Trace: ${TRACE_COLLECTION}"

curl -i -H 'Content-Type: application/json' \
    -H "Api-Key: ${NR_LICENSE_KEY}" \
    -H 'Data-Format: zipkin' \
    -H 'Data-Format-Version: 2' \
    -X POST \
    -d '[
    ]' 'https://trace-api.newrelic.com/trace/v1'

source $BASH_ENV