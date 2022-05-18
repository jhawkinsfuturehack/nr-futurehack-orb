#!/bin/bash
echo Step: "${PARAM_TRACE_ID}"
CURRENT_TIME=$(date +%s)

curl -vvv -k -H "Content-Type: application/json" \
-H "Api-Key: ${NR_LICENSE_KEY}" \
-X POST https://metric-api.newrelic.com/metric/v1 \
--data "[{ 
        \"metrics\":[{ 
           \"name\":\"build_step_time\", 
           \"type\":\"count\", 
           \"value\":1, 
           \"timestamp\":${CURRENT_TIME}, 
           \"interval.ms\": 10000,
           \"attributes\":{
               \"project\": \"${CIRCLE_PROJECT_REPONAME}\", 
               \"branch\": \"${CIRCLE_BRANCH}\", 
               \"trace_id\": \"${PARAM_TRACE_ID}\",
               \"step\":\"${CIRCLE_NODE_INDEX}\",
               \"build_number\":\"${CIRCLE_BUILD_NUM}\"
               } 
           }] 
    }]"

echo "${CURRENT_TIME}|${PARAM_TRACE_ID}" >> trace.log