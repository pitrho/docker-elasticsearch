#!/bin/bash


set -e

NAME=elasticsearch
ES_USER=elasticsearch
ES_HOME=/user/share/$NAME
LOG_DIR=${ES_LOG_DIR:=/var/log/$NAME}
DATA_DIR=${ES_DATA_DIR:=/var/lib/$NAME}
WORK_DIR=/tmp/$NAME
CONF_DIR=/etc/$NAME
CONF_FILE=$CONF_DIR/elasticsearch.yml

mkdir -p $LOG_DIR
mkdir -p $DATA_DIR
chown -R elasticsearch:elasticsearch $LOG_DIR
chown -R elasticsearch:elasticsearch $DATA_DIR

echo "${LOG_DIR}/*.log {\n\tweekly\n\trotate 2\n\tcopytruncate\n\tdelaycompress\n\tcompress\n\tnotifempty\n\tmissingok\n\tsu root root\n}" > /etc/logrotate.d/redis

echo "Starting elasticsearch... "
sudo -H -u elasticsearch bash -c                \
    "/opt/elasticsearch/bin/elasticsearch       \
     -Des.path.data=${DATA_DIR}                 \
     -Des.path.logs=${LOG_DIR}                  \
     ${EXTRA_OPTS}                              \
     -d"
while ! echo exit | nc -z -w 3 localhost 9200;  do sleep 3; done
echo "Started"

tail -f $LOG_DIR/elasticsearch.log
