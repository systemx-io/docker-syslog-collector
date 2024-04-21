# docker-syslog-collector
This repository provides a very simple containerized syslog service based on [rsyslogd](https://www.rsyslog.com).

The container provides a TCP+UDP port and writes syslog messages to the local filesystem. There's also the possibility to forward events to a remote destination using HTTP.

Supported architectures:
* `linux/amd64`
* `linux/arm64`

## Usage
You need to provide a volume for the local cache which needs to be mounted at `/app/data`.

Inputs:
* `imptcp` & `imudp` providing a regular syslog service on TCP/UDP port `10514`

Outputs:
* `omfile` that uses a dynaFile termplate for local file organization.
* `omhttp` that can be used to forward syslog messages to a HTTP endpoint.

## How to build
Bulding the image locally using Docker Desktop on my M-series MacBook:

`docker buildx build --platform linux/amd64,linux/arm64 --tag ghcr.io/systemx-io/docker-syslog-collector:x.y.z --push .`
