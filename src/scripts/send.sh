#!/bin/bash
declare -a trace_array
declare -a log_array

while read p; do
  echo "$p"
  ts=$(echo $p | cut -d "|" -f 1)
  log=$(echo $p | cut -d "|" -f 2)

    if [ ${#trace_array[@]} -eq 0 ]; then
        trace_array+=("$ts")
        log_array+=("$log")
    else
        last_ts=${trace_array[${#trace_array[@]}-1]}
        trace_array[${#trace_array[@]}-1]="$((ts-last_ts))"

        if [ "$log" == "Build Finished" ]; then
            echo "Skipping, build complete"
        else
            trace_array+=("$ts")
            log_array+=("$log")
        fi
    fi
done </tmp/trace.log

CURRENT_TIME=$(date +%s)

trace_array_length=${#trace_array[@]}
for (( i=0; i<${trace_array_length}; i++ ));
do
  echo "index: $i, elapsed: ${trace_array[$i]}"
  echo "index: $i, value: ${log_array[$i]}"

  curl -vvv -k -H "Content-Type: application/json" \
    -H "Api-Key: ${NR_LICENSE_KEY}" \
    -X POST https://metric-api.newrelic.com/metric/v1 \
    --data "[{ 
            \"metrics\":[{ 
            \"name\":\"elapsed_build_time\", 
            \"type\":\"gauge\", 
            \"value\": ${trace_array[$i]}, 
            \"timestamp\":${CURRENT_TIME}, 
            \"interval.ms\": 10000,
            \"attributes\":{
                \"project\": \"${CIRCLE_PROJECT_REPONAME}\", 
                \"branch\": \"${CIRCLE_BRANCH}\", 
                \"trace_id\": \"${log_array[$i]}\",
                \"step\":\"${CIRCLE_NODE_INDEX}\",
                \"build_number\":\"${CIRCLE_BUILD_NUM}\"
                } 
            }] 
        }]"
done