FROM        busybox:latest
MAINTAINER  Serban Nistor <serban@nistor.io>

LABEL ARCHITECTURE="linux_armv7"
LABEL VERSION="2.22.0"
LABEL MAINTAINER="Serban Nistor <serban@nistor.io>"

COPY start.sh                   /bin/start.sh
COPY prometheus                 /bin/prometheus
COPY promtool                   /bin/promtool
COPY common/console_libraries/  /usr/share/prometheus/
COPY common/consoles/           /usr/share/prometheus/

ENV WEB_LISTEN_ADDRESS                          "0.0.0.0:9090"
ENV WEB_READ_TIMEOUT                            "5m"
ENV WEB_MAX_CONNECTIONS                         512
ENV WEB_PAGE_TITLE                              "Prometheus Time Series Collection and Processing Server"
ENV WEB_CORS_ORIGIN                             ".*"
ENV STORAGE_TSDB_RETENTION_TIME                 "15d"
ENV RULES_ALERT_FOR_OUTAGE_TOLERANCE            "1h"
ENV RULES_ALERT_FOR_GRACE_PERIOD                "10m"
ENV RULES_ALERT_RESEND_DELAY                    "1m"
ENV ALERTMANAGER_NOTIFICATION_QUEUE_CAPACITY    10000
ENV ALERTMANAGER_TIMEOUT                        "10s"
ENV QUERY_LOOKBACK_DELTA                        "5m"
ENV QUERY_TIMEOUT                               "2m"
ENV QUERY_MAX_CONCURRENCY                       10
ENV QUERY_MAX_SAMPLES                           50000000
ENV LOG_LEVEL                                   "info"
ENV LOG_FORMAT                                  "logfmt"

EXPOSE      9090

VOLUME      [ "/data" ]
VOLUME      [ "/etc/prometheus" ]

WORKDIR     /data
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD wget -q --spider http://localhost:9090/targets
ENTRYPOINT  [ "/bin/start.sh" ]
