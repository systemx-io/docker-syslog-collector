# docker-syslog-collector
This repository provides a very simple containerized syslog service.
The provided container simply provides a TCP+UDP port and writes syslog messages to the local filesystem.

Supported architectures:
* `linux/amd64`
* `linux/arm64`

## How to use
You need to provide a volume for the local cache which needs to be mounted at `/app/data`.

Inputs:
* `imptcp`, `imudp` providing a regular syslog service on TCP/UDP port `10514`

Outputs:
* `omfile` that uses a dynaFile termplate.
* File organization: `/app/data/syslog/%HOSTNAME%/%syslogfacility-text%-%$YEAR%-%$MONTH%-%$DAY%.log`.

## How to build
`docker buildx build --platform linux/amd64,linux/arm64 --tag ghcr.io/systemx-io/docker-syslog-retention:x.y.z --push .`