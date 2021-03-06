FROM ubuntu:latest
MAINTAINER Sergey Sushenko <phantom@wfap.ru>
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV PUBLIC_HOSTNAME=127.0.0.1

RUN apt-get update && \
	apt-get install --allow-unauthenticated -y gnupg2 wget dnsutils vim telnet expect apt-transport-https
RUN wget -qO - https://download.jitsi.org/jitsi-key.gpg.key | apt-key add -
RUN sh -c "echo 'deb https://download.jitsi.org stable/' > /etc/apt/sources.list.d/jitsi-stable.list"
RUN apt-get -y update
RUN apt-get --allow-unauthenticated -y install jitsi-meet
RUN	apt-get clean

EXPOSE 80 443 5347
EXPOSE 10000/udp 10001/udp 10002/udp 10003/udp 10004/udp 10005/udp 10006/udp 10007/udp 10008/udp 10009/udp 10010/udp

COPY run.sh /run.sh
COPY autoconf.videobridge.exp /autoconf.videobridge.exp
COPY autoconf.jitsimeet.exp /autoconf.jitsimeet.exp

RUN chmod +x autoconf.videobridge.exp autoconf.jitsimeet.exp

CMD /run.sh