#!/usr/bin/env bash

mkdir $logdir

export KEYBASE_RUN_MODE="${KEYBASE_RUN_MODE:-prod}"
export KEYBASE_DEBUG=1

echo Launching keybase service...
keybase -d --log-file="/dev/stdout" service --auto-forked &
echo Mounting /keybase...
kbfsfuse -debug /keybase &
echo Launching Keybase GUI...
/opt/keybase/Keybase
