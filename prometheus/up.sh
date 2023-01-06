#!/usr/bin/env bash
#set -euox pipefail

echo ">> Starting Monitoring tools"
docker-compose -f ../monitoring/docker-compose-monitoring.yml up -d

echo ">> Starting Prometheus"
docker-compose -f docker-compose-prometheus.yml up -d

sleep 10

echo ">> Starting Avalanche"
docker-compose -f docker-compose-avalanche.yml up -d

sleep 10

echo ">> Running scripts/metrics-extractor.sh"
bash ../scripts/metrics-extractor.sh

echo ">> Starting K6"
docker-compose -f docker-compose-stress-test.yml up -d

echo ">> You can see the test progress at: "
echo "http://localhost:3000/d/01npcT44k/test-result?orgId=1&refresh=5s"