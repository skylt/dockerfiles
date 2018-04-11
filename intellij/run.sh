#!/bin/bash

IMAGE=${1:-skylt/intellij-eap:latest}

DOCKER_GROUP_ID=$(cut -d: -f3 < <(getent group docker))
USER_ID=$(id -u $(whoami))
GROUP_ID=$(id -g $(whoami))

# Need to give the container access to your windowing system
export DISPLAY=:0
xhost +

CMD="docker run --detach\
                --group-add ${DOCKER_GROUP_ID} \
                --env HOME=${HOME} \
                --env DISPLAY=unix${DISPLAY} \
                --interactive \
                --name IntelliJ-skylt \
                --net "host" \
                --tty \
                --rm \
                --user=${USER_ID}:${GROUP_ID} \
                --volume $HOME:/home/yaourt \
                --volume /tmp/.X11-unix:/tmp/.X11-unix \
                --volume /var/run/docker.sock:/var/run/docker.sock \
                --workdir ${HOME} \
                ${IMAGE}"

echo ${CMD}
${CMD}
