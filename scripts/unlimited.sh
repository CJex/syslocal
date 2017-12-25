#!/bin/bash



cat ../etc/sysctl-local.conf > /etc/sysctl.d/local.conf

sysctl --system
ulimit -n 51200

echo "
* soft     nproc          65535
* hard     nproc          65535
* soft     nofile         65535
* hard     nofile         65535

" >> /etc/security/limits.conf;