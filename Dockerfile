FROM debian:bullseye

RUN apt-get update && apt-get install -y gpg

COPY gpg_public_key /tmp/zt-gpg-key
RUN gpg --dearmor < /tmp/zt-gpg-key > /etc/apt/trusted.gpg.d/zerotier-debian-package-key.gpg \
 && rm /tmp/zt-gpg-key \
 && echo "deb http://download.zerotier.com/debian/bullseye bullseye main" > /etc/apt/sources.list.d/zerotier.list \
 && apt-get update && apt-get install -y zerotier-one

COPY startup.sh /startup.sh
RUN chmod 0755 /startup.sh

EXPOSE 9993/udp

ENTRYPOINT ["/startup.sh"]