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

# 作者描述信息
MAINTAINER danxiaonuo
# 时区设置
ARG TZ=Asia/Shanghai
ENV TZ=$TZ
# 语言设置
ARG LANG=C.UTF-8
ENV LANG=$LANG

# 指定用户
USER root

# 环境设置
ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND=$DEBIAN_FRONTEND
# 依赖包
ARG DEPENDS_LIST=depends-ubuntu-2004
ENV DEPENDS_LIST=$DEPENDS_LIST

# 预设环境
RUN set -eux \
    && apt-get update -qqy && apt-get upgrade -qqy \
    && apt-get install -qqy git sudo wget curl zsh vim nano tmux tree htop screen rsync gnupg ca-certificates uuid-runtime tzdata openssh-server lrzsz xz-utils \
    && apt-get install -qqy $(curl -fsSL git.io/${DEPENDS_LIST}) tree \
    && apt-get -qqy autoremove --purge \
    && apt-get -qqy clean \
    && wget --no-check-certificate https://raw.githubusercontent.com/danxiaonuo/openwrtenv-docker/main/scripts/configure.sh \
    && chmod +x configure.sh \
    && ./configure.sh \
    && rm -rf configure.sh
    
USER admin
WORKDIR /home/admin

EXPOSE 22

CMD [ "sudo", "/usr/sbin/sshd", "-D" ]
