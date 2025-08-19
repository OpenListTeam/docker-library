#!/bin/sh
# create aria2.session file if it does not exist
if [ ! -f /data/aria2.session ]; then
    touch /data/aria2.session
fi
# check RPC_SECURE variable, must be true or false or empty
if [ -z "$RPC_SECURE" ]; then
    RPC_SECURE="false"
fi

if [ "$RPC_SECURE" != "true" ] && [ "$RPC_SECURE" != "false" ]; then
    echo "RPC_SECURE must be true or false"
    exit 1
fi

if [ "$RPC_SECURE" = "false" ]; then
    exec /app/aria2c \
        --conf-path=/etc/aria2/aria2.conf \
        --rpc-listen-port=${RPC_LISTEN_PORT} \
        --rpc-secure=${RPC_SECURE} \
        --rpc-secret=${RPC_SECRET}
else
    exec /app/aria2c \
        --conf-path=/etc/aria2/aria2.conf \
        --rpc-listen-port=${RPC_LISTEN_PORT} \
        --rpc-secret=${RPC_SECRET} \
        --rpc-secure=${RPC_SECURE} \
        --rpc-certificate=${RPC_CERTIFICATE} \
        --rpc-private-key=${RPC_PRIVATE_KEY}
fi
