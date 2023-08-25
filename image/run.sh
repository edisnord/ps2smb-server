#!/usr/bin/env bash

if [ -z "$RUN_UID" ]
then
    RUN_UID=1000
fi

if [ -z "$RUN_GID" ]
then
    RUN_GID=1001
fi

if [ -z "$LOG_LEVEL" ]
then
    export LOG_LEVEL=1
fi

echo "UID is $RUN_UID"
echo "GID is $RUN_GID"
echo "Log level is $LOG_LEVEL"

addgroup -S -g $RUN_GID "user"
adduser -S -D -H -h /tmp -s /sbin/nologin -G user -g "User" -u $RUN_UID "user"
smbpasswd -s -a -n "user"

smbd -F -S --no-process-group --debuglevel=$LOG_LEVEL
