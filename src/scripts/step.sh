#!/bin/bash
CURRENT_TIME=$(date +%s)

echo "${CURRENT_TIME}|${PARAM_TRACE_ID}" >> /tmp/trace.log