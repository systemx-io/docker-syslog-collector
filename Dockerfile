# Simple container that provides syslog service using rsyslogd
# --
# Listens on port 10514 UDP + TCP
# Runs rsyslogd as non-root user
# Writes logs and state to /app/data which should be backed by a volume
#

FROM alpine:latest
LABEL org.opencontainers.image.source https://github.com/systemx-io/docker-syslog-collector

RUN addgroup -g 9999 syslog && \
	adduser -u 9999 -h /var/empty -g "syslog sandbox" -s /sbin/nologin -G syslog -D -H syslog

RUN apk update && \
	apk add rsyslog

RUN install -d -D -o root -g syslog -m 0750 /app/config && \
	install -d -D -o syslog -g syslog -m 0750 /app/data /app/data/state /app/data/queue /app/data/syslog

ADD ./files/rsyslog.conf /app/config/rsyslog.conf

EXPOSE 10514

USER syslog

CMD ["rsyslogd", "-f", "/app/config/rsyslog.conf", "-i", "/app/data/state/rsyslogd.pid", "-n"]

# EOF
