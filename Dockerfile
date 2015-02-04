FROM phusion/baseimage:0.9.16
MAINTAINER Arthur Axel fREW Schmdit <frioux@gmail.com>

CMD ["/sbin/my_init"]
VOLUME ["/opt/var/", "/opt/log", "/opt/etc"]
EXPOSE 2812

ADD ./services /etc/service/
ADD ./offlineimaprc /home/user/.offlineimaprc
ADD ./offlineimap.py /home/user/.offlineimap.py

RUN env DEBIAN_FRONTEND=noninteractive apt-get update \
 && useradd user \
 && chown 1000:1000 /opt/var /home/user /home/user/.offlineimaprc /home/user/.offlineimap.py \
 && env DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    daemontools                                \
    libio-all-perl                             \
    monit                                      \
    offlineimap                                \
    sudo
