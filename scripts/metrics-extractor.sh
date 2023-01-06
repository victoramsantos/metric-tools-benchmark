#!/usr/bin/env bash
#set -euox pipefail

PROMETHEUS_URL=http://localhost:9090
TARGET_JOB=avalanche
PRETTY_JSON=false
METRICS_FILE=metrics.json
OUTPUT_FILE=metrics.js

curl -XGET -G "${PROMETHEUS_URL}/api/v1/label/__name__/values" \
  --data-urlencode "match[]={job=\"${TARGET_JOB}\"}" > $METRICS_FILE

if $PRETTY_JSON; then
  cat <<< $(jq . $METRICS_FILE) > $METRICS_FILE
fi

TYPES="histogram gauge"
JS_EXPORTER=""
for type in $TYPES; do
  metrics=$(cat $METRICS_FILE | jq -c '.data[] | select(contains("'${type}'"))')
  metrics=$(sed '$!s/$/,/' <<< $metrics)
  JS_EXPORTER="${type}_metrics,${JS_EXPORTER}"

cat <<EOF >> ${OUTPUT_FILE}
const ${type}_metrics = [
$metrics
];

EOF
done

cat <<EOF >> ${OUTPUT_FILE}
export {${JS_EXPORTER:0:-1}};

EOF



