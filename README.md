# metric-tools-benchmark
Benchmark tooling for [Thanos](https://thanos.io/), [Mimir](https://grafana.com/oss/mimir/) and [Victoriametrics](https://victoriametrics.com/). 

## Running

Each folder has `docker-compose` files to instantiate the stack and [Avalanche](https://github.com/prometheus-community/avalanche) (the tool we use
to generate metrics).

## About Avalanche

It's possible to run a standalone version of Avalanche in [avalanche/docker-compose-standalone.yml](avalanche/docker-compose-standalone.yml). 
This `docker-compose` point out to original docker image repository (i.e: [quay.io/freshtracks.io/avalanche](https://quay.io/repository/freshtracks.io/avalanche)).
However, to improve our tests we create a fork of this repository which can be found in [https://github.com/victoramsantos/avalanche](https://github.com/victoramsantos/avalanche).
In this fork we enabled metrics as `histogram` and changed the default name of the generated metrics to have the metric type.

## Scripts

We created the [scripts/metrics-extractor.sh](scripts/metrics-extractor.sh) which queries a Prometheus-like API to 
retrieve all metrics and generate an output only the `avalanche` metrics filtered.

## Kubernetes

In the [kubernetes/](kubernetes/) folder you can find the reference to kubernetes manifest for deploy.