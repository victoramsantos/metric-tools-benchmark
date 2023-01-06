#!/usr/bin/env bash
#set -euox pipefail

echo ">> Stoping Monitoring tools"
docker-compose -f ../monitoring/docker-compose-monitoring.yml down

echo ">> Stoping Prometheus"
docker-compose -f docker-compose-prometheus.yml down

echo ">> Stoping Avalanche"
docker-compose -f docker-compose-avalanche.yml down

echo ">> Removing metrics files"
rm metrics.json
rm metrics.js

echo ">> Stoping K6"
docker-compose -f docker-compose-stress-test.yml down

echo ">> Everything is clear"
