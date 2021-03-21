#!/bin/sh

set -o errexit

if [ "$(id -u)" -eq '0' ]
then
    USER_ID=${UID:-9001}
    echo "Change user to $UID"

    # usermod is not available in alpine, so we need to del and then add
    deluser hath && adduser -DH -s /sbin/nologin -u ${USER_ID} hath hath
    chown -R $(id -u hath):$(id -g hath) /hath
    exec su-exec hath "$0" "$@"
fi

if [ ! -f /hath/data/client_login ]; then
  if [ $HatH_KEY ]; then 
    echo -n "${HatH_KEY}" > /hath/data/client_login
  else 
    echo "HatH_KEY not specified."
		exit 1
  fi
fi

ls -l /hath

exec java $JVM_DEFAULT_OPT $JVM_OPT -jar HentaiAtHome.jar \
    --cache-dir="/hath/cache" \
    --data-dir="/hath/data" \
    --download-dir="/hath/download" \
    --log-dir="/hath/log" \
    --temp-dir="/hath/temp" $@