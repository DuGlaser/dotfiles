FROM ubuntu:22.04 AS UBUNTU

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y make git sudo curl

ARG USER="test"
ARG UID="1280"
ARG GROUP="test"
ARG GID="1280"
ARG PASS="password"

RUN groupadd -r ${GROUP} --gid=${GID} && useradd -r -g ${GROUP} --uid=${UID} --create-home --shell /bin/bash ${USER}
RUN echo "${USER}:${PASS}" | chpasswd

RUN echo 'Defaults visiblepw'             >> /etc/sudoers
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER}
WORKDIR /home/${USER}

COPY ./ /home/${USER}/dotfiles
WORKDIR /home/${USER}/dotfiles
