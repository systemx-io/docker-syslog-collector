#!/bin/sh
set -e

install -d -D -o syslog -g syslog -m 0750 /app/data/state /app/data/queue /app/data/syslog
exec $@
