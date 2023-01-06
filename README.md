# metric-tools-benchmark
Benchmark tooling for [Prometheus](https://prometheus.io), [Thanos](https://thanos.io/), [Mimir](https://grafana.com/oss/mimir/) and [Victoriametrics](https://victoriametrics.com/). 

## Running With Docker Locally

Each folder has a bootstrap script `up.sh` which instantiate the monitoring tool ([Grafana](https://grafana.com/)), the referenced tool
(i.e. Prometheus, Thanos, Mimir or Victoriametrics), a container of [Avalanche](https://github.com/prometheus-community/avalanche) 
to be scraped and a container of [K6](https://k6.io/) used to create random requests to our environment.

We deployed a dashboard to follow K6 requests at [http://localhost:3000/d/01npcT44k/test-result?orgId=1&refresh=5s](http://localhost:3000/d/01npcT44k/test-result?orgId=1&refresh=5s).

When finished, you can delete the environment running the `down.sh` script.

## About Avalanche

We created a fork of Avalanche which can be found in [https://github.com/victoramsantos/avalanche](https://github.com/victoramsantos/avalanche).
In this fork we enabled metrics as `histogram` and changed the default name of the generated metrics to have the metric type.
We also upload it's docker image to [https://hub.docker.com/repository/docker/victoramsantos/avalanche](https://hub.docker.com/repository/docker/victoramsantos/avalanche).


## About K6

We customized a runtime of K6 to run using the exported metrics from Avalanche. This [image](https://hub.docker.com/repository/docker/victoramsantos/k6) uses the output of [scripts/metrics-extractor.sh](scripts/metrics-extractor.sh)
to generate a `metrics.js` file which breaks the metrics into two arrays (`histogram_metrics` and `gauge_metrics`).
This file is used by our K6 image to generate some queries to a Prometheus-like API.

## Kubernetes

To simulate a real scenario with kubernetes, we create a small environment which can be deployed locally using [Kind](https://kind.sigs.k8s.io/).
This tool will create a local kubernetes cluster. Running the [kubernetes-up.sh](kubernetes-up.sh) script, you will create
a kind cluster and apply all manifests. 

After created, you can run `kubectl port-forward svc/grafana-service 3000:3000` to access Grafana at [http://localhost:3000](http://localhost:3000).
We also added a dashboard to follow the K6 running, which can be accessed in [http://localhost:3000/d/01npcT44k/test-result?orgId=1&refresh=5s](http://localhost:3000/d/01npcT44k/test-result?orgId=1&refresh=5s).

When finished, you can run [kubernetes-down.sh](kubernetes-down.sh) which delete the kind cluster and all PODs created.
