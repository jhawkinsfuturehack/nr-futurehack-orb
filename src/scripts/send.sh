#!/bin/bash
echo Step: "${PARAM_NAME}"

CURRENT_TIME=$(date +%s%N)

curl -vvv -k -H "Content-Type: application/json" \
-H "Api-Key: ${NR_LICENSE_KEY}" \
-X POST https://metric-api.newrelic.com/metric/v1 \
--data "[{ 
        'metrics':[{ 
           'name':'build_step_time', 
           'type':'gauge', 
           'value':1, 
           'timestamp':${CURRENT_TIME}, 
           'attributes':{
               'project': '${CIRCLE_PROJECT_REPONAME}', 
               'branch': '${CIRCLE_BRANCH}', 
               'trace_id': '${PARAM_TRACE_ID}',
               'step':'${CIRCLE_NODE_INDEX}',
               'build_number':'${CIRCLE_BUILD_NUM}'
               } 
           }] 
    }]"


# curl -i -H 'Content-Type: application/json' \
#     -H "Api-Key: ${NR_LICENSE_KEY}" \
#     -H 'Data-Format: zipkin' \
#     -H 'Data-Format-Version: 2' \
#     -X POST \
#     -d '[
#     ]' 'https://trace-api.newrelic.com/trace/v1'
