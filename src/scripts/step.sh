#!/bin/bash
echo Step: "${PARAM_TRACE_ID}"
CURRENT_TIME=$(($(date +%s%N)/1000000))

TRACE_STAMP="{'name':'${PARAM_TRACE_ID}','time':${CURRENT_TIME}}"

if [ -z "$TRACE_COLLECTION" ]
then
      export TRACE_COLLECTION="${TRACE_STAMP}" >> $BASH_ENV
else
      export TRACE_COLLECTION="${TRACE_COLLECTION},${TRACE_STAMP}" >> $BASH_ENV
fi
