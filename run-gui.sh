#!/usr/bin/env bash

die() {
	2>&1 echo $2
	exit $1
}

IMAGE="asssaf/keybase-gui"
MOUNT="/run/user/$(id -u)/docker-keybase"
[ -d "$MOUNT" ] || mkdir $MOUNT || die 1 "Can't create $MOUNT"

# CAP_SYS_ADMIN, /dev/fuse and /etc/passwd are needed for fuse mount
# /tmp/.X11-unix and DISAPLAY are needed for connecting to the X server
docker run -d --rm \
	--cap-add SYS_ADMIN \
	--device /dev/fuse \
	-v /etc/passwd:/etc/passwd:ro \
	-v ${MOUNT}:/keybase \
	-v ${HOME}/.config/keybase:/tmp/.config/keybase \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
        -e "DISPLAY=unix${DISPLAY}" \
	--user $(id -u):$(id -g) \
	${IMAGE}
