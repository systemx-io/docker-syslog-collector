# Simple container that provides a syslog collector service using rsyslogd
# --
# Default configuration:
# - Listens on port 10514 UDP + TCP
# - Runs rsyslogd as non-root user
# - Writes logs and state to /app/data which should be backed by a volume
#

FROM --platform=$BUILDPLATFORM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/systemx-io/docker-syslog-collector
LABEL org.opencontainers.image.licenses=BSD-2-Clause

RUN addgroup -g 9999 syslog && \
	adduser -u 9999 -h /var/empty -g "syslog sandbox" -s /sbin/nologin -G syslog -D -H syslog

RUN install -d -D -o root -g syslog -m 0750 /app/config && \
	install -d -D -o syslog -g syslog -m 0750 /app/data

RUN apk add --no-cache rsyslog

ADD --chmod=444 ./files/rsyslog.conf /app/config/rsyslog.conf
ADD --chmod=755 ./files/entrypoint.sh /entrypoint.sh

EXPOSE 10514

USER syslog

ENTRYPOINT ["/entrypoint.sh"]
CMD ["rsyslogd", "-f", "/app/config/rsyslog.conf", "-n"]

# EOF
