#=================================================
# https://github.com/danxiaonuo/openwrtenv-docker
# Description: OpenWrt build environment in docker
# Lisence: MIT
# Author: danxiaonuo
# Blog: https://www.danxiaonuo.me
#=================================================

# 指定构建的基础镜像
ARG BASE_IMAGE_TAG=20.04
FROM ubuntu:${BASE_IMAGE_TAG}

# 指定用户
USER root

ARG DEBIAN_FRONTEND=noninteractive
ARG DEPENDS_LIST=depends-ubuntu-2004

# 预设环境
RUN set -eux \
    && apt-get update -qq && apt-get upgrade -qqy \
    && apt-get install -qqy git sudo wget curl zsh vim nano tmux tree htop screen rsync gnupg ca-certificates uuid-runtime tzdata openssh-server lrzsz xz-utils \
    && apt-get install -qqy $(curl -fsSL git.io/${DEPENDS_LIST}) \
    && wget --no-check-certificate https://raw.githubusercontent.com/danxiaonuo/openwrtenv-docker/main/scripts/configure.sh \
    && chmod +x configure.sh \
    && ./configure.sh \
    && rm -rf configure.sh
    
USER admin
WORKDIR /home/admin

ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8

EXPOSE 22

CMD [ "sudo", "/usr/sbin/sshd", "-D" ]
