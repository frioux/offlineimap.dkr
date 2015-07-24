FROM phusion/baseimage:0.9.16
MAINTAINER Arthur Axel fREW Schmidt <frioux@gmail.com>

# Dockerfile defining a robust offlineimap container
#
# Copyright 2015 Arthur Axel fREW Schmidt
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

CMD ["/sbin/my_init"]
VOLUME ["/opt/var/mail", "/opt/var/index", "/opt/log", "/opt/etc"]
EXPOSE 2812

ADD ./services/ /etc/service/user
ADD ./user_services /home/user/services
ADD ./offlineimaprc /home/user/.offlineimaprc
ADD ./offlineimap.py /home/user/.offlineimap.py
ADD ./bin/cerberus /home/user/bin/cerberus
ADD ./monitrc /home/user/.monitrc

RUN apt-add-repository -y ppa:rsrchboy/offline-mail \
 && env DEBIAN_FRONTEND=noninteractive apt-get update \
 && useradd user \
 && ln -s /opt/etc/netrc /home/user/.netrc \
 && ln -s /opt/var/index /home/user/.offlineimap \
 && chown 1000:1000 /opt/var/mail /opt/var/index /home/user -R \
 && env DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    daemontools                                \
    libio-all-perl                             \
    monit                                      \
    offlineimap                                \
    sudo
