#!/bin/sh
# create aria2.session file if it does not exist
if [ ! -f /data/aria2.session ]; then
    touch /data/aria2.session
fi
if [[ $RPC_SECURE == "false" || -z $RPC_SECURE ]]; then
    exec /app/aria2c \
        --conf-path=/etc/aria2/aria2.conf \
        --rpc-listen-port=${RPC_LISTEN_PORT} \
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
