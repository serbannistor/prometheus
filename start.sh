#!/bin/sh

echo "WEB_LISTEN_ADDRESS:                       ${WEB_LISTEN_ADDRESS}"
echo "WEB_READ_TIMEOUT:                         ${WEB_READ_TIMEOUT}"
echo "WEB_MAX_CONNECTIONS:                      ${WEB_MAX_CONNECTIONS}"
echo "WEB_PAGE_TITLE:                           ${WEB_PAGE_TITLE}"
echo "WEB_CORS_ORIGIN:                          ${WEB_CORS_ORIGIN}"
echo "STORAGE_TSDB_RETENTION_TIME:              ${STORAGE_TSDB_RETENTION_TIME}"
echo "RULES_ALERT_FOR_OUTAGE_TOLERANCE:         ${RULES_ALERT_FOR_OUTAGE_TOLERANCE}"
echo "RULES_ALERT_FOR_GRACE_PERIOD:             ${RULES_ALERT_FOR_GRACE_PERIOD}"
echo "RULES_ALERT_RESEND_DELAY:                 ${RULES_ALERT_RESEND_DELAY}"
echo "ALERTMANAGER_NOTIFICATION_QUEUE_CAPACITY: ${ALERTMANAGER_NOTIFICATION_QUEUE_CAPACITY}"
echo "ALERTMANAGER_TIMEOUT:                     ${ALERTMANAGER_TIMEOUT}"
echo "QUERY_LOOKBACK_DELTA:                     ${QUERY_LOOKBACK_DELTA}"
echo "QUERY_TIMEOUT:                            ${QUERY_TIMEOUT}"
echo "QUERY_MAX_CONCURRENCY:                    ${QUERY_MAX_CONCURRENCY}"
echo "QUERY_MAX_SAMPLES:                        ${QUERY_MAX_SAMPLES}"
echo "LOG_LEVEL:                                ${LOG_LEVEL}"
echo "LOG_FORMAT:                               ${LOG_FORMAT}"

CMD="/bin/prometheus \
    --config.file=/etc/prometheus/prometheus.yml \
    --web.console.templates=/usr/share/prometheus/consoles \
    --web.console.libraries=/usr/share/prometheus/console_libraries \
    --storage.tsdb.path=/data \
    --web.listen-address=\"${WEB_LISTEN_ADDRESS}\" \
    --web.read-timeout=\"${WEB_READ_TIMEOUT}\" \
    --web.max-connections=\"${WEB_MAX_CONNECTIONS}\" \
    --web.page-title=\"${WEB_PAGE_TITLE}\" \
    --web.cors.origin=\"${WEB_CORS_ORIGIN}\" \
    --storage.tsdb.retention.time=\"${STORAGE_TSDB_RETENTION_TIME}\" \
    --rules.alert.for-outage-tolerance=\"${RULES_ALERT_FOR_OUTAGE_TOLERANCE}\" \
    --rules.alert.for-grace-period=\"${RULES_ALERT_FOR_GRACE_PERIOD}\" \
    --rules.alert.resend-delay=\"${RULES_ALERT_RESEND_DELAY}\" \
    --alertmanager.notification-queue-capacity=\"${ALERTMANAGER_NOTIFICATION_QUEUE_CAPACITY}\" \
    --alertmanager.timeout=\"${ALERTMANAGER_TIMEOUT}\" \
    --query.lookback-delta=\"${QUERY_LOOKBACK_DELTA}\" \
    --query.timeout=\"${QUERY_TIMEOUT}\" \
    --query.max-concurrency=\"${QUERY_MAX_CONCURRENCY}\" \
    --query.max-samples=\"${QUERY_MAX_SAMPLES}\" \
    --log.level=\"${LOG_LEVEL}\" \
    --log.format=\"${LOG_FORMAT}\""

echo $CMD

eval $CMD
