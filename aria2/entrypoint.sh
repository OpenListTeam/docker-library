#!/bin/sh

if [[ $RPC_SECURE == "false" || -z $RPC_SECURE ]]; then
    exec /opt/aria2/bin/aria2c \
        --conf-path=/opt/aria2/aria2.conf \
        --rpc-listen-port=${RPC_LISTEN_PORT} \
        --rpc-secret=${RPC_SECRET}
else
    exec /opt/aria2/bin/aria2c \
        --conf-path=/opt/aria2/aria2.conf \
        --rpc-listen-port=${RPC_LISTEN_PORT} \
        --rpc-secret=${RPC_SECRET} \
        --rpc-secure=${RPC_SECURE} \
        --rpc-certificate=${RPC_CERTIFICATE} \
        --rpc-private-key=${RPC_PRIVATE_KEY}
fi
